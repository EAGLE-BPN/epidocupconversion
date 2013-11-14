<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    version="2.0"  xmlns:skos="http://www.w3.org/2004/02/skos/core#" 
    xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#" 
    xmlns:tei="http://www.tei-c.org/ns/1.0" 
    xmlns="http://www.tei-c.org/ns/1.0" 
    exclude-result-prefixes="tei rdf skos">
    
    <xsl:template match="tei:material">
        <xsl:param name="materialURI" tunnel="yes"/>
        <xsl:variable name="noquestion">
            <xsl:analyze-string select="." regex="(\w+)\?">
            <xsl:matching-substring>
                <xsl:value-of select="regex-group(1)"/>
            </xsl:matching-substring>            
            <xsl:non-matching-substring>
                <xsl:analyze-string select="." regex="(\w+),\s(\w*)">
                    <xsl:matching-substring> 
                            <xsl:value-of select="regex-group(1)"/>                     
                    </xsl:matching-substring>            
                    <xsl:non-matching-substring>
                <xsl:value-of select="."/>
            </xsl:non-matching-substring>
</xsl:analyze-string>
            </xsl:non-matching-substring>
        </xsl:analyze-string>
        </xsl:variable>
        <xsl:copy>
            <xsl:copy-of select="@*[not(local-name()='ref')]"/>
            <xsl:if test="text()">
                <xsl:variable name="voc_term">          
<xsl:choose> 
    <xsl:when test="text()">   
        <xsl:value-of select="document('eagle-vocabulary-material.rdf')//skos:prefLabel[lower-case(.)=lower-case($noquestion)]/parent::skos:Concept/@rdf:about"/>
    </xsl:when>
     <xsl:otherwise>
        <xsl:value-of select="document('eagle-vocabulary-material.rdf')//skos:altLabel[lower-case(.)=lower-case($noquestion)]/parent::skos:Concept/@rdf:about"/>
      </xsl:otherwise>
</xsl:choose>
                </xsl:variable>
                <xsl:if test="$voc_term!=''">
                    <xsl:attribute name="ref">
                        <xsl:value-of select="$voc_term"/>
                    </xsl:attribute>                
                </xsl:if>
            </xsl:if>
            <xsl:apply-templates/>
        </xsl:copy>
    </xsl:template>
</xsl:stylesheet>
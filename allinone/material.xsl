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
                        <xsl:when test="document('https://raw.githubusercontent.com/EAGLE-BPN/epidocupconversion/master/allinone/eagle-vocabulary-material.rdf')//skos:prefLabel[lower-case(.)=lower-case($noquestion)]/parent::skos:Concept/@rdf:about">
                            <xsl:if test="not(contains(document('https://raw.githubusercontent.com/EAGLE-BPN/epidocupconversion/master/allinone/eagle-vocabulary-material.rdf')//skos:prefLabel[lower-case(.)=lower-case($noquestion)]/parent::skos:Concept/@rdf:about, 'archwort'))">
                                <xsl:value-of select="document('https://raw.githubusercontent.com/EAGLE-BPN/epidocupconversion/master/allinone/eagle-vocabulary-material.rdf')//skos:prefLabel[lower-case(.)=lower-case($noquestion)]/parent::skos:Concept/@rdf:about"/></xsl:if>
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:if test="not(contains(document('https://raw.githubusercontent.com/EAGLE-BPN/epidocupconversion/master/allinone/eagle-vocabulary-material.rdf')//skos:altLabel[lower-case(.)=lower-case($noquestion)]/parent::skos:Concept/@rdf:about, 'archwort'))">
                        <xsl:value-of select="document('https://raw.githubusercontent.com/EAGLE-BPN/epidocupconversion/master/allinone/eagle-vocabulary-material.rdf')//skos:altLabel[1][lower-case(.)=lower-case($noquestion)]/parent::skos:Concept/@rdf:about"/>
                        </xsl:if>
                    </xsl:otherwise>
                    </xsl:choose>
                </xsl:variable>
                <xsl:if test="$voc_term!=''">
                    <xsl:attribute name="ref">
                        <xsl:value-of select="$voc_term"/>
                    </xsl:attribute>                
                </xsl:if>
            </xsl:if>
            <xsl:value-of select="."/>
        </xsl:copy>
    </xsl:template>
</xsl:stylesheet>
<?xml version="1.0" encoding="UTF-8"?>

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    version="2.0"  xmlns:skos="http://www.w3.org/2004/02/skos/core#" 
    xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#" 
    xmlns:tei="http://www.tei-c.org/ns/1.0" 
    xmlns="http://www.tei-c.org/ns/1.0" 
    exclude-result-prefixes="tei rdf skos">

    <!--   GIVES PROBLEMS!!! probably due to vocabulary file -->
    <xsl:template match="tei:rs[@type='execution']">
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
                        <xsl:when test="document('https://raw.githubusercontent.com/EAGLE-BPN/epidocupconversion/master/allinone/eagle-vocabulary-writing.rdf')//skos:prefLabel[lower-case(normalize-space(.))=lower-case(normalize-space($noquestion))]/parent::skos:Concept[not(parent::skos:exactMatch[contains(skos:Concept/@rdf:about,'archwort')])]/@rdf:about">
                            <xsl:variable name="seq" select="document('https://raw.githubusercontent.com/EAGLE-BPN/epidocupconversion/master/allinone/eagle-vocabulary-writing.rdf')//skos:prefLabel[lower-case(normalize-space(.))=lower-case(normalize-space($noquestion))]/parent::skos:Concept/@rdf:about"/>
                            <xsl:value-of select="$seq[1]"/>
                        </xsl:when>
                        <xsl:otherwise>
                            <xsl:variable name="seq" select="document('https://raw.githubusercontent.com/EAGLE-BPN/epidocupconversion/master/allinone/eagle-vocabulary-writing.rdf')//skos:altLabel[lower-case(normalize-space(.))=lower-case(normalize-space($noquestion))]/parent::skos:Concept/@rdf:about"/>
                            <xsl:value-of select="$seq[1]"/> <!--this is not very clever but gives at least coherent results and one value only when vocabularies have many possible...-->
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
<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    version="2.0"  xmlns:skos="http://www.w3.org/2004/02/skos/core#" 
    xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#" 
    xmlns:tei="http://www.tei-c.org/ns/1.0" 
    xmlns="http://www.tei-c.org/ns/1.0" 
    exclude-result-prefixes="tei rdf skos">
    
    <!--where no information is given in the field objectType in an epidoc file the corresponding url of the unknown term is inserted and the text according to the language.-->
    
    <xsl:template match="tei:objectType[not(node())]">
        <objectType>
            <xsl:attribute name="ref">
                <xsl:text>http://www.eagle-network.eu/voc/objtyp/lod/2</xsl:text>
            </xsl:attribute>
            <xsl:choose>
                <xsl:when test="ancestor::tei:TEI[@xml:lang='en']">
                    <xsl:text>unknown</xsl:text>
                </xsl:when>
                <xsl:when test="ancestor::tei:TEI[@xml:lang='it']">
                    <xsl:text>sconosciuto</xsl:text>
                </xsl:when>
                <xsl:when test="ancestor::tei:TEI[@xml:lang='la']">
                    <xsl:text>ignoratur</xsl:text>
                </xsl:when>
                <xsl:when test="ancestor::tei:TEI[@xml:lang='de']">
                    <xsl:text>unbestimmt</xsl:text>
                </xsl:when>
                <xsl:when test="ancestor::tei:TEI[@xml:lang='es']">
                    <xsl:text>Desconocido</xsl:text>
                </xsl:when>
                <xsl:when test="ancestor::tei:TEI[@xml:lang='fr']">
                    <xsl:text>Inconnu</xsl:text>
                </xsl:when>
                <!--if no language is specified the english term is entered with the xml:lang attribute to specify the language of that info-->
                
<xsl:otherwise>
<xsl:attribute name="xml:lang">en</xsl:attribute>
 <xsl:text>unknown</xsl:text>
</xsl:otherwise>
            </xsl:choose>
        </objectType>
    </xsl:template>

    <xsl:template match="tei:objectType">
        <xsl:variable name="noquestion">
            <xsl:analyze-string select="." regex="(\w+\s*\w*\s*)\?">
                <xsl:matching-substring>
                    <xsl:value-of select="regex-group(1)"/>
                </xsl:matching-substring>            
                <xsl:non-matching-substring>
                    <xsl:analyze-string select="." regex="(\w+\s*\w*\s*),\s(\w*)">
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
                        <xsl:when test="document('eagle-vocabulary-object-type.rdf')//skos:prefLabel[lower-case(.)=lower-case(normalize-space($noquestion))]/parent::skos:Concept[not(ancestor::skos:exactMatch) or not(@rdf:about[contains(.,'archwort')])]/@rdf:about">
                            <xsl:variable name="seq" select="document('eagle-vocabulary-object-type.rdf')//skos:prefLabel[lower-case(.)=lower-case(normalize-space($noquestion))]/parent::skos:Concept[not(ancestor::skos:exactMatch) or not(@rdf:about[contains(.,'archwort')])]/@rdf:about"/>
                            <xsl:value-of select="$seq[1]"/>
                        </xsl:when>
                    <xsl:otherwise>
                        <xsl:variable name="seq" select="document('eagle-vocabulary-object-type.rdf')//skos:altLabel[lower-case(.)=lower-case(normalize-space($noquestion))]/parent::skos:Concept/@rdf:about"/>
                        <xsl:value-of select="$seq[1]"/> <!--this is not very clever but gives at least coherent results and one value only when vocabularies have many possible...-->
                    </xsl:otherwise>
              </xsl:choose>  </xsl:variable>
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

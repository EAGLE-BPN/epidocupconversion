<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    version="2.0"  xmlns:skos="http://www.w3.org/2004/02/skos/core#" 
    xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#" 
    xmlns:tei="http://www.tei-c.org/ns/1.0" 
    xmlns="http://www.tei-c.org/ns/1.0" 
    exclude-result-prefixes="tei rdf skos">
    
    <xsl:variable name="typobj" select="//tei:objectType"/>
    <xsl:variable name="objtyp"> 
        <xsl:analyze-string select="//tei:objectType" regex="(\w+)\?">
            <xsl:matching-substring>
                <xsl:value-of select="regex-group(1)"/>
                <!--<xsl:text> (?)</xsl:text>-->
            </xsl:matching-substring>            
            <xsl:non-matching-substring>
                <xsl:value-of select="."/>
            </xsl:non-matching-substring>
        </xsl:analyze-string> 
    </xsl:variable>
    
    <xsl:variable name="typins" select="//tei:term"/>
    <xsl:variable name="instyp">
        <xsl:analyze-string select="//tei:term" regex="(\w+)\?">
            <xsl:matching-substring>
                <xsl:value-of select="regex-group(1)"/> 
                <!--<xsl:text> (?)</xsl:text>-->
            </xsl:matching-substring>            
            <xsl:non-matching-substring>
                <xsl:value-of select="."/>
            </xsl:non-matching-substring>
        </xsl:analyze-string>
    </xsl:variable>
    
    <xsl:variable name="bibl" select="//tei:listBibl"/>
    
    
    <xsl:template match="tei:title">
        <xsl:param name="maketitle"  tunnel="yes"/>
        <title>
            <xsl:choose>
                <xsl:when test="$typobj/text()">
                    <xsl:if test="not($typins/text()=$typobj/text())"><xsl:value-of select="$instyp"/>
                        <xsl:if test="$typins/text()"><xsl:text> auf </xsl:text></xsl:if></xsl:if>
                    <xsl:value-of select="$objtyp"/></xsl:when>
                <xsl:otherwise>
                    <xsl:choose>
                        <xsl:when test="$typins/text()">
                            <xsl:value-of select="$instyp"/>
                        </xsl:when>
                        <xsl:otherwise>
                            <xsl:choose>
                                <xsl:when test="contains($bibl,'AE')">
                                    <xsl:analyze-string select="$bibl" regex="(AE(\s\d\d\d\d),(\s\d\d\d\d).)">
                                        <xsl:matching-substring>
                                            <xsl:value-of select="regex-group(1)"/>
                                            <!--<xsl:text> (?)</xsl:text>-->
                                        </xsl:matching-substring>
                                    </xsl:analyze-string>
                                </xsl:when>
                                <xsl:otherwise>
                                    <xsl:choose><xsl:when test="contains($bibl,'CIL')"> 
                                        <xsl:analyze-string select="$bibl" regex="(CIL(\s\d\d),(\s\d\d\d\d\d).)">
                                            <xsl:matching-substring>
                                                <xsl:value-of select="regex-group(1)"/>
                                            </xsl:matching-substring>
                                        </xsl:analyze-string></xsl:when>
                                        <xsl:otherwise>
                                            <xsl:text>Inschrift</xsl:text>
                                        </xsl:otherwise>
                                    </xsl:choose>
                                </xsl:otherwise>
                            </xsl:choose>
                        </xsl:otherwise>
                    </xsl:choose>
                </xsl:otherwise>
            </xsl:choose>
        </title>
    </xsl:template>
</xsl:stylesheet>
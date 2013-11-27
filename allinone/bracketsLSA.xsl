<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    version="2.0"  xmlns:skos="http://www.w3.org/2004/02/skos/core#" 
    xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#" 
    xmlns:tei="http://www.tei-c.org/ns/1.0" 
    xmlns="http://www.tei-c.org/ns/1.0" 
    exclude-result-prefixes="tei rdf skos">
    
    <xsl:template name="breakbrackets">
        <xsl:param name="textToBeProcessed" tunnel="yes"/>
        
                <!--     [dedicaverunt? \-\-\- Iu] -->
                <xsl:analyze-string select="." regex="\[((.*)\?)(\s(\-\-\-)\s)(.*)\]">
                    <xsl:matching-substring>
                        <xsl:text>[</xsl:text><xsl:value-of select="regex-group(1)"
                        /><xsl:text>][</xsl:text><xsl:text>3</xsl:text><!--<xsl:value-of select="regex-group(4)"/>--><xsl:text>][</xsl:text><xsl:value-of
                            select="regex-group(5)"/><xsl:text>]</xsl:text>
                    </xsl:matching-substring>
                    <xsl:non-matching-substring>
                                                        <!--     splits [- B] in [1][B]                   -->
                                                        <xsl:analyze-string select="."
                                                            regex="\[(\-)\s+([a-zA-Z]+)\]">
                                                            <xsl:matching-substring>
                                                                <xsl:text>[1][</xsl:text>
                                                                <xsl:value-of select="regex-group(2)"/>
                                                                <xsl:text>]</xsl:text>
                                                            </xsl:matching-substring>
                                                            <xsl:non-matching-substring>
                                                                <!--     splits [- - - B] in [- - -][B]                   -->
                                                                <xsl:analyze-string select="."
                                                                    regex="\[(\-\-\-)\s+([a-zA-Z]+)\]">
                                                                    <xsl:matching-substring>
                                                                        <xsl:text>[---][</xsl:text>
                                                                        <xsl:value-of select="regex-group(2)"/>
                                                                        <xsl:text>]</xsl:text>
                                                                    </xsl:matching-substring>
                                                                    <xsl:non-matching-substring>
                                                                        <!--     splits [B - - -] in [B][- - -]                   -->
                                                                        <xsl:analyze-string select="."
                                                                            regex="\[([a-zA-Z]+)\s+(\-\-\-)\]">
                                                                            <xsl:matching-substring>
                                                                                <xsl:text>[</xsl:text>
                                                                                <xsl:value-of select="regex-group(1)"/>
                                                                                <xsl:text>][---]</xsl:text>
                                                                            </xsl:matching-substring>
                                                                                                            <xsl:non-matching-substring>
                                                                                                                <xsl:value-of select="."/>
                                                                                                            </xsl:non-matching-substring>
                                                                                                        </xsl:analyze-string>
                                                                                                    </xsl:non-matching-substring>
                                                                                                </xsl:analyze-string>
                                                                                            </xsl:non-matching-substring>
                                                                                        </xsl:analyze-string>
                                                                                    </xsl:non-matching-substring>
                                                                                </xsl:analyze-string>
                                            
    </xsl:template>
</xsl:stylesheet>
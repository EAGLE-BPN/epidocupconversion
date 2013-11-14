<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    version="2.0"  xmlns:skos="http://www.w3.org/2004/02/skos/core#" 
    xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#" 
    xmlns:tei="http://www.tei-c.org/ns/1.0" 
    xmlns="http://www.tei-c.org/ns/1.0" 
    exclude-result-prefixes="tei rdf skos">
    
    <xsl:template name="breakbrackets">
        <xsl:param name="textToBeProcessed" tunnel="yes"/>
   <!-- splits [fortasse? bene? merenti?] in  [fortasse?][bene?][merenti?]      -->
        <xsl:analyze-string select="$textToBeProcessed" regex="\[((.*)\?)((.*)\?)((.*)\?)\]">
            <xsl:matching-substring>
                <xsl:text>[</xsl:text><xsl:value-of select="regex-group(1)"
                /><xsl:text>][</xsl:text><xsl:value-of select="regex-group(3)"/>][<xsl:value-of
                    select="regex-group(5)"/><xsl:text>]</xsl:text>
            </xsl:matching-substring>
            <xsl:non-matching-substring>
    <!-- splits [bene? merenti?] in  [bene?][merenti?]      -->
                <xsl:analyze-string select="." regex="\[((.*)\?)((.*)\?)\]">
                    <xsl:matching-substring>
                        <xsl:text>[</xsl:text>
                        <xsl:value-of select="regex-group(1)"/>
                        <xsl:text>][</xsl:text>
                        <xsl:value-of select="regex-group(3)"/>
                        <xsl:text>]</xsl:text>
                    </xsl:matching-substring>
                    <xsl:non-matching-substring>
                        <!-- splits [- - - ert] in [- - -][ert]-->
                        <xsl:analyze-string select="." regex="\[(-\s*-\s*-)\s+([a-zA-Z]+)\]">
                            <xsl:matching-substring>
                                <xsl:text>[</xsl:text>
                                <xsl:value-of select="regex-group(1)"/>
                                <xsl:text>][</xsl:text>
                                <xsl:value-of select="regex-group(2)"/>
                                <xsl:text>]</xsl:text>
                            </xsl:matching-substring>
                            <xsl:non-matching-substring>
 <!--    splits [ert - - -] in [ert][- - -] this regex might be better then the one use in brackets.xsl for a similar purpose-->
                                <xsl:analyze-string select="." regex="\[(\w*\(*\w*\)*)\s+(\s*-\s*-\s*-)\]">
                                    <xsl:matching-substring>
                                        <xsl:text>[</xsl:text>
                                        <xsl:value-of select="regex-group(1)"/>
                                        <xsl:text>][</xsl:text>
                                        <xsl:value-of select="regex-group(2)"/>
                                        <xsl:text>]</xsl:text>
                                    </xsl:matching-substring>
                                    <xsl:non-matching-substring>
                                        <!--  splits - - - fgh] in $][fgh]                          -->
                                        <xsl:analyze-string select="." regex="(\s*-\s*-\s*-)\s+([a-zA-Z]+)\]">
                                            <xsl:matching-substring>
                                                <xsl:value-of select="regex-group(1)"/>
                                                <xsl:text>][</xsl:text>
                                                <xsl:value-of select="regex-group(2)"/>
                                                <xsl:text>]</xsl:text>
                                            </xsl:matching-substring>
                                            <xsl:non-matching-substring>
                                                <!--     splits [dasd - - - in [dasd][&                   -->
                                                <xsl:analyze-string select="."
                                                    regex="\[([a-zA-Z]+)\s+(-\s*-\s*-\s*)">
                                                    <xsl:matching-substring>
                                                        <xsl:text>[</xsl:text>
                                                        <xsl:value-of select="regex-group(1)"/>
                                                        <xsl:text>][- - - </xsl:text>
                                                        <xsl:value-of select="regex-group(2)"/>
                                                    </xsl:matching-substring>
                                                    <xsl:non-matching-substring>
                                                        <!--       line breaks for gap unknown lines and first known line                                               -->
                                                        <xsl:analyze-string select="." regex="(\$\])(\w)">
                                                            <xsl:matching-substring>
                                                                <xsl:value-of select="regex-group(1)"/>
                                                                <xsl:text> / </xsl:text>
                                                                <xsl:value-of select="regex-group(2)"/>
                                                            </xsl:matching-substring>
                                                            <xsl:non-matching-substring>
                                                                <!--    corrects ]$                                   -->
                                                                <xsl:analyze-string select="." regex="\]\$">
                                                                    <xsl:matching-substring>
                                                                        <xsl:text>$]</xsl:text>
                                                                    </xsl:matching-substring>
                                                                    <xsl:non-matching-substring>
                                                                        <!--   ] and [ into [3]                           -->
                                                                        <xsl:analyze-string select="." regex="(\[\s+)">
                                                                            <xsl:matching-substring>
                                                                                <xsl:text>[- - -</xsl:text>
                                                                            </xsl:matching-substring>
                                                                            <xsl:non-matching-substring>                                                                      
                                                                                <xsl:analyze-string select="." regex=" (\s*\])">
                                                                                    <xsl:matching-substring>
                                                                                        <xsl:text>- - -]</xsl:text>
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
                                                    </xsl:non-matching-substring>
                                                </xsl:analyze-string>
                                            </xsl:non-matching-substring>
                                        </xsl:analyze-string>
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
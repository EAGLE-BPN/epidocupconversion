<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    version="2.0"  xmlns:skos="http://www.w3.org/2004/02/skos/core#" 
    xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#" 
    xmlns:tei="http://www.tei-c.org/ns/1.0" 
    xmlns="http://www.tei-c.org/ns/1.0" 
    exclude-result-prefixes="tei rdf skos">
    
    <xsl:template name="breakbrackets">
        <xsl:param name="textToBeProcessed" tunnel="yes"/>        
<xsl:analyze-string select="$textToBeProcessed" regex="\[\-\]">
            <xsl:matching-substring>
                <xsl:text>[-]</xsl:text>
            </xsl:matching-substring>
    <xsl:non-matching-substring>
            <!-- splits [fortasse? bene? merenti?] in  [fortasse?][bene?][merenti?]      -->
        <xsl:analyze-string select="$textToBeProcessed" regex="\[((\w+)\?)((\w+)\?)((\w+)\?)\]">
            <xsl:matching-substring>
                <xsl:text>[</xsl:text><xsl:value-of select="regex-group(1)"
                /><xsl:text> ?][</xsl:text><xsl:value-of select="regex-group(3)"/> ?][<xsl:value-of
                    select="regex-group(5)"/><xsl:text> ?]</xsl:text>
            </xsl:matching-substring>
            <xsl:non-matching-substring>
                <!-- splits [bene? merenti?] in  [bene?][merenti?]    can be improved with tokenize?  -->
                <xsl:analyze-string select="." regex="(\[((\w+)\?)\s*((\w+)\?)\])">
                    <xsl:matching-substring>
                        <xsl:text>[</xsl:text>
                        <xsl:value-of select="regex-group(2)"/>
                        <xsl:text>][</xsl:text>
                        <xsl:value-of select="regex-group(3)"/>
                        <xsl:text>]</xsl:text>
                    </xsl:matching-substring>
                    <xsl:non-matching-substring>
                        <!--  \[\-\s\-\s\-\s\-\s\-\s\-\] in [6]                          -->
                        <xsl:analyze-string select="." regex="\[\-\s*\-\s*\-\s*\-\s*\-\s*\-\]">
                            <xsl:matching-substring>
                                <xsl:text>[6]</xsl:text>
                            </xsl:matching-substring>
                            <xsl:non-matching-substring>
                                <!--  \-\s\-\s\-\s\-\s\-\s\- \s\? in [7]                          -->
                                <xsl:analyze-string select="." regex="\-\s*\-\s*\-\s*\-\s*\-\s*\-\s*\?">
                                    <xsl:matching-substring>
                                        <xsl:text>[7]</xsl:text>
                                    </xsl:matching-substring>
                                    <xsl:non-matching-substring>
                                        <!--  \-\s\-\s\-\s\-\s\-\s\- in [8]                          -->
                                        <xsl:analyze-string select="." regex="\-\s*\-\s*\-\s*\-\s*\-\s*\-\s*">
                                            <xsl:matching-substring>
                                                <xsl:text>[8]</xsl:text>
                                            </xsl:matching-substring>
                                            <xsl:non-matching-substring>
                                                
                <!--     [dedicaverunt? \-\-\- Iu] -->
                                                <xsl:analyze-string select="." regex="\[(([a-zA-Z\s]*)\?)(\s(\-\s*\-\s*\-)\s)([a-zA-Z\s]*)\]">
                    <xsl:matching-substring>
                        <xsl:text>[</xsl:text><xsl:value-of select="regex-group(1)"
                        /><xsl:text>][</xsl:text><xsl:text>3</xsl:text><!--<xsl:value-of select="regex-group(4)"/>--><xsl:text>][</xsl:text><xsl:value-of
                            select="regex-group(5)"/><xsl:text>]</xsl:text>
                    </xsl:matching-substring>
                    <xsl:non-matching-substring>
                        <!--\[(\s*(\-\s*\-\s*\-,*)\s*)(([a-zA-Z,\-\(\)\s]*))(\s(\-\s*\-\s*\-,*)\s)([a-zA-Z,\-\(\)\s]*)\]-->
                        <xsl:analyze-string select="." regex="\[(([a-zA-Z,\s]*))(\s(\-\s*\-\s*\-)\s)([a-zA-Z,\s]*)\]">
                            <xsl:matching-substring>
                                <xsl:text>[3][</xsl:text><xsl:value-of select="regex-group(3)"
                                /><xsl:text>][3][</xsl:text><xsl:value-of
                                    select="regex-group(7)"/><xsl:text>]</xsl:text>
                            </xsl:matching-substring>
                            <xsl:non-matching-substring>
                                
                        <!--     [dedicaverunt \-\-\- Iu] -->
                        <xsl:analyze-string select="." regex="\[(([a-zA-Z,\s]*))(\s(\-\s*\-\s*\-)\s)([a-zA-Z,\s]*)\]">
                            <xsl:matching-substring>
                                <xsl:text>[</xsl:text><xsl:value-of select="regex-group(1)"
                                /><xsl:text>][</xsl:text><xsl:text>3</xsl:text><!--<xsl:value-of select="regex-group(4)"/>--><xsl:text>][</xsl:text><xsl:value-of
                                    select="regex-group(5)"/><xsl:text>]</xsl:text>
                            </xsl:matching-substring>
                            <xsl:non-matching-substring>
                        <!--     [\?\-\-\-] -->
                        <xsl:analyze-string select="." regex="\[\?\s?\-\s?\-\s?\-\]">
                            <xsl:matching-substring>
                                <xsl:text>[3?]</xsl:text>
                            </xsl:matching-substring>
                            <xsl:non-matching-substring>
                                <!--     [\-\-\-\?] -->
                                <xsl:analyze-string select="." regex="\[\-\s?\-\s?\-\s?\?\]">
                                    <xsl:matching-substring>
                                        <xsl:text>[3?]</xsl:text>
                                    </xsl:matching-substring>
                                    <xsl:non-matching-substring>
                                        <!--                                                                CASISISTACA NON CONSIDERATA PRIMA, DA Controllare per ripercussioni su altre parti-->
                                        <!--     [pedes \-\-\-\?] -->
                                        <xsl:analyze-string select="." regex="\[([-A-Za-z,\s]+)\s\-\s*\-\s*\-\?\]">
                                            <xsl:matching-substring>
                                                <xsl:text>[</xsl:text><xsl:value-of select="regex-group(1)"
                                                /><xsl:text> ][3?]</xsl:text>
                                            </xsl:matching-substring>
                                            <xsl:non-matching-substring>
                                                
                                                <!--     [\-\-\-\? pedes] -->
                                                <xsl:analyze-string select="." regex="\[(\-\s*\-\s*\-\s*\?\s)([-A-Za-z,\s]+)\]">
                                                    <xsl:matching-substring>
                                                        <xsl:text>[3?][ </xsl:text><xsl:value-of select="regex-group(2)"
                                                        /><xsl:text>]</xsl:text>
                                                    </xsl:matching-substring>
                                                    <xsl:non-matching-substring>
                                                        
                                        <!--     [p(edes) \-\-\-\?] -->
                                        <xsl:analyze-string select="." regex="\[[-A-Za-z,\s]+([-A-Za-z()\s]+)\s\-\s*\-\s*\-\?\]">
                                            <xsl:matching-substring>
                                                <xsl:text>[</xsl:text><xsl:value-of select="regex-group(1)"
                                                /><xsl:text> ][3?]</xsl:text>
                                            </xsl:matching-substring>
                                            <xsl:non-matching-substring>
                                                <!--     [p(edes?) \-\-\-] -->
                                                <xsl:analyze-string select="." regex="\[([-A-Za-z,\s]+\([A-Za-z]+\))\s\-\s*\-\s*\-\]">
                                                    <xsl:matching-substring>
                                                        <xsl:text>[</xsl:text><xsl:value-of select="regex-group(1)"
                                                        /><xsl:text>][3]</xsl:text>
                                                    </xsl:matching-substring>
                                                    <xsl:non-matching-substring>  
                                                        <!--     [\-\-\- p(edes?)] -->
                                                        <xsl:analyze-string select="." regex="\[\-\s*\-\s*\-\s([-A-Za-z,\s]+\([A-Za-z,?\s]+\))\]">
                                                            <xsl:matching-substring>
                                                                <xsl:text>[3][</xsl:text><xsl:value-of select="regex-group(1)"
                                                                /><xsl:text>]</xsl:text>
                                                            </xsl:matching-substring>
                                                            <xsl:non-matching-substring> 
                                                                
<!--     [p(edes) \-\-\-] -->
                                                                <xsl:analyze-string select="." regex="\[([-A-Za-z,\s]+\([A-Za-z,\s]+\)),*\s\-\s*\-\s*\-\]">
                            <xsl:matching-substring>
                                <xsl:text>[</xsl:text><xsl:value-of select="regex-group(1)"
                                /><xsl:text> ][3]</xsl:text>
                            </xsl:matching-substring>
                            <xsl:non-matching-substring>
                                <!--     [\-\-\- p(edes) ] -->
                                <xsl:analyze-string select="." regex="\[\-\s*\-\s*\-([A-Za-z\s]+\([A-Za-z\s]+\))\]">
                                    <xsl:matching-substring>
                                        <xsl:text>[3][</xsl:text><xsl:value-of select="regex-group(1)"
                                        /><!--<xsl:value-of select="regex-group(4)"/>--><xsl:text>]</xsl:text>
                                    </xsl:matching-substring>
                                    <xsl:non-matching-substring>
                        <!-- splits [3 ert] in [3][ert]-->
                        <xsl:analyze-string select="." regex="\[(\-\s*\-\s*\-)\s+([a-zA-Z,\s]+)\]">
                            <xsl:matching-substring>
                                <xsl:text>[3][ </xsl:text>
                                <xsl:value-of select="regex-group(2)"/>
                                <xsl:text>]</xsl:text>
                            </xsl:matching-substring>
                            <xsl:non-matching-substring>
                                <!--    splits [ert gap] in [ert][gap] -->
                                <xsl:analyze-string select="." regex="\[([a-zA-Z,\s]+)[,]*\s+(\-\s*\-\s*\-)\]">
                                    <xsl:matching-substring>
                                        <xsl:text>[</xsl:text>
                                        <xsl:value-of select="regex-group(1)"/>
                                        <xsl:text> ][3]</xsl:text>
                                    </xsl:matching-substring>
                                    <xsl:non-matching-substring>
                                        <!-- splits [3 ert] in [3][ert]-->
                                        <xsl:analyze-string select="." regex="\[(\-\s\-\s\-)([a-zA-Z,\s]+)\]">
                                            <xsl:matching-substring>
                                                <xsl:text>[3][</xsl:text>
                                                <xsl:value-of select="regex-group(2)"/>
                                                <xsl:text>]</xsl:text>
                                            </xsl:matching-substring>
                                            <xsl:non-matching-substring>
                                                <!--    splits [ert gap] in [ert][gap] -->
                                                <xsl:analyze-string select="." regex="\[([a-zA-Z\s]+)[,]*(\-\s*\-\s*\-)\]">
                                                    <xsl:matching-substring>
                                                        <xsl:text>[</xsl:text>
                                                        <xsl:value-of select="regex-group(1)"/>
                                                        <xsl:text>][3]</xsl:text>
                                                    </xsl:matching-substring>
                                                    <xsl:non-matching-substring>
                                       <!--  splits $ fgh] in $][fgh]                          -->
                                        <xsl:analyze-string select="." regex="(\$)\s+([a-zA-Z\s]+)\]">
                                            <xsl:matching-substring>
                                                <xsl:value-of select="regex-group(1)"/>
                                                <xsl:text>] / [</xsl:text>
                                                <xsl:value-of select="regex-group(2)"/>
                                                <xsl:text>]</xsl:text>
                                            </xsl:matching-substring>
                                            <xsl:non-matching-substring>
                                                <!--     splits [dasd & in [dasd][&                   -->
                                                <xsl:analyze-string select="."
                                                    regex="\[([a-zA-Z]+)\s+(&amp;)">
                                                    <xsl:matching-substring>
                                                        <xsl:text>[</xsl:text>
                                                        <xsl:value-of select="regex-group(1)"/>
                                                        <xsl:text>] / [</xsl:text>
                                                        <xsl:value-of select="regex-group(2)"/>
                                                    </xsl:matching-substring>
                                                    <xsl:non-matching-substring>
                                                        <!--     splits [\-\- B \-\-] in [2][B][2]                   -->
                                                        <xsl:analyze-string select="."
                                                            regex="\[(\-\s*\-)\s+([a-zA-Z,\s]+)[,]*\s+(\-\s*\-)\]">
                                                            <xsl:matching-substring>
                                                                <xsl:text>[2][</xsl:text>
                                                                <xsl:value-of select="regex-group(2)"/>
                                                                <xsl:text>][2]</xsl:text>
                                                            </xsl:matching-substring>
                                                            <xsl:non-matching-substring>
                                                        <!--     splits [- B -] in [1][B][1]                   -->
                                                        <xsl:analyze-string select="."
                                                            regex="\[(\-)\s+([a-zA-Z,\s]+)\s+(\-)\]">
                                                            <xsl:matching-substring>
                                                                <xsl:text>[1][</xsl:text>
                                                                <xsl:value-of select="regex-group(2)"/>
                                                                <xsl:text>][1]</xsl:text>
                                                            </xsl:matching-substring>
                                                            <xsl:non-matching-substring>
                                                        <!--     splits [- B] in [1][B]                   -->
                                                        <xsl:analyze-string select="."
                                                            regex="\[(\-)\s+([a-zA-Z,\s]+)\]">
                                                            <xsl:matching-substring>
                                                                <xsl:text>[1][</xsl:text>
                                                                <xsl:value-of select="regex-group(2)"/>
                                                                <xsl:text>]</xsl:text>
                                                            </xsl:matching-substring>
                                                            <xsl:non-matching-substring>
                                                                <!--     splits [- - - B] in [3][B]                   -->
                                                                <xsl:analyze-string select="."
                                                                    regex="\[(\-\-\-)\s+([a-zA-Z,\s]+)\]">
                                                                    <xsl:matching-substring>
                                                                        <xsl:text>[3][</xsl:text>
                                                                        <xsl:value-of select="regex-group(2)"/>
                                                                        <xsl:text>]</xsl:text>
                                                                    </xsl:matching-substring>
                                                                    <xsl:non-matching-substring>
                                                                        <!--     splits [B - - -] in [B][3]                   -->
                                                                        <xsl:analyze-string select="."
                                                                            regex="\[([a-zA-Z,\s]+)\s+(\-\-\-)\]">
                                                                            <xsl:matching-substring>
                                                                                <xsl:text>[</xsl:text>
                                                                                <xsl:value-of select="regex-group(1)"/>
                                                                                <xsl:text>][3]</xsl:text>
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
                                                                                                        <!--    (- - -) becomes (3)                                   -->
                                                                                                        <xsl:analyze-string select="." regex="\(---\)">
                                                                                                            <xsl:matching-substring>
                                                                                                                <xsl:text>(3)</xsl:text>
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
                
            </xsl:non-matching-substring>
            </xsl:analyze-string>
    </xsl:non-matching-substring>
</xsl:analyze-string>
    </xsl:template>
</xsl:stylesheet>

<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="2.0"
    xmlns:tei="http://www.tei-c.org/ns/1.0" xmlns="http://www.tei-c.org/ns/1.0" exclude-result-prefixes="tei">

    
    <xsl:template match="@* | node()">
        <xsl:copy copy-namespaces="yes">
            <xsl:apply-templates select="@* | node()"/>
        </xsl:copy>
    </xsl:template>
    
    
    <!--  Create descriptive Title required from Europeana from Object Type and Inscription Type  -->
    
    <xsl:variable name="instyp" select="//tei:term"/>
    <xsl:variable name="objtyp" select="//tei:objectType"/>    
    
    <xsl:template match="tei:title">
        <title>
            <xsl:value-of select="$instyp"/>
            <xsl:text> über </xsl:text>
            <xsl:value-of select="$objtyp"/>
        </title>
    </xsl:template>
    
    
<!--  works on div to explicit TEXT and evaluate the presence of more inscriptions, parts, fragments  -->
    
    <xsl:template match="tei:div[@type='edition']">
        <xsl:copy>
            <xsl:apply-templates select="@*"/>
        <head>Text</head>
                    <xsl:choose>
                        <xsl:when test="contains(.,'//')">
                        <xsl:for-each select="tokenize(.,'//')">
                        <div>
                    <xsl:attribute name="n" select="position()"/>
                    <xsl:attribute name="type">textpart</xsl:attribute>
                        <ab><lb/>
                            <xsl:variable name="brackets">
                                <xsl:call-template name="breakbrackets">
                                    <xsl:with-param name="textToBeProcessed" select="."/>
                                </xsl:call-template>
                            </xsl:variable>
                            <xsl:for-each select="$brackets">
                                <xsl:call-template name="upconversion"/>
                            </xsl:for-each>
                        </ab>
                    </div>
                    </xsl:for-each>
                    </xsl:when>
<!--    THE FOLLOWING WILL WORK ON THE MAJORITY OF TEXT WHICH DO NOT HAVE PARTS      -->
                    <xsl:otherwise>
                        <ab>
                        <lb/>
                            <xsl:variable name="brackets">
                            <xsl:call-template name="breakbrackets">
                                <xsl:with-param name="textToBeProcessed" select="."/>
                            </xsl:call-template>
                        </xsl:variable>
                        <xsl:for-each select="$brackets">
                            <xsl:call-template name="upconversion"/>
                        </xsl:for-each>
                    </ab>
                   </xsl:otherwise>
                    </xsl:choose>
        </xsl:copy>
        
    </xsl:template>





<!--first step: breaks breakets in unique meaning ones -->
    <xsl:template name="breakbrackets">
        <xsl:param name="textToBeProcessed"/>
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
<!-- splits [3 ert] in [3][ert]-->
                        <xsl:analyze-string select="." regex="\[(\d)\s+([a-zA-Z]+)\]">
                            <xsl:matching-substring>
                                <xsl:text>[</xsl:text>
                                <xsl:value-of select="regex-group(1)"/>
                                <xsl:text>][</xsl:text>
                                <xsl:value-of select="regex-group(2)"/>
                                <xsl:text>]</xsl:text>
                            </xsl:matching-substring>
                            <xsl:non-matching-substring>
<!--    splits [ert 3] in [ert][3] -->
                                <xsl:analyze-string select="." regex="\[([a-zA-Z]+)\s+(\d)\]">
                                    <xsl:matching-substring>
                                        <xsl:text>[</xsl:text>
                                        <xsl:value-of select="regex-group(1)"/>
                                        <xsl:text>][</xsl:text>
                                        <xsl:value-of select="regex-group(2)"/>
                                        <xsl:text>]</xsl:text>
                                    </xsl:matching-substring>
                                    <xsl:non-matching-substring>
<!--  splits $ fgh] in $][fgh]                          -->
                                        <xsl:analyze-string select="." regex="(\$)\s+([a-zA-Z]+)\]">
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
    </xsl:template>

<!--  Takes all breakets sets and other diacritict and substitutes them with markup  -->
    <xsl:template name="upconversion">

<!--line breaks-->
        <xsl:analyze-string select="." regex="(\s*)/(\s+)|(\s+)/(\s*)">
            <xsl:matching-substring>
                <lb/>
            </xsl:matching-substring>
            <xsl:non-matching-substring>
<!--line breaks in word -->
                <xsl:analyze-string select="." regex="/">
                    <xsl:matching-substring>
                        <lb break="no"/>
                    </xsl:matching-substring>
                    <xsl:non-matching-substring>
<!--choice-->
                        <xsl:analyze-string select="." regex="(&lt;)(.)=(.)(&gt;)">
                            <xsl:matching-substring>
                                <choice>
                                    <corr>
                                        <xsl:value-of select="regex-group(2)"/>
                                    </corr>
                                    <sic>
                                        <xsl:value-of select="regex-group(3)"/>
                                    </sic>
                                </choice>
                            </xsl:matching-substring>
                            <xsl:non-matching-substring>
<!--      omitted                  -->
                                <xsl:analyze-string select="." regex="(&lt;)(\w*?)(&gt;)">
                                    <xsl:matching-substring>
                                        <supplied reason="omitted">
                                            <xsl:value-of select="regex-group(2)"/>
                                        </supplied>
                                    </xsl:matching-substring>
                                    <xsl:non-matching-substring>
<!--surplus-->
                                        <xsl:analyze-string select="." regex="\{{(.*?)\}}">
                                            <xsl:matching-substring>
                                                <surplus>
                                                  <xsl:value-of select="regex-group(1)"/>
                                                </surplus>
                                            </xsl:matching-substring>
                                            <xsl:non-matching-substring>
<!--del but lost-->
                                                <xsl:analyze-string select="."
                                                  regex="\[\[\[(3)\]\]\]">
                                                  <xsl:matching-substring>
                                                  <del rend="erasure">
                                                  <gap reason="lost" extent="unknown"
                                                  unit="character"/>
                                                  </del>
                                                  </xsl:matching-substring>
                                                  <xsl:non-matching-substring>
<!--   Gap unknown lines begining and end                             -->
                                                  <xsl:analyze-string select="."
                                                  regex="(\$\])|(\[&amp;)">
                                                  <xsl:matching-substring>
                                                  <gap reason="lost" extent="unknown" unit="line"/>
                                                  </xsl:matching-substring>
                                                  <xsl:non-matching-substring>
<!--     line gap                                   -->
                                                      <xsl:analyze-string select="." regex="\[(6)\]|\[(------)">
                                                  <xsl:matching-substring>
                                                  <gap reason="lost" quantity="1" unit="line"/>
                                                  </xsl:matching-substring>
                                                  <xsl:non-matching-substring>
<!--     extent unknown gap                                   -->
                                                  <xsl:analyze-string select="." regex="\[(3)\]|\[(---)\]">
                                                  <xsl:matching-substring>
                                                  <gap reason="lost" extent="unknown"
                                                  unit="character"/>
                                                  </xsl:matching-substring>
                                                  <xsl:non-matching-substring>
<!--      gap 1 char                                  -->
                                                  <xsl:analyze-string select="." regex="\[(1)\]">
                                                  <xsl:matching-substring>
                                                  <gap reason="lost" quantity="1" unit="character"/>
                                                  </xsl:matching-substring>
                                                  <xsl:non-matching-substring>
<!--      gap 2 char                                  -->
                                                  <xsl:analyze-string select="." regex="\[(2)\]">
                                                  <xsl:matching-substring>
                                                  <gap reason="lost" quantity="2" unit="character"/>
                                                  </xsl:matching-substring>
                                                  <xsl:non-matching-substring>

<!--del but suppl-->
                                                  <xsl:analyze-string select="."
                                                  regex="\[\[\[(.*?)\]\]\]">
                                                  <xsl:matching-substring>
                                                  <del rend="erasure">
                                                  <supplied reason="lost">
                                                  <xsl:value-of select="regex-group(1)"/>
                                                  </supplied>
                                                  </del>
                                                  </xsl:matching-substring>
                                                  <xsl:non-matching-substring>
<!-- del and part suppl MAX THREE [[[DO NOT UNDERSTAND WHY...]]]-->
                                                  <xsl:analyze-string select="."
                                                  regex="\[\[(.*?)\[(.*?)\](.*?)(\[(.*?)\](.*?))?(\[(.*?)\](.*?))?\]\]">
                                                  <xsl:matching-substring>
                                                  <del rend="erasure">
                                                  <xsl:value-of select="regex-group(1)"/>
                                                  <supplied reason="lost">
                                                  <xsl:value-of select="regex-group(2)"/>
                                                  </supplied>
                                                  <xsl:value-of select="regex-group(3)"/>

                                                  <xsl:if test="regex-group(4)">
                                                  <supplied reason="lost">
                                                  <xsl:value-of select="regex-group(5)"/>
                                                  </supplied>
                                                  <xsl:value-of select="regex-group(6)"/>
                                                  </xsl:if>
                                                  <xsl:if test="regex-group(7)">
                                                  <supplied reason="lost">
                                                  <xsl:value-of select="regex-group(8)"/>
                                                  </supplied>
                                                  <xsl:value-of select="regex-group(9)"/>
                                                  </xsl:if>
                                                  </del>
                                                  </xsl:matching-substring>
                                                  <xsl:non-matching-substring>
<!--del-->
                                                  <xsl:analyze-string select="."
                                                  regex="\[\[(.*?)\]\]">
                                                  <xsl:matching-substring>
                                                  <del rend="erasure">
                                                  <xsl:value-of select="regex-group(1)"/>
                                                  </del>
                                                  </xsl:matching-substring>
                                                  <xsl:non-matching-substring>
<!-- suppl cert low internal-->
             <!--WORKS ONLY FOR ONE-->
                                                  <xsl:analyze-string select="." regex="\[(.*?)\?\]">
                                                  <xsl:matching-substring>
                                                  <supplied reason="lost" cert="low">
                                                  <xsl:value-of
                                                  select="translate(regex-group(1), '?', '')"/>
                                                  </supplied>
                                                  </xsl:matching-substring>
                                                  <xsl:non-matching-substring>
<!--suppl cert low general-->
                                                  <xsl:analyze-string select="."
                                                  regex="\[(.*)\]\(\?\)">
                                                  <xsl:matching-substring>
                                                  <supplied reason="lost" cert="low">
                                                  <xsl:value-of select="regex-group(1)"/>
                                                  </supplied>
                                                  </xsl:matching-substring>
                                                  <xsl:non-matching-substring>
                                                      
                                                      <!-- [A]u[g(ustus) e] situation-->                                                      
                                                      <xsl:analyze-string select="." regex="([A-Za-z0-9]*)\[([A-Za-z0-9]+)\]([A-Za-z0-9]*)\[([A-Za-z0-9]*)\(([A-Za-z0-9]+)\)\s*([A-Za-z0-9]*)\]">
                                                          <xsl:matching-substring>
                                                              <expan>
                                                                  
                                                                  <abbr>
                                                                      <xsl:value-of select=" regex-group(1)"/>
                                                                      <supplied reason="lost">
                                                                          <xsl:value-of select=" regex-group(2)"/>
                                                                      </supplied>
                                                                      <xsl:value-of select=" regex-group(3)"/>
                                                                      
                                                                      
                                                                      <supplied reason="lost">    
                                                                          
                                                                          <xsl:value-of select=" regex-group(4)"/>
                                                                          
                                                                      </supplied>
                                                                  </abbr>
                                                                  <supplied reason="lost">    
                                                                      <ex>
                                                                          <xsl:value-of select=" regex-group(5)"/>
                                                                      </ex>
                                                                  </supplied>
                                                                  
                                                              </expan>
                                                              <supplied reason="lost">
                                                                  <xsl:value-of select=" regex-group(6)"/>
                                                              </supplied>
                                                              
                                                          </xsl:matching-substring>
                                                          <xsl:non-matching-substring>   
                                                              <!--v[ix(it)] situation-->
                                                              <xsl:analyze-string select="." regex="([A-Za-z0-9]+)\[(([A-Za-z0-9]+)\(([A-Za-z0-9]+)\)([A-Za-z0-9]+)*)\]">
                                                                  <xsl:matching-substring>
                                                                      <expan>
                                                                          
                                                                          <abbr>
                                                                              <xsl:value-of select=" regex-group(1)"/>
                                                                              <supplied reason="lost">
                                                                                  <xsl:value-of select=" regex-group(3)"/>
                                                                              </supplied>
                                                                          </abbr>
                                                                          <supplied reason="lost">    
                                                                              <ex>
                                                                                  <xsl:value-of select=" regex-group(4)"/>
                                                                              </ex>
                                                                          </supplied>
                                                                          <xsl:value-of select=" regex-group(5)"/>
                                                                      </expan>
                                                                      
                                                                  </xsl:matching-substring>
                                                                  <xsl:non-matching-substring>
                                                                      <!-- [A]ug(ustus) situation-->
                                                                      <xsl:analyze-string select="."
                                                                          regex="([A-Za-z0-9]*)\[([A-Za-z0-9]+)\]([A-Za-z0-9]*)\(([A-Za-z0-9]+)\)([A-Za-z0-9]+)*">
                                                                          <xsl:matching-substring>
                                                                              <expan>
                                                                                  <abbr>
                                                                                      <xsl:value-of select=" regex-group(1)"/>
                                                                                      <supplied reason="lost">
                                                                                          <xsl:value-of select=" regex-group(2)"/>
                                                                                      </supplied>
                                                                                      <xsl:value-of select=" regex-group(3)"/>
                                                                                  </abbr>
                                                                                  <ex>
                                                                                      <xsl:value-of select=" regex-group(4)"/>
                                                                                  </ex>
                                                                                  <xsl:value-of select=" regex-group(5)"/>
                                                                              </expan>
                                                                          </xsl:matching-substring>
                                                                          <xsl:non-matching-substring>
                                                                              <!--suppl with abbr-->
                                                                              <xsl:analyze-string select="." regex="\[(([A-Za-z0-9]+)\(([A-Za-z0-9]+)\)([A-Za-z0-9]+)*)\]">
                                                                                  <xsl:matching-substring>
                                                                                      <supplied reason="lost">
                                                                                          <expan>
                                                                                              <abbr>
                                                                                                  <xsl:value-of select=" regex-group(2)"/>
                                                                                              </abbr>
                                                                                              <ex>
                                                                                                  <xsl:value-of select=" regex-group(3)"/>
                                                                                              </ex>
                                                                                              <xsl:value-of select=" regex-group(4)"/>
                                                                                          </expan>
                                                                                      </supplied>
                                                                                  </xsl:matching-substring>
                                                                                  <xsl:non-matching-substring>
                                                                                      
<!--suppl-->
                                                  <xsl:analyze-string select="." regex="\[(.*?)\]">
                                                  <xsl:matching-substring>
                                                  <supplied reason="lost">
                                                  <xsl:value-of select="regex-group(1)"/>
                                                  </supplied>
                                                  </xsl:matching-substring>
                                                  <xsl:non-matching-substring>
 <!-- (sic) -->
                                                  <xsl:analyze-string select="." regex="\((!)\)">
                                                  <xsl:matching-substring>
                                                  <note>(sic)</note>
                                                  </xsl:matching-substring>
                                                  <xsl:non-matching-substring>
<!-- b(ene?) -->
                                                  <xsl:analyze-string select="."
                                                  regex="([A-Za-z0-9]+)\(([A-Za-z0-9]+)\?\)([A-Za-z0-9]+)*">
                                                  <xsl:matching-substring>
                                                  <expan>
                                                  <abbr>
                                                  <xsl:value-of select=" regex-group(1)"/>
                                                  </abbr>
                                                  <ex cert="low">
                                                  <xsl:value-of select=" regex-group(2)"/>
                                                  </ex>
                                                  <xsl:value-of select=" regex-group(3)"/>
                                                  </expan>
                                                  </xsl:matching-substring>
                                                  <xsl:non-matching-substring>
 <!-- only abbr -->
                                                  <xsl:analyze-string select="."
                                                  regex="((\w)*?)\(3\)">
                                                  <xsl:matching-substring>
                                                  <abbr>
                                                  <xsl:value-of select=" regex-group(1)"/>
                                                  </abbr>
                                                  </xsl:matching-substring>
                                                  <xsl:non-matching-substring>
<!--(Luci) lib-->
                                                      <xsl:analyze-string select="."
                                                          regex="\|\(([A-Za-z0-9]+)\)\s(lib)">
                                                          <xsl:matching-substring>
                                                                      <expan>
                                                                          <abbr>
                                                                          <am>
                                                                              <g type="solidus"/>
                                                                          </am>
                                                                  </abbr>
                                                                  <ex>
                                                                      <xsl:value-of select=" regex-group(1)"/>
                                                                  </ex>
                                                                      </expan>
                                                                                     <xsl:text> </xsl:text>
                                                              <abbr><xsl:text>lib</xsl:text></abbr>
                                                          </xsl:matching-substring>
                                                          <xsl:non-matching-substring>
<!--       W(mulieris)           -->
                                                              <xsl:analyze-string select="."
                                                                  regex="((W)\(mulieris\))">
                                                                  <xsl:matching-substring>
                                                                      <expan>
                                                                          <abbr>
                                                                              <am>
                                                                                  <g type="mulieris"/>
                                                                              </am>
                                                                          </abbr>
                                                                          <ex>
                                                                              <xsl:text>mulieris</xsl:text>
                                                                          </ex>
                                                                      </expan>
                                                                  </xsl:matching-substring>
                                                                  <xsl:non-matching-substring>
 <!--expan + abbr-->
                                                  <xsl:analyze-string select="."
                                                  regex="([A-Za-z0-9]+)\(([A-Za-z0-9]+)\)([A-Za-z0-9]+)*">
                                                  <xsl:matching-substring>
                                                  <expan>
                                                  <abbr>
                                                  <xsl:value-of select=" regex-group(1)"/>
                                                  </abbr>
                                                  <ex>
                                                  <xsl:value-of select=" regex-group(2)"/>
                                                  </ex>
                                                  <xsl:value-of select=" regex-group(3)"/>
                                                  </expan>
                                                  </xsl:matching-substring>
                                                      <xsl:non-matching-substring>
<!--|(centuria)-->
                                                      <xsl:analyze-string select="."
                                                          regex="\|\(centuria\)">
                                                          <xsl:matching-substring>
                                                              <expan>
                                                                  <abbr>
                                                                      <am>
                                                                          <g type="centuria"/>
                                                                      </am>
                                                                  </abbr>
                                                                  <ex>
                                                                      <xsl:text>centuria</xsl:text>
                                                                  </ex>
                                                              </expan>
                                                          </xsl:matching-substring>
                                                          <xsl:non-matching-substring>
<!--@(obitus)         -->
                                                              <xsl:analyze-string select="."
                                                                  regex="(@)\(obitus\)">
                                                                  <xsl:matching-substring>
                                                                      <expan>
                                                                          <abbr>
                                                                              <am>
                                                                                  <g type="obitus"/>
                                                                              </am>
                                                                          </abbr>
                                                                          <ex>
                                                                              <xsl:text>obitus</xsl:text>
                                                                          </ex>
                                                                      </expan>
                                                                  </xsl:matching-substring>
                                                                  <xsl:non-matching-substring>

<!--close non matchings-->
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
    </xsl:template>
    

</xsl:stylesheet>

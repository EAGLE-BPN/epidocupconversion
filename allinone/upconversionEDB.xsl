<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    version="2.0"  xmlns:skos="http://www.w3.org/2004/02/skos/core#" 
    xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#" 
    xmlns:tei="http://www.tei-c.org/ns/1.0" 
    xmlns="http://www.tei-c.org/ns/1.0" 
    exclude-result-prefixes="tei rdf skos">

        <xsl:template name="upconversion">
<xsl:param name="substitutions" tunnel="yes"/>
<!--1NAME1-->
            <xsl:analyze-string select="." regex="1">
                <xsl:matching-substring>
                    <xsl:text></xsl:text>
                </xsl:matching-substring>
                <xsl:non-matching-substring>
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
                        <xsl:analyze-string select="." regex="(⌜)(\w)(⌝)">
                            <xsl:matching-substring>
                                <choice>
                                    <corr>
                                        <xsl:value-of select="regex-group(2)"/>
                                    </corr>
                                    
                                </choice>
                            </xsl:matching-substring>
                            <xsl:non-matching-substring>
<!--      omitted                  -->
                                <xsl:analyze-string select="." regex="〈(\w*?)〉">
                                    <xsl:matching-substring>
                                        <supplied reason="omitted">
                                            <xsl:value-of select="regex-group(1)"/>
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
  <!--     line gap                                   -->
                                                <xsl:analyze-string select="." regex="\[(6)\]">
                                                    <xsl:matching-substring>
                                                        <gap reason="lost" quantity="1" unit="line"/>
                                                    </xsl:matching-substring>
                                                    <xsl:non-matching-substring>
       <!--      gap illegible                                  -->
                                                        <xsl:analyze-string select="." regex="(\++)">
                                                            <xsl:matching-substring>
                                                                <gap reason="illegible" quantity="{string-length(regex-group(1))}" unit="character"/>
                                                            </xsl:matching-substring>
                                                            <xsl:non-matching-substring>
     <!--unclear &#803; -->
                                                <xsl:analyze-string select="." regex="((\w&#803;)+)">
                                                    <xsl:matching-substring>
                                                        <unclear>
                                                            <xsl:variable name="underdot">
                                                                <xsl:value-of select="regex-group(1)"/>
                                                            </xsl:variable>
                                                            <xsl:analyze-string select="$underdot" regex="&#803;">
                                                                 <xsl:non-matching-substring>     
                                                                     <xsl:value-of select="."/>
                                                                 </xsl:non-matching-substring>
                                                             </xsl:analyze-string>
                                                        </unclear>
                                                    </xsl:matching-substring>
                                                    <xsl:non-matching-substring>
  <!--previously read &#818; -->
                                                        <xsl:analyze-string select="." regex="((\w&#818;)+)">
                                                            <xsl:matching-substring>
                                                                <supplied reason="undefined" evidence="previouseditor">
                                                                    <xsl:variable name="underline">
                                                                        <xsl:value-of select="regex-group(1)"/>
                                                                    </xsl:variable>
                                                                    <xsl:analyze-string select="$underline" regex="&#818;">
                                                                        <xsl:non-matching-substring>     
                                                                            <xsl:value-of select="."/>
                                                                        </xsl:non-matching-substring>
                                                                    </xsl:analyze-string>
                                                                </supplied>
                                                            </xsl:matching-substring>
                                                            <xsl:non-matching-substring>
      
    <!--del gap unknown -->
                                                <xsl:analyze-string select="."
                                                    regex="&#12314;\[\-\s\-\s\-\]&#12315;">
                                                  <xsl:matching-substring>
                                                  <del rend="erasure">
                                                  <gap reason="lost" extent="unknown"
                                                  unit="character"/>
                                                  </del>
                                                  </xsl:matching-substring>
                                                  <xsl:non-matching-substring>

<!--del-->
                                                  <xsl:analyze-string select="."
                                                      regex="&#12314;(.*?)&#12315;">
                                                  <xsl:matching-substring>
                                                  <del rend="erasure">
                                                      <xsl:analyze-string select="regex-group(1)" regex="\-\-\-|\[\-\-\-\]">    
                                                          <xsl:matching-substring>
                                                              <gap reason="lost" extent="unknown" unit="character"/>
                                                              <!--   it works in terms of search: it does not in terms of html transformation, cause it creates double breackets in the middle of a supplied...
  this is probably something which would then need to be twicked by the start.edition stylesheets?
  -->
                                                          </xsl:matching-substring>
                                                          <xsl:non-matching-substring>
                                                              <xsl:analyze-string select="." regex="\-|\[\-\]">    
                                                                  <xsl:matching-substring>
                                                                      <gap reason="lost" quantity="1" unit="character"/>
                                                                  </xsl:matching-substring>
                                                                  <xsl:non-matching-substring>
                                                                      
                                                                      
                                                      <xsl:analyze-string select="."
                                                          regex="\[(.*?)\]">
                                                          <xsl:matching-substring>
                                                              <supplied reason="lost">
                                                                  <xsl:analyze-string select="regex-group(1)"
                                                                      regex="([A-Za-z0-9]+)\(([A-Za-z0-9]+)\)([A-Za-z0-9]+)\(([A-Za-z0-9]+)\)([A-Za-z0-9]+)*">
                                                                      <xsl:matching-substring>
                                                                          <expan>
                                                                              <abbr>
                                                                                  <!--unclear &#803; -->
                                                                                  <xsl:analyze-string select="regex-group(1)" regex="((\w&#803;)+)">
                                                                                      <xsl:matching-substring>
                                                                                          <unclear>
                                                                                              <xsl:variable name="underdot">
                                                                                                  <xsl:value-of select="regex-group(1)"/>
                                                                                              </xsl:variable>
                                                                                              <xsl:analyze-string select="$underdot" regex="&#803;">
                                                                                                  <xsl:non-matching-substring>     
                                                                                                      <xsl:value-of select="."/>
                                                                                                  </xsl:non-matching-substring>
                                                                                              </xsl:analyze-string>
                                                                                          </unclear>
                                                                                      </xsl:matching-substring>
                                                                                      <xsl:non-matching-substring>
                                                                                          <xsl:value-of select="."/>
                                                                                      </xsl:non-matching-substring>
                                                                                  </xsl:analyze-string>
                                                                              </abbr>
                                                                              <ex>
                                                                                  <xsl:analyze-string select=" regex-group(2)" regex="\-\-\-">
                                                                                      <xsl:matching-substring>
                                                                                          <xsl:text>-</xsl:text>
                                                                                      </xsl:matching-substring>
                                                                                      <xsl:non-matching-substring>
                                                                                          <xsl:analyze-string regex="\?" select=".">
                                                                                              <xsl:matching-substring>
                                                                                                  <xsl:attribute name="cert">
                                                                                                      <xsl:text>low</xsl:text>
                                                                                                  </xsl:attribute>
                                                                                              </xsl:matching-substring>
                                                                                              <xsl:non-matching-substring>
                                                                                                  <xsl:value-of select="."/>
                                                                                              </xsl:non-matching-substring>
                                                                                          </xsl:analyze-string>
                                                                                      </xsl:non-matching-substring>
                                                                                  </xsl:analyze-string>
                                                                              </ex>
                                                                              <abbr>
                                                                                  <!--unclear &#803; -->
                                                                                  <xsl:analyze-string select="regex-group(1)" regex="((\w&#803;)+)">
                                                                                      <xsl:matching-substring>
                                                                                          <unclear>
                                                                                              <xsl:variable name="underdot">
                                                                                                  <xsl:value-of select="regex-group(1)"/>
                                                                                              </xsl:variable>
                                                                                              <xsl:analyze-string select="$underdot" regex="&#803;">
                                                                                                  <xsl:non-matching-substring>     
                                                                                                      <xsl:value-of select="."/>
                                                                                                  </xsl:non-matching-substring>
                                                                                              </xsl:analyze-string>
                                                                                          </unclear>
                                                                                      </xsl:matching-substring>
                                                                                      <xsl:non-matching-substring>
                                                                                          <xsl:value-of select="."/>
                                                                                      </xsl:non-matching-substring>
                                                                                  </xsl:analyze-string>
                                                                              </abbr>
                                                                              <ex>
                                                                                  <xsl:analyze-string select=" regex-group(4)" regex="\-\-\-">
                                                                                      <xsl:matching-substring>
                                                                                          <xsl:text>-</xsl:text>
                                                                                      </xsl:matching-substring>
                                                                                      <xsl:non-matching-substring>
                                                                                          <xsl:analyze-string regex="\?" select=".">
                                                                                              <xsl:matching-substring>
                                                                                                  <xsl:attribute name="cert">
                                                                                                      <xsl:text>low</xsl:text>
                                                                                                  </xsl:attribute>
                                                                                              </xsl:matching-substring>
                                                                                              <xsl:non-matching-substring>
                                                                                                  <xsl:value-of select="."/>
                                                                                              </xsl:non-matching-substring>
                                                                                          </xsl:analyze-string>
                                                                                      </xsl:non-matching-substring>
                                                                                  </xsl:analyze-string>
                                                                              </ex>
                                                                              <xsl:value-of select=" regex-group(5)"/>
                                                                          </expan>
                                                                      </xsl:matching-substring>
                                                                      <xsl:non-matching-substring>
                                                                          <!--              expan + abbr + eventually ? in ex-->
                                                                          <xsl:analyze-string select="."
                                                                              regex="([A-Za-z0-9]+)\((.*?)\)([A-Za-z0-9]+)*">
                                                                              <xsl:matching-substring>
                                                                                  <expan>
                                                                                      <abbr>
                                                                                          <!--unclear &#803; -->
                                                                                          <xsl:analyze-string select="regex-group(1)" regex="((\w&#803;)+)">
                                                                                              <xsl:matching-substring>
                                                                                                  <unclear>
                                                                                                      <xsl:variable name="underdot">
                                                                                                          <xsl:value-of select="regex-group(1)"/>
                                                                                                      </xsl:variable>
                                                                                                      <xsl:analyze-string select="$underdot" regex="&#803;">
                                                                                                          <xsl:non-matching-substring>     
                                                                                                              <xsl:value-of select="."/>
                                                                                                          </xsl:non-matching-substring>
                                                                                                      </xsl:analyze-string>
                                                                                                  </unclear>
                                                                                              </xsl:matching-substring>
                                                                                              <xsl:non-matching-substring>
                                                                                                  <xsl:value-of select="."/>
                                                                                              </xsl:non-matching-substring>
                                                                                          </xsl:analyze-string>
                                                                                      </abbr>
                                                                                      <ex>
                                                                                          <xsl:analyze-string select=" regex-group(2)" regex="\-\-\-">
                                                                                              <xsl:matching-substring>
                                                                                                  <xsl:text>-</xsl:text>
                                                                                              </xsl:matching-substring>
                                                                                              <xsl:non-matching-substring>
                                                                                                  <xsl:analyze-string regex="\?" select=".">
                                                                                                      <xsl:matching-substring>
                                                                                                          <xsl:attribute name="cert">
                                                                                                              <xsl:text>low</xsl:text>
                                                                                                          </xsl:attribute>
                                                                                                      </xsl:matching-substring>
                                                                                                      <xsl:non-matching-substring>
                                                                                                          <xsl:value-of select="."/>
                                                                                                      </xsl:non-matching-substring>
                                                                                                  </xsl:analyze-string>
                                                                                              </xsl:non-matching-substring>
                                                                                          </xsl:analyze-string>
                                                                                      </ex>
                                                                                      <xsl:value-of select=" regex-group(3)"/>
                                                                                  </expan>
                                                                              </xsl:matching-substring>
                                                                              <xsl:non-matching-substring>
                                                                                  <!--unclear &#803; -->
                                                                                  <xsl:analyze-string select="." regex="((\w&#803;)+)">
                                                                                      <xsl:matching-substring>
                                                                                          <unclear>
                                                                                              <xsl:variable name="underdot">
                                                                                                  <xsl:value-of select="regex-group(1)"/>
                                                                                              </xsl:variable>
                                                                                              <xsl:analyze-string select="$underdot" regex="&#803;">
                                                                                                  <xsl:non-matching-substring>     
                                                                                                      <xsl:value-of select="."/>
                                                                                                  </xsl:non-matching-substring>
                                                                                              </xsl:analyze-string>
                                                                                          </unclear>
                                                                                      </xsl:matching-substring>
                                                                                      <xsl:non-matching-substring>
                                                                                  <xsl:analyze-string select="." regex="\-\-\-|\[\-\-\-\]">    
                                                                                                                      <xsl:matching-substring>
                                                                                                                          <gap reason="lost" extent="unknown" unit="character"/>
                                                                                                                          <!--                                                                                               it works in terms of search: it does not in terms of html transformation, cause it creates double breackets in the middle of a supplied...
  this is probably something which would then need to be twicked by the start.edition stylesheets?
  -->
                                                                                                                      </xsl:matching-substring>
                                                                                                                      <xsl:non-matching-substring>
                                                                                                                          <xsl:analyze-string select="." regex="\-|\[\-\]">    
                                                                                                                              <xsl:matching-substring>
                                                                                                                                  <gap reason="lost" quantity="1" unit="character"/>
                                                                                                                              </xsl:matching-substring>
                                                                                                                              <xsl:non-matching-substring>
                                                                                                                          <xsl:analyze-string select="." regex="((\w+)\?)">
                                                                                                                              <xsl:matching-substring>
                                                                                                                                  <xsl:value-of select="regex-group(2)"/>
                                                                                                                                  <certainty locus="name" match="preceding-sibling::text()" cert="low"/>
                                                                                                                                  <!--                            not sure this is actually fine.           
                                                                               needs to be handled by start edition stylesheets                      -->
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
                                                              </supplied>
                                                          </xsl:matching-substring>
                                                          <xsl:non-matching-substring>
                                                              <xsl:analyze-string select="."
                                                                  regex="([A-Za-z0-9]+)\(([A-Za-z0-9]+)\)([A-Za-z0-9]+)\(([A-Za-z0-9]+)\)([A-Za-z0-9]+)*">
                                                                  <xsl:matching-substring>
                                                                      <expan>
                                                                          <abbr>
                                                                              <!--unclear &#803; -->
                                                                              <xsl:analyze-string select="regex-group(1)" regex="((\w&#803;)+)">
                                                                                  <xsl:matching-substring>
                                                                                      <unclear>
                                                                                          <xsl:variable name="underdot">
                                                                                              <xsl:value-of select="regex-group(1)"/>
                                                                                          </xsl:variable>
                                                                                          <xsl:analyze-string select="$underdot" regex="&#803;">
                                                                                              <xsl:non-matching-substring>     
                                                                                                  <xsl:value-of select="."/>
                                                                                              </xsl:non-matching-substring>
                                                                                          </xsl:analyze-string>
                                                                                      </unclear>
                                                                                  </xsl:matching-substring>
                                                                                  <xsl:non-matching-substring>
                                                                                      <xsl:value-of select="."/>
                                                                                  </xsl:non-matching-substring>
                                                                              </xsl:analyze-string>
                                                                          </abbr>
                                                                          <ex>
                                                                              <xsl:analyze-string select=" regex-group(2)" regex="\-\-\-">
                                                                                  <xsl:matching-substring>
                                                                                      <xsl:text>-</xsl:text>
                                                                                  </xsl:matching-substring>
                                                                                  <xsl:non-matching-substring>
                                                                                      <xsl:analyze-string regex="\?" select=".">
                                                                                          <xsl:matching-substring>
                                                                                              <xsl:attribute name="cert">
                                                                                                  <xsl:text>low</xsl:text>
                                                                                              </xsl:attribute>
                                                                                          </xsl:matching-substring>
                                                                                          <xsl:non-matching-substring>
                                                                                              <xsl:value-of select="."/>
                                                                                          </xsl:non-matching-substring>
                                                                                      </xsl:analyze-string>
                                                                                  </xsl:non-matching-substring>
                                                                              </xsl:analyze-string>
                                                                          </ex>
                                                                          <abbr>
                                                                              <!--unclear &#803; -->
                                                                              <xsl:analyze-string select="regex-group(1)" regex="((\w&#803;)+)">
                                                                                  <xsl:matching-substring>
                                                                                      <unclear>
                                                                                          <xsl:variable name="underdot">
                                                                                              <xsl:value-of select="regex-group(1)"/>
                                                                                          </xsl:variable>
                                                                                          <xsl:analyze-string select="$underdot" regex="&#803;">
                                                                                              <xsl:non-matching-substring>     
                                                                                                  <xsl:value-of select="."/>
                                                                                              </xsl:non-matching-substring>
                                                                                          </xsl:analyze-string>
                                                                                      </unclear>
                                                                                  </xsl:matching-substring>
                                                                                  <xsl:non-matching-substring>
                                                                                      <xsl:value-of select="."/>
                                                                                  </xsl:non-matching-substring>
                                                                              </xsl:analyze-string>
                                                                          </abbr>
                                                                          <ex>
                                                                              <xsl:analyze-string select=" regex-group(2)" regex="\-\-\-">
                                                                                  <xsl:matching-substring>
                                                                                      <xsl:text>-</xsl:text>
                                                                                  </xsl:matching-substring>
                                                                                  <xsl:non-matching-substring>
                                                                                      <xsl:analyze-string regex="\?" select=".">
                                                                                          <xsl:matching-substring>
                                                                                              <xsl:attribute name="cert">
                                                                                                  <xsl:text>low</xsl:text>
                                                                                              </xsl:attribute>
                                                                                          </xsl:matching-substring>
                                                                                          <xsl:non-matching-substring>
                                                                                              <xsl:value-of select="."/>
                                                                                          </xsl:non-matching-substring>
                                                                                      </xsl:analyze-string>
                                                                                  </xsl:non-matching-substring>
                                                                              </xsl:analyze-string>
                                                                          </ex>
                                                                          <xsl:value-of select=" regex-group(5)"/>
                                                                      </expan>
                                                                  </xsl:matching-substring>
                                                                  <xsl:non-matching-substring>
                                                                      <!--              expan + abbr + eventually ? in ex-->
                                                                      <xsl:analyze-string select="."
                                                                          regex="([A-Za-z0-9]+)\((.*?)\)([A-Za-z0-9]+)*">
                                                                          <xsl:matching-substring>
                                                                              <expan>
                                                                                  <abbr>
                                                                                      <!--unclear &#803; -->
                                                                                      <xsl:analyze-string select="regex-group(1)" regex="((\w&#803;)+)">
                                                                                          <xsl:matching-substring>
                                                                                              <unclear>
                                                                                                  <xsl:variable name="underdot">
                                                                                                      <xsl:value-of select="regex-group(1)"/>
                                                                                                  </xsl:variable>
                                                                                                  <xsl:analyze-string select="$underdot" regex="&#803;">
                                                                                                      <xsl:non-matching-substring>     
                                                                                                          <xsl:value-of select="."/>
                                                                                                      </xsl:non-matching-substring>
                                                                                                  </xsl:analyze-string>
                                                                                              </unclear>
                                                                                          </xsl:matching-substring>
                                                                                          <xsl:non-matching-substring>
                                                                                              <xsl:value-of select="."/>
                                                                                          </xsl:non-matching-substring>
                                                                                      </xsl:analyze-string>
                                                                                  </abbr>
                                                                                  <ex>
                                                                                      <xsl:analyze-string select=" regex-group(2)" regex="\-\-\-">
                                                                                          <xsl:matching-substring>
                                                                                              <xsl:text>-</xsl:text>
                                                                                          </xsl:matching-substring>
                                                                                          <xsl:non-matching-substring>
                                                                                              <xsl:analyze-string regex="\?" select=".">
                                                                                                  <xsl:matching-substring>
                                                                                                      <xsl:attribute name="cert">
                                                                                                          <xsl:text>low</xsl:text>
                                                                                                      </xsl:attribute>
                                                                                                  </xsl:matching-substring>
                                                                                                  <xsl:non-matching-substring>
                                                                                                      <xsl:value-of select="."/>
                                                                                                  </xsl:non-matching-substring>
                                                                                              </xsl:analyze-string>
                                                                                          </xsl:non-matching-substring>
                                                                                      </xsl:analyze-string>
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
                                                                                                                      <xsl:analyze-string select="." regex="((\w+)\?)">
                                                                                                                          <xsl:matching-substring>
                                                                                                                              <xsl:value-of select="regex-group(2)"/>
                                                                                                                              <certainty locus="name" match="preceding-sibling::text()" cert="low"/>
                                                                                                                              <!--                            not sure this is actually fine.           
                                                                               needs to be handled by start edition stylesheets                      -->
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
                                                  </del>
                                                  </xsl:matching-substring>
                                                  <xsl:non-matching-substring>

<!-- suppl cert low internal [bene?]-->
             <!--WORKS ONLY FOR ONE-->
                                                  <xsl:analyze-string select="." regex="(\[(.*?)\?\])">
                                                  <xsl:matching-substring>
                                                  <supplied reason="lost" cert="low">
                                                  <xsl:value-of
                                                  select="regex-group(2)"/>
                                                  </supplied>
                                                  </xsl:matching-substring>
                                                  <xsl:non-matching-substring>
<!--suppl cert low general [da]?-->
                                                  <xsl:analyze-string select="."
                                                  regex="\[(.*)\]\(\?\)">
                                                  <xsl:matching-substring>
                                                  <supplied reason="lost" cert="low">
                                                  <xsl:value-of select="regex-group(1)"/>
                                                  </supplied>
                                                  </xsl:matching-substring>
                                                  <xsl:non-matching-substring>
     <!--mace(rie) (:maceria)         -->
                                                      <xsl:analyze-string select="."
                                                          regex="(\w+)\((\w+)\)(\s\(:(\w+)\))">
                                                          <xsl:matching-substring>
                                                              <choice>
                                                                  <corr>
                                                                      <xsl:value-of select="regex-group(4)"/>
                                                                  </corr>
                                                                  <sic>
                                                                      <expan><abbr>
                                                                          <!--unclear &#803; -->
                                                                          <xsl:analyze-string select="regex-group(1)" regex="((\w&#803;)+)">
                                                                              <xsl:matching-substring>
                                                                                  <unclear>
                                                                                      <xsl:variable name="underdot">
                                                                                          <xsl:value-of select="regex-group(1)"/>
                                                                                      </xsl:variable>
                                                                                      <xsl:analyze-string select="$underdot" regex="&#803;">
                                                                                          <xsl:non-matching-substring>     
                                                                                              <xsl:value-of select="."/>
                                                                                          </xsl:non-matching-substring>
                                                                                      </xsl:analyze-string>
                                                                                  </unclear>
                                                                              </xsl:matching-substring>
                                                                              <xsl:non-matching-substring>
                                                                                  <xsl:value-of select="."/>
                                                                              </xsl:non-matching-substring>
                                                                          </xsl:analyze-string>
                                                                      </abbr>
                                                                      <ex>
                                                                          <xsl:value-of select="regex-group(2)"/>
                                                                      </ex>
                                                                      </expan>
                                                                  </sic>
                                                              </choice>
                                                          </xsl:matching-substring>
                                                          <xsl:non-matching-substring>
                                                              
           <!-- [A]u[g(ustus) e] situation-->                                                      
                                                      <xsl:analyze-string select="." regex="([A-Za-z0-9]*)\[([A-Za-z0-9]+)\]([A-Za-z0-9]*)\[([A-Za-z0-9]*)\(([A-Za-z0-9]+)\)\s*([A-Za-z0-9]*)\]">
                                                          <xsl:matching-substring>
                                                              <expan>
                                                                  
                                                                  <abbr>
                                                                      <abbr>
                                                                          <!--unclear &#803; -->
                                                                          <xsl:analyze-string select="regex-group(1)" regex="((\w&#803;)+)">
                                                                              <xsl:matching-substring>
                                                                                  <unclear>
                                                                                      <xsl:variable name="underdot">
                                                                                          <xsl:value-of select="regex-group(1)"/>
                                                                                      </xsl:variable>
                                                                                      <xsl:analyze-string select="$underdot" regex="&#803;">
                                                                                          <xsl:non-matching-substring>     
                                                                                              <xsl:value-of select="."/>
                                                                                          </xsl:non-matching-substring>
                                                                                      </xsl:analyze-string>
                                                                                  </unclear>
                                                                              </xsl:matching-substring>
                                                                              <xsl:non-matching-substring>
                                                                                  <xsl:value-of select="."/>
                                                                              </xsl:non-matching-substring>
                                                                          </xsl:analyze-string>
                                                                      </abbr>
                                                                      <supplied reason="lost">
                                                                          <xsl:value-of select=" regex-group(2)"/>
                                                                      </supplied>
                                                                      <abbr>
                                                                          <!--unclear &#803; -->
                                                                          <xsl:analyze-string select="regex-group(3)" regex="((\w&#803;)+)">
                                                                              <xsl:matching-substring>
                                                                                  <unclear>
                                                                                      <xsl:variable name="underdot">
                                                                                          <xsl:value-of select="regex-group(1)"/>
                                                                                      </xsl:variable>
                                                                                      <xsl:analyze-string select="$underdot" regex="&#803;">
                                                                                          <xsl:non-matching-substring>     
                                                                                              <xsl:value-of select="."/>
                                                                                          </xsl:non-matching-substring>
                                                                                      </xsl:analyze-string>
                                                                                  </unclear>
                                                                              </xsl:matching-substring>
                                                                              <xsl:non-matching-substring>
                                                                                  <xsl:value-of select="."/>
                                                                              </xsl:non-matching-substring>
                                                                          </xsl:analyze-string>
                                                                      </abbr>
                                                                      <supplied reason="lost">    
                                                                          
                                                                          <xsl:value-of select=" regex-group(4)"/>
                                                                          
                                                                      </supplied>
                                                                  </abbr>
                                                                  <supplied reason="lost">    
                                                                      <ex>
                                                                          <xsl:analyze-string select=" regex-group(5)" regex="\-\-\-">
                                                                              <xsl:matching-substring>
                                                                                  <xsl:text>-</xsl:text>
                                                                              </xsl:matching-substring>
                                                                              <xsl:non-matching-substring>
                                                                                  <xsl:analyze-string regex="\?" select=".">
                                                                                      <xsl:matching-substring>
                                                                                          <xsl:attribute name="cert">
                                                                                              <xsl:text>low</xsl:text>
                                                                                          </xsl:attribute>
                                                                                      </xsl:matching-substring>
                                                                                      <xsl:non-matching-substring>
                                                                                          <xsl:value-of select="."/>
                                                                                      </xsl:non-matching-substring>
                                                                                  </xsl:analyze-string>
                                                                              </xsl:non-matching-substring>
                                                                          </xsl:analyze-string>
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
                                                                              <abbr>
                                                                                  <!--unclear &#803; -->
                                                                                  <xsl:analyze-string select="regex-group(1)" regex="((\w&#803;)+)">
                                                                                      <xsl:matching-substring>
                                                                                          <unclear>
                                                                                              <xsl:variable name="underdot">
                                                                                                  <xsl:value-of select="regex-group(1)"/>
                                                                                              </xsl:variable>
                                                                                              <xsl:analyze-string select="$underdot" regex="&#803;">
                                                                                                  <xsl:non-matching-substring>     
                                                                                                      <xsl:value-of select="."/>
                                                                                                  </xsl:non-matching-substring>
                                                                                              </xsl:analyze-string>
                                                                                          </unclear>
                                                                                      </xsl:matching-substring>
                                                                                      <xsl:non-matching-substring>
                                                                                          <xsl:value-of select="."/>
                                                                                      </xsl:non-matching-substring>
                                                                                  </xsl:analyze-string>
                                                                              </abbr>
                                                                              <supplied reason="lost">
                                                                                  <xsl:value-of select=" regex-group(3)"/>
                                                                              </supplied>
                                                                          </abbr>
                                                                          <supplied reason="lost">    
                                                                              <ex>
                                                                                  <xsl:analyze-string select=" regex-group(4)" regex="\-\-\-">
                                                                                      <xsl:matching-substring>
                                                                                          <xsl:text>-</xsl:text>
                                                                                      </xsl:matching-substring>
                                                                                      <xsl:non-matching-substring>
                                                                                          <xsl:analyze-string regex="\?" select=".">
                                                                                              <xsl:matching-substring>
                                                                                                  <xsl:attribute name="cert">
                                                                                                      <xsl:text>low</xsl:text>
                                                                                                  </xsl:attribute>
                                                                                              </xsl:matching-substring>
                                                                                              <xsl:non-matching-substring>
                                                                                                  <xsl:value-of select="."/>
                                                                                              </xsl:non-matching-substring>
                                                                                          </xsl:analyze-string>
                                                                                      </xsl:non-matching-substring>
                                                                                  </xsl:analyze-string>
                                                                              </ex>
                                                                          </supplied>
                                                                          <xsl:value-of select=" regex-group(5)"/>
                                                                      </expan>
                                                                      
                                                                  </xsl:matching-substring>
                                                                  <xsl:non-matching-substring>
                <!--[P(ublio)] situation-->
                                                                      <xsl:analyze-string select="." regex="\[([A-Za-z0-9])+\(([A-Za-z0-9]+)\)\]">
                                                                          <xsl:matching-substring>
                                                                              <supplied reason="lost">
                                                                              <expan>
                                                                                  <abbr>
                                                                                      <!--unclear &#803; -->
                                                                                      <xsl:analyze-string select="regex-group(1)" regex="((\w&#803;)+)">
                                                                                          <xsl:matching-substring>
                                                                                              <unclear>
                                                                                                  <xsl:variable name="underdot">
                                                                                                      <xsl:value-of select="regex-group(1)"/>
                                                                                                  </xsl:variable>
                                                                                                  <xsl:analyze-string select="$underdot" regex="&#803;">
                                                                                                      <xsl:non-matching-substring>     
                                                                                                          <xsl:value-of select="."/>
                                                                                                      </xsl:non-matching-substring>
                                                                                                  </xsl:analyze-string>
                                                                                              </unclear>
                                                                                          </xsl:matching-substring>
                                                                                          <xsl:non-matching-substring>
                                                                                              <xsl:value-of select="."/>
                                                                                          </xsl:non-matching-substring>
                                                                                      </xsl:analyze-string>
                                                                                  </abbr>
                                                                                      <ex>
                                                                                          <xsl:analyze-string select=" regex-group(2)" regex="\-\-\-">
                                                                                              <xsl:matching-substring>
                                                                                                  <xsl:text>-</xsl:text>
                                                                                              </xsl:matching-substring>
                                                                                              <xsl:non-matching-substring>
                                                                                                  <xsl:analyze-string regex="\?" select=".">
                                                                                                      <xsl:matching-substring>
                                                                                                          <xsl:attribute name="cert">
                                                                                                              <xsl:text>low</xsl:text>
                                                                                                          </xsl:attribute>
                                                                                                      </xsl:matching-substring>
                                                                                                      <xsl:non-matching-substring>
                                                                                                          <xsl:value-of select="."/>
                                                                                                      </xsl:non-matching-substring>
                                                                                                  </xsl:analyze-string>
                                                                                              </xsl:non-matching-substring>
                                                                                          </xsl:analyze-string>
                                                                                      </ex>
                                                                                  
                                                                              </expan>
                                                                              </supplied>
                                                                          </xsl:matching-substring>
                                                                          <xsl:non-matching-substring>
                                                                              
  <!-- [A]ug(ustus) situation-->
                                                                      <xsl:analyze-string select="."
                                                                          regex="([A-Za-z0-9]*)\[([A-Za-z0-9]+)\]([A-Za-z0-9]*)\(([A-Za-z0-9]+)\)([A-Za-z0-9]+)*">
                                                                          <xsl:matching-substring>
                                                                              <expan>
                                                                                  <abbr>
                                                                                      <abbr>
                                                                                          <!--unclear &#803; -->
                                                                                          <xsl:analyze-string select="regex-group(1)" regex="((\w&#803;)+)">
                                                                                              <xsl:matching-substring>
                                                                                                  <unclear>
                                                                                                      <xsl:variable name="underdot">
                                                                                                          <xsl:value-of select="regex-group(1)"/>
                                                                                                      </xsl:variable>
                                                                                                      <xsl:analyze-string select="$underdot" regex="&#803;">
                                                                                                          <xsl:non-matching-substring>     
                                                                                                              <xsl:value-of select="."/>
                                                                                                          </xsl:non-matching-substring>
                                                                                                      </xsl:analyze-string>
                                                                                                  </unclear>
                                                                                              </xsl:matching-substring>
                                                                                              <xsl:non-matching-substring>
                                                                                                  <xsl:value-of select="."/>
                                                                                              </xsl:non-matching-substring>
                                                                                          </xsl:analyze-string>
                                                                                      </abbr>
                                                                                      <supplied reason="lost">
                                                                                          <xsl:value-of select=" regex-group(2)"/>
                                                                                      </supplied>
                                                                                      
                                                                                          <!--unclear &#803; -->
                                                                                          <xsl:analyze-string select="regex-group(1)" regex="((\w&#803;)+)">
                                                                                              <xsl:matching-substring>
                                                                                                  <unclear>
                                                                                                      <xsl:variable name="underdot">
                                                                                                          <xsl:value-of select="regex-group(1)"/>
                                                                                                      </xsl:variable>
                                                                                                      <xsl:analyze-string select="$underdot" regex="&#803;">
                                                                                                          <xsl:non-matching-substring>     
                                                                                                              <xsl:value-of select="."/>
                                                                                                          </xsl:non-matching-substring>
                                                                                                      </xsl:analyze-string>
                                                                                                  </unclear>
                                                                                              </xsl:matching-substring>
                                                                                              <xsl:non-matching-substring>
                                                                                                  <xsl:value-of select="."/>
                                                                                              </xsl:non-matching-substring>
                                                                                          </xsl:analyze-string>
                                                                                      </abbr>
                                                                                  <ex>
                                                                                      <xsl:analyze-string select=" regex-group(4)" regex="\-\-\-">
                                                                                          <xsl:matching-substring>
                                                                                              <xsl:text>-</xsl:text>
                                                                                          </xsl:matching-substring>
                                                                                          <xsl:non-matching-substring>
                                                                                              <xsl:analyze-string regex="\?" select=".">
                                                                                                  <xsl:matching-substring>
                                                                                                      <xsl:attribute name="cert">
                                                                                                          <xsl:text>low</xsl:text>
                                                                                                      </xsl:attribute>
                                                                                                  </xsl:matching-substring>
                                                                                                  <xsl:non-matching-substring>
                                                                                                      <xsl:value-of select="."/>
                                                                                                  </xsl:non-matching-substring>
                                                                                              </xsl:analyze-string>
                                                                                          </xsl:non-matching-substring>
                                                                                      </xsl:analyze-string>
                                                                                  </ex>
                                                                                  
                                                                                  <xsl:value-of select=" regex-group(5)"/>
                                                                              </expan>
                                                                          </xsl:matching-substring>
                                                                          <xsl:non-matching-substring>
         <!--      gap unknown                               -->
                                                                              <xsl:analyze-string select="." regex="\[(3)\]|\[\-\-\-\]">
                                                          <xsl:matching-substring>
                                                              <gap reason="lost" extent="unknown" unit="character"/>
                                                          </xsl:matching-substring>
                                                          <xsl:non-matching-substring>
      <!--      gap 2 char                                  -->
                                                              <xsl:analyze-string select="." regex="\[(2)\]|\[\-\-\]">
                                                                  <xsl:matching-substring>
                                                                      <gap reason="lost" quantity="2" unit="character"/>
                                                                  </xsl:matching-substring>
                                                                  <xsl:non-matching-substring>
        <!--      gap 1 char                                  -->
                                                                      <xsl:analyze-string select="." regex="\[(1)\]|\[\-\]">
                                                                          <xsl:matching-substring>
                                                                              <gap reason="lost" quantity="1" unit="character"/>
                                                                          </xsl:matching-substring>
                                                                          <xsl:non-matching-substring>
                                                                              
        <!--suppl-->
                                                                              <xsl:analyze-string select="."
                                                                                  regex="\[(.*?)\]">
                                                                                  <xsl:matching-substring>
                                                                                      <supplied reason="lost">
                                                                                          <xsl:analyze-string select="regex-group(1)"
                                                                                              regex="([A-Za-z0-9]+)\(([A-Za-z0-9]+)\)([A-Za-z0-9]+)\(([A-Za-z0-9]+)\)([A-Za-z0-9]+)*">
                                                                                              <xsl:matching-substring>
                                                                                                  <expan>
                                                                                                      <abbr>
                                                                                                          <!--unclear &#803; -->
                                                                                                          <xsl:analyze-string select="regex-group(1)" regex="((\w&#803;)+)">
                                                                                                              <xsl:matching-substring>
                                                                                                                  <unclear>
                                                                                                                      <xsl:variable name="underdot">
                                                                                                                          <xsl:value-of select="regex-group(1)"/>
                                                                                                                      </xsl:variable>
                                                                                                                      <xsl:analyze-string select="$underdot" regex="&#803;">
                                                                                                                          <xsl:non-matching-substring>     
                                                                                                                              <xsl:value-of select="."/>
                                                                                                                          </xsl:non-matching-substring>
                                                                                                                      </xsl:analyze-string>
                                                                                                                  </unclear>
                                                                                                              </xsl:matching-substring>
                                                                                                              <xsl:non-matching-substring>
                                                                                                                  <xsl:value-of select="."/>
                                                                                                              </xsl:non-matching-substring>
                                                                                                          </xsl:analyze-string>
                                                                                                      </abbr>
                                                                                                      <ex>
                                                                                                          <xsl:analyze-string select=" regex-group(2)" regex="\-\-\-">
                                                                                                              <xsl:matching-substring>
                                                                                                                  <xsl:text>-</xsl:text>
                                                                                                              </xsl:matching-substring>
                                                                                                              <xsl:non-matching-substring>
                                                                                                                  <xsl:analyze-string regex="\?" select=".">
                                                                                                                      <xsl:matching-substring>
                                                                                                                          <xsl:attribute name="cert">
                                                                                                                              <xsl:text>low</xsl:text>
                                                                                                                          </xsl:attribute>
                                                                                                                      </xsl:matching-substring>
                                                                                                                      <xsl:non-matching-substring>
                                                                                                                          <xsl:value-of select="."/>
                                                                                                                      </xsl:non-matching-substring>
                                                                                                                  </xsl:analyze-string>
                                                                                                              </xsl:non-matching-substring>
                                                                                                          </xsl:analyze-string>
                                                                                                      </ex>
                                                                                                      <abbr>
                                                                                                          <!--unclear &#803; -->
                                                                                                          <xsl:analyze-string select="regex-group(3)" regex="((\w&#803;)+)">
                                                                                                              <xsl:matching-substring>
                                                                                                                  <unclear>
                                                                                                                      <xsl:variable name="underdot">
                                                                                                                          <xsl:value-of select="regex-group(1)"/>
                                                                                                                      </xsl:variable>
                                                                                                                      <xsl:analyze-string select="$underdot" regex="&#803;">
                                                                                                                          <xsl:non-matching-substring>     
                                                                                                                              <xsl:value-of select="."/>
                                                                                                                          </xsl:non-matching-substring>
                                                                                                                      </xsl:analyze-string>
                                                                                                                  </unclear>
                                                                                                              </xsl:matching-substring>
                                                                                                              <xsl:non-matching-substring>
                                                                                                                  <xsl:value-of select="."/>
                                                                                                              </xsl:non-matching-substring>
                                                                                                          </xsl:analyze-string>
                                                                                                      </abbr>
                                                                                                      <ex>
                                                                                                          <xsl:analyze-string select=" regex-group(4)" regex="\-\-\-">
                                                                                                              <xsl:matching-substring>
                                                                                                                  <xsl:text>-</xsl:text>
                                                                                                              </xsl:matching-substring>
                                                                                                              <xsl:non-matching-substring>
                                                                                                                  <xsl:analyze-string regex="\?" select=".">
                                                                                                                      <xsl:matching-substring>
                                                                                                                          <xsl:attribute name="cert">
                                                                                                                              <xsl:text>low</xsl:text>
                                                                                                                          </xsl:attribute>
                                                                                                                      </xsl:matching-substring>
                                                                                                                      <xsl:non-matching-substring>
                                                                                                                          <xsl:value-of select="."/>
                                                                                                                      </xsl:non-matching-substring>
                                                                                                                  </xsl:analyze-string>
                                                                                                              </xsl:non-matching-substring>
                                                                                                          </xsl:analyze-string>
                                                                                                      </ex>
                                                                                                      <xsl:value-of select=" regex-group(5)"/>
                                                                                                  </expan>
                                                                                              </xsl:matching-substring>
                                                                                              <xsl:non-matching-substring>
                                                                                                  <!--              expan + abbr + eventually ? in ex-->
                                                                                                  <xsl:analyze-string select="."
                                                                                                      regex="([A-Za-z0-9]+)\((.*?)\)([A-Za-z0-9]+)*">
                                                                                                      <xsl:matching-substring>
                                                                                                          <expan>
                                                                                                              <abbr>
                                                                                                                  <!--unclear &#803; -->
                                                                                                                  <xsl:analyze-string select="regex-group(1)" regex="((\w&#803;)+)">
                                                                                                                      <xsl:matching-substring>
                                                                                                                          <unclear>
                                                                                                                              <xsl:variable name="underdot">
                                                                                                                                  <xsl:value-of select="regex-group(1)"/>
                                                                                                                              </xsl:variable>
                                                                                                                              <xsl:analyze-string select="$underdot" regex="&#803;">
                                                                                                                                  <xsl:non-matching-substring>     
                                                                                                                                      <xsl:value-of select="."/>
                                                                                                                                  </xsl:non-matching-substring>
                                                                                                                              </xsl:analyze-string>
                                                                                                                          </unclear>
                                                                                                                      </xsl:matching-substring>
                                                                                                                      <xsl:non-matching-substring>
                                                                                                                          <xsl:value-of select="."/>
                                                                                                                      </xsl:non-matching-substring>
                                                                                                                  </xsl:analyze-string>
                                                                                                              </abbr>
                                                                                                              <ex>
                                                                                                                  <xsl:analyze-string select=" regex-group(2)" regex="\-\-\-">
                                                                                                                      <xsl:matching-substring>
                                                                                                                          <xsl:text>-</xsl:text>
                                                                                                                      </xsl:matching-substring>
                                                                                                                     
                                                                                                                              <xsl:non-matching-substring>
                                                                                                                                  <xsl:value-of select="."/>
                                                                                                                              </xsl:non-matching-substring>
                                                                                                                          </xsl:analyze-string>
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
                                                                                                                                          <xsl:analyze-string select="." regex="\-\-\-">    
                                                                                                                                              <xsl:matching-substring>
                                                                                                                                                  <gap reason="lost" extent="unknown" unit="character"/>
                                                                                                                                                  <!--                                                                                               it works in terms of search: it does not in terms of html transformation, cause it creates double breackets in the middle of a supplied...
  this is probably something which would then need to be twicked by the start.edition stylesheets?
  -->
                                                                                                                                              </xsl:matching-substring>
                                                                                                                                              <xsl:non-matching-substring>
                                                                                                                                                  <xsl:analyze-string select="." regex="\-">    
                                                                                                                                                      <xsl:matching-substring>
                                                                                                                                                          <gap reason="lost" quantity="1" unit="character"/>
                                                                                                                                                      </xsl:matching-substring>
                                                                                                                                                      <xsl:non-matching-substring>
                                                                                                                                                          <xsl:analyze-string select="." regex="((\w+)\?)">
                                                                                                                                                              <xsl:matching-substring>
                                                                                                                                                                  <xsl:value-of select="regex-group(2)"/>
                                                                                                                                                                  <certainty locus="name" match="preceding-sibling::text()" cert="low"/>
                                                                                                                                                                  <!--                            not sure this is actually fine.           
                                                                               needs to be handled by start edition stylesheets                      -->
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
                                                                                      </supplied>
                                                                                  </xsl:matching-substring>
                                                                                  <xsl:non-matching-substring>                                                                
                                                                                      
 <!-- (sic) -->
                                                  <xsl:analyze-string select="." regex="\((!)\)">
                                                  <xsl:matching-substring>
                                                      <xsl:text> </xsl:text>
                                                  <note>sic</note>
                                                  </xsl:matching-substring>
                                                  <xsl:non-matching-substring>
<!-- b(ene?) -->
                                                  <xsl:analyze-string select="."
                                                  regex="([A-Za-z0-9]+)\(([A-Za-z0-9]+)\?\)([A-Za-z0-9]+)*">
                                                  <xsl:matching-substring>
                                                  <expan>
                                                      <abbr>
                                                          <!--unclear &#803; -->
                                                          <xsl:analyze-string select="regex-group(1)" regex="((\w&#803;)+)">
                                                              <xsl:matching-substring>
                                                                  <unclear>
                                                                      <xsl:variable name="underdot">
                                                                          <xsl:value-of select="regex-group(1)"/>
                                                                      </xsl:variable>
                                                                      <xsl:analyze-string select="$underdot" regex="&#803;">
                                                                          <xsl:non-matching-substring>     
                                                                              <xsl:value-of select="."/>
                                                                          </xsl:non-matching-substring>
                                                                      </xsl:analyze-string>
                                                                  </unclear>
                                                              </xsl:matching-substring>
                                                              <xsl:non-matching-substring>
                                                                  <xsl:value-of select="."/>
                                                              </xsl:non-matching-substring>
                                                          </xsl:analyze-string>
                                                      </abbr>
                                                  <ex>
                                                      <xsl:analyze-string select=" regex-group(2)" regex="\-\-\-">
                                                          <xsl:matching-substring>
                                                              <xsl:text>-</xsl:text>
                                                          </xsl:matching-substring>
                                                          <xsl:non-matching-substring>
                                                              <xsl:analyze-string regex="\?" select=".">
                                                                  <xsl:matching-substring>
                                                                      <xsl:attribute name="cert">
                                                                          <xsl:text>low</xsl:text>
                                                                      </xsl:attribute>
                                                                  </xsl:matching-substring>
                                                                  <xsl:non-matching-substring>
                                                                      <xsl:value-of select="."/>
                                                                  </xsl:non-matching-substring>
                                                              </xsl:analyze-string>
                                                          </xsl:non-matching-substring>
                                                      </xsl:analyze-string>
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
                                                          <!--unclear &#803; -->
                                                          <xsl:analyze-string select="regex-group(1)" regex="((\w&#803;)+)">
                                                              <xsl:matching-substring>
                                                                  <unclear>
                                                                      <xsl:variable name="underdot">
                                                                          <xsl:value-of select="regex-group(1)"/>
                                                                      </xsl:variable>
                                                                      <xsl:analyze-string select="$underdot" regex="&#803;">
                                                                          <xsl:non-matching-substring>     
                                                                              <xsl:value-of select="."/>
                                                                          </xsl:non-matching-substring>
                                                                      </xsl:analyze-string>
                                                                  </unclear>
                                                              </xsl:matching-substring>
                                                              <xsl:non-matching-substring>
                                                                  <xsl:value-of select="."/>
                                                              </xsl:non-matching-substring>
                                                          </xsl:analyze-string>
                                                      </abbr>
                                                  </xsl:matching-substring>
                                                  <xsl:non-matching-substring>
                                                      <!--abbr+ expan (ta)mdiu situation and (contra)scr(iptor)-->
                                                      <xsl:analyze-string select="."
                                                          regex="\(([A-Za-z0-9]+)\)([A-Za-z0-9]+)\(*([A-Za-z0-9]*)\)*([A-Za-z0-9]*)">
                                                          <xsl:matching-substring>
                                                              <expan>
                                                                  <ex>
                                                                      <xsl:analyze-string select=" regex-group(1)" regex="\-\-\-">
                                                                          <xsl:matching-substring>
                                                                              <xsl:text>-</xsl:text>
                                                                          </xsl:matching-substring>
                                                                          <xsl:non-matching-substring>
                                                                              <xsl:analyze-string regex="\?" select=".">
                                                                                  <xsl:matching-substring>
                                                                                      <xsl:attribute name="cert">
                                                                                          <xsl:text>low</xsl:text>
                                                                                      </xsl:attribute>
                                                                                  </xsl:matching-substring>
                                                                                  <xsl:non-matching-substring>
                                                                                      <xsl:value-of select="."/>
                                                                                  </xsl:non-matching-substring>
                                                                              </xsl:analyze-string>
                                                                          </xsl:non-matching-substring>
                                                                      </xsl:analyze-string>
                                                                  </ex>
                                                                  
                                                                  <abbr>
                                                                      <!--unclear &#803; -->
                                                                      <xsl:analyze-string select="regex-group(2)" regex="((\w&#803;)+)">
                                                                          <xsl:matching-substring>
                                                                              <unclear>
                                                                                  <xsl:variable name="underdot">
                                                                                      <xsl:value-of select="regex-group(1)"/>
                                                                                  </xsl:variable>
                                                                                  <xsl:analyze-string select="$underdot" regex="&#803;">
                                                                                      <xsl:non-matching-substring>     
                                                                                          <xsl:value-of select="."/>
                                                                                      </xsl:non-matching-substring>
                                                                                  </xsl:analyze-string>
                                                                              </unclear>
                                                                          </xsl:matching-substring>
                                                                          <xsl:non-matching-substring>
                                                                              <xsl:value-of select="."/>
                                                                          </xsl:non-matching-substring>
                                                                      </xsl:analyze-string>
                                                                  </abbr>
                                                                  <xsl:if test="regex-group(3)">                                                                  
                                                                      <ex>
                                                                          <xsl:analyze-string select=" regex-group(3)" regex="\-\-\-">
                                                                              <xsl:matching-substring>
                                                                                  <xsl:text>-</xsl:text>
                                                                              </xsl:matching-substring>
                                                                              <xsl:non-matching-substring>
                                                                                  <xsl:analyze-string regex="\?" select=".">
                                                                                      <xsl:matching-substring>
                                                                                          <xsl:attribute name="cert">
                                                                                              <xsl:text>low</xsl:text>
                                                                                          </xsl:attribute>
                                                                                      </xsl:matching-substring>
                                                                                      <xsl:non-matching-substring>
                                                                                          <xsl:value-of select="."/>
                                                                                      </xsl:non-matching-substring>
                                                                                  </xsl:analyze-string>
                                                                              </xsl:non-matching-substring>
                                                                          </xsl:analyze-string>
                                                                      </ex>
                                                                  </xsl:if>
                                                                  <xsl:if test="regex-group(4)"> 
                                                                      <abbr>
                                                                          <!--unclear &#803; -->
                                                                          <xsl:analyze-string select="regex-group(4)" regex="((\w&#803;)+)">
                                                                              <xsl:matching-substring>
                                                                                  <unclear>
                                                                                      <xsl:variable name="underdot">
                                                                                          <xsl:value-of select="regex-group(1)"/>
                                                                                      </xsl:variable>
                                                                                      <xsl:analyze-string select="$underdot" regex="&#803;">
                                                                                          <xsl:non-matching-substring>     
                                                                                              <xsl:value-of select="."/>
                                                                                          </xsl:non-matching-substring>
                                                                                      </xsl:analyze-string>
                                                                                  </unclear>
                                                                              </xsl:matching-substring>
                                                                              <xsl:non-matching-substring>
                                                                                  <xsl:value-of select="."/>
                                                                              </xsl:non-matching-substring>
                                                                          </xsl:analyze-string>
                                                                      </abbr>
                                                                  </xsl:if>
                                                              </expan></xsl:matching-substring>
                                                          <xsl:non-matching-substring>
<!--(Luci) lib-->
                                                    <xsl:analyze-string select="."
                                                        regex="  &#12296;&#12296;(.*?)&#12297; &#12297;  ">
                                                          <xsl:matching-substring>
                                                              <add place="overstrike">
                                                              <xsl:value-of select="regex-group(1)"/>
                                                              </add>
                                                          </xsl:matching-substring>
                                                          <xsl:non-matching-substring>
    <!--        ((:crux))            -->
                                                              <xsl:analyze-string select="."
                                                                  regex="\(\(:(\w*)\)\)">
                                                                  <xsl:matching-substring>
                                                                                  <g>
                                                                                     <xsl:attribute name="type">
                                                                                         <xsl:value-of select="regex-group(1)"/>
                                                                                     </xsl:attribute> 
                                                                                  </g>
                                                                  </xsl:matching-substring>
                                                                  <xsl:non-matching-substring>
      <!--        ((abc))            -->
                                                                      <xsl:analyze-string select="."
                                                                          regex="\(\((\w*\s*\w*\s*\w*\s*\w*\s*\w*\s*\w*\s*)\)\)">
                                                                          <xsl:matching-substring>
                                                                              <g>
                                                                                  <xsl:attribute name="type">
                                                                                      <xsl:text>descriptive</xsl:text>
                                                                                  </xsl:attribute> 
                                                                                      <xsl:value-of select="regex-group(1)"/>
                                                                                   </g>
                                                                          </xsl:matching-substring>
                                                                          <xsl:non-matching-substring>
                                                                              
                                                                      <!--     
     Augg. (:Augusti duo)                                                          \w+\.\s\(\:.*\)  
    e simili con g                                                                          <expan><abbr>Aug<am>g</am></abbr><ex>usti duo</ex></expan>
    (che è un <am/> non un abbreviazione)
    coss. (consolibus)                                                                  <expan><abbr>co</abbr><ex>s</ex><abbr><am>s</am></abbr><ex>solibus</ex></expan>-->
                                                                      <xsl:analyze-string select="."
                                                                          regex="((\w+)\.)\s\(:(\w+\s*)*\)">
                                                                          <xsl:matching-substring>
                                                                              <expan>
                                                                                  <abbr>
                                                                                      <am>
                                                                                          <xsl:value-of select=" regex-group(2)"/>
                                                                                      </am>
                                                                                  </abbr>
                                                                                  <ex><xsl:value-of select=" regex-group(3)"/></ex></expan>
                                                                          </xsl:matching-substring>
                                                                          <xsl:non-matching-substring>
<!--                   
    IIvir (:duovir)                                                                         <expan><abbr><am><n value="2">II</n>vir</am></abbr><ex>duovir</ex></expan>
    IIIvir (:tresvir)                                                                        <expan><abbr><am><n value="3">III</n>vir</am></abbr><ex>tresvir</ex></expan>
    IIIIvir (:quattuorvir)                                                              <expan><abbr><am><n value="4">IIII</n>vir</am></abbr><ex>quattuorvir</ex></expan>
    VIvir (:sevir)                                                                           <expan><abbr><am><n value="6">VI</n>vir</am></abbr><ex>sevir</ex></expan>
   
                                                                              -->
                                                                              <xsl:analyze-string select="."
                                                                                  regex="((II|III|IIII|VI)vir)\s\(:(\w+\s*)*\)">
                                                                                  <xsl:matching-substring>
                                                                                      <expan>
                                                                                          <abbr>
                                                                                              <am>
                                                                                                      <xsl:value-of select=" regex-group(1)"/>
                                                                                                  </am>
                                                                                          </abbr>
                                                                                          <ex>
                                                                                              <xsl:analyze-string select=" regex-group(3)" regex="\-\-\-">
                                                                                                  <xsl:matching-substring>
                                                                                                      <xsl:text>-</xsl:text>
                                                                                                  </xsl:matching-substring>
                                                                                                  <xsl:non-matching-substring>
                                                                                                      <xsl:analyze-string regex="\?" select=".">
                                                                                                          <xsl:matching-substring>
                                                                                                              <xsl:attribute name="cert">
                                                                                                                  <xsl:text>low</xsl:text>
                                                                                                              </xsl:attribute>
                                                                                                          </xsl:matching-substring>
                                                                                                          <xsl:non-matching-substring>
                                                                                                              <xsl:value-of select="."/>
                                                                                                          </xsl:non-matching-substring>
                                                                                                      </xsl:analyze-string>
                                                                                                  </xsl:non-matching-substring>
                                                                                              </xsl:analyze-string>
                                                                                          </ex>
                                                                                      </expan>
                                                                                  </xsl:matching-substring>
                                                                                  <xsl:non-matching-substring>
                                                                                      
                                                                      
     <!--co(n)s(ul)-->
                                                          <xsl:analyze-string select="."
                                                              regex="([A-Za-z0-9]+)\(([A-Za-z0-9]+)\)([A-Za-z0-9]+)\(([A-Za-z0-9]+)\)([A-Za-z0-9]+)*">
                                                              <xsl:matching-substring>
                                                                  <expan>
                                                                      <abbr>
                                                                          <!--unclear &#803; -->
                                                                          <xsl:analyze-string select="regex-group(1)" regex="((\w&#803;)+)">
                                                                              <xsl:matching-substring>
                                                                                  <unclear>
                                                                                      <xsl:variable name="underdot">
                                                                                          <xsl:value-of select="regex-group(1)"/>
                                                                                      </xsl:variable>
                                                                                      <xsl:analyze-string select="$underdot" regex="&#803;">
                                                                                          <xsl:non-matching-substring>     
                                                                                              <xsl:value-of select="."/>
                                                                                          </xsl:non-matching-substring>
                                                                                      </xsl:analyze-string>
                                                                                  </unclear>
                                                                              </xsl:matching-substring>
                                                                              <xsl:non-matching-substring>
                                                                                  <xsl:value-of select="."/>
                                                                              </xsl:non-matching-substring>
                                                                          </xsl:analyze-string>
                                                                      </abbr>
                                                                      <ex>
                                                                          <xsl:analyze-string select=" regex-group(2)" regex="\-\-\-">
                                                                              <xsl:matching-substring>
                                                                                  <xsl:text>-</xsl:text>
                                                                              </xsl:matching-substring>
                                                                              <xsl:non-matching-substring>
                                                                                  <xsl:analyze-string regex="\?" select=".">
                                                                                      <xsl:matching-substring>
                                                                                          <xsl:attribute name="cert">
                                                                                              <xsl:text>low</xsl:text>
                                                                                          </xsl:attribute>
                                                                                      </xsl:matching-substring>
                                                                                      <xsl:non-matching-substring>
                                                                                          <xsl:value-of select="."/>
                                                                                      </xsl:non-matching-substring>
                                                                                  </xsl:analyze-string>
                                                                              </xsl:non-matching-substring>
                                                                          </xsl:analyze-string>
                                                                      </ex>
                                                                      <abbr>
                                                                          <!--unclear &#803; -->
                                                                          <xsl:analyze-string select="regex-group(3)" regex="((\w&#803;)+)">
                                                                              <xsl:matching-substring>
                                                                                  <unclear>
                                                                                      <xsl:variable name="underdot">
                                                                                          <xsl:value-of select="regex-group(1)"/>
                                                                                      </xsl:variable>
                                                                                      <xsl:analyze-string select="$underdot" regex="&#803;">
                                                                                          <xsl:non-matching-substring>     
                                                                                              <xsl:value-of select="."/>
                                                                                          </xsl:non-matching-substring>
                                                                                      </xsl:analyze-string>
                                                                                  </unclear>
                                                                              </xsl:matching-substring>
                                                                              <xsl:non-matching-substring>
                                                                                  <xsl:value-of select="."/>
                                                                              </xsl:non-matching-substring>
                                                                          </xsl:analyze-string>
                                                                      </abbr>
                                                                      <ex>
                                                                          <xsl:analyze-string select=" regex-group(4)" regex="\-\-\-">
                                                                              <xsl:matching-substring>
                                                                                  <xsl:text>-</xsl:text>
                                                                              </xsl:matching-substring>
                                                                              <xsl:non-matching-substring>
                                                                                  <xsl:analyze-string regex="\?" select=".">
                                                                                      <xsl:matching-substring>
                                                                                          <xsl:attribute name="cert">
                                                                                              <xsl:text>low</xsl:text>
                                                                                          </xsl:attribute>
                                                                                      </xsl:matching-substring>
                                                                                      <xsl:non-matching-substring>
                                                                                          <xsl:value-of select="."/>
                                                                                      </xsl:non-matching-substring>
                                                                                  </xsl:analyze-string>
                                                                              </xsl:non-matching-substring>
                                                                          </xsl:analyze-string>
                                                                      </ex>
                                                                      <xsl:value-of select=" regex-group(5)"/>
                                                                  </expan>
                                                              </xsl:matching-substring>
                                                              <xsl:non-matching-substring>
        <!--expan + abbr-->
                                                                  <xsl:analyze-string select="."
                                                                      regex="([A-Za-z0-9]+)\(([A-Za-z0-9]+)\)([A-Za-z0-9]+)*">
                                                                      <xsl:matching-substring>
                                                                          <expan>
                                                                              <abbr>
                                                                                  <!--unclear &#803; -->
                                                                                  <xsl:analyze-string select="regex-group(1)" regex="((\w&#803;)+)">
                                                                                      <xsl:matching-substring>
                                                                                          <unclear>
                                                                                              <xsl:variable name="underdot">
                                                                                                  <xsl:value-of select="regex-group(1)"/>
                                                                                              </xsl:variable>
                                                                                              <xsl:analyze-string select="$underdot" regex="&#803;">
                                                                                                  <xsl:non-matching-substring>     
                                                                                                      <xsl:value-of select="."/>
                                                                                                  </xsl:non-matching-substring>
                                                                                              </xsl:analyze-string>
                                                                                          </unclear>
                                                                                      </xsl:matching-substring>
                                                                                      <xsl:non-matching-substring>
                                                                                          <xsl:value-of select="."/>
                                                                                      </xsl:non-matching-substring>
                                                                                  </xsl:analyze-string>
                                                                              </abbr>
                                                                              <ex>
                                                                                  <xsl:analyze-string select=" regex-group(2)" regex="\-\-\-">
                                                                                      <xsl:matching-substring>
                                                                                          <xsl:text>-</xsl:text>
                                                                                      </xsl:matching-substring>
                                                                                      <xsl:non-matching-substring>
                                                                                                  <xsl:value-of select="."/>
                                                                                              </xsl:non-matching-substring>
                                                                                          </xsl:analyze-string>
                                                                              </ex>
                                                                              <xsl:value-of select=" regex-group(3)"/>
                                                                          </expan>
                                                                      </xsl:matching-substring>
                                                                      <xsl:non-matching-substring>

<!--subaudible words -->
                                                      <xsl:analyze-string select="."
                                                          regex="(&#12296;):(\w*?)(&#12297;)">
                                                          <xsl:matching-substring>
                                                              <supplied reason="subaudible">
                                                                  <xsl:value-of select="regex-group(2)"/>
                                                              </supplied>
                                                          </xsl:matching-substring>
                                                          <xsl:non-matching-substring>
<!--macerie (:maceria)         -->
                                                              <xsl:analyze-string select="."
                                                                  regex="(\w+)(\s\(:(\w+)\))">
                                                                  <xsl:matching-substring>
                                                                      <choice>
                                                                          <corr>
                                                                              <xsl:value-of select="regex-group(1)"/>
                                                                          </corr>
                                                                          <sic>
                                                                              <xsl:value-of select="regex-group(3)"/>
                                                                          </sic>
                                                                      </choice>
                                                                  </xsl:matching-substring>
                                                                  <xsl:non-matching-substring>
<!--free standing (?)-->
                                                                      <xsl:analyze-string select="."
                                                                          regex="\(*\?\)*">
                                                                          <xsl:matching-substring>
                                                                              <certainty match="preceding-sibling::node()" locus="value"/>
                                                                          </xsl:matching-substring>
                                                                          <xsl:non-matching-substring>
       <!--ligature   ̂   -->
                                                                              <xsl:analyze-string select="."
                                                                                  regex="((\ŵ)+\w)">
                                                                                  <xsl:matching-substring>
                                                                                      <hi rend="ligature">
                                                                                      <xsl:value-of select="regex-group(1)"/>
                                                                                      </hi>
                                                                                  </xsl:matching-substring>
                                                                                  <xsl:non-matching-substring>
<!--match roman numerals -->
                                                                                  <!--    <xsl:analyze-string select="."
                                                                                          regex="(M{{1,4}}(CM|CD|D?C{{0,3}})(XC|XL|L?X{{0,3}})(IX|IV|V?I{{0,3}})|M{{0,4}}(CM|C?D|D?C{{1,3}})(XC|XL|L?X{{0,3}})(IX|IV|V?I{{0,3}})|M{{0,4}}(CM|CD|D?C{{0,3}})(XC|X?L|L?X{{1,3}})(IX|IV|V?I{{0,3}})|M{{0,4}}(CM|CD|D?C{{0,3}})(XC|XL|L?X{{0,3}})(IX|I?V|V?I{{1,3}}))
                                                                                          ">
                                                                                          <xsl:matching-substring>
                                                                                              <num type="roman">
                                                                                                  <xsl:value-of select="regex-group(1)"/>
                                                                                              </num>
                                                                                          </xsl:matching-substring>
                                                                                          <xsl:non-matching-substring>-->
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


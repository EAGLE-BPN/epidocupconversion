<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    version="2.0"  xmlns:skos="http://www.w3.org/2004/02/skos/core#" 
    xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#" 
    xmlns:tei="http://www.tei-c.org/ns/1.0" 
    xmlns="http://www.tei-c.org/ns/1.0" 
    exclude-result-prefixes="tei rdf skos">
        <xsl:template name="upconversion">
<xsl:param name="substitutions" tunnel="yes"/>
<!--   Gap unknown lines begining and end                             -->
                                                  <xsl:analyze-string select="."
                                                  regex="(\$\]\s+)|(\s+\[&amp;)">
                                                  <xsl:matching-substring>
                                                  <gap reason="lost" extent="unknown" unit="line"/>
                                                  </xsl:matching-substring>
                                                  <xsl:non-matching-substring>
        <!--line breaks-->
        <xsl:analyze-string select="." regex="(\s*)/(\s+)|(\s+)/(\s*)">
            <xsl:matching-substring>
                
                <xsl:text> </xsl:text><lb/>
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
 <!--del but lost line-->
                                                <xsl:analyze-string select="."
                                                    regex="\[\[\[\-\-\-\-\-\-\]\]\]">
                                                    <xsl:matching-substring>
                                                        <del rend="erasure">
                                                            <gap reason="lost" quantity="1"
                                                                unit="line"/>
                                                        </del>
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
                                                      
      <!--   uncertain Gap unknown charact begining and end                             -->
                                                      <xsl:analyze-string select="."
                                                          regex="(\$\?\])|\$\]\(\?\)|(\[&amp;\?)">
                                                          <xsl:matching-substring>
                                                              <gap reason="lost" extent="unknown" unit="character"><certainty match=".." locus="name"/></gap>
                                                          </xsl:matching-substring>
                                                          <xsl:non-matching-substring>

           <!--   Gap unknown charact begining and end                             -->
                                                      <xsl:analyze-string select="."
                                                          regex="(\$\])|(\[&amp;)">
                                                          <xsl:matching-substring>
                                                              <gap reason="lost" extent="unknown" unit="character"/>
                                                          </xsl:matching-substring>
                                                          <xsl:non-matching-substring>
           <!--     line gap                                   -->
                                                      <xsl:analyze-string select="." regex="\[(6)\]|\[(\-\-\-\-\-\-)\]">
                                                  <xsl:matching-substring>
                                                  <gap reason="lost" quantity="1" unit="line"/>
                                                  </xsl:matching-substring>
                                                  <xsl:non-matching-substring>
     <!--     unknown gap                                   -->
                                                      <xsl:analyze-string select="." regex="\[(3)\]\(\?\)|\[(\-\-\-\?)\]">
                                                          <xsl:matching-substring>
                                                              <gap reason="lost" extent="unknown" unit="character"><certainty match=".." locus="name"/></gap>
                                                          </xsl:matching-substring>
                                                          <xsl:non-matching-substring>
<!--del-->
                                                  <xsl:analyze-string select="."
                                                  regex="\[\[(.*?)\]\]">
                                                  <xsl:matching-substring>
                                                  <del rend="erasure">
                                                      <xsl:analyze-string select="regex-group(1)" regex="\-\-\-|\[\-\-\-\]">    
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
                                                                      
                                                                      
                                                      <xsl:analyze-string select="."
                                                          regex="\[(.*?)\]">
                                                          <xsl:matching-substring>
                                                              <supplied reason="lost">
                                                                  <xsl:analyze-string select="regex-group(1)"
                                                                      regex="([A-Za-z0-9]+)\(([A-Za-z0-9]+)\)([A-Za-z0-9]+)\(([A-Za-z0-9]+)\)([A-Za-z0-9]+)*">
                                                                      <xsl:matching-substring>
                                                                          <expan>
                                                                              <abbr>
                                                                                  <xsl:value-of select=" regex-group(1)"/>
                                                                              </abbr>
                                                                              <ex>     
                                                                                  <xsl:if test="contains(regex-group(2), '?')">
                                                                                      <xsl:attribute name="cert">low</xsl:attribute>
                                                                                  </xsl:if>
                                                                                  <xsl:analyze-string select="regex-group(2)" regex="(\w*?)\?">
                                                                                      <xsl:matching-substring>                                                                                        
                                                                                          <xsl:value-of select="regex-group(1)"/>
                                                                                      </xsl:matching-substring>
                                                                                      <xsl:non-matching-substring>
                                                                                          <xsl:value-of select="."/>
                                                                                      </xsl:non-matching-substring>
                                                                                  </xsl:analyze-string>
                                                                              </ex>
                                                                              <abbr>
                                                                                  <xsl:value-of select=" regex-group(3)"/>
                                                                              </abbr>
                                                                              <ex>     
                                                                                  <xsl:if test="contains(regex-group(4), '?')">
                                                                                      <xsl:attribute name="cert">low</xsl:attribute>
                                                                                  </xsl:if>
                                                                                  <xsl:analyze-string select="regex-group(4)" regex="(\w*?)\?">
                                                                                      <xsl:matching-substring>                                                                                        
                                                                                          <xsl:value-of select="regex-group(1)"/>
                                                                                      </xsl:matching-substring>
                                                                                      <xsl:non-matching-substring>
                                                                                          <xsl:value-of select="."/>
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
                                                                                          <xsl:value-of select=" regex-group(1)"/>
                                                                                      </abbr>
                                                                                      <ex>     
                                                                                          <xsl:if test="contains(regex-group(2), '?')">
                                                                                              <xsl:attribute name="cert">low</xsl:attribute>
                                                                                          </xsl:if>
                                                                                          <xsl:analyze-string select="regex-group(2)" regex="(\w*?)\?">
                                                                                              <xsl:matching-substring>                                                                                        
                                                                                                  <xsl:value-of select="regex-group(1)"/>
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
                                                                              <xsl:value-of select=" regex-group(1)"/>
                                                                          </abbr>
                                                                          <ex>     
                                                                              <xsl:if test="contains(regex-group(2), '?')">
                                                                                  <xsl:attribute name="cert">low</xsl:attribute>
                                                                              </xsl:if>
                                                                              <xsl:analyze-string select="regex-group(2)" regex="(\w*?)\?">
                                                                                  <xsl:matching-substring>                                                                                        
                                                                                      <xsl:value-of select="regex-group(1)"/>
                                                                                  </xsl:matching-substring>
                                                                                  <xsl:non-matching-substring>
                                                                                      <xsl:value-of select="."/>
                                                                                  </xsl:non-matching-substring>
                                                                              </xsl:analyze-string>
                                                                          </ex>
                                                                          <abbr>
                                                                              <xsl:value-of select=" regex-group(3)"/>
                                                                          </abbr>
                                                                          <ex>     
                                                                              <xsl:if test="contains(regex-group(4), '?')">
                                                                                  <xsl:attribute name="cert">low</xsl:attribute>
                                                                              </xsl:if>
                                                                              <xsl:analyze-string select="regex-group(4)" regex="(\w*?)\?">
                                                                                  <xsl:matching-substring>                                                                                        
                                                                                      <xsl:value-of select="regex-group(1)"/>
                                                                                  </xsl:matching-substring>
                                                                                  <xsl:non-matching-substring>
                                                                                      <xsl:value-of select="."/>
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
                                                                                      <xsl:value-of select=" regex-group(1)"/>
                                                                                  </abbr>
                                                                                  <ex>     
                                                                                      <xsl:if test="contains(regex-group(2), '?')">
                                                                                          <xsl:attribute name="cert">low</xsl:attribute>
                                                                                      </xsl:if>
                                                                                      <xsl:analyze-string select="regex-group(2)" regex="(\w*?)\?">
                                                                                          <xsl:matching-substring>                                                                                        
                                                                                              <xsl:value-of select="regex-group(1)"/>
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
          <!--     extent unknown gap                                   -->
                                                      <xsl:analyze-string select="." regex="\[(3)\]|\[(\-\-\-)\]">
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
                <!-- suppl cert low internal [bene?]-->
             <!--WORKS ONLY FOR ONE if more words in the supplied and only one is uncertain then the following analysis in the suppl part will add a certainty element-->
                                          <!--        <xsl:analyze-string select="." regex="(\[(.*?)\?\])">
                                                  <xsl:matching-substring>
                                                  <supplied reason="lost" cert="low">
                                                  <xsl:value-of
                                                  select="regex-group(2)"/>
                                                  </supplied>
                                                  </xsl:matching-substring>
                                                  <xsl:non-matching-substring>-->
<!--suppl cert low general [da]?-->
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
                                                                          <xsl:if test="contains(regex-group(5), '?')">
                                                                              <xsl:attribute name="cert">low</xsl:attribute>
                                                                          </xsl:if>
                                                                          <xsl:analyze-string select="regex-group(5)" regex="(\w*?)\?">
                                                                              <xsl:matching-substring>                                                                                        
                                                                                  <xsl:value-of select="regex-group(1)"/>
                                                                              </xsl:matching-substring>
                                                                              <xsl:non-matching-substring>
                                                                                  <xsl:value-of select="."/>
                                                                              </xsl:non-matching-substring>
                                                                          </xsl:analyze-string>
                                                                      </ex>
                                                                  </supplied>
                                                                  
                                                              </expan>
                                                              <xsl:text> </xsl:text>
                                                              <supplied reason="lost">
                                                                  <xsl:value-of select=" regex-group(6)"/>
                                                              </supplied>
                                                              
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
                                                                                      <xsl:if test="contains(regex-group(4), '?')">
                                                                                          <xsl:attribute name="cert">low</xsl:attribute>
                                                                                      </xsl:if>
                                                                                      <xsl:analyze-string select="regex-group(4)" regex="(\w*?)\?">
                                                                                          <xsl:matching-substring>                                                                                        
                                                                                              <xsl:value-of select="regex-group(1)"/>
                                                                                          </xsl:matching-substring>
                                                                                          <xsl:non-matching-substring>
                                                                                              <xsl:value-of select="."/>
                                                                                          </xsl:non-matching-substring>
                                                                                      </xsl:analyze-string>
                                                                                  </ex>
                                                                                  <xsl:value-of select=" regex-group(5)"/>
                                                                              </expan>
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
                                                                                                          <xsl:value-of select=" regex-group(1)"/>
                                                                                                      </abbr>
                                                                                                      <ex>     
                                                                                                          <xsl:if test="contains(regex-group(2), '?')">
                                                                                                              <xsl:attribute name="cert">low</xsl:attribute>
                                                                                                          </xsl:if>
                                                                                                          <xsl:analyze-string select="regex-group(2)" regex="(\w*?)\?">
                                                                                                              <xsl:matching-substring>                                                                                        
                                                                                                                  <xsl:value-of select="regex-group(1)"/>
                                                                                                              </xsl:matching-substring>
                                                                                                              <xsl:non-matching-substring>
                                                                                                                  <xsl:value-of select="."/>
                                                                                                              </xsl:non-matching-substring>
                                                                                                          </xsl:analyze-string>
                                                                                                      </ex>
                                                                                                      <abbr>
                                                                                                          <xsl:value-of select=" regex-group(3)"/>
                                                                                                      </abbr>
                                                                                                      <ex>     
                                                                                                          <xsl:if test="contains(regex-group(4), '?')">
                                                                                                              <xsl:attribute name="cert">low</xsl:attribute>
                                                                                                          </xsl:if>
                                                                                                          <xsl:analyze-string select="regex-group(4)" regex="(\w*?)\?">
                                                                                                              <xsl:matching-substring>                                                                                        
                                                                                                                  <xsl:value-of select="regex-group(1)"/>
                                                                                                              </xsl:matching-substring>
                                                                                                              <xsl:non-matching-substring>
                                                                                                                  <xsl:value-of select="."/>
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
                                                                                                                  <xsl:value-of select=" regex-group(1)"/>
                                                                                                              </abbr>
                                                                                                              <ex>     
                                                                                                                  <xsl:if test="contains(regex-group(2), '?')">
                                                                                                                      <xsl:attribute name="cert">low</xsl:attribute>
                                                                                                                  </xsl:if>
                                                                                                                  <xsl:analyze-string select="regex-group(2)" regex="(\w*?)\?">
                                                                                                                      <xsl:matching-substring>                                                                                        
                                                                                                                          <xsl:value-of select="regex-group(1)"/>
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
          <!--abbr+ expan (ta)mdiu situation and (contra)scr(iptor)-->
                                                      <xsl:analyze-string select="."
                                                          regex="\(([A-Za-z0-9]+)\)([A-Za-z0-9]+)\(*([A-Za-z0-9]*)\)*([A-Za-z0-9]*)">
                                                          <xsl:matching-substring>
                                                              <expan>
                                                                  <ex>     
                                                                      <xsl:if test="contains(regex-group(1), '?')">
                                                                          <xsl:attribute name="cert">low</xsl:attribute>
                                                                      </xsl:if>
                                                                      <xsl:analyze-string select="regex-group(1)" regex="(\w*?)\?">
                                                                          <xsl:matching-substring>                                                                                        
                                                                              <xsl:value-of select="regex-group(1)"/>
                                                                          </xsl:matching-substring>
                                                                          <xsl:non-matching-substring>
                                                                              <xsl:value-of select="."/>
                                                                          </xsl:non-matching-substring>
                                                                      </xsl:analyze-string>
                                                                  </ex>
                                                                  <abbr>
                                                                      <xsl:value-of select=" regex-group(2)"/>
                                                                  </abbr>
                                                                  <xsl:if test="regex-group(3)">                                                                  
                                                                      <ex>     
                                                                          <xsl:if test="contains(regex-group(3), '?')">
                                                                              <xsl:attribute name="cert">low</xsl:attribute>
                                                                          </xsl:if>
                                                                          <xsl:analyze-string select="regex-group(3)" regex="(\w*?)\?">
                                                                              <xsl:matching-substring>                                                                                        
                                                                                  <xsl:value-of select="regex-group(1)"/>
                                                                              </xsl:matching-substring>
                                                                              <xsl:non-matching-substring>
                                                                                  <xsl:value-of select="."/>
                                                                              </xsl:non-matching-substring>
                                                                          </xsl:analyze-string>
                                                                      </ex></xsl:if>
                                                                  <xsl:if test="regex-group(4)"> 
                                                                      <abbr>
                                                                          <xsl:value-of select=" regex-group(4)"/>
                                                                      </abbr>
                                                                  </xsl:if>
                                                              </expan></xsl:matching-substring>
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
     <!--co(n)s(ul)-->
                                                          <xsl:analyze-string select="."
                                                              regex="([A-Za-z0-9]+)\(([A-Za-z0-9]+)\)([A-Za-z0-9]+)\(([A-Za-z0-9]+)\)([A-Za-z0-9]+)*">
                                                              <xsl:matching-substring>
                                                                  <expan>
                                                                      <abbr>
                                                                          <xsl:value-of select=" regex-group(1)"/>
                                                                      </abbr>
                                                                      <ex>     
                                                                          <xsl:if test="contains(regex-group(2), '?')">
                                                                              <xsl:attribute name="cert">low</xsl:attribute>
                                                                          </xsl:if>
                                                                          <xsl:analyze-string select="regex-group(2)" regex="(\w*?)\?">
                                                                              <xsl:matching-substring>                                                                                        
                                                                                  <xsl:value-of select="regex-group(1)"/>
                                                                              </xsl:matching-substring>
                                                                              <xsl:non-matching-substring>
                                                                                  <xsl:value-of select="."/>
                                                                              </xsl:non-matching-substring>
                                                                          </xsl:analyze-string>
                                                                      </ex>
                                                                      <abbr>
                                                                          <xsl:value-of select=" regex-group(3)"/>
                                                                      </abbr>
                                                                      <ex>     
                                                                          <xsl:if test="contains(regex-group(4), '?')">
                                                                              <xsl:attribute name="cert">low</xsl:attribute>
                                                                          </xsl:if>
                                                                          <xsl:analyze-string select="regex-group(4)" regex="(\w*?)\?">
                                                                              <xsl:matching-substring>                                                                                        
                                                                                  <xsl:value-of select="regex-group(1)"/>
                                                                              </xsl:matching-substring>
                                                                              <xsl:non-matching-substring>
                                                                                  <xsl:value-of select="."/>
                                                                              </xsl:non-matching-substring>
                                                                          </xsl:analyze-string>
                                                                      </ex>
                                                                      <xsl:value-of select=" regex-group(5)"/>
                                                                  </expan>
                                                              </xsl:matching-substring>
                                                              <xsl:non-matching-substring>
        <!--expan + abbr-->
                                                                  <xsl:analyze-string select="."
                                                                      regex="([A-Za-z0-9]+)\((.*?)\)([A-Za-z0-9]+)*">
                                                                      <xsl:matching-substring>
                                                                          <expan>
                                                                              <abbr>
                                                                                 <xsl:choose> 
                                                                                     <xsl:when test="matches(regex-group(1), 'Augg')">
                                                                                      <xsl:text>Aug</xsl:text><am>g</am>
                                                                                  </xsl:when>
                                                                                     <xsl:when test="matches(regex-group(1), 'nnn')">
                                                                                         <xsl:text>n</xsl:text><am>nn</am>
                                                                                     </xsl:when>
                                                                                     <xsl:when test="matches(regex-group(1), 'nn')">
                                                                                         <xsl:text>n</xsl:text><am>n</am>
                                                                                     </xsl:when>
                                                                                     <xsl:when test="matches(regex-group(1), 'ddd')">
                                                                                         <xsl:text>d</xsl:text><am>dd</am>
                                                                                     </xsl:when>
                                                                                     <xsl:when test="matches(regex-group(1), 'dd')">
                                                                                         <xsl:text>d</xsl:text><am>d</am>
                                                                                     </xsl:when>
                                                                                  <xsl:otherwise><xsl:value-of select=" regex-group(1)"/></xsl:otherwise></xsl:choose>
                                                                              </abbr>
                                                                              <ex>     
                                                                                    <xsl:if test="contains(regex-group(2), '?')">
                                                                                        <xsl:attribute name="cert">low</xsl:attribute>
                                                                                    </xsl:if>
                                                                                  <xsl:analyze-string select="regex-group(2)" regex="(\w*?)\?">
                                                                                      <xsl:matching-substring>                                                                                        
                                                                                          <xsl:value-of select="regex-group(1)"/>
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
<!--free standing (?)-->
                                                                      <xsl:analyze-string select="."
                                                                          regex="\(*\?\)*">
                                                                          <xsl:matching-substring>
                                                                              <certainty match="preceding-sibling::node()" locus="value"/>
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
                                            </xsl:non-matching-substring>
                                        </xsl:analyze-string>
                                    </xsl:non-matching-substring>
                                </xsl:analyze-string><!--
                            </xsl:non-matching-substring>
                        </xsl:analyze-string>-->
    </xsl:template>
</xsl:stylesheet>

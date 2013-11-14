<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    version="2.0"  xmlns:skos="http://www.w3.org/2004/02/skos/core#" 
    xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#" 
    xmlns:tei="http://www.tei-c.org/ns/1.0" 
    xmlns="http://www.tei-c.org/ns/1.0" 
    exclude-result-prefixes="tei rdf skos">

    <xsl:template name="upconversion">
        <xsl:param name="substitutions" tunnel="yes"/>
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

<!--(vacat)--> 
                                <xsl:analyze-string select="." regex="\((vacat)\)">
                                    <xsl:matching-substring>
                                        <space extent="unknown" unit="character"/>
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
<!--     line gap ?                                  -->
                                                      <xsl:analyze-string select="." regex="(\s*-\s*-\s*-\s*-\s*-\s*-\s*\?+)">
                                                          <xsl:matching-substring>
                                                              <gap reason="lost" quantity="1" unit="line"><certainty locus="name" target=".."/></gap>
                                                          </xsl:matching-substring>
                                                          <xsl:non-matching-substring>
<!--     line gap                                   -->
                                                      <xsl:analyze-string select="." regex="\[*(\s*-\s*-\s*-\s*-\s*-\s*-\s*)\]*">
                                                  <xsl:matching-substring>
                                                  <gap reason="lost" quantity="1" unit="line"/>
                                                  </xsl:matching-substring>
                                                  <xsl:non-matching-substring>
 <!--     circa gap                                   -->
                                                      <xsl:analyze-string select="." regex="\[-(c.)(\d+)-(\d+)-\]">
                                                          <xsl:matching-substring>
                                                              <gap reason="lost" unit="character" precision="low">
                                                                  <xsl:attribute name="atLeast">
                                                                      <xsl:value-of select="regex-group(2)"/>
                                                                  </xsl:attribute>
                                                                  <xsl:attribute name="atMost">
                                                                      <xsl:value-of select="regex-group(3)"/>
                                                                  </xsl:attribute>
                                                              </gap>
                                                                  
                                                          </xsl:matching-substring>
                                                          <xsl:non-matching-substring>
<!--     extent unknown gap                                   -->
                                                      <xsl:analyze-string select="." regex="\[(3)\]|\[(\s*-\s*-\s*-)\]">
                                                  <xsl:matching-substring>
                                                  <gap reason="lost" quantity="3"
                                                  unit="character"/>
                                                  </xsl:matching-substring>
                                                  <xsl:non-matching-substring>
<!--      gap 1 char                                  -->
                                                      <xsl:analyze-string select="." regex="(\[-\s*-\s*-)|(\s*-\s*-\s*-\])">
                                                  <xsl:matching-substring>
                                                  <gap reason="lost" extent="unknown" unit="character"/>
                                                  </xsl:matching-substring>
                                                  <xsl:non-matching-substring>
<!--      gap 2 char                                  -->
                                                      <xsl:analyze-string select="." regex="\[(\s*-\s*-)\]">
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
 <!--suppl-->
                                                              <xsl:analyze-string select="." regex="\[(.*?)\]">
                                                                  <xsl:matching-substring>
                                                                      <supplied reason="lost">
                                                                          <xsl:variable name="supplied"><xsl:value-of select="regex-group(1)"/></xsl:variable>
                                                                          <xsl:analyze-string select="$supplied"
                                                                              regex="([A-Za-z0-9]+)\(([A-Za-z0-9]+)\)([A-Za-z0-9]*)\(*([A-Za-z0-9]*)\)*([A-Za-z0-9]*)">
                                                                              <xsl:matching-substring>
                                                                                  <expan>
                                                                                      <abbr>
                                                                                          <xsl:value-of select=" regex-group(1)"/>
                                                                                      </abbr>
                                                                                      <ex>
                                                                                          <xsl:value-of select=" regex-group(2)"/>
                                                                                      </ex>
                                                                                      <xsl:if test="regex-group(3)">                                                                  
                                                                                          <abbr>
                                                                                              <xsl:value-of select=" regex-group(3)"/>
                                                                                          </abbr></xsl:if>
                                                                                      <xsl:if test="regex-group(4)"> 
                                                                                          <ex>
                                                                                              <xsl:value-of select=" regex-group(4)"/>
                                                                                          </ex>
                                                                                      </xsl:if>
                                                                                      <xsl:if test="regex-group(5)">
                                                                                          <xsl:value-of select=" regex-group(5)"/>
                                                                                      </xsl:if>
                                                                                  </expan>
                                                                              </xsl:matching-substring>
                                                                              <xsl:non-matching-substring>
                                                                                  <!--punto-->
                                                                                  <xsl:analyze-string select="." regex="•|·">
                                                                                      <xsl:matching-substring>
                                                                                          <g type="stop"/>
                                                                                      </xsl:matching-substring>
                                                                                      <xsl:non-matching-substring>
                                                                                      <xsl:value-of select="."/>
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
                                                      regex="((\w)*?)\(-\s*-\s*-\s*\)">
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
 <!--expan + abbr --> 
                                                              <xsl:analyze-string select="."
                                                                  regex="([\p{{Ps}}A-Za-z0-9\p{{Pe}}]+)\(([A-Za-z0-9]+)\)([A-Za-z0-9]+)*">
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
 
<!--(centuria)-->
                                                      <xsl:analyze-string select="."
                                                          regex="\(centuria\)">
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
           <!--(denarios)         -->
                                                              <xsl:analyze-string select="."
                                                                  regex="\(denarios\)">
                                                                  <xsl:matching-substring>
                                                                      <expan>
                                                                          <abbr>
                                                                              <am>
                                                                                  <g type="denarios"/>
                                                                              </am>
                                                                          </abbr>
                                                                          <ex>
                                                                              <xsl:text>denarius</xsl:text>
                                                                          </ex>
                                                                      </expan>
                                                                  </xsl:matching-substring>
                                                                  <xsl:non-matching-substring>
                                                                      <!--punto-->
                                                                      <xsl:analyze-string select="." regex="•|·">
                                                                          <xsl:matching-substring>
                                                                              <g type="stop"/>
                                                                          </xsl:matching-substring>
                                                                          <xsl:non-matching-substring>
<!--          ORIG                   !!!only where unmatched above!!!        -->
                                                                      <xsl:analyze-string select="."
                                                                          regex="(\p{{Lu}})">
                                                                          <xsl:matching-substring>
                                                                              <orig>
                                                                                  <xsl:value-of select="regex-group(1)"/>
                                                                              </orig>
                                                                              
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
                </xsl:analyze-string>
            </xsl:non-matching-substring>
                </xsl:analyze-string>
            </xsl:non-matching-substring>
                </xsl:analyze-string>
    </xsl:template>

</xsl:stylesheet>
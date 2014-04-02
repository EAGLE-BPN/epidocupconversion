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
          <xsl:analyze-string select="." regex="=\s*/">
            <xsl:matching-substring>
                <lb break="no"/>
            </xsl:matching-substring>
            <xsl:non-matching-substring>
<!--line breaks in word -->
                <xsl:analyze-string select="." regex="(\s*)/(\s+)|(\s+)/(\s*)">
                    <xsl:matching-substring>
                        <lb/>
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
    <!--      gap unknown                               -->
                                                                <xsl:analyze-string select="." regex="\[(3)\]">
                                                                    <xsl:matching-substring>
                                                                        <gap reason="lost" extent="unknown" unit="character"/>
                                                                    </xsl:matching-substring>
                                                                    <xsl:non-matching-substring>
       <!--      gap 2 char                                  -->
                                                                <xsl:analyze-string select="." regex="\[(2)\]">
                                                                    <xsl:matching-substring>
                                                                        <gap reason="lost" quantity="2" unit="character"/>
                                                                    </xsl:matching-substring>
                                                                    <xsl:non-matching-substring>
      <!--      gap 1 char                                  -->
                                                                        <xsl:analyze-string select="." regex="\[(2)\]">
                                                                            <xsl:matching-substring>
                                                                                <gap reason="lost" quantity="1" unit="character"/>
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
      
    <!--del gap -->
                                                <xsl:analyze-string select="."
                                                    regex="&#12314;\[\-\s\-\s\-\]&#12315;">
                                                  <xsl:matching-substring>
                                                  <del rend="erasure">
                                                  <gap reason="lost" extent="unknown"
                                                  unit="character"/>
                                                  </del>
                                                  </xsl:matching-substring>
                                                  <xsl:non-matching-substring>
      <!--del suppl -->
                                                      <xsl:analyze-string select="."
                                                          regex="&#12314;((\[(\w\s)\])*)\.*&#12315;">
                                                          <xsl:matching-substring>
                                                              <del rend="erasure">
                                                                  <gap reason="lost" extent="unknown"
                                                                      unit="character"/>
                                                              </del>
                                                          </xsl:matching-substring>
                                                          <xsl:non-matching-substring>
  <!--   Gap unknown charact begining and end                             -->
                                                      <xsl:analyze-string select="."
                                                          regex="(\$\])|(\[&amp;)">
                                                          <xsl:matching-substring>
                                                              <gap reason="lost" extent="unknown" unit="character"/>
                                                          </xsl:matching-substring>
                                                          <xsl:non-matching-substring>
  
<!--del but suppl-->
                                                  <xsl:analyze-string select="."
                                                      regex="&#12314;\[(.*?)\]&#12315;">
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
                                                      regex="&#12314;(.*?)&#12315;">
                                                  <xsl:matching-substring>
                                                  <del rend="erasure">
                                                  <xsl:variable name="erased">
                                                      <xsl:value-of select="regex-group(1)"/>
                                                  </xsl:variable>
                                                      <xsl:analyze-string select="$erased"
                                                          regex="([A-Za-z]+)\(([A-Za-z]+)\)(\w)*(\((.*?)\))*">
                                                          <xsl:matching-substring>
                                                              <expan>
                                                                  <abbr>
                                                                      <xsl:value-of select=" regex-group(1)"/>
                                                                  </abbr>
                                                                  <ex>
                                                                      <xsl:value-of select=" regex-group(2)"/>
                                                                  </ex>
                                                                  <abbr>
                                                                      <xsl:value-of select="regex-group(3)"/>
                                                                  </abbr>
                                                            <xsl:if test="regex-group(4)">   
                                                                          <ex>
                                                                              <xsl:value-of select="regex-group(5)"/>
                                                                          </ex>
</xsl:if>
                                                                  
                                                              </expan>
                                                          </xsl:matching-substring>
                                                          <xsl:non-matching-substring>
<xsl:value-of select="."/>                                             
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
                                                                      <expan><abbr><xsl:value-of select="regex-group(1)"/></abbr>
                                                                      <ex><xsl:value-of select="regex-group(2)"/></ex></expan>
                                                                  </sic>
                                                              </choice>
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
                <!--[P(ublio)] situation-->
                                                                      <xsl:analyze-string select="." regex="\[([A-Za-z0-9])+\(([A-Za-z0-9]+)\)\]">
                                                                          <xsl:matching-substring>
                                                                              <supplied reason="lost">
                                                                              <expan>
                                                                                  <abbr>
                                                                                           <xsl:value-of select=" regex-group(1)"/>
                                                                                     
                                                                                  </abbr>
                                                                                      <ex>
                                                                                          <xsl:value-of select=" regex-group(2)"/>
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
                                                                                      
<!--suppl + co(n)s(ul) abbr inside it-->
                                                  <xsl:analyze-string select="." regex="\[(.*?)\]">
                                                  <xsl:matching-substring>
                                                  <supplied reason="lost">
                                                <xsl:variable name="supplied"><xsl:value-of select="regex-group(1)"/></xsl:variable>
                                                      <xsl:analyze-string select="$supplied"
                                                          regex="([A-Za-z0-9]+)\(([A-Za-z0-9]+)\)\s*([A-Za-z0-9]+)\(*([A-Za-z0-9]*)\)*([A-Za-z0-9]*)">
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
                                                                      <xsl:value-of select="."/>
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
                                                                      <xsl:value-of select=" regex-group(1)"/>
                                                                  </ex>
                                                                  <abbr>
                                                                      <xsl:value-of select=" regex-group(2)"/>
                                                                  </abbr>
                                                                  <xsl:if test="regex-group(3)">                                                                  
                                                                      <ex>
                                                                          <xsl:value-of select=" regex-group(3)"/>
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
                                                                          regex="\(\((\w*)\)\)">
                                                                          <xsl:matching-substring>
                                                                              <g>
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
                                                                                          <ex><xsl:value-of select=" regex-group(3)"/></ex></expan>
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
                                                                          <xsl:value-of select=" regex-group(2)"/>
                                                                      </ex>
                                                                      <abbr>
                                                                          <xsl:value-of select=" regex-group(3)"/>
                                                                      </abbr>
                                                                      <ex>
                                                                          <xsl:value-of select=" regex-group(4)"/>
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
                                                                                  <xsl:value-of select=" regex-group(1)"/>
                                                                              </abbr>
                                                                              <ex>
                                                                                  <xsl:value-of select=" regex-group(2)"/>
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
                            </xsl:non-matching-substring>
                        </xsl:analyze-string>
            </xsl:non-matching-substring>
          </xsl:analyze-string>
            </xsl:non-matching-substring>
          </xsl:analyze-string>
    </xsl:template>

</xsl:stylesheet>


<!--
   OK (x 1)      &#12296;  &#12297;     〈 〉
   ok &#12296;:in latere intuentibus sinistro &#12297;
   ok &#12296;:in latere intuentibus dextro &#12297;
   ok &#12296;:in epystilio &#12297;
   ok &#12296;:in ipsa aedicula &#12297;
   ok &#12296;:in una linea &#12297;
   ok &#12296;:in parte aversa &#12297;
    
    FRAMMENTI
   ok &#12296;:frg. a&#12297;  |||||||STR||||||  
   
  ok  &#12296;:in columna I &#12297; 
    COLONNE
   
     &#12296;:servus&#12297; "PAROLE SOTTINTESE"   <supplied reason="subaudible" cert="high"></supplied>
     
  ok  macerie (:maceria)                                                               \w+\s\(\:\w+\) 
                                                                                                   <corr>macerie</corr><sic>maceria</sic>
        
    ok Augg. (:Augusti duo)                                                          \w+\.\s\(\:.*\)  
    e simili con g                                                                          <expan><abbr>Aug<am>g</am></abbr><ex>usti duo</ex></expan>
    (che è un <am/> non un abbreviazione)
    ok IIvir (:duovir)                                                                         <expan><abbr><am><n value="2">II</n>vir</am></abbr><ex>duovir</ex></expan>
    ok IIIvir (:tresvir)                                                                        <expan><abbr><am><n value="3">III</n>vir</am></abbr><ex>tresvir</ex></expan>
    ok IIIIvir (:quattuorvir)                                                              <expan><abbr><am><n value="4">IIII</n>vir</am></abbr><ex>quattuorvir</ex></expan>
    ok VIvir (:sevir)                                                                           <expan><abbr><am><n value="6">VI</n>vir</am></abbr><ex>sevir</ex></expan>
    ok coss. (consolibus)                                                                  <expan><abbr>co</abbr><ex>s</ex><abbr><am>s</am></abbr><ex>solibus</ex></expan>
    
    %%%%% CONTROLLARE CHE NON INTEREFERISCA CON I NUMERI%%%%%%
    
   ok ((:crux))                                                                                   <g type="crux"/>
    
   ok ((abc))                                                                                     <g>abc</g>
    
  ok  &#818; SOTTOLINEATO ( PREVIOUSLY READ)         <supplied reason="undefined" evidence="previouseditor">αβγ</supplied>
    
    ok {servus} servus  parole ripetute per errore                         <surplus>a</surplus>
    
ok    &#803; underdot
    
    &#12314; &#12315;〚  〛erased text                                    <del rend="erasure"></del>
        può contenere underdots
        può contenere maiuscole
        può contenere abbreviazioni
        può contenere <supplied></supplied>
        può contenere <gap></gap>
        
    &#12296;&#12296;  ... &#12297; &#12297;                                 <add place="overstrike">...</add>
    
   %%%%%%% NOTA
    <subst>
 <del rend="erasure">Imilchonis</del>
 <add place="overstrike">Himilcho</add>
</subst>            
        NOTA %%%%%%
        
     &#768; αβ &#769;   `αβ´                                                               <add place="overstrike">αβ</add>
        
   OK  &#8988;   ⌜ ⌝  angolini in alto     
    
  OK   &#770;      ̂                                                                                       <hi rend="ligature"></hi>
    ligature della lettera 
    su cui è con la seguente.
    
    &#7735;     Ḷ                                                                                   <unclear>L</unclear>
    &#7716;    Ḥ                                                                                    <unclear>H</unclear>
    &#7747;      ṃ                                                                                  <unclear>m</unclear>
    &#7865;      Ẹ                                                                                      <unclear>E</unclear>
    &#773;    ̅                                                                                          <hi rend="supraline">abc</hi>
    
   OK  = /                                                                                                       @break="no"
    
    +++                                                                                                     <gap reason="illegible" unit="character" quantity="x"/>
    +10?+ 
    
    
    NUMBERS
    
    ............
    
    -->

<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="2.0"
    xmlns:skos="http://www.w3.org/2004/02/skos/core#" xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#"
    xmlns:tei="http://www.tei-c.org/ns/1.0" xmlns="http://www.tei-c.org/ns/1.0" exclude-result-prefixes="tei rdf skos">
  
    <!--when no date is provided the element is completed with the string "unknown" 
-->
    <xsl:template match="tei:origDate[not(node())]">
        <origDate xml:lang="en">Unknown</origDate>
    </xsl:template>

    <!--the string description of the date is evaluated for matches in the vocabulary: this is currently very poor.
both a uri identifying the string description and the corresponding attributes are entered in the elements for the purpose of qurying and searching on the dates
-->
    <xsl:template match="tei:origDate">
        <xsl:param name="dateURI" tunnel="yes"/>
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
            <!--this string uniforms the dates in EDR (ONLY!) to the standard when they are in 1, 2, 3 digits. and if the NULL value 0000 appears the attribute is entirely removed-->
            <xsl:choose>
<!-- !!!!!!!!N.B.B.B.B.!!!!!!!!! 
evaluates in the template the presence of the prefix EDR in the title: 
if the template on which the transformation runs has been modified this is never going to work-->
                <xsl:when test="ancestor::tei:teiHeader//tei:title[contains(.,'EDR')]">
                    <xsl:choose>
                        <xsl:when test="./@notBefore-custom[not(contains(.,'0000'))]">
                        <xsl:attribute name="notBefore-custom">
                            <xsl:value-of select="format-number(./@notBefore-custom, '0000')"/>
                        </xsl:attribute>
                    </xsl:when>
                        
                       <xsl:when test="contains(./@notBefore-custom,'0000')"/>
</xsl:choose>
<xsl:choose>                    <xsl:when test="./@notAfter-custom[not(contains(.,'0000'))]">
                        <xsl:attribute name="notAfter-custom">
                            <xsl:value-of select="format-number(./@notAfter-custom, '0000')"/>
                        </xsl:attribute>
                    </xsl:when>
                    <xsl:when test="contains(./@notAfter-custom,'0000')"/></xsl:choose>
                    <xsl:attribute name="datingMethod">
                        <xsl:text>http://en.wikipedia.org/wiki/Julian_calendar</xsl:text>
                    </xsl:attribute>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:copy-of select="@*[not(local-name()='period')]"/>
                </xsl:otherwise>
            </xsl:choose>
            <xsl:if test="text()">
                <xsl:variable name="voc_term">
                    <xsl:choose>
                        <xsl:when
                            test="document('https://raw.githubusercontent.com/EAGLE-BPN/epidocupconversion/master/allinone/eagle-vocabulary-dating-criteria.rdf')//skos:prefLabel[lower-case(normalize-space(.))=lower-case(normalize-space(normalize-space($noquestion)))]/parent::skos:Concept[not(parent::skos:exactMatch[contains(skos:Concept/@rdf:about,'archwort')])]/@rdf:about">
                            <xsl:variable name="seq"
                                select="document('https://raw.githubusercontent.com/EAGLE-BPN/epidocupconversion/master/allinone/eagle-vocabulary-dating-criteria.rdf')//skos:prefLabel[lower-case(normalize-space(.))=lower-case(normalize-space(normalize-space($noquestion)))]/parent::skos:Concept/@rdf:about"/>
                            <xsl:value-of select="$seq[1]"/>
                        </xsl:when>
                        <xsl:otherwise>
                            <xsl:variable name="seq"
                                select="document('https://raw.githubusercontent.com/EAGLE-BPN/epidocupconversion/master/allinone/eagle-vocabulary-dating-criteria.rdf')//skos:altLabel[lower-case(normalize-space(.))=lower-case(normalize-space(normalize-space($noquestion)))]/parent::skos:Concept/@rdf:about"/>
                            <xsl:value-of select="$seq[1]"/>
                            <!--this is not very clever but gives at least coherent results and one value only when vocabularies have many possible...-->
                        </xsl:otherwise>
                    </xsl:choose>
                </xsl:variable>
                <xsl:if test="$voc_term!=''">
                    <xsl:attribute name="period">
                        <xsl:value-of select="$voc_term"/>
                    </xsl:attribute>

                    <!--checks again (avoidable actually by shortening the vairable to include all the skos:Concept??) but saves the skopeNote rather than the @rdfabout-->
                    <xsl:variable name="skopeNote">
                        <xsl:choose>
                            <xsl:when
                                test="document('https://raw.githubusercontent.com/EAGLE-BPN/epidocupconversion/master/allinone/eagle-vocabulary-dating-criteria.rdf')//skos:prefLabel[lower-case(normalize-space(.))=lower-case(normalize-space(normalize-space($noquestion)))]/parent::skos:Concept[not(parent::skos:exactMatch[contains(skos:Concept/@rdf:about,'archwort')])]/skos:scopeNote">
                                <xsl:value-of
                                    select="document('https://raw.githubusercontent.com/EAGLE-BPN/epidocupconversion/master/allinone/eagle-vocabulary-dating-criteria.rdf')//skos:prefLabel[lower-case(normalize-space(.))=lower-case(normalize-space(normalize-space($noquestion)))]/parent::skos:Concept[not(parent::skos:exactMatch[contains(skos:Concept/@rdf:about,'archwort')])]/skos:scopeNote"
                                />
                            </xsl:when>
                            <xsl:otherwise>
                                <xsl:value-of
                                    select="document('https://raw.githubusercontent.com/EAGLE-BPN/epidocupconversion/master/allinone/eagle-vocabulary-dating-criteria.rdf')//skos:altLabel[lower-case(normalize-space(.))=lower-case(normalize-space(normalize-space($noquestion)))]/parent::skos:Concept/skos:scopeNote"
                                />
                            </xsl:otherwise>
                        </xsl:choose>
                    </xsl:variable>
                    <!--checks if - or not and insert the right substring from the value of skos:scopeNote-->
                    <xsl:if test="not(@notBefore-custom)">
                        <xsl:attribute name="notBefore-custom">
                            <xsl:variable name="minus">
                                <xsl:value-of select="substring(substring-after($skopeNote, 'notBefore='), 2, 5)"/>
                            </xsl:variable>
                            <xsl:choose>
                                <xsl:when test="contains($minus,'-')">
                                    <xsl:value-of select="substring($minus, 1, 5)"/>
                                </xsl:when>
                                <xsl:otherwise>
                                    <xsl:value-of select="substring($minus, 1, 4)"/>
                                </xsl:otherwise>
                            </xsl:choose>
                        </xsl:attribute>
                    </xsl:if>

                    <xsl:if test="not(@notAfter-custom)">
                        <xsl:attribute name="notAfter-custom">
                            <xsl:variable name="minus">
                                <xsl:value-of select="substring(substring-after($skopeNote, 'notAfter='), 2, 5)"/>
                            </xsl:variable>
                            <xsl:choose>
                                <xsl:when test="contains($minus,'-')">
                                    <xsl:value-of select="substring($minus, 1, 5)"/>
                                </xsl:when>
                                <xsl:otherwise>
                                    <xsl:value-of select="substring($minus, 1, 4)"/>
                                </xsl:otherwise>
                            </xsl:choose>
                        </xsl:attribute>
                    </xsl:if>
                </xsl:if>
            </xsl:if>
            <xsl:apply-templates/>
        </xsl:copy>
    </xsl:template>
</xsl:stylesheet>

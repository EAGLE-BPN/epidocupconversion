<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    version="2.0"  xmlns:skos="http://www.w3.org/2004/02/skos/core#" 
    xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#" 
    xmlns:tei="http://www.tei-c.org/ns/1.0" 
    xmlns="http://www.tei-c.org/ns/1.0" 
    xmlns:f="http://www.filemaker.com/fmpxmlresult"
    exclude-result-prefixes="#all"
    >  
    
<!--copies info wrongly placed in conservation to the modernfindspot-->
<xsl:template match="//tei:provenance">
<provenance type="found">
<xsl:copy-of select="@*|node()"/>
<xsl:copy-of select="ancestor::tei:TEI//tei:settlement/tei:placeName"/>
<xsl:copy-of select="ancestor::tei:TEI//tei:region/tei:placeName"/>
<xsl:copy-of select="ancestor::tei:TEI//tei:country/tei:placeName"/>
</provenance>
</xsl:template>
<!--removes from msIdentifier unwanted info-->

    <xsl:template match="tei:country"/>
    <xsl:template match="tei:settlement"/>
    <xsl:template match="tei:region"/>


    <xsl:template match="//tei:placeName[not(node())]"/>

    <xsl:template match="tei:origPlace">
<origPlace>
<xsl:for-each select="./tei:placeName">
            <xsl:variable name="noquestion">
<!--in this variable all the punctuation is removed from the initial string for the purpose of matching: only what is before a ? or a , or a : is evaluated. if only ? is present, all the string before is evaluated-->
                <xsl:analyze-string select="." regex="(\w+)\?">
                    <xsl:matching-substring>
                        <xsl:value-of select="regex-group(1)"/>
                    </xsl:matching-substring>            
                    <xsl:non-matching-substring>
                        <xsl:choose>
                            <xsl:when test="matches(.,'((\w+)\s*\w*),\s((\w*\*?)\s*\w*\s*\w*)')"><xsl:value-of select="substring-before(.,',')"/></xsl:when>
                            <xsl:when test="matches(.,'((\w+)\s*\w*):\s((\w*\*?)\s*\w*\s*\w*)')"><xsl:value-of select="substring-before(.,':')"/></xsl:when>
                            <xsl:otherwise><xsl:value-of select="."/></xsl:otherwise>
                        </xsl:choose>
                    </xsl:non-matching-substring>
                </xsl:analyze-string>
            </xsl:variable>
            <xsl:variable name="voc_term">  

<!--this part checks in the dump from Trismegistos Geo for the corresponding string, and if found saves the corresponding ID-->       
                <xsl:choose> 
                    <xsl:when test="document('https://raw.githubusercontent.com/EAGLE-BPN/epidocupconversion/master/allinone/TMGeoIDToponyms.XML')//f:RESULTSET/f:ROW/f:COL[2]/f:DATA
                    [contains(lower-case(.), lower-case($noquestion))]">
                        <xsl:variable name="seq" select="document('https://raw.githubusercontent.com/EAGLE-BPN/epidocupconversion/master/allinone/TMGeoIDToponyms.XML')//f:RESULTSET/f:ROW/f:COL[2]/f:DATA
                        [contains(lower-case(.), lower-case($noquestion))]/parent::f:COL/preceding-sibling::f:COL/f:DATA"/>
                        <xsl:value-of select="$seq[1]"/>
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:variable name="seq" select="document('https://raw.githubusercontent.com/EAGLE-BPN/epidocupconversion/master/allinone/TMGeoIDToponyms.XML')//f:RESULTSET/f:ROW/f:COL[3]/f:DATA
                            [contains(lower-case(.), lower-case($noquestion))]/ancestor::f:ROW/f:COL[1]/f:DATA"/>
                        <xsl:value-of select="$seq[1]"/>
                    </xsl:otherwise>
                    </xsl:choose>
            </xsl:variable>
        <xsl:copy>
            <xsl:copy-of select="@*[not(local-name()='ref')]"/>

<!--this part checks that the result of the matching is fine, if it is not a valid number it does not create the attribute with the uri, if it is it does-->
<xsl:variable name="tmnumber">
    <xsl:value-of select="format-number(number($voc_term),'000000')"/>
</xsl:variable>
            <xsl:if test="not($tmnumber = 'NaN')">
<xsl:attribute name="ref">
                <xsl:value-of select="concat('http://www.trismegistos.org/place/',$tmnumber)"/>
            </xsl:attribute>
</xsl:if>
            <xsl:value-of select="."/>
        </xsl:copy>
</xsl:for-each>
</origPlace>    
    </xsl:template>
</xsl:stylesheet>
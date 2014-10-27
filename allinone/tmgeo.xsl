<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    version="2.0"  xmlns:skos="http://www.w3.org/2004/02/skos/core#" 
    xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#" 
    xmlns:tei="http://www.tei-c.org/ns/1.0" 
    xmlns="http://www.tei-c.org/ns/1.0" 
    xmlns:f="http://www.filemaker.com/fmpxmlresult"
    exclude-result-prefixes="#all"
    >  
    
    <xsl:template match="tei:placeName[not(node())]">
        <placeName/>
    </xsl:template>

    
    
    <xsl:template match="tei:origPlace">
        
        <xsl:for-each select="tei:placeName">
            <xsl:variable name="noquestion">
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
            <xsl:variable name="voc_term">  <!---->       
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
            <xsl:attribute name="ref">
                <xsl:value-of select="concat('http://www.trismegistos.org/place/',format-number(number($voc_term),'000000'))"/>
            </xsl:attribute>
            <xsl:value-of select="."/>
        </xsl:copy>
</xsl:for-each>
    
    </xsl:template>
</xsl:stylesheet>
<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    exclude-result-prefixes="xs"
    version="2.0">
    
    <xsl:template  match="@*|node()">
        <xsl:copy>
            <xsl:copy-of select="@*|node()"/>
            <xsl:apply-templates/>
        </xsl:copy>
    </xsl:template>   
    
    <xsl:template match="/">
        <xsl:for-each select="origPlace/placeName">
            <place><xsl:attribute name="ref"><xsl:call-template name="tmgeoid"/></xsl:attribute><xsl:value-of select="."></xsl:value-of></place>
        </xsl:for-each>
    </xsl:template>
    <xsl:template name="tmgeoid">
        <xsl:variable name="noquestion">
            <xsl:analyze-string select="." regex="(\w+)\?">
                <xsl:matching-substring>
                    <xsl:value-of select="regex-group(1)"/>
                </xsl:matching-substring>            
                <xsl:non-matching-substring>
                    <xsl:analyze-string select="." regex="(\w+),\s(\w*)">
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
        <xsl:variable name="voc_term">  <!---->       
            <xsl:value-of select="document('tmgeosample.xml')//RESULTSET/ROW/COL[2]/DATA[contains(., $noquestion)]/parent::COL/preceding-sibling::COL/DATA"/>
            <xsl:value-of select="document('tmgeosample.xml')//RESULTSET/ROW/COL[30]/DATA[contains(., $noquestion)]/ancestor::ROW/COL[1]/DATA"/>
        </xsl:variable>
           <xsl:value-of select="concat('www.trismegistos.org/place/',format-number(number($voc_term),'000000'))"/>
    </xsl:template>
</xsl:stylesheet>
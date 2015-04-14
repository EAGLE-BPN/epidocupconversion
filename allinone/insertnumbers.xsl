<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    version="2.0"  xmlns:skos="http://www.w3.org/2004/02/skos/core#" 
    xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#" 
    xmlns:tei="http://www.tei-c.org/ns/1.0" 
    xmlns="http://www.tei-c.org/ns/1.0" 
    exclude-result-prefixes="tei rdf skos">

<xsl:template  match="tei:*" mode="lb">
    <xsl:copy>
        <xsl:copy-of select="@*"/>
        <xsl:apply-templates mode="lb"/>
    </xsl:copy>
</xsl:template>   

<xsl:template match="tei:div[@type='edition']">       
    <xsl:comment>
<xsl:value-of select="."/>
                            </xsl:comment>
    <xsl:variable name="nonumber">
        <xsl:call-template name="edition"/>
    </xsl:variable>  
    <xsl:apply-templates select="$nonumber" mode="lb"/>
</xsl:template>
    
    <xsl:template match="tei:lb[following-sibling::*[1][self::tei:gap[@unit='line']]]" mode="lb">
        <lb n="0"/>
    </xsl:template>
    
    <xsl:template match="tei:lb[not(@break)][not(following-sibling::*[1][self::tei:gap[@unit='line']])]" mode="lb">
    <lb>
        <xsl:attribute name="n"><xsl:number count="tei:lb[not(following-sibling::*[1][self::tei:gap[@unit='line']])]"/></xsl:attribute>
        <xsl:apply-templates/>
    </lb>
</xsl:template>

    <xsl:template match="tei:lb[@break][not(following-sibling::*[1][self::tei:gap[@unit='line']])]" mode="lb">
    <lb>
        <xsl:attribute name="break">no</xsl:attribute>
        <xsl:attribute name="n"><xsl:number count="tei:lb[not(following-sibling::*[1][self::tei:gap[@unit='line']])]"/></xsl:attribute>
        <xsl:apply-templates/>
    </lb>
</xsl:template>

</xsl:stylesheet>

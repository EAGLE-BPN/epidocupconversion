<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    version="2.0"    xmlns:tei="http://www.tei-c.org/ns/1.0" xmlns="http://www.tei-c.org/ns/1.0">
    
    
    <!--insert attributes in div and lb and value as numbers-->
    <xsl:template match="@* | node()">
        <xsl:copy copy-namespaces="yes">
            <xsl:apply-templates select="@* | node()"/>
        </xsl:copy>
    </xsl:template>
     
<!--  the following is wirdish... @break is inserted by edh-epidoc.xsl, but this is the only way I found to preserve numbering and distinction, which is using it to identify specific cases and then put it back...   -->
    
    <xsl:template match="tei:lb[not(@break)]">
        <lb>
            <xsl:attribute name="n"><xsl:number count="tei:lb[not(following-sibling::*[1][self::tei:gap[@unit='line']])]"/></xsl:attribute>
            <xsl:apply-templates/>
        </lb>
    </xsl:template>
    
    <xsl:template match="tei:lb[@break]">
          <lb>
              <xsl:attribute name="break">no</xsl:attribute>
              <xsl:attribute name="n"><xsl:number count="tei:lb[not(following-sibling::*[1][self::tei:gap[@unit='line']])]"/></xsl:attribute>
            <xsl:apply-templates/>
        </lb>
    </xsl:template>
    
    <xsl:template match="tei:lb[following-sibling::*[1][self::tei:gap[@unit='line']]]">
        <lb n="0"/>
    </xsl:template>
</xsl:stylesheet>
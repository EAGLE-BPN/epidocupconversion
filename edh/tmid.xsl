<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    version="2.0" xmlns:skos="http://www.w3.org/2004/02/skos/core#" 
    xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#" 
    xmlns:tei="http://www.tei-c.org/ns/1.0" 
    xmlns="http://www.tei-c.org/ns/1.0" 
    exclude-result-prefixes="tei rdf skos xs">
    
    <xsl:template match="//tei:idno[@type='URI'][not(node())]">
        
        <idno>
            <xsl:variable name="tm">
<xsl:choose>
    <xsl:when test="contains(//tei:title,',')">
        <xsl:value-of select="substring-before(//tei:title,',')"/>
</xsl:when>
<xsl:otherwise>
    <xsl:value-of select="//tei:title"/>
</xsl:otherwise>
</xsl:choose>
</xsl:variable>
            <xsl:attribute name="type">TM</xsl:attribute>
          <xsl:variable name="tminsert">
<xsl:value-of select="document('edh-tm.htm')//td[preceding-sibling::td[lower-case(.) = lower-case($tm)]]"/>
</xsl:variable>
            <xsl:choose>
                <xsl:when test="contains($tminsert,',')">
                    <xsl:value-of select="substring-before($tminsert,',')"/>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:value-of select="$tminsert"/>
                </xsl:otherwise>
            </xsl:choose>
</idno>
        <idno>
            <xsl:attribute name="type">localID</xsl:attribute>
            <xsl:value-of select="//tei:title"/>
        </idno>
    </xsl:template>
    
    <xsl:template match="//tei:idno[@type='URI'][text()[contains(.,'http://www.trismegistos.org/text/')]]">
        <idno>
            <xsl:attribute name="type">TM</xsl:attribute>
            <xsl:value-of select="substring-after(., 'http://www.trismegistos.org/text/')"/>
        </idno>
        <idno>
            <xsl:attribute name="type">localID</xsl:attribute>
            <xsl:value-of select="//tei:title"/>
        </idno>
    </xsl:template>
    
</xsl:stylesheet>
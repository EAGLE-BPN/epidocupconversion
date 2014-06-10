<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    version="2.0" xmlns:skos="http://www.w3.org/2004/02/skos/core#" 
    xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#" 
    xmlns:tei="http://www.tei-c.org/ns/1.0" 
    xmlns:crm="http://cidoc.ics.forth.gr/rdfs/cidoc_v4.2.rdfs#"
    xmlns="http://www.tei-c.org/ns/1.0" 
    exclude-result-prefixes="tei rdf skos xs crm">
    
    <xsl:template match="//tei:graphic">
        <xsl:choose>
            <xsl:when test="contains(@url, 'http://edh-www.adw.uni-heidelberg.de')">
        <graphic>
            <xsl:attribute name="url"><xsl:value-of select="concat('http://edh-www.adw.uni-heidelberg.de/fotos/', substring-after(@url, 'http://edh-www.adw.uni-heidelberg.de/edh/foto/'),'.JPG')"/></xsl:attribute>
            <desc>
                <xsl:value-of select="tei:desc"/>
                <xsl:text>, </xsl:text>
                <xsl:value-of select="document(concat(@url, '.xml'))//crm:E39.Actor"/>
                <xsl:text>(</xsl:text>
                <xsl:value-of select="document(concat(@url, '.xml'))//crm:E39.Actor/@date"/>
                <xsl:text>)</xsl:text>
                <ref>
                    <xsl:attribute name="type">licence</xsl:attribute>
                    <xsl:attribute name="target"><xsl:value-of select="document(concat(@url, '.xml'))//crm:E30.Right/@target"/></xsl:attribute>
                    <xsl:value-of select="document(concat(@url, '.xml'))//crm:E30.Right/text()"/>
                </ref>
            </desc>
        </graphic>
    </xsl:when>
    <xsl:otherwise>
        <xsl:copy>
        <xsl:attribute name="rend">externalLink</xsl:attribute>
            <xsl:copy-of select="@*|node()"/>
        </xsl:copy>
    </xsl:otherwise>
</xsl:choose>
        
    </xsl:template>
    <!--    <graphic n="0003" url="http://images.cch.kcl.ac.uk/irt/liv/full/0003.jpg">
        <desc> Ward-Perkins Archive, BSR (Sopr. DS 860 Leica) <ref type="licence"
            target="http://www.europeana.eu/rights/rr-f/">Rights Reserved – Free Access from The
            British School at Rome</ref>
        </desc>
    </graphic>
    
    rend="externalLink"
    
    -->
</xsl:stylesheet>
<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    version="2.0"  xmlns:skos="http://www.w3.org/2004/02/skos/core#" 
    xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#" 
    xmlns:tei="http://www.tei-c.org/ns/1.0" 
    xmlns="http://www.tei-c.org/ns/1.0" 
    exclude-result-prefixes="tei rdf skos">
    
    <xsl:template match="tei:region/tei:placeName[@type='modern']">
        <xsl:copy><xsl:copy-of select="@*[not(local-name()='ref')]"/></xsl:copy>
        <xsl:apply-templates/>
    </xsl:template> 

    <xsl:template match="tei:placeName[@type='provinceItalicRegion']">
        <xsl:copy><xsl:copy-of select="@*[not(local-name()='ref')]"/></xsl:copy>
        <xsl:apply-templates/>
    </xsl:template> 

<!--       <xsl:template match="tei:origPlace/tei:placeName[not(@type='provinceItalicRegion')]">
<placeName>        
    <xsl:copy-of select="@*[not(local-name()='ref')]"/>
        </placeName>
        <xsl:apply-templates/>
    </xsl:template> 

  <xsl:template match="tei:repository">
        <xsl:copy>
            <xsl:copy-of select="@*[not(local-name()='ref')]"/>
        </xsl:copy>
        <xsl:apply-templates/>
    </xsl:template> -->
    
    
    
</xsl:stylesheet>

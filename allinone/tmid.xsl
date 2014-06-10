<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    version="2.0" xmlns:skos="http://www.w3.org/2004/02/skos/core#" 
    xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#" 
    xmlns:tei="http://www.tei-c.org/ns/1.0" 
    xmlns="http://www.tei-c.org/ns/1.0" 
    exclude-result-prefixes="tei rdf skos xs">
    
    <xsl:template match="//tei:idno[@type='URI'][not(node())]">
        <idno><xsl:attribute name="type">TM</xsl:attribute>
            <xsl:variable select="//tei:title" name="tm"/>
            <xsl:value-of select="document('edh-tm.htm')//td[preceding-sibling::td[lower-case(.) = lower-case($tm)]]"/>
</idno>
    </xsl:template>
</xsl:stylesheet>
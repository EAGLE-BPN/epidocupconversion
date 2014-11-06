<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	version="2.0"  xmlns:skos="http://www.w3.org/2004/02/skos/core#" 
	xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#" 
	xmlns:tei="http://www.tei-c.org/ns/1.0" 
	xmlns="http://www.tei-c.org/ns/1.0" 
	xmlns:f="http://www.filemaker.com/fmpxmlresult"
	exclude-result-prefixes="#all"
	>  

	<xsl:template match="//tei:origDate/@notBefore-custom">
		<xsl:attribute name="notBefore-custom">
<xsl:choose>
			<xsl:when test="contains(.,'-')">
				<xsl:text>-</xsl:text>
				<xsl:value-of select="format-number(., '0000')"/>
			</xsl:when>
			<xsl:otherwise>
				<xsl:value-of select="format-number(., '0000')"/>
			</xsl:otherwise>
		</xsl:choose></xsl:attribute>
	</xsl:template>
</xsl:stylesheet>

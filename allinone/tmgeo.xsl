<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    exclude-result-prefixes="xs"
    version="2.0">
    <xsl:template match="/">
        <xsl:for-each select="root/RESULTSET/ROW/COL[position()=1]/DATA">
            <xsl:element name="x"><xsl:value-of select="ancestor::ROW/@RECORDID"/></xsl:element>
        </xsl:for-each>
    </xsl:template>
</xsl:stylesheet>
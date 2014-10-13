<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:xs="http://www.w3.org/2001/XMLSchema"
	exclude-result-prefixes="xs"
	version="2.0">
	
	<xsl:variable name="inscription">fm00000001
       <xsl:sequence select="document(concat('/newfiles2/', '\w\w\d\d\d\d\d\d\d\d', '.xml'))"/>
	</xsl:variable>
<xsl:template name="list">
<list>
<xsl:for-each select="$inscription">
<item><xsl:value-of select="//idno[@localID]"/></item>
</xsl:for-each></list>
</xsl:template>
</xsl:stylesheet>
<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    version="2.0"  xmlns:skos="http://www.w3.org/2004/02/skos/core#" 
    xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#" 
    xmlns:tei="http://www.tei-c.org/ns/1.0" 
    xmlns="http://www.tei-c.org/ns/1.0" 
    exclude-result-prefixes="tei rdf skos">
    
    
    <xsl:variable name="verschollen" select="//tei:repository/text()"/>
    
    <xsl:template match="tei:support">
        <xsl:copy>
            <xsl:apply-templates select="@*|node()"/>
         <rs type="statPreserv">
        <xsl:if test="$verschollen='verschollen'">
            
                <xsl:value-of select="$verschollen"/>
               
        </xsl:if> 
         </rs>
        </xsl:copy>
    </xsl:template>
</xsl:stylesheet>
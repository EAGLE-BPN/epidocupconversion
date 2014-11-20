<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet 
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="2.0"  
    xmlns:skos="http://www.w3.org/2004/02/skos/core#" 
    xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#" 
    xmlns:rdfs="http://www.w3.org/2000/01/rdf-schema#"
    xmlns:tei="http://www.tei-c.org/ns/1.0"
    xmlns:dct="http://purl.org/dc/terms/"
    xmlns:map="http://www.w3c.rl.ac.uk/2003/11/21-skos-mapping#"
    xmlns:dc="http://purl.org/dc/elements/1.1/"
    xmlns="http://www.tei-c.org/ns/1.0"
    exclude-result-prefixes="tei rdf skos">
    
   <xsl:template match="/">
      
       <xsl:text>
    \hline
    \multicolumn{1}{|c|}{\textbf{Term}} &amp;
    \multicolumn{1}{c|}{\textbf{Type}} &amp; 
    \multicolumn{1}{c|}{\textbf{Annotations}} &amp; 
    \multicolumn{1}{c|}{\textbf{Lang}}
    \tabularnewline
    \hline 
    \endfirsthead
    \multicolumn{4}{c}
    {{\bfseries \tablename\ \thetable{} -- continued from previous page}} \tabularnewline
    \hline 
    \multicolumn{1}{c}{\textbf{Term}} &amp;
    \multicolumn{1}{c|}{\textbf{Type}} &amp;
    \multicolumn{1}{c|}{\textbf{Annotations}} &amp; 
    \multicolumn{1}{c|}{\textbf{Lang}}
    \tabularnewline
    \hline 
    \endhead
    \hline 
    \multicolumn{4}{|r|}{{ -- continued on next page}} \tabularnewline 
    \hline
    \endfoot
    \hline \hline
    \endlastfoot
    \hline  
    </xsl:text>
        <xsl:apply-templates mode="a"/>
    <xsl:text>    \hline
    \end{longtable}</xsl:text>
    </xsl:template>
    
    <xsl:template match="skos:Concept" mode="a">
        <xsl:variable name="x" select="@rdf:about"/>
        <xsl:text>\hline\hline</xsl:text>
        <xsl:apply-templates mode="b"/> 
        <xsl:text>&amp; </xsl:text>definition and examples<xsl:text> &amp; </xsl:text><xsl:value-of select="document('eagle-vocabulary-material-links-to-thesaurus.rdf')//skos:Concept[@rdf:about=$x]/skos:closeMatch/skos:Concept/@rdf:about"/><xsl:text> &amp; \\</xsl:text>
    </xsl:template>
    
    <xsl:template match="skos:prefLabel" mode="b"><xsl:value-of select="."/> <xsl:text> &amp; &amp; &amp; </xsl:text><xsl:value-of select="@xml:lang"/><xsl:text> \\</xsl:text> 
        <xsl:text> &amp; URI &amp; </xsl:text><xsl:value-of select="parent::skos:Concept/@rdf:about"/><xsl:text> &amp; \\ </xsl:text> </xsl:template>
    <xsl:template match="skos:scopeNote" mode="b"><xsl:for-each select="."><xsl:text> &amp; definition &amp;</xsl:text><xsl:value-of select="."/><xsl:text>&amp;</xsl:text> <xsl:value-of select="@xml:lang"/>\\  </xsl:for-each></xsl:template>
    <xsl:template match="skos:historyNote" mode="b"><xsl:for-each select="."><xsl:text> &amp; examples &amp;</xsl:text><xsl:value-of select="."/><xsl:text>&amp;</xsl:text> <xsl:value-of select="@xml:lang"/>\\  </xsl:for-each></xsl:template>
    <xsl:template match="skos:note" mode="b"><xsl:for-each select="."><xsl:text> &amp; bibliography &amp;</xsl:text><xsl:value-of select="."/><xsl:text>&amp;</xsl:text> <xsl:value-of select="@xml:lang"/>\\  </xsl:for-each></xsl:template>
    <xsl:template match="skos:exactMatch" mode="b"><xsl:for-each select="."><xsl:text>&amp; </xsl:text>same as<xsl:text> &amp; </xsl:text> <xsl:text>\href{</xsl:text><xsl:value-of select="skos:Concept/@rdf:about"/><xsl:text>}{</xsl:text><xsl:value-of select="skos:Concept/skos:prefLabel"/><xsl:text>}</xsl:text> <xsl:text> &amp; </xsl:text> <xsl:value-of select="skos:Concept/skos:prefLabel/@xml:lang"/><xsl:text> \\</xsl:text>
    </xsl:for-each></xsl:template>
    <xsl:template match="skos:altLabel" mode="b"><xsl:for-each select="."><xsl:text>&amp; </xsl:text>alternative term<xsl:text> &amp; </xsl:text><xsl:value-of select="."/><xsl:text> &amp; </xsl:text><xsl:value-of select="@xml:lang"/><xsl:text> \\</xsl:text></xsl:for-each></xsl:template>
    <xsl:template match="skos:related" mode="b"><xsl:for-each select="."><xsl:text>&amp; </xsl:text>related term<xsl:text> &amp; </xsl:text><xsl:value-of select="@rdf:resource"/><xsl:text> &amp; \\</xsl:text></xsl:for-each></xsl:template>
    <xsl:template match="skos:broader" mode="b"><xsl:for-each select="."><xsl:text>&amp; </xsl:text>contained in<xsl:text> &amp; </xsl:text><xsl:value-of select="@rdf:resource"/><xsl:text> &amp; \\</xsl:text></xsl:for-each></xsl:template>
    <xsl:template match="skos:narrower" mode="b"><xsl:for-each select="."><xsl:text>&amp; </xsl:text>includes<xsl:text> &amp; </xsl:text><xsl:value-of select="@rdf:resource"/><xsl:text> &amp; \\</xsl:text></xsl:for-each></xsl:template>
    <xsl:template match="dct:created" mode="b"><xsl:text>&amp; </xsl:text>created<xsl:text> &amp; </xsl:text><xsl:value-of select="."/><xsl:text> &amp; \\</xsl:text></xsl:template>
    <xsl:template match="dct:modified" mode="b"><xsl:text>&amp; </xsl:text>modified<xsl:text> &amp; </xsl:text><xsl:value-of select="."/><xsl:text> &amp; \\</xsl:text></xsl:template>
    
</xsl:stylesheet>
<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    version="2.0"  xmlns:skos="http://www.w3.org/2004/02/skos/core#" 
    xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#" 
    xmlns:tei="http://www.tei-c.org/ns/1.0" 
    xmlns="http://www.tei-c.org/ns/1.0" 
    exclude-result-prefixes="tei rdf skos">
    
    <xsl:template match="@* | node()">
        <xsl:copy copy-namespaces="yes">
            <xsl:apply-templates select="@* | node()"/>
        </xsl:copy>
    </xsl:template>
<!--    https://raw.githubusercontent.com/EAGLE-BPN/epidocupconversion/master/allinone/-->
    
    <!--  Create descriptive Title required from Europeana from Object Type and Inscription Type  -->
    <xsl:include href="maketitle.xsl"/>
        
<!--  adds in specific elements a @ref with the corresponding url from the EAGLE Tematres Vocabularies -->
    <xsl:include href="popwithvoc.xsl"/>
    
<!--    breaks up sections and call templates to normalize ()[] and to convert in epidoc -->
    <xsl:include href="textstructure.xsl"/>
    
    <!--breaks brackets in unique meaning ones as much as possible preparing things for the next step-->
    <xsl:include href="brackets.xsl"/>


<!--  Takes all brackets sets and other diacritict and substitutes them with markup  -->
    <xsl:include href="upconversion.xsl"/>    
    
    <!--  adds numbers to the marked up text-->
    
    <xsl:include href="insertnumbers.xsl"/>
    
</xsl:stylesheet>

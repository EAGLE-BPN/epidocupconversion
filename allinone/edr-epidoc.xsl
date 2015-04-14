<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    version="2.0"  xmlns:skos="http://www.w3.org/2004/02/skos/core#" 
    xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#" 
    xmlns:tei="http://www.tei-c.org/ns/1.0" 
    xmlns:xsd="http://www.w3.org/2001/XMLSchema"
    xmlns="http://www.tei-c.org/ns/1.0" 
    exclude-result-prefixes="#all">
    
<xsl:output indent="yes" method="xml"/>

    <xsl:template match="@* | node()">
        <xsl:copy copy-namespaces="yes">
            <xsl:apply-templates select="@* | node()"/>
        </xsl:copy>
    </xsl:template>
    
    
    <!--inserts trismegistos id-->
    <xsl:include href="https://raw.githubusercontent.com/EAGLE-BPN/epidocupconversion/master/allinone/tmidEDR.xsl"/>
    
    <!--  Create descriptive Title required from Europeana from Object Type and Inscription Type  -->
    <!--    <xsl:include href="maketitledr.xsl"/>-->
        
<!--  adds in specific elements a @ref with the corresponding url from the EAGLE Tematres Vocabularies -->
    <xsl:include href="popwithvoc.xsl"/>
    
<!--    breaks up sections and call templates to normalize ()[] and to convert in epidoc -->
    <xsl:include href="https://raw.githubusercontent.com/EAGLE-BPN/epidocupconversion/master/allinone/textstructureEDR.xsl"/>
    
    <!--breaks brackets in unique meaning ones as much as possible preparing things for the next step-->
    <xsl:include href="https://raw.githubusercontent.com/EAGLE-BPN/epidocupconversion/master/allinone/bracketsEDR.xsl"/>


<!--  Takes all brackets sets and other diacritict and substitutes them with markup  -->
    <xsl:include href="upconversionEDR.xsl"/>    
    
    <!--  adds numbers to the marked up text-->
    
    <xsl:include href="https://raw.githubusercontent.com/EAGLE-BPN/epidocupconversion/master/allinone/insertnumbers.xsl"/>
    
<!-- remove attributes inherited from template which contain sample urls. to be used until those can be usefully populated  -->
    
    <!--   <xsl:include href="cleaner.xsl"/>-->
    
</xsl:stylesheet>

<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    version="2.0"  xmlns:skos="http://www.w3.org/2004/02/skos/core#" 
    xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#" 
    xmlns:tei="http://www.tei-c.org/ns/1.0" 
    xmlns="http://www.tei-c.org/ns/1.0" 
    exclude-result-prefixes="tei rdf skos">
    
    
    <!-- Object Type   -->
    <xsl:include href="objectType.xsl"/>
    
    <!-- Material   -->
    <xsl:include href="https://raw.githubusercontent.com/EAGLE-BPN/epidocupconversion/master/allinone/material.xsl"/>
    
    <!--  Type of Inscription  -->
    <xsl:include href="https://raw.githubusercontent.com/EAGLE-BPN/epidocupconversion/master/allinone/instype.xsl"/>
    
    <!--  Writing  -->
    <xsl:include href="https://raw.githubusercontent.com/EAGLE-BPN/epidocupconversion/master/allinone/writing.xsl"/>
    
    <!--  Dating Criteria -->
    <xsl:include href="https://raw.githubusercontent.com/EAGLE-BPN/epidocupconversion/master/allinone/dates.xsl"/>
    
    <!--  Decoration  -->
    <xsl:include href="https://raw.githubusercontent.com/EAGLE-BPN/epidocupconversion/master/allinone/deco.xsl"/>
    
    <!--  state preservation  -->
    <xsl:include href="https://raw.githubusercontent.com/EAGLE-BPN/epidocupconversion/master/allinone/statepres.xsl"/>    
    
<!--    TMGeo ID-->
    <xsl:include href="https://raw.githubusercontent.com/EAGLE-BPN/epidocupconversion/master/allinone/tmgeo.xsl"/>
    
</xsl:stylesheet>

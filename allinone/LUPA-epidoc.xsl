<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:office="urn:oasis:names:tc:opendocument:xmlns:office:1.0"
    xmlns:table="urn:oasis:names:tc:opendocument:xmlns:table:1.0"
    xmlns:text="urn:oasis:names:tc:opendocument:xmlns:text:1.0"
    xmlns:skos="http://www.w3.org/2004/02/skos/core#"
    xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#" 
    xmlns:tei="http://www.tei-c.org/ns/1.0"
    xmlns:f="http://www.filemaker.com/fmpxmlresult"
    exclude-result-prefixes="f tei skos rdf text table office xs xsl"
    version="2.0">
<!--    
    THIS XSL IS DESIGNED TO TAKE DATA FROM 
    http://www.ubi-erat-lupa.org/eagle/monuments.xml.php
and insert it in a epidoc template compliant with EAGLE definition
    -->
    
    
<!--   PROBLEM:
        FOR SOME REASON I DID NOT UNDERSTAND THIS TRANSFORMATION GENERATES xmlns="" in each <lb> which need to be removed afterwords.-->
   
    
 <xsl:template match="/">  
        

         
        <lupa>
            <xsl:for-each select="//monument[inscription]">
           
            <TEI xml:space="preserve" xml:lang="de" xmlns="http://www.tei-c.org/ns/1.0">
    <teiHeader>
        <fileDesc>
            <titleStmt>
                <title><xsl:value-of select="current()/title"/></title>
            </titleStmt>  
            <publicationStmt>
                <authority>Ubi Erat Lupa</authority>
                <idno type="URI"><xsl:value-of select="current()/url"/></idno>
                <idno type="TM"/>
                <availability>
                    <licence target="http://creativecommons.org/licenses/by-sa/3.0/">
This file is licensed under the Creative Commons Attribution-NonCommercial-ShareAlike 3.0 Unported license.
</licence>
                </availability>
            </publicationStmt>
            <sourceDesc>
                <msDesc>
                    <msIdentifier>
                        <country>
                            <placeName type="modern"><xsl:value-of select=" normalize-space(current()//placeOfFinding/place[position()=last()]/name)"/></placeName>
                        </country>
                     <!--   <region>
                            <placeName type="modern"><xsl:if test="normalize-space(TD[position()=7])"><xsl:value-of select="normalize-space(TD[position()=7])"/></xsl:if></placeName>
                        </region>
                     -->   <settlement>
                            <placeName><xsl:value-of select="normalize-space(current()//placeOfFinding/place[1]/name)"/></placeName>                     
                        </settlement>
                        <repository><xsl:value-of select="normalize-space(current()//placeOfConservation/place[1]/name)"/></repository>
                        <collection/>
                        <idno/>
                    </msIdentifier>
                    <physDesc>
                        <objectDesc>
                            <supportDesc>
                                <support>
<objectType><xsl:variable name="noquestion"><xsl:analyze-string 
                                            select="normalize-space(current()//objectType)" 
                                            regex="(\*\s*\w*)\?"><xsl:matching-substring><xsl:value-of select="regex-group(1)"/></xsl:matching-substring><xsl:non-matching-substring><xsl:analyze-string select="." regex="(\w+),\s(\w*)"><xsl:matching-substring><xsl:value-of select="regex-group(1)"/></xsl:matching-substring><xsl:non-matching-substring><xsl:value-of select="."/></xsl:non-matching-substring></xsl:analyze-string></xsl:non-matching-substring></xsl:analyze-string></xsl:variable><!--
                                             --><xsl:variable name="voc_term"><!--add https://raw.githubusercontent.com/EAGLE-BPN/epidocupconversion/master/allinone/ in front of file name for absolute path
                                    --><xsl:value-of select="document('https://raw.githubusercontent.com/EAGLE-BPN/epidocupconversion/master/allinone/eagle-vocabulary-object-type.rdf')//skos:prefLabel[lower-case(.)=lower-case($noquestion)]/parent::skos:Concept/@rdf:about"/><xsl:value-of select="document('https://raw.githubusercontent.com/EAGLE-BPN/epidocupconversion/master/allinone/eagle-vocabulary-object-type.rdf')//skos:altLabel[lower-case(.)=lower-case($noquestion)]/parent::skos:Concept/@rdf:about"/></xsl:variable><!--
                                         --><xsl:if test="$voc_term!=''"><xsl:attribute name="ref"><xsl:value-of select="$voc_term"/></xsl:attribute></xsl:if><xsl:value-of select="normalize-space(current()//objectType)"/></objectType>
                             <!--       <material><xsl:variable name="noquestion"><xsl:analyze-string 
                                        select="normalize-space(TD[position()=15])" 
                                        regex="(\w+\s*\w*)\?"><xsl:matching-substring><xsl:value-of select="regex-group(1)"/></xsl:matching-substring><xsl:non-matching-substring><xsl:analyze-string select="." regex="(\w+),\s(\w*)"><xsl:matching-substring><xsl:value-of select="regex-group(1)"/></xsl:matching-substring><xsl:non-matching-substring><xsl:value-of select="."/></xsl:non-matching-substring></xsl:analyze-string></xsl:non-matching-substring></xsl:analyze-string></xsl:variable><!-\-
                                        -\-><xsl:variable name="voc_term"><!-\-add https://raw.githubusercontent.com/EAGLE-BPN/epidocupconversion/master/allinone/ in front of file name for absolute path
                                    -\-><xsl:value-of select="document('https://raw.githubusercontent.com/EAGLE-BPN/epidocupconversion/master/allinone/eagle-vocabulary-material.rdf')//skos:prefLabel[lower-case(.)=lower-case($noquestion)]/parent::skos:Concept/@rdf:about"/><xsl:value-of select="document('https://raw.githubusercontent.com/EAGLE-BPN/epidocupconversion/master/allinone/eagle-vocabulary-material.rdf')//skos:altLabel[lower-case(.)=lower-case($noquestion)]/parent::skos:Concept/@rdf:about"/></xsl:variable><!-\-
                                         -\-><xsl:if test="$voc_term!=''"><xsl:attribute name="ref"><xsl:value-of select="$voc_term"/></xsl:attribute></xsl:if><xsl:value-of select="normalize-space(TD[position()=15])"/></material>
                                    <p/>
                                    <dimensions unit="cm">
                                        <height><xsl:variable name="s" as="xs:string*"><xsl:analyze-string select="normalize-space(TD[position()=16])" regex="(\d+(.|,)?\d+?)"><xsl:matching-substring><xsl:sequence select="regex-group(1)"/></xsl:matching-substring></xsl:analyze-string></xsl:variable><xsl:attribute name="atMost"><xsl:value-of select="$s[1]"/></xsl:attribute><xsl:if test="$s[2]"><xsl:attribute name="atLeast"><xsl:value-of select="$s[2]"/></xsl:attribute></xsl:if><xsl:value-of select="$s[1]"/><xsl:if test="$s[2]"><xsl:text>; </xsl:text><xsl:value-of select="$s[2]"/></xsl:if></height>
                                        <width><xsl:variable name="s" as="xs:string*"><xsl:analyze-string select="normalize-space(TD[position()=17])" regex="(\d+(.|,)?\d+?)"><xsl:matching-substring><xsl:sequence select="regex-group(1)"/></xsl:matching-substring></xsl:analyze-string></xsl:variable><xsl:attribute name="atMost"><xsl:value-of select="$s[1]"/></xsl:attribute><xsl:if test="$s[2]"><xsl:attribute name="atLeast"><xsl:value-of select="$s[2]"/></xsl:attribute></xsl:if><xsl:value-of select="$s[1]"/><xsl:if test="$s[2]"><xsl:text>; </xsl:text><xsl:value-of select="$s[2]"/></xsl:if></width>
                                        <depth><xsl:variable name="s" as="xs:string*"><xsl:analyze-string select="normalize-space(TD[position()=18])" regex="(\d+(.|,)?\d+?)"><xsl:matching-substring><xsl:sequence select="regex-group(1)"/></xsl:matching-substring></xsl:analyze-string></xsl:variable><xsl:attribute name="atMost"><xsl:value-of select="$s[1]"/></xsl:attribute><xsl:if test="$s[2]"><xsl:attribute name="atLeast"><xsl:value-of select="$s[2]"/></xsl:attribute></xsl:if><xsl:value-of select="$s[1]"/><xsl:if test="$s[2]"><xsl:text>; </xsl:text><xsl:value-of select="$s[2]"/></xsl:if></depth>
                                    </dimensions>
                             -->       <rs type="decoration"><xsl:variable name="noquestion"><xsl:analyze-string 
                                        select="normalize-space(current()//iconography)" 
                                        regex="(\w+\s*\w*)\?"><xsl:matching-substring><xsl:value-of select="regex-group(1)"/></xsl:matching-substring><xsl:non-matching-substring><xsl:analyze-string select="." regex="(\w+),\s(\w*)"><xsl:matching-substring><xsl:value-of select="regex-group(1)"/></xsl:matching-substring><xsl:non-matching-substring><xsl:value-of select="."/></xsl:non-matching-substring></xsl:analyze-string></xsl:non-matching-substring></xsl:analyze-string></xsl:variable><!--
                                        --><xsl:variable name="voc_term"><xsl:value-of select="document('https://raw.githubusercontent.com/EAGLE-BPN/epidocupconversion/master/allinone/eagle-vocabulary-decoration.rdf')//skos:prefLabel[lower-case(.)=lower-case($noquestion)]/parent::skos:Concept/@rdf:about"/><xsl:value-of select="document('https://raw.githubusercontent.com/EAGLE-BPN/epidocupconversion/master/allinone/eagle-vocabulary-decoration.rdf')//skos:altLabel[lower-case(.)=lower-case($noquestion)]/parent::skos:Concept/@rdf:about"/></xsl:variable><!--
                                         --><xsl:if test="$voc_term!=''"><xsl:attribute name="ref"><xsl:value-of select="$voc_term"/></xsl:attribute></xsl:if><xsl:value-of select="normalize-space(current()//iconography)"/></rs>
                                   <!-- <rs type="statPreserv"><xsl:variable name="noquestion"><xsl:analyze-string 
                                        select="normalize-space(TD[position()=XX])" 
                                        regex="(\w+\s*\w*)\?"><xsl:matching-substring><xsl:value-of select="regex-group(1)"/></xsl:matching-substring><xsl:non-matching-substring><xsl:analyze-string select="." regex="(\w+),\s(\w*)"><xsl:matching-substring><xsl:value-of select="regex-group(1)"/></xsl:matching-substring><xsl:non-matching-substring><xsl:value-of select="."/></xsl:non-matching-substring></xsl:analyze-string></xsl:non-matching-substring></xsl:analyze-string></xsl:variable><xsl:variable name="voc_term"><xsl:value-of select="document('https://raw.githubusercontent.com/EAGLE-BPN/epidocupconversion/master/allinone/eagle-vocabulary-state-of-preservation.rdf')//skos:prefLabel[lower-case(.)=lower-case($noquestion)]/parent::skos:Concept/@rdf:about"/><xsl:value-of select="document('https://raw.githubusercontent.com/EAGLE-BPN/epidocupconversion/master/allinone/eagle-vocabulary-state-of-preservation.rdf')//skos:altLabel[lower-case(.)=lower-case($noquestion)]/parent::skos:Concept/@rdf:about"/></xsl:variable><xsl:if test="$voc_term!=''"><xsl:attribute name="ref"><xsl:value-of select="$voc_term"/></xsl:attribute></xsl:if>
                                        <xsl:value-of select="normalize-space(TD[position()=XX])"/></rs>-->
                                </support>
                            </supportDesc>
                            <layoutDesc>
                                <layout>
                                 <!--   <rs type="execution"><xsl:variable name="noquestion"><xsl:analyze-string 
                                        select="normalize-space(TD[position()=21])" 
                                        regex="(\w+\s*\w*)\?"><xsl:matching-substring><xsl:value-of select="regex-group(1)"/></xsl:matching-substring><xsl:non-matching-substring><xsl:analyze-string select="." regex="(\w+),\s(\w*)"><xsl:matching-substring><xsl:value-of select="regex-group(1)"/></xsl:matching-substring><xsl:non-matching-substring><xsl:value-of select="."/></xsl:non-matching-substring></xsl:analyze-string></xsl:non-matching-substring></xsl:analyze-string></xsl:variable><!-\-
                                        -\-><xsl:variable name="voc_term"><xsl:value-of select="document('https://raw.githubusercontent.com/EAGLE-BPN/epidocupconversion/master/allinone/eagle-vocabulary-writing.rdf')//skos:prefLabel[lower-case(.)=lower-case($noquestion)]/parent::skos:Concept/@rdf:about"/><xsl:value-of select="document('https://raw.githubusercontent.com/EAGLE-BPN/epidocupconversion/master/allinone/eagle-vocabulary-writing.rdf')//skos:altLabel[lower-case(.)=lower-case($noquestion)]/parent::skos:Concept/@rdf:about"/></xsl:variable><!-\-
                                         -\-><xsl:if test="$voc_term!=''"><xsl:attribute name="ref"><xsl:value-of select="$voc_term"/></xsl:attribute></xsl:if>
                                        <xsl:value-of select="normalize-space(TD[position()=21])"/><!-\-<xsl:text>; </xsl:text><xsl:value-of select="TD[position()=13]"/>-\-></rs>
                                    <dimensions>
                                        <width unit="cm"/>
                                        <height unit="cm"/>
                                    </dimensions>
                                    <rs type="metre"><xsl:value-of select="normalize-space(TD[position()=13])"/></rs>
                                --></layout>
                            </layoutDesc>
                        </objectDesc>
                        <handDesc>
                            <handNote>
                            <!--   <xsl:value-of select="normalize-space(TD[position()=22])"/>
                                <height unit="cm"><xsl:analyze-string select="normalize-space(TD[position()=19])" regex="(\d+(.|,)?\d+?)"><xsl:matching-substring><xsl:value-of select="regex-group(1)"/></xsl:matching-substring></xsl:analyze-string></height>
                           --> </handNote>
                        </handDesc>
                    </physDesc>
                    <history>
                        <origin>
                            <origPlace>
                            <!--    <placeName><xsl:for-each select="normalize-space(TD[position()=4])"><xsl:variable name="noquestion"><xsl:analyze-string select="." regex="(\w+)\?"><xsl:matching-substring><!-\-
                        -\-><xsl:value-of select="regex-group(1)"/></xsl:matching-substring><xsl:non-matching-substring><xsl:analyze-string select="." regex="((\w+)\s*\w*)(,|:)\s((\w*\*?)\s*\w*\s*\w*)"><xsl:matching-substring><!-\- 
                                -\-><xsl:value-of select="regex-group(1)"/><!-\-  if the toponym is before the , or : needs to be regex-group(1) if it is after, regex-group(4) -\-><!-\-               
                            -\-></xsl:matching-substring><xsl:non-matching-substring><xsl:value-of select="."/></xsl:non-matching-substring></xsl:analyze-string></xsl:non-matching-substring></xsl:analyze-string></xsl:variable><!-\-
            -\-><xsl:variable name="voc_term"><!-\-
            -\-><xsl:choose><xsl:when test="document('TMGeoIDToponyms.XML')//f:RESULTSET/f:ROW/f:COL[2]/f:DATA[contains(., $noquestion)]"><!-\-
                    -\-><xsl:value-of select="document('TMGeoIDToponyms.XML')//f:RESULTSET/f:ROW/f:COL[2]/f:DATA[contains(., $noquestion)]/parent::f:COL/preceding-sibling::f:COL/f:DATA"/><!-\-
                -\-></xsl:when><xsl:otherwise><xsl:value-of select="document('TMGeoIDToponyms.XML')//f:RESULTSET/f:ROW/f:COL[3]/f:DATA[contains(., $noquestion)]/ancestor::f:ROW/f:COL[1]/f:DATA"/></xsl:otherwise></xsl:choose></xsl:variable><xsl:attribute name="ref"><xsl:value-of select="concat('www.trismegistos.org/place/',format-number(number($voc_term),'000000'))"/></xsl:attribute><xsl:value-of select="."/></xsl:for-each><!-\-<xsl:value-of select="normalize-space(TD[position()=4])"/>-\-></placeName>
                                <placeName type="provincItalicRegion"><xsl:for-each select="normalize-space(TD[position()=2])"><xsl:variable name="noquestion"><xsl:analyze-string select="." regex="(\w+)\?"><xsl:matching-substring><!-\-
                        -\-><xsl:value-of select="regex-group(1)"/></xsl:matching-substring><xsl:non-matching-substring><xsl:analyze-string select="." regex="((\w+)\s*\w*)(,|:)\s((\w*\*?)\s*\w*\s*\w*)"><xsl:matching-substring><!-\- 
                                -\-><xsl:value-of select="regex-group(1)"/><!-\-  if the toponym is before the , or : needs to be regex-group(1) if it is after, regex-group(4) -\-><!-\-               
                            -\-></xsl:matching-substring><xsl:non-matching-substring><xsl:value-of select="."/></xsl:non-matching-substring></xsl:analyze-string></xsl:non-matching-substring></xsl:analyze-string></xsl:variable><!-\-
            -\-><xsl:variable name="voc_term"><!-\-
            -\-><xsl:choose><xsl:when test="document('TMGeoIDToponyms.XML')//f:RESULTSET/f:ROW/f:COL[2]/f:DATA[contains(., $noquestion)]"><!-\-
                    -\-><xsl:value-of select="document('TMGeoIDToponyms.XML')//f:RESULTSET/f:ROW/f:COL[2]/f:DATA[contains(., $noquestion)]/parent::f:COL/preceding-sibling::f:COL/f:DATA"/><!-\-
                -\-></xsl:when><xsl:otherwise><xsl:value-of select="document('TMGeoIDToponyms.XML')//f:RESULTSET/f:ROW/f:COL[3]/f:DATA[contains(., $noquestion)]/ancestor::f:ROW/f:COL[1]/f:DATA"/></xsl:otherwise></xsl:choose></xsl:variable><xsl:attribute name="ref"><xsl:value-of select="concat('www.trismegistos.org/place/',format-number(number($voc_term),'000000'))"/></xsl:attribute><xsl:value-of select="."/></xsl:for-each><!-\-<xsl:value-of select="normalize-space(TD[position()=2])"/>-\-></placeName>
                        -->    </origPlace>
                              <origDate>
                                  <!--<xsl:if test="normalize-space(TD[position()=24])"><xsl:attribute name="notBefore-custom"><xsl:value-of select="format-number(number(TD[position()=24]), '0000')"/></xsl:attribute></xsl:if><xsl:if test="normalize-space(TD[position()=25])"><xsl:attribute name="notAfter-custom"><xsl:value-of select="format-number(number(TD[position()=25]), '0000')"/></xsl:attribute></xsl:if><xsl:attribute name="datingMethod">http://en.wikipedia.org/wiki/Julian_calendar</xsl:attribute><xsl:value-of select="normalize-space(TD[position()=23])"/>
                                  --></origDate>
                        </origin>
                        <provenance type="found">  
                         <!--   <date><xsl:value-of select="normalize-space(TD[position()=8])"/></date>
                         -->       <placeName><xsl:value-of select="normalize-space(current()//placeOfFinding/place[1]/name)"/></placeName> 
<!--                            <placeName type="modernRegion"><xsl:if test="normalize-space(TD[position()=7])"><xsl:value-of select="normalize-space(TD[position()=7])"/></xsl:if></placeName>-->
                            <placeName type="modernCountry"><xsl:value-of select="normalize-space(current()//placeOfFinding/place[position()=last()]/name)"/></placeName>
                        </provenance>
                    </history>
                </msDesc>
            </sourceDesc>
        </fileDesc>
        <encodingDesc>
            <p>Marked-up according to the EpiDoc Guidelines</p>
            <classDecl>
                <taxonomy>
                    <category xml:id="representation">
                        <catDesc>Digitized other representations</catDesc>
                    </category>
                </taxonomy>
            </classDecl>
        </encodingDesc>
        <profileDesc>
                <textClass>
<keywords>
    <term><xsl:variable name="noquestion"><xsl:analyze-string 
                                        select="normalize-space(current()//inscription/type)" 
                                        regex="(\w+\s*\w*)\?"><xsl:matching-substring><xsl:value-of select="regex-group(1)"/></xsl:matching-substring><xsl:non-matching-substring><xsl:analyze-string select="." regex="(\w+),\s(\w*)"><xsl:matching-substring><xsl:value-of select="regex-group(1)"/></xsl:matching-substring><xsl:non-matching-substring><xsl:value-of select="."/></xsl:non-matching-substring></xsl:analyze-string></xsl:non-matching-substring></xsl:analyze-string></xsl:variable><!--
                                        --><xsl:variable name="voc_term"><xsl:value-of select="document('https://raw.githubusercontent.com/EAGLE-BPN/epidocupconversion/master/allinone/eagle-vocabulary-type-of-inscription.rdf')//skos:prefLabel[lower-case(.)=lower-case($noquestion)]/parent::skos:Concept/@rdf:about"/><xsl:value-of select="document('https://raw.githubusercontent.com/EAGLE-BPN/epidocupconversion/master/allinone/eagle-vocabulary-type-of-inscription.rdf')//skos:altLabel[lower-case(.)=lower-case($noquestion)]/parent::skos:Concept/@rdf:about"/></xsl:variable><!--
                                         --><xsl:if test="$voc_term!=''"><xsl:attribute name="ref"><xsl:value-of select="$voc_term"/></xsl:attribute></xsl:if><xsl:value-of select="normalize-space(current()//inscription/type)"/></term>
</keywords>
    </textClass>

            <langUsage>
                <language ident="ar">Arabic</language>
                <language ident="en">English</language>
                <language ident="fr">French</language>
                <language ident="de">German</language>
                <language ident="grc">Ancient Greek</language>
                <language ident="grc-Latn">Transliterated Greek</language>
                <language ident="el">Modern Greek</language>
                <language ident="he">Hebrew</language>
                <language ident="it">Italian</language>
                <language ident="la">Latin</language>
                <language ident="sp">Spanish</language>
            </langUsage>
        <creation>EAGLE - Europeana Network of Ancient Greek and Latin Epigraphy</creation></profileDesc>
        <revisionDesc>
         <change><xsl:attribute name="when"><xsl:value-of select="current-date()"/></xsl:attribute><!--
             --><xsl:attribute name="who">UbiEratLupa</xsl:attribute><xsl:text>Ubi Erat Lupa</xsl:text></change>
        </revisionDesc>
    </teiHeader>
        <xsl:if test="current()//photo"> <facsimile>
<xsl:for-each select="current()//photo">
    <graphic><xsl:attribute name="n"><xsl:value-of select="normalize-space(current()//id)"/></xsl:attribute><xsl:attribute name="url"><xsl:value-of select="normalize-space(current()//url)"/></xsl:attribute><desc><xsl:value-of select="normalize-space(current()//year)"/><ref type="license" target="creativecommons.org/licenses/by-sa/3.0/"><xsl:value-of select="normalize-space(current()//copyright)"/></ref>
      </desc>
   </graphic>
</xsl:for-each>
            
        </facsimile>
        </xsl:if>
    
    <text>
        <body>
                       
            <div type="bibliography">
                <listBibl>
<xsl:for-each select="normalize-space(current()//bibliography)"><xsl:choose><xsl:when test="contains(.,';')"><xsl:for-each select="tokenize(.,';')"><bibl><xsl:value-of select="."/></bibl></xsl:for-each></xsl:when><xsl:otherwise><bibl><xsl:value-of select="."/></bibl></xsl:otherwise></xsl:choose></xsl:for-each>
                </listBibl>
            </div>
            
            
            <div type="edition" xml:lang="la">
              <head>Text</head><xsl:variable name="textepidoc">  
            <xsl:choose>
                <xsl:when test="contains(current()/inscription/text,'//')">
                    <xsl:for-each select="tokenize(normalize-space(current()//inscription/text),'//')">
                        <div><xsl:attribute name="n" select="position()"/><xsl:attribute name="type">textpart</xsl:attribute><ab><lb/>
                                <xsl:variable name="brackets">
                                    <xsl:call-template name="breakbrackets">
                                        <xsl:with-param name="textToBeProcessed"  tunnel="yes" select="."/>
                                    </xsl:call-template>
                                </xsl:variable>
                                <xsl:for-each select="$brackets">
                                    <xsl:call-template name="upconversion">
                                        <xsl:with-param name="substitutions" tunnel="yes" select="."/>
                                    </xsl:call-template>
                                </xsl:for-each>
                            </ab>
                        </div>
                    </xsl:for-each>
                </xsl:when>
                <!--    THE FOLLOWING WILL WORK ON THE MAJORITY OF TEXT WHICH DO NOT HAVE PARTS      -->
                <xsl:otherwise>
<xsl:for-each select="normalize-space(current()//inscription/text)">
    <ab>
                        <lb/>
                        <xsl:variable name="brackets">
                            <xsl:call-template name="breakbrackets">
                                <xsl:with-param name="textToBeProcessed"  tunnel="yes" select="."/>
                            </xsl:call-template>
                        </xsl:variable>
                        <xsl:for-each select="$brackets">
                            <xsl:call-template name="upconversion">
                                <xsl:with-param name="substitutions" tunnel="yes" select="."/>
                            </xsl:call-template>
                        </xsl:for-each>
                    </ab>
</xsl:for-each>
                </xsl:otherwise>
            </xsl:choose></xsl:variable>
                <xsl:for-each select="$textepidoc">
<xsl:apply-templates mode="lb"/>
                </xsl:for-each>
                <!--                <xsl:value-of select="normalize-space(TD[position()=25])"/>-->
            </div>
<!--<xsl:if test="normalize-space(TD[position()=29])">
            <div type="apparatus">
                <p><xsl:value-of select="normalize-space(TD[position()=29])"/></p>
            </div>
</xsl:if>
            <xsl:if test="normalize-space(TD[position()=30])">
           <div type="translation">
                <p>                    <xsl:value-of select="normalize-space(TD[position()=30])"/></p>
                    <desc><ref type="license" target="http://creativecommons.org/licenses/by-sa/3.0/">Licensed under a Creative Commons Attribution-ShareAlike 3.0 Unported licence.</ref>
                </desc>
            </div>
            </xsl:if>
<xsl:if test="normalize-space(TD[position()=XX])">
            <div type="commentary">
                <p><!-\-Commentary-\-></p>
            </div>
</xsl:if>-->
        </body>
    </text>
</TEI>


        </xsl:for-each>
        </lupa>
    </xsl:template>
    
    
    <!--breaks brackets in unique meaning ones as much as possible preparing things for the next step-->
    <xsl:include href="https://raw.githubusercontent.com/EAGLE-BPN/epidocupconversion/master/allinone/brackets.xsl"/>
    <!--  Takes all brackets sets and other diacritict and substitutes them with markup  -->
    <xsl:include href="https://raw.githubusercontent.com/EAGLE-BPN/epidocupconversion/master/allinone/upconversion.xsl"/>  
   
    <xsl:template  match="tei:*" mode="lb">
        <xsl:copy>
            <xsl:copy-of select="@*"/>
            <xsl:apply-templates mode="lb"/>
        </xsl:copy>
    </xsl:template>   
    
    

    <xsl:template match="tei:lb[not(@break)]" mode="lb">
        <lb>
            <xsl:attribute name="n"><xsl:number count="tei:lb[not(following-sibling::*[1][self::tei:gap[@unit='line']])]"/></xsl:attribute>
            <xsl:apply-templates/>
        </lb>
    </xsl:template>
    
    <xsl:template match="tei:lb[@break]" mode="lb">
        <lb>
            <xsl:attribute name="break">no</xsl:attribute>
            <xsl:attribute name="n"><xsl:number count="tei:lb[not(following-sibling::*[1][self::tei:gap[@unit='line']])]"/></xsl:attribute>
            <xsl:apply-templates/>
        </lb>
    </xsl:template>
    
    <xsl:template match="tei:lb[following-sibling::*[1][self::tei:gap[@unit='line']]]" mode="lb">
        <lb n="0"/>
    </xsl:template>

</xsl:stylesheet>

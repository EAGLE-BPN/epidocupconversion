<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="2.0"
    xmlns:skos="http://www.w3.org/2004/02/skos/core#" xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#"
    xmlns:rdfs="http://www.w3.org/2000/01/rdf-schema#" xmlns:tei="http://www.tei-c.org/ns/1.0"
    xmlns:dct="http://purl.org/dc/terms/" xmlns:map="http://www.w3c.rl.ac.uk/2003/11/21-skos-mapping#"
    xmlns:dc="http://purl.org/dc/elements/1.1/" 
exclude-result-prefixes="tei xsl skos rdf rdfs dct map dc">


    <!--USE THIS TO GENERATE SKOS AND HTML VIEW FOR WEB SITE NOT SURE HOW TO ACTIVATE LINKS-->

    <xsl:output method="xml" indent="yes" name="xml"/>
    <xsl:output method="html" indent="yes" name="html"/>
    <xsl:output omit-xml-declaration="yes" indent="yes"/>

    <xsl:variable name="title" select="//dc:title"/>
    <xsl:variable name="url" select="//skos:ConceptScheme/@rdf:about"/>

    <!--index-->

    <xsl:template match="/">
        <xsl:variable name="fullskosfile"
            select="concat('voc/',substring-before(substring-after($url, 'http://www.eagle-network.eu/voc/'),'/'),'.rdf')"/>
        <xsl:variable name="filenameindex"
            select="concat('voc/',substring-before(substring-after($url, 'http://www.eagle-network.eu/voc/'),'/'),'.html')"/>
        <xsl:result-document href="{$filenameindex}" format="html" exclude-result-prefixes="#all" omit-xml-declaration="yes">

            <html>
                <head>
                    <!--
               <meta charset="UTF-8"/>-->
                    <link rel="stylesheet" href="http://www.eagle-network.eu/wp-content/themes/eaglenetwork/style.css" type="text/css" />
                    <style type="text/css">
                        .list{
                        	display:none;
                        }</style>
                    <script type="text/javascript" src="http://code.jquery.com/jquery.js"/>
                    <!--java for language selection-->
                    <script type="text/javascript">  
                    $(document).ready(function(){
                    $("select").change(function(){
                    $( "select option:selected").each(function(){
                    if($(this).attr("value")=="la"){
                    $(".list").hide();
                    $(".la").show();
                    }
                    if($(this).attr("value")=="it"){
                    $(".list").hide();
                    $(".it").show();
                    }
                    if($(this).attr("value")=="de"){
                    $(".list").hide();
                    $(".de").show();
                    }
                    if($(this).attr("value")=="en"){
                    $(".list").hide();
                    $(".en").show();
                    }
                    if($(this).attr("value")=="fr"){
                    $(".list").hide();
                    $(".fr").show();
                    }
                    if($(this).attr("value")=="es"){
                    $(".list").hide();
                    $(".es").show();
                    }
                    if($(this).attr("value")=="hu"){
                    $(".list").hide();
                    $(".hu").show();
                    }
                    if($(this).attr("value")=="el"){
                    $(".list").hide();
                    $(".el").show();
                    }
                    if($(this).attr("value")=="others"){
                    $(".list").hide();
                    $(".others").show();
                    }
                    
                    if($(this).attr("value")=="ALL"){
                    $(".list").hide();
                    $(".ALL").show();
                    }
                    });
                    }).change();
                    });
                </script>
                    <!--java for select and go to url-->
                    <SCRIPT TYPE="text/javascript"> function dropdown(mySel) { var myWin, myVal; myVal =
                        mySel.options[mySel.selectedIndex].value; if(myVal) { if(mySel.form.target)myWin =
                        parent[mySel.form.target]; else myWin = window; if (! myWin) return true; myWin.location =
                        myVal; } return false; } // </SCRIPT>
                    <h1>
                        <xsl:value-of select="$title"/>
                    </h1>
                </head>
                <body style="margin:8;padding:8">
                    <p>Choose a language to start navigating or select SHOW ALL TERMS to see the full list of terms in
                        this vocabulary. Equivalent terms are shown in the tematres instance and in each main concept description.</p>
                    <div>
                        <select>
                            <option>Choose Language</option>
                            <option value="ALL">Show all terms</option>
                            <option value="la">Latin</option>
                            <option value="de">German</option>
                            <option value="it">Italian</option>
                            <option value="fr">French</option>
                            <option value="es">Spanish</option>
                            <option value="en">English</option>
                            <option value="hu">Hungarian</option>
                            <option value="gr">Greek</option>
                            <option value="others">Others</option>

                        </select>
                    </div>

                    <div class="la list">
                        <h3>Terms in Latin</h3>
                        <p>Preferred <FORM ACTION="../cgi-bin/redirect.pl" METHOD="POST"
                                onSubmit="return dropdown(this.gourl)">
                                <SELECT NAME="gourl">
                                    <OPTION VALUE="">Choose...</OPTION>
                                    <xsl:for-each select="//skos:prefLabel[@xml:lang='la']">
                                        <xsl:sort order="ascending"/>
                                        <option><xsl:attribute name="value"><xsl:value-of
                                                    select="parent::node()/@rdf:about"/>
                                            </xsl:attribute><xsl:value-of select="."/></option>
                                    </xsl:for-each>
                                    <INPUT TYPE="SUBMIT" VALUE="Go"/>
                                </SELECT></FORM></p>
                        <p>Alternative <FORM ACTION="../cgi-bin/redirect.pl" METHOD="POST"
                                onSubmit="return dropdown(this.gourl)">
                                <SELECT NAME="gourl">
                                    <OPTION VALUE="">Choose...</OPTION>
                                    <xsl:for-each select="//skos:altLabel[@xml:lang='la']">
                                        <xsl:sort order="ascending"/>
                                        <option><xsl:attribute name="value"><xsl:value-of
                                                    select="parent::node()/@rdf:about"/>
                                            </xsl:attribute><xsl:value-of select="."/></option>
                                    </xsl:for-each>
                                    <INPUT TYPE="SUBMIT" VALUE="Go"/>
                                </SELECT></FORM></p>
                    </div>
                    <div class="en list">
                        <h3>Terms in English</h3>

                        <p>Preferred <FORM ACTION="../cgi-bin/redirect.pl" METHOD="POST"
                                onSubmit="return dropdown(this.gourl)">
                                <SELECT NAME="gourl">
                                    <OPTION VALUE="">Choose...</OPTION>
                                    <xsl:for-each select="//skos:prefLabel[@xml:lang='en']">
                                        <xsl:sort order="ascending"/>
                                        <option><xsl:attribute name="value"><xsl:value-of
                                                    select="parent::node()/@rdf:about"/>
                                            </xsl:attribute><xsl:value-of select="."/></option>
                                    </xsl:for-each>
                                    <INPUT TYPE="SUBMIT" VALUE="Go"/>
                                </SELECT></FORM></p>
                        <p>Alternative <FORM ACTION="../cgi-bin/redirect.pl" METHOD="POST"
                                onSubmit="return dropdown(this.gourl)">
                                <SELECT NAME="gourl">
                                    <OPTION VALUE="">Choose...</OPTION>
                                    <xsl:for-each select="//skos:altLabel[@xml:lang='en']">
                                        <xsl:sort order="ascending"/>
                                        <option><xsl:attribute name="value"><xsl:value-of
                                                    select="parent::node()/@rdf:about"/>
                                            </xsl:attribute><xsl:value-of select="."/></option>
                                    </xsl:for-each>
                                    <INPUT TYPE="SUBMIT" VALUE="Go"/>
                                </SELECT></FORM></p>
                    </div>
                    <div class="de list">
                        <h3>Terms in German</h3>
                        <p>Preferred <FORM ACTION="../cgi-bin/redirect.pl" METHOD="POST"
                                onSubmit="return dropdown(this.gourl)">
                                <SELECT NAME="gourl">
                                    <OPTION VALUE="">Choose...</OPTION>
                                    <xsl:for-each select="//skos:prefLabel[@xml:lang='de']">
                                        <xsl:sort order="ascending"/>
                                        <option><xsl:attribute name="value"><xsl:value-of
                                                    select="parent::node()/@rdf:about"/>
                                            </xsl:attribute><xsl:value-of select="."/></option>
                                    </xsl:for-each>
                                    <INPUT TYPE="SUBMIT" VALUE="Go"/>
                                </SELECT>
                            </FORM></p>
                        <p>Alternative <FORM ACTION="../cgi-bin/redirect.pl" METHOD="POST"
                                onSubmit="return dropdown(this.gourl)">
                                <SELECT NAME="gourl">
                                    <OPTION VALUE="">Choose...</OPTION>
                                    <xsl:for-each select="//skos:altLabel[@xml:lang='de']">
                                        <xsl:sort order="ascending"/>
                                        <option><xsl:attribute name="value"><xsl:value-of
                                                    select="parent::node()/@rdf:about"/>
                                            </xsl:attribute><xsl:value-of select="."/></option>
                                    </xsl:for-each>
                                    <INPUT TYPE="SUBMIT" VALUE="Go"/>
                                </SELECT></FORM></p>
                    </div>
                    <div class="it list">
                        <h3>Terms in Italian</h3>
                        <p>Preferred <FORM ACTION="../cgi-bin/redirect.pl" METHOD="POST"
                                onSubmit="return dropdown(this.gourl)">
                                <SELECT NAME="gourl">
                                    <OPTION VALUE="">Choose...</OPTION>
                                    <xsl:for-each select="//skos:prefLabel[@xml:lang='it']">
                                        <xsl:sort order="ascending"/>
                                        <option><xsl:attribute name="value"><xsl:value-of
                                                    select="parent::node()/@rdf:about"/>
                                            </xsl:attribute><xsl:value-of select="."/></option>
                                    </xsl:for-each>
                                    <INPUT TYPE="SUBMIT" VALUE="Go"/>
                                </SELECT></FORM></p>
                        <p>Alternative <FORM ACTION="../cgi-bin/redirect.pl" METHOD="POST"
                                onSubmit="return dropdown(this.gourl)">
                                <SELECT NAME="gourl">
                                    <OPTION VALUE="">Choose...</OPTION>
                                    <xsl:for-each select="//skos:altLabel[@xml:lang='it']">
                                        <xsl:sort order="ascending"/>
                                        <option><xsl:attribute name="value"><xsl:value-of
                                                    select="parent::node()/@rdf:about"/>
                                            </xsl:attribute><xsl:value-of select="."/></option>
                                    </xsl:for-each>
                                    <INPUT TYPE="SUBMIT" VALUE="Go"/>
                                </SELECT></FORM></p>
                    </div>
                    <div class="fr list">
                        <h3>Terms in French</h3>
                        <p>Preferred <FORM ACTION="../cgi-bin/redirect.pl" METHOD="POST"
                                onSubmit="return dropdown(this.gourl)">
                                <SELECT NAME="gourl">
                                    <OPTION VALUE="">Choose...</OPTION>
                                    <xsl:for-each select="//skos:prefLabel[@xml:lang='fr']">
                                        <xsl:sort order="ascending"/>
                                        <option><xsl:attribute name="value"><xsl:value-of
                                                    select="parent::node()/@rdf:about"/>
                                            </xsl:attribute><xsl:value-of select="."/></option>
                                    </xsl:for-each>
                                    <INPUT TYPE="SUBMIT" VALUE="Go"/>
                                </SELECT></FORM></p>
                        <p>Alternative <FORM ACTION="../cgi-bin/redirect.pl" METHOD="POST"
                                onSubmit="return dropdown(this.gourl)">
                                <SELECT NAME="gourl">
                                    <OPTION VALUE="">Choose...</OPTION>
                                    <xsl:for-each select="//skos:altLabel[@xml:lang='fr']">
                                        <xsl:sort order="ascending"/>
                                        <option><xsl:attribute name="value"><xsl:value-of
                                                    select="parent::node()/@rdf:about"/>
                                            </xsl:attribute><xsl:value-of select="."/></option>
                                    </xsl:for-each>
                                    <INPUT TYPE="SUBMIT" VALUE="Go"/>
                                </SELECT></FORM></p>
                    </div>
                    <div class="es list">
                        <h3>Terms in Spanish</h3>
                        <p>Preferred <FORM ACTION="../cgi-bin/redirect.pl" METHOD="POST"
                                onSubmit="return dropdown(this.gourl)">
                                <SELECT NAME="gourl">
                                    <OPTION VALUE="">Choose...</OPTION>
                                    <xsl:for-each select="//skos:prefLabel[@xml:lang='es']">
                                        <xsl:sort order="ascending"/>
                                        <option><xsl:attribute name="value"><xsl:value-of
                                                    select="parent::node()/@rdf:about"/>
                                            </xsl:attribute><xsl:value-of select="."/></option>
                                    </xsl:for-each>
                                    <INPUT TYPE="SUBMIT" VALUE="Go"/>
                                </SELECT></FORM></p>
                        <p>Alternative <FORM ACTION="../cgi-bin/redirect.pl" METHOD="POST"
                                onSubmit="return dropdown(this.gourl)">
                                <SELECT NAME="gourl">
                                    <OPTION VALUE="">Choose...</OPTION>
                                    <xsl:for-each select="//skos:altLabel[@xml:lang='es']">
                                        <xsl:sort order="ascending"/>
                                        <option><xsl:attribute name="value"><xsl:value-of
                                                    select="parent::node()/@rdf:about"/>
                                            </xsl:attribute><xsl:value-of select="."/></option>
                                    </xsl:for-each>
                                    <INPUT TYPE="SUBMIT" VALUE="Go"/>
                                </SELECT></FORM></p>
                    </div>
                    <div class="hu list">
                        <h3>Terms in Hungarian</h3>
                        <p>
                            <FORM ACTION="../cgi-bin/redirect.pl" METHOD="POST" onSubmit="return dropdown(this.gourl)">
                                <SELECT NAME="gourl">
                                    <OPTION VALUE="">Choose...</OPTION>
                                    <xsl:for-each select="//skos:altLabel[@xml:lang='hu']">
                                        <xsl:sort order="ascending"/>
                                        <option>
                                            <xsl:attribute name="value">
                                                <xsl:value-of select="parent::node()/@rdf:about"/>
                                            </xsl:attribute>
                                            <xsl:value-of select="."/>
                                        </option>
                                    </xsl:for-each>

                                    <INPUT TYPE="SUBMIT" VALUE="Go"/>
                                </SELECT>
                            </FORM>
                        </p>
                    </div>
                    <div class="el list">
                        <h3>Terms in Greek</h3>
                        <p>
                            <FORM ACTION="../cgi-bin/redirect.pl" METHOD="POST" onSubmit="return dropdown(this.gourl)">
                                <SELECT NAME="gourl">
                                    <OPTION VALUE="">Choose...</OPTION>
                                    <xsl:for-each select="//skos:altLabel[@xml:lang='el']">
                                        <xsl:sort order="ascending"/>
                                        <option>
                                            <xsl:attribute name="value">
                                                <xsl:value-of select="parent::node()/@rdf:about"/>
                                            </xsl:attribute>
                                            <xsl:value-of select="."/>
                                        </option>
                                    </xsl:for-each>

                                    <INPUT TYPE="SUBMIT" VALUE="Go"/>
                                </SELECT>
                            </FORM>
                        </p>
                    </div>
                    <div class="others list">
                        <h3>Terms in Arabic</h3>
                        <p>
                            <FORM ACTION="../cgi-bin/redirect.pl" METHOD="POST" onSubmit="return dropdown(this.gourl)">
                                <SELECT NAME="gourl">
                                    <OPTION VALUE="">Choose...</OPTION>
                                    <xsl:for-each select="//skos:altLabel[@xml:lang='ar']">
                                        <xsl:sort order="ascending"/>
                                        <option>
                                            <xsl:attribute name="value">
                                                <xsl:value-of select="parent::node()/@rdf:about"/>
                                            </xsl:attribute>
                                            <xsl:value-of select="."/>
                                        </option>
                                    </xsl:for-each>

                                    <INPUT TYPE="SUBMIT" VALUE="Go"/>
                                </SELECT>
                            </FORM>
                        </p>
                        <h3>Terms in Bulgarian</h3>
                        <p>
                            <FORM ACTION="../cgi-bin/redirect.pl" METHOD="POST" onSubmit="return dropdown(this.gourl)">
                                <SELECT NAME="gourl">
                                    <OPTION VALUE="">Choose...</OPTION>
                                    <xsl:for-each select="//skos:altLabel[@xml:lang='ru']">
                                        <xsl:sort order="ascending"/>
                                        <option>
                                            <xsl:attribute name="value">
                                                <xsl:value-of select="parent::node()/@rdf:about"/>
                                            </xsl:attribute>
                                            <xsl:value-of select="."/>
                                        </option>
                                    </xsl:for-each>

                                    <INPUT TYPE="SUBMIT" VALUE="Go"/>
                                </SELECT>
                            </FORM>
                        </p>
                        <h3>Terms in Turkish</h3>
                        <p>
                            <FORM ACTION="../cgi-bin/redirect.pl" METHOD="POST" onSubmit="return dropdown(this.gourl)">
                                <SELECT NAME="gourl">
                                    <OPTION VALUE="">Choose...</OPTION>
                                    <xsl:for-each select="//skos:altLabel[@xml:lang='tr']">
                                        <xsl:sort order="ascending"/>
                                        <option>
                                            <xsl:attribute name="value">
                                                <xsl:value-of select="parent::node()/@rdf:about"/>
                                            </xsl:attribute>
                                            <xsl:value-of select="."/>
                                        </option>
                                    </xsl:for-each>

                                    <INPUT TYPE="SUBMIT" VALUE="Go"/>
                                </SELECT>
                            </FORM>
                        </p>
                    </div>
                    <div class="ALL list">
<!--add condition to show hierarchical tree when the vocabulary is hierarcical (material and dates)-->
                        <table>
                            <tr>
                                <xsl:apply-templates mode="a"/>
                                <!--main terms-->
                            </tr>
                        </table>
                    </div>
                    <p>
                        <a
                            href="{concat('http://www.eagle-network.eu/resources/vocabularies/', substring-after($url, 'voc/'))}"
                            >Back to Intro</a>
                    </p>
                    <p>
                        <a href="{concat('http://www.eagle-network.eu/',$fullskosfile)}">See SKOS version</a>
                    </p>
                </body>
            </html>

        </xsl:result-document>
        <xsl:result-document href="{$fullskosfile}" format="xml">
<xsl:apply-templates mode="skosuris"/>
</xsl:result-document>
    </xsl:template>

    <xsl:template match="@*|node()" mode="skosuris">
        <xsl:copy>
            <xsl:apply-templates select="@*|node()" mode="skosuris"/>
        </xsl:copy>
    </xsl:template>
    <xsl:template match="@*|node()" mode="skosurissinglefile">
        <xsl:copy>
            <xsl:apply-templates select="@*|node()" mode="skosurissinglefile"/>
        </xsl:copy>
    </xsl:template>
    <xsl:template match="//@*[contains(., 'eagle') and contains(.,'lod')]" mode="skosuris">
        <xsl:attribute name="rdf:{local-name()}"><xsl:value-of select="concat(replace(., 'lod', 'skos'), '.rdf')"/>
</xsl:attribute>
    </xsl:template>
    <xsl:template match="//@*[contains(., 'eagle') and contains(.,'lod')]" mode="skosurissinglefile">
        <xsl:attribute name="rdf:{local-name()}"><xsl:value-of select="concat(replace(., 'lod', 'skos'), '.rdf')"/>
        </xsl:attribute>
    </xsl:template>

    <xsl:template match="skos:Concept" mode="a">

        <!--single files-->
        <xsl:for-each select=".">
            <xsl:variable name="id">
                <xsl:value-of select="substring-after(@rdf:about, 'lod/')"/>
            </xsl:variable>

            <!--skos-->
            <xsl:variable name="filenameskos"
                select="concat(substring-after($url, 'http://www.eagle-network.eu/'),'/skos/',$id,'.rdf')"/>
            <xsl:result-document href="{$filenameskos}" format="xml" omit-xml-declaration="yes" exclude-result-prefixes="#all">
                <rdf:RDF xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#"
                    xmlns:rdfs="http://www.w3.org/2000/01/rdf-schema#" xmlns:skos="http://www.w3.org/2004/02/skos/core#"
                    xmlns:map="http://www.w3c.rl.ac.uk/2003/11/21-skos-mapping#" xmlns:dct="http://purl.org/dc/terms/"
                    xmlns:dc="http://purl.org/dc/elements/1.1/">
                    <skos:ConceptScheme rdf:about="{$url}">
                        <xsl:value-of select="$title"/>
                        <dc:creator>Europeana Best Practice Network for Ancient Greek and Latin Epigraphy (EAGLE
                            BPN)</dc:creator>
                        <dc:contributor/>
                        <dc:publisher/>
                        <dc:rights/>
                        <dc:subject/>
                        <dc:description>
                            <xsl:attribute name="rdf:about">
                                <xsl:value-of
                                    select="concat('http//:www.eagle-network.eu/resources/vocabularies/', substring-before(substring-after($url, 'voc/'), '/'), '.html')"
                                />
                            </xsl:attribute>
                        </dc:description>
                        <dc:date>
                            <xsl:value-of select="current-date()"/>
                        </dc:date>
                        <dct:modified>
                            <xsl:value-of select="current-date()"/>
                        </dct:modified>
                    </skos:ConceptScheme>
                    <xsl:copy><xsl:attribute name="rdf:about">
                        <xsl:value-of select="concat(replace(@rdf:about, 'lod', 'skos'), '.rdf')"/>
                    </xsl:attribute><xsl:apply-templates mode="skosuris"/></xsl:copy>
                    
                </rdf:RDF>
            </xsl:result-document>

            <!--html-->
            <xsl:variable name="filenamehtml"
                select="concat(substring-after($url, 'http://www.eagle-network.eu/'),'/lod/',$id,'.html')"/>
            <xsl:result-document href="{$filenamehtml}" format="html">
                <html>
                    <head>
                        <meta charset="UTF-8"/>
                        <link rel="stylesheet" href="http://www.eagle-network.eu/wp-content/themes/eaglenetwork/style.css" type="text/css" />
                        <h1>
                            <xsl:value-of select="$title"/>
                        </h1>
                    </head>
                    <body style="margin:8;padding:8">
                        <table>
                            <tr>
                                <xsl:apply-templates mode="b"/>
                            </tr>
                            <!-- apply templates for each file -->
                        </table>


                        <p>
                            <a href="http://www.eagle-network.eu/advanced-search">Search for this term on the EAGLE Advanced Search</a>
                        </p>
                        <p>
                            <a
                                href="{concat('http://www.eagle-network.eu/voc/',substring-before(substring-after($url, 'http://www.eagle-network.eu/voc/'),'/'),'.html')}"
                                >Back to Index</a>
                        </p>
                        <p>
                            <a
                                href="{concat('http://www.eagle-network.eu/resources/vocabularies/', substring-after($url, 'voc/'))}"
                                >Back to Intro</a>
                        </p>
                        <p>
                            <a href="{concat($url,'skos/',$id,'.rdf')}">See SKOS version</a>
                        </p>
                    </body>
                </html>
            </xsl:result-document>
        </xsl:for-each>

        <!--main table contents-->
        <xsl:variable name="x" select="@rdf:about"/>
        <xsl:apply-templates mode="b"/>
        <xsl:if test="//skos:Concept[@rdf:about=$x]/skos:closeMatch/skos:Concept">
            <tr>
                <td/>
                <td>External definition</td>
                <td>
                    <xsl:value-of select="//skos:Concept[@rdf:about=$x]/skos:closeMatch/skos:Concept/@rdf:about"/>
                </td>
                <td/>
            </tr>
        </xsl:if>
    </xsl:template>
    <xsl:template match="skos:prefLabel" mode="b">
        <tr>
            <td>
                <a>
                    <xsl:attribute name="href">
                        <xsl:value-of select="parent::skos:Concept/@rdf:about"/>
                    </xsl:attribute>
                    <h2>
                        <xsl:value-of select="."/>
                    </h2>
                </a>
            </td>
            <td/>
            <td/>
            <td>
                <xsl:value-of select="@xml:lang"/>
            </td>
        </tr>
    </xsl:template>
    <xsl:template match="skos:scopeNote" mode="b">
        <xsl:for-each select=".">
            <tr>
                <td/>
                <td>Definition</td>
                <td>
                    <xsl:value-of select="."/>
                </td>
                <td>
                    <xsl:value-of select="@xml:lang"/>
                </td>
            </tr>
        </xsl:for-each>
    </xsl:template>
    <xsl:template match="skos:historyNote" mode="b">
        <xsl:for-each select=".">
            <tr>
                <td/>
                <td>Notes</td>
                <td>
                    <xsl:value-of select="."/>
                </td>
                <td>
                    <xsl:value-of select="@xml:lang"/>
                </td>
            </tr>
        </xsl:for-each>
    </xsl:template>
    <xsl:template match="skos:note" mode="b">
        <xsl:for-each select=".">
            <tr>
                <td/>
                <td>Bibliography</td>
                <td>
                    <xsl:value-of select="."/>
                </td>
                <td>
                    <xsl:value-of select="@xml:lang"/>
                </td>
            </tr>
        </xsl:for-each>
    </xsl:template>

    <xsl:template match="skos:exactMatch" mode="b">
        <xsl:for-each select=".">
            <tr>
                <td/>
                <td>Same as</td>
                <td>
                    <a>
                        <xsl:attribute name="href">
                            <xsl:value-of select="skos:Concept/@rdf:about"/>
                        </xsl:attribute>
                        <xsl:value-of select="skos:Concept/skos:prefLabel"/>
                    </a>
                </td>
                <td>
                    <xsl:value-of select="skos:Concept/skos:prefLabel/@xml:lang"/>
                </td>
            </tr>
        </xsl:for-each>
    </xsl:template>

    <xsl:template match="skos:altLabel" mode="b">
        <xsl:for-each select=".">
            <tr>
                <td/>
                <td>Translated term</td>
                <td>
                    <xsl:value-of select="."/>
                </td>
                <td>
                    <xsl:value-of select="@xml:lang"/>
                </td>
            </tr>
        </xsl:for-each>
    </xsl:template>

    <xsl:template match="skos:related" mode="b">
        <xsl:for-each select=".">
            <xsl:variable name="x">
                <xsl:value-of select="./@rdf:resource"/>
            </xsl:variable>
            <tr>
                <td/>
                <td>Related term</td>
                <td>
                    <a>
                        <xsl:attribute name="href">
                            <xsl:value-of select="@rdf:resource"/>
                        </xsl:attribute>
                        <xsl:value-of select="//skos:Concept[@rdf:about=$x]/skos:prefLabel"/>
                    </a>
                </td>
                <td/>
            </tr>
        </xsl:for-each>
    </xsl:template>

    <xsl:template match="skos:broader" mode="b">
        <xsl:for-each select=".">
            <xsl:variable name="x">
                <xsl:value-of select="./@rdf:resource"/>
            </xsl:variable>
            <tr>
                <td/>
                <td>Contained in</td>
                <td>
                    <a>
                        <xsl:attribute name="href">
                            <xsl:value-of select="@rdf:resource"/>
                        </xsl:attribute>
                        <xsl:value-of select="//skos:Concept[@rdf:about=$x]/skos:prefLabel"/>
                    </a>
                </td>
                <td/>
            </tr>
        </xsl:for-each>
    </xsl:template>
    <xsl:template match="skos:narrower" mode="b">
        <xsl:for-each select=".">
            <xsl:variable name="x">
                <xsl:value-of select="./@rdf:resource"/>
            </xsl:variable>
            <tr>
                <td/>
                <td>Includes</td>
                <td>
                    <a>
                        <xsl:attribute name="href">
                            <xsl:value-of select="@rdf:resource"/>
                        </xsl:attribute>
                        <xsl:value-of select="//skos:Concept[@rdf:about=$x]/skos:prefLabel"/>
                    </a>
                </td>
                <td/>
            </tr>
        </xsl:for-each>
    </xsl:template>
    <xsl:template match="dct:created" mode="b">
        <tr>
            <td/>
            <td>Created</td>
            <td>
                <xsl:value-of select="."/>
            </td>
            <td/>
        </tr>
    </xsl:template>
    <xsl:template match="dct:modified" mode="b">
        <tr>
            <td/>
            <td>Modified</td>
            <td>
                <xsl:value-of select="."/>
            </td>
            <td/>
        </tr>
    </xsl:template>

</xsl:stylesheet>

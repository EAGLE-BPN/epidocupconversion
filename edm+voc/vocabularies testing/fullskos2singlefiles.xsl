<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet 
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="2.0"
    xmlns:skos="http://www.w3.org/2004/02/skos/core#"
    xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#"
    xmlns:rdfs="http://www.w3.org/2000/01/rdf-schema#" 
    xmlns:tei="http://www.tei-c.org/ns/1.0"
    xmlns:dct="http://purl.org/dc/terms/" 
    xmlns:map="http://www.w3c.rl.ac.uk/2003/11/21-skos-mapping#"
xmlns:gcse="uri:not-provided"
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
            select="concat('voc/',substring-before(substring-after($url, 'https://www.eagle-network.eu/voc/'),'/'),'.rdf')"/>
        <xsl:variable name="filenameindex"
            select="concat('voc/',substring-before(substring-after($url, 'https://www.eagle-network.eu/voc/'),'/'),'.html')"/>
        <xsl:result-document href="{$filenameindex}" format="html" exclude-result-prefixes="#all"
            omit-xml-declaration="yes">

            <html>
                <head>
                    <!--
               <meta charset="UTF-8"/>-->
                    <link rel="stylesheet" href="//www.eagle-network.eu/wp-content/themes/eaglenetwork/style.css"
                        type="text/css"/>
                    <style type="text/css">
                        .list{
                        	display:none;
                        }</style>
                    <script type="text/javascript" src="//code.jquery.com/jquery-latest.js"/>
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
                    
                    if($(this).attr("value")=="he"){
                    $(".list").hide();
                    $(".he").show();
                    }
                    if($(this).attr("value")=="ar"){
                    $(".list").hide();
                    $(".ar").show();
                    }
                    
                    if($(this).attr("value")=="tr"){
                    $(".list").hide();
                    $(".tr").show();
                    }
                    
                    if($(this).attr("value")=="ru"){
                    $(".list").hide();
                    $(".ru").show();
                    }
                    if($(this).attr("value")=="others"){
                    $(".list").hide();
                    $(".others").show();
                    }
                    
                    if($(this).attr("value")=="ALL"){
                    $(".list").hide();
                    $(".ALL").show();
                    }
                    if($(this).attr("value")=="hier"){
                    $(".list").hide();
                    $(".hier").show();
                    }
                    });
                    }).change();
                    });
                 
                </script>
<script type="text/javascript">
    $(document).ready(function() 
    { 
    $("#FullList").tablesorter(); 
    } 
    );</script>
                    <!--java for select and go to url-->
                    <SCRIPT TYPE="text/javascript"> function dropdown(mySel) { var myWin, myVal; myVal =
                        mySel.options[mySel.selectedIndex].value; if(myVal) { if(mySel.form.target)myWin =
                        parent[mySel.form.target]; else myWin = window; if (! myWin) return true; myWin.location =
                        myVal; } return false; } // </SCRIPT>
                    <style>
                        table{
                        	table-layout:fixed;
                        	width:100%;
                        	border-collapse:collapse;
                        }
                        tr{
                        	border-bottom:1px solid #ccc;
                        }
                        td,
                        th{
                        	font-size:1em;
                        	padding:3px 7px 2px 7px;
                        	width:100%;
                        }
                        th{
                        	font-size:1.1em;
                        	text-align:left;
                        	padding-top:5px;
                        	padding-bottom:4px;
                        }

</style>
                    <title>
                        <xsl:value-of select="substring-after($title, '- ')"/>
                    </title>

                    <script type="text/javascript">
                        
                        var _gaq = _gaq || [];
                        _gaq.push(['_setAccount', 'UA-25697327-3']);
                        _gaq.push(['_setDomainName', 'eagle-network.eu']);
                        _gaq.push(['_trackPageview']);
                        
                        (function() {
                        var ga = document.createElement('script'); ga.type = 'text/javascript'; ga.async = true;
                        ga.src = ('https:' == document.location.protocol ? 'https://ssl' : 'http://www') + '.google-analytics.com/ga.js';
                        var s = document.getElementsByTagName('script')[0]; s.parentNode.insertBefore(ga, s);
                        })();
                        
                    </script>
                </head>

                <body style="margin:8;padding:8">
                    <script src="header.js"/>
                    <h1 class="page_title">
                        <xsl:value-of select="$title"/>
                    </h1>
                    
                    <div class="post-content">

                        <p>General data about this vocabulary:</p>
                        <table>
                            <tr>
                                <td>Languages attested</td>
                                <td>
                                    <xsl:for-each select="distinct-values(//@xml:lang)">
                                        <xsl:value-of select="."/>
                                        <xsl:if test="not(position() = last())">
                                            <xsl:text>, </xsl:text>
                                        </xsl:if>
                                    </xsl:for-each>
                                </td>
                            </tr>
                            <tr>
                                <td>Total number of terms</td>
                                <td>
                                    <xsl:value-of select="count(//skos:Concept)"/>
                                </td>
                            </tr>
                            <tr>
                                <td>Total number of preferred labels</td>
                                <td>
                                    <xsl:value-of select="count(//skos:prefLabel)"/>
                                </td>
                            </tr>
                            <tr>
                                <td>Total number of translated terms</td>
                                <td>
                                    <xsl:value-of select="count(//skos:altLabel)"/>
                                </td>
                            </tr>
                            <tr>
                                <td>Total number of equivalent and aligned terms</td>
                                <td>
                                    <xsl:value-of select="count(//skos:Concept[parent::skos:exactMatch])"/>
                                </td>
                            </tr>
                            <tr>
                                <td>Total number of related terms</td>
                                <td>
                                    <xsl:value-of select="count(//skos:related)"/>
                                </td>
                            </tr>
                            <tr>
                                <td>Total number of definitions</td>
                                <td>
                                    <xsl:value-of select="count(//skos:scopeNote)"/>
                                </td>
                            </tr>

                        </table>
                       
                        <p>Choose a language to start navigating or select SHOW ALL TERMS to see the full list of terms in this vocabulary.</p>
                        <xsl:if test="contains($title, 'Dating') or contains($title, 'Material')">
<p>You can also select SHOW HIERARCHICAL list to see the first three levels of the vocabulary's hierarchy.</p>
</xsl:if>
                        
                        <div size="20">
                            <select>
                                <option>Choose language or full display</option>
                                <option value="ALL">Show all terms</option>
                                <xsl:if test="//skos:hasTopConcept">
<option value="hier">Show hierarchical list</option>
                                </xsl:if>
                                <option value="la">Latin</option>
                                <option value="de">German</option>
                                <option value="it">Italian</option>
                                <option value="fr">French</option>
                                <option value="he">Hebrew</option>
                                <option value="es">Spanish</option>
                                <option value="en">English</option>
                                <option value="hu">Hungarian</option>
                                <option value="gr">Greek</option>
                                <option value="ar">Arabic</option>
                                <option value="ru">Bulgarian</option>
                                <option value="tr">Turkish</option>
                                <option value="others">Others</option>
                            </select>
                            <FORM ACTION="../cgi-bin/redirect.pl" METHOD="POST" onSubmit="return dropdown(this.gourl)">
                                <SELECT NAME="gourl">
                                    <xsl:choose>
<xsl:when test="contains($title, 'Dating')">
    <OPTION VALUE="">Select from chronological list</OPTION>
    <xsl:for-each select="//skos:Concept[not(@rdf:about = //skos:hasTopConcept/@rdf:resource)]">
                                        <xsl:sort select="number(substring-before(skos:scopeNote[not(@xml:lang)], ' ;'))" order="ascending"/>
                                        <option>
                                            <xsl:attribute name="value">
                                                <xsl:value-of select="@rdf:about"/>
                                            </xsl:attribute>
                                            <xsl:value-of select="skos:prefLabel[1]"/>
                                        </option>
                                    </xsl:for-each>
</xsl:when>
<xsl:otherwise>
    <OPTION VALUE="">Select from all preferred labels alphabetically</OPTION>
<xsl:for-each select="//skos:prefLabel[1]">
                                        <xsl:sort order="ascending"/>
                                        <option>
                                            <xsl:attribute name="value">
                                                <xsl:value-of select="parent::node()/@rdf:about"/>
                                            </xsl:attribute>
                                            <xsl:value-of select="."/>
                                        </option>
                                    </xsl:for-each></xsl:otherwise></xsl:choose>
                                    <INPUT TYPE="SUBMIT" VALUE="Go"/>
                                </SELECT>
                            </FORM>
                            <FORM ACTION="../cgi-bin/redirect.pl" METHOD="POST" onSubmit="return dropdown(this.gourl)">
                                <SELECT NAME="gourl">
<xsl:choose>
    <xsl:when test="contains($title, 'Dating')">
        <OPTION VALUE="">Select from all preferred labels alfabetically </OPTION>
        <xsl:for-each select="//skos:prefLabel[1]">
            <xsl:sort order="ascending"/>
            <option>
                <xsl:attribute name="value">
                    <xsl:value-of select="parent::node()/@rdf:about"/>
                </xsl:attribute>
                <xsl:value-of select="."/>
            </option>
        </xsl:for-each>
    </xsl:when>
<xsl:otherwise>                                    
<OPTION VALUE="">Select from all alternative labels alphabetically</OPTION>
                                    <xsl:for-each select="//skos:altLabel">
                                        <xsl:sort order="ascending"/>
                                        <option>
                                            <xsl:attribute name="value">
                                                <xsl:value-of select="parent::node()/@rdf:about"/>
                                            </xsl:attribute>
                                            <xsl:value-of select="."/>
                                        </option>
                                    </xsl:for-each>
</xsl:otherwise>
</xsl:choose>                                    
<INPUT TYPE="SUBMIT" VALUE="Go"/>
                                </SELECT>
                            </FORM>

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
                                <FORM ACTION="../cgi-bin/redirect.pl" METHOD="POST"
                                    onSubmit="return dropdown(this.gourl)">
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
                        <div class="he list">
                            <h3>Terms in Hebrew</h3>
                            <p>
                                <FORM ACTION="../cgi-bin/redirect.pl" METHOD="POST"
                                    onSubmit="return dropdown(this.gourl)">
                                    <SELECT NAME="gourl">
                                        <OPTION VALUE="">Choose...</OPTION>
                                        <xsl:for-each select="//skos:altLabel[@xml:lang='he']">
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
                                <FORM ACTION="../cgi-bin/redirect.pl" METHOD="POST"
                                    onSubmit="return dropdown(this.gourl)">
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
                        <div class="ar list">
                            <h3>Terms in Arabic</h3>
                            <p>
                                <FORM ACTION="../cgi-bin/redirect.pl" METHOD="POST"
                                    onSubmit="return dropdown(this.gourl)">
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
                        </div>
                        <div class="tr list">
                            <h3>Terms in Turkish</h3>
                            <p>
                                <FORM ACTION="../cgi-bin/redirect.pl" METHOD="POST"
                                    onSubmit="return dropdown(this.gourl)">
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
                        <div class="ru list">
                            <h3>Terms in Bulgarian</h3>
                            <p>
                                <FORM ACTION="../cgi-bin/redirect.pl" METHOD="POST"
                                    onSubmit="return dropdown(this.gourl)">
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
                        </div>
                        <div class="others list">
                            <h3>Terms in Arabic</h3>
                            <p>
                                <FORM ACTION="../cgi-bin/redirect.pl" METHOD="POST"
                                    onSubmit="return dropdown(this.gourl)">
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
                                <FORM ACTION="../cgi-bin/redirect.pl" METHOD="POST"
                                    onSubmit="return dropdown(this.gourl)">
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
                                <FORM ACTION="../cgi-bin/redirect.pl" METHOD="POST"
                                    onSubmit="return dropdown(this.gourl)">
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
                            <table id="FullList">
                                <thead><tr>
                                    <th>preferred label</th>
                                    <th>relation</th>
                                    <th>term</th>
                                    <th>language</th>
                                </tr></thead>
                               <tbody>
                                    <xsl:apply-templates mode="a"/>

                                    <!--main terms-->
                                </tbody>
                            </table>
                        </div>

<xsl:if test="//skos:hasTopConcept">
                        <div class="hier list">
                            <ul>
                                <xsl:for-each select="//skos:Concept[@rdf:about = //skos:hasTopConcept/@rdf:resource]">
                                    <li><a href="{@rdf:about}" target="_blank"><xsl:value-of select="skos:prefLabel[1]"/></a></li>
                                    <ul><xsl:for-each select="skos:narrower/@rdf:resource">
                                        <xsl:variable name="value" select="."/>
                                        <li><a href="{//skos:Concept[@rdf:about = $value]/@rdf:about}" target="_blank"><xsl:value-of select="//skos:Concept[@rdf:about = $value]/skos:prefLabel[1]"/></a><xsl:text> (</xsl:text><xsl:value-of select="//skos:Concept[@rdf:about = $value]/skos:prefLabel[1]/@xml:lang"/><xsl:text>)</xsl:text>
                                            <xsl:if test="//skos:Concept[@rdf:about = $value]/skos:narrower">
                                                <ul><xsl:for-each select="//skos:Concept[@rdf:about = $value]/skos:narrower/@rdf:resource">
                                                    <xsl:variable name="value" select="."/>
                                                    <li><a href="{.}" target="_blank"><xsl:value-of select="//skos:Concept[@rdf:about = $value]/skos:prefLabel[1]"/></a><xsl:text> (</xsl:text><xsl:value-of select="//skos:Concept[@rdf:about = $value]/skos:prefLabel[1]/@xml:lang"/><xsl:text>)</xsl:text></li>
                                                </xsl:for-each>
                                                </ul>
                                            </xsl:if>
                                        </li>
                                    </xsl:for-each>
                                    </ul>
                                </xsl:for-each>
                            </ul>
                        </div></xsl:if>
<div>
    <script>
        (function() {
        var cx = '004934001066682767631:ghj9p-xjqws';
        var gcse = document.createElement('script');
        gcse.type = 'text/javascript';
        gcse.async = true;
        gcse.src = (document.location.protocol == 'https:' ? 'https:' : 'http:') +
        '//www.google.com/cse/cse.js?cx=' + cx;
        var s = document.getElementsByTagName('script')[0];
        s.parentNode.insertBefore(gcse, s);
        })();
    </script>
    <p><gcse:searchbox-only></gcse:searchbox-only></p>
</div>
  <div>                      <p>
                            <a
                                href="{concat('https://www.eagle-network.eu/resources/vocabularies/', substring-after($url, 'voc/'))}" target="_blank">Back to Intro</a>
                        </p>
                        <p>
                            <a href="{concat('https://www.eagle-network.eu/',$fullskosfile)}" target="_blank">See SKOS version</a>
                        </p>
  </div>                      
                        <script src="footer.js"/>

                    </div>
                </body>
            </html>

        </xsl:result-document>
        <xsl:result-document href="{$fullskosfile}" format="xml">
           <xsl:copy-of select="."/>
        </xsl:result-document>
        <xsl:apply-templates mode="d"/>
    </xsl:template>

    <!--<xsl:template match="@*|node()" mode="skosuris">
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
        <xsl:attribute name="rdf:{local-name()}">
            <xsl:value-of select="replace(., 'lod', 'skos')"/>
        </xsl:attribute>
    </xsl:template>
    <xsl:template match="//@*[contains(., 'eagle') and contains(.,'lod')]" mode="skosurissinglefile">
        <xsl:attribute name="rdf:{local-name()}">
            <xsl:value-of select="replace(., 'lod', 'skos')"/>
        </xsl:attribute>
    </xsl:template>-->

    <xsl:template match="skos:Concept" mode="a">

        <!--single files-->
        <xsl:for-each select=".">
            <xsl:variable name="id">
                <xsl:value-of select="substring-after(@rdf:about, 'lod/')"/>
            </xsl:variable>

            <!--skos-->
            <xsl:variable name="filenameskos"
                select="concat(substring-after($url, 'https://www.eagle-network.eu/'),'/lod/',$id,'.rdf')"/>
            <xsl:result-document href="{$filenameskos}" format="xml" omit-xml-declaration="yes"
                exclude-result-prefixes="#all">
                <rdf:RDF xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#"
                    xmlns:rdfs="https://www.w3.org/2000/01/rdf-schema#"
                    xmlns:skos="https://www.w3.org/2004/02/skos/core#"
                    xmlns:map="https://www.w3c.rl.ac.uk/2003/11/21-skos-mapping#"
                    xmlns:dct="https://purl.org/dc/terms/" 
                    xmlns:dc="https://purl.org/dc/elements/1.1/">
                    <skos:ConceptScheme rdf:about="{$url}">
                        <xsl:value-of select="$title"/>
                        <dc:creator>Europeana Best Practice Network for Ancient Greek and Latin Epigraphy (EAGLE
                            BPN)</dc:creator>
                        <dc:contributor/>
                        <dc:publisher/>
                        <dc:rights/>
                        <dc:subject/>
                        <dc:description>
                            <xsl:attribute name="rdf:resource">
                                <xsl:value-of
                                    select="concat('https://www.eagle-network.eu/resources/vocabularies/', substring-before(substring-after($url, 'voc/'), '/'), '.html')"
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
                    <xsl:copy-of select="."/>

                </rdf:RDF>
            </xsl:result-document>

            <!--html-->
            <xsl:variable name="filenamehtml"
                select="concat(substring-after($url, 'https://www.eagle-network.eu/'),'/lod/',$id,'.html')"/>
            <xsl:result-document href="{$filenamehtml}" format="html">
                <html>
                    <head>
                        <meta charset="UTF-8"/>
                        <link rel="stylesheet"
                            href="//www.eagle-network.eu/wp-content/themes/eaglenetwork/style.css" type="text/css"/>
                        <title>
                            <xsl:value-of select="skos:prefLabel[1]"/>
                        </title>
                        <style>
                            table{
                            	table-layout:fixed;
                            	width:100%;
                            	border-collapse:collapse;
                            }
                            tr{
                            	border-bottom:1px solid #ccc;
                            }
                            td,
                            th{
                            	font-size:1em;
                            	padding:3px 7px 2px 7px;
                            	width:100%;
                            }
                            th{
                            	font-size:1.1em;
                            	text-align:left;
                            	padding-top:5px;
                            	padding-bottom:4px;
                            }</style>
                        <style>
                            ul#searches li{
                            	display:inline;
                            }</style>
                        
                        
                        <script type="text/javascript" src="//code.jquery.com/jquery-latest.js"/>
                        <script type="text/javascript" src="../../jquery.tablesorter.js"></script>
                        <script  type="text/javascript" src="../../jquery.tablesorter.staticrow.min.js"></script>
                        <script type="text/javascript"> 
                            $(document).ready(function() 
                            { 
                            $("#ConceptList").tablesorter({ widgets: ['staticRow'] }); 
                            } 
                            );</script>
                        <script type="text/javascript">
                            
                            var _gaq = _gaq || [];
                            _gaq.push(['_setAccount', 'UA-25697327-3']);
                            _gaq.push(['_setDomainName', 'eagle-network.eu']);
                            _gaq.push(['_trackPageview']);
                            
                            (function() {
                            var ga = document.createElement('script'); ga.type = 'text/javascript'; ga.async = true;
                            ga.src = ('https:' == document.location.protocol ? 'https://ssl' : 'http://www') + '.google-analytics.com/ga.js';
                            var s = document.getElementsByTagName('script')[0]; s.parentNode.insertBefore(ga, s);
                            })();
                            
                        </script>
                    </head>
                    <body style="margin:8;padding:8">
                        <script src="../../header.js"/>

                        <h1 class="page_title">
                            <xsl:value-of select="skos:prefLabel[1]"/>
                        </h1>
                        <div class="post-content">
                            <p>
                                <xsl:value-of select="$title"/>
                            </p>
                            <table id="ConceptList" class="tablesorter">
                                <thead><tr>
                                    <th>preferred label</th>
                                    <th>relation</th>
                                    <th>term</th>
                                    <th>language</th>
                                </tr></thead>
                                <tbody><xsl:apply-templates mode="b"/></tbody>
                                <!-- apply templates for each file -->
                            </table>
                            <br/>
                            <div>
                                <ul id="searches">
                                    <li>Find out more about this term:</li>
                                    <li>
                                        <a>
                                            <xsl:attribute name="href">
                                                <xsl:value-of
                                                    select="concat('https://en.wikipedia.org/wiki/Special:Search?search=',skos:prefLabel[1],'&amp;fulltext')"
                                                />
                                            </xsl:attribute>
<xsl:attribute name="target">_blank</xsl:attribute>
                                            <img width="5%" height="5%"
                                                src="//upload.wikimedia.org/wikipedia/commons/d/de/Wikipedia_Logo_1.0.png"
                                                title="{concat('Search ',skos:prefLabel[@xml:lang = 'en'],' in Wikipedia (EN)')}"/>
                                        </a>
                                    </li>

                                    <li>
                                        <a>
                                            <xsl:attribute name="href">
                                                <xsl:value-of
                                                    select="concat('https://www.wikidata.org/w/index.php?search=',skos:prefLabel[1],'&amp;fulltext')"
                                                />
                                            </xsl:attribute>
                                            
                                            <xsl:attribute name="target">_blank</xsl:attribute>
                                            <img width="5%" height="5%"
                                                src="//smallbiztrends.com/wp-content/uploads/2013/05/wikidata-logo-660x462.jpg"
                                                title="{concat('Search ',skos:prefLabel[1],' in Wikidata')}"/>
                                        </a>
                                    </li>
                                    <li>
                                        <a>
                                            <xsl:attribute name="href">
                                                <xsl:value-of
                                                    select="concat('https://www.google.com/search?as_epq=',skos:prefLabel[1])"
                                                />
                                            </xsl:attribute>
                                            
                                            <xsl:attribute name="target">_blank</xsl:attribute>
                                            <img width="5%" height="5%"
                                                src="https://encrypted-tbn1.gstatic.com/images?q=tbn:ANd9GcQfCP45qJe_tXuHkkAjf3sqKj2BxX0RxjE_9DBlsLbaTpsrjCx1Kg"
                                                title="{concat('Search ',skos:prefLabel[1],' in Google')}"/>
                                        </a>
                                    </li>
                                    <li>
                                        <a>
                                            <xsl:attribute name="href">
                                                <xsl:value-of
                                                    select="concat(' http://scholar.google.com/scholar?lr=&amp;ie=UTF-8&amp;q=%22',skos:prefLabel[1],'%22&amp;btnG=Search&amp;oe=UTF-8')"
                                                />
                                            </xsl:attribute>
                                            <xsl:attribute name="target">_blank</xsl:attribute>
                                            <img width="5%" height="5%"
                                                src="https://encrypted-tbn3.gstatic.com/images?q=tbn:ANd9GcQoe8OM0OJIpQtArLh2Qeo6N1ohL_nentoovO0nl6t1HzXpUxvWx6az_XbD"
                                                title="{concat('Search ',skos:prefLabel[1],' in Google Scholar')}"/>
                                        </a>
                                    </li>


                                    <li>
                                        <a>
                                            <xsl:attribute name="href">
                                                <xsl:value-of
                                                    select="concat('https://www.google.com/search?q=',skos:prefLabel[1],'&amp;gws_rd=ssl&amp;tbm=isch')"
                                                />
                                            </xsl:attribute>
                                            <xsl:attribute name="target">_blank</xsl:attribute>
                                            <img width="5%" height="5%"
                                                src="https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQacAaEn4nn0A4697mmGf1A2-OflYYCI4j7F2lNitilAF4gOvnGJDzZJlFk"
                                                title="{concat('Search ',skos:prefLabel[1],' in Google Images')}"/>
                                        </a>
                                    </li>
                                </ul>
                                <br/>
                                <form style="float:right" action="//www.eagle-network.eu/advanced-search">
                                    <input type="submit" value="EAGLE Advanced Search"/>
                                </form>
                                <form style="float:left" action="{concat('https://www.eagle-network.eu/voc/',substring-before(substring-after($url, 'https://www.eagle-network.eu/voc/'),'/'),'.html')}">
                                    <input type="submit" value="Back to Index"/>
                                </form>
                                <form style="float:left"
                                    action="{concat('https://www.eagle-network.eu/resources/vocabularies/', substring-after($url, 'voc/'))}">
                                    <input type="submit" value="Back to Intro"/>
                                </form>
                                <form style="float:right" action="{concat($url,'lod/',$id,'.rdf')}">
                                    <input type="submit" value="See SKOS version"/>
                                </form>
                            </div>

                            <script src="../../footer.js"/>
                        </div>
                    </body>
                </html>
            </xsl:result-document>
        </xsl:for-each>

        <!--main table contents-->
        <xsl:apply-templates mode="b"/>
    </xsl:template>
    <xsl:template match="skos:Concept/skos:closeMatch/skos:Concept[contains(@rdf:about,'chc.sbg.ac.at')]" mode="b">
        <tr>
            <td/>
            <td>External definition</td>
            <td>
                <a href="{@rdf:about}" target="_blank">
                    <xsl:value-of select="parent::*/preceding-sibling::skos:prefLabel"/>
                </a>
            </td>
            <td/>
        </tr>
    </xsl:template>
    <xsl:template match="skos:prefLabel" mode="b">
        <tr class="static">
            <td>
                <a>
                    <xsl:attribute name="href">
                        <xsl:value-of select="parent::skos:Concept/@rdf:about"/>
                    </xsl:attribute>
                    <xsl:attribute name="target">_blank</xsl:attribute>
                    <h2>
                        <xsl:value-of select="."/>
                    </h2>
                </a>
                <xsl:variable name="edhvocs">
                    <xsl:choose>
                        <xsl:when test="contains($url, 'material')">
                            <xsl:text>material=</xsl:text>
                        </xsl:when>
                        <!--  <xsl:when test="contains($url, 'objtyp')">
                            <xsl:text>inschrifttraeger=</xsl:text>
                        </xsl:when>
                        <xsl:when test="contains($url, 'writing')">
                            <xsl:text>palSchreibtechnik=</xsl:text>
                        </xsl:when>-->
                    </xsl:choose>
                </xsl:variable>
                <xsl:if test="@xml:lang='de' and contains($edhvocs, '=')">
                    <a>
                        <xsl:attribute name="href">
                            <xsl:value-of
                                select="concat('http://edh-www.adw.uni-heidelberg.de/inschrift/erweiterteSuche?',$edhvocs,.)"
                            />
                        </xsl:attribute>
                        <xsl:attribute name="target">_blank</xsl:attribute>
                        <img height="20%" width="20%"
                            src="//www.eagle-network.eu/wp-content/uploads/2013/06/edh-300x300.gif"
                            title="Search in EDH"/>
                    </a>
                </xsl:if>
                <!-- if in de search in Heidelberg database but needs to take into account vocabulary type-->
            </td>
            <td/>
            <td/>
            <td scope="width:10%">
                <xsl:value-of select="@xml:lang"/>
            </td>
        </tr>
    </xsl:template>
    <xsl:template match="skos:scopeNote" mode="b">
        <xsl:for-each select=".">
            <xsl:choose>
                <xsl:when test="contains(.,'HD') or contains(.,'http') or contains(.,'EDR') or contains(.,'HEpOnline') or contains(.,'UEL')">
                    <tr>
                        <td/>
                        <td>Examples</td>
                        <td>
                            <xsl:choose>
                                <xsl:when test="contains(.,'http')">
                                    <a>
                                        <xsl:attribute name="href">
                                            <xsl:value-of select="."/>
                                        </xsl:attribute>
                                        <xsl:attribute name="target">_blank</xsl:attribute>
External Example
                                    </a>
                                </xsl:when>
                                <xsl:when test="contains(.,'HD')">
                                    <xsl:for-each select="tokenize(.,' ')"><a>
<xsl:attribute name="href">
                                            <xsl:value-of select="concat('http://edh-www.adw.uni-heidelberg.de/edh/inschrift/', .)"/>
</xsl:attribute>
                                        <xsl:attribute name="target">_blank</xsl:attribute>
                                        <xsl:value-of select="."/></a><br/></xsl:for-each>
                                </xsl:when>
                                <xsl:when test="contains(.,'EDR')">
                                    <xsl:for-each select="tokenize(.,' ')"><a>
                                        <xsl:attribute name="href">
                                            <xsl:value-of select="concat('http://www.edr-edr.it/edr_programmi/res_complex_comune.php?do=book&amp;id_nr=', .)"/>
                                        </xsl:attribute>
                                        <xsl:attribute name="target">_blank</xsl:attribute>
                                        <xsl:value-of select="."/></a><br/></xsl:for-each>
                                </xsl:when>
                                <xsl:when test="contains(.,'UEL')">
                                    <a>
                                        <xsl:attribute name="href">
                                            <xsl:value-of select="concat('www.ubi-erat-lupa.org/monument.php?id=', substring-after(., 'UEL '))"/>
                                        </xsl:attribute>
                                        <xsl:attribute name="target">_blank</xsl:attribute>
                                        <xsl:value-of select="."/></a>
                                </xsl:when>
                                <xsl:when test="contains(.,'HEpOnline')">
                                    <a>
                                        <xsl:attribute name="href">
                                            <xsl:value-of select="concat('http://eda-bea.es/pub/record_card_2.php?refpage=%2Fpub%2Fsearch_select.php&amp;quicksearch=Acuerdo+de+Hospitalidad&amp;rec=', substring-after(.,'HEpOnline '))"/>
                                        </xsl:attribute>
                                        <xsl:attribute name="target">_blank</xsl:attribute>
                                        <xsl:value-of select="."/></a>
                                </xsl:when>

                                <xsl:otherwise>
    <xsl:value-of select="."/>
</xsl:otherwise>
                            </xsl:choose>
                        </td>
                        <td scope="width:10%">
                            <xsl:value-of select="@xml:lang"/>
                        </td>
                    </tr>
                </xsl:when>
                <xsl:when test="contains(.,'CIL')">
                    <tr>
                        <td/>
                        <td>Definition</td>
                        <td>
                    <xsl:value-of select="substring-before(.,'CIL')"/>
                    <a>
                        <xsl:attribute name="href">
                            <xsl:text>http://cil.bbaw.de/cil_en/dateien/glossar.php</xsl:text>
                        </xsl:attribute>
                        <xsl:attribute name="target">_blank</xsl:attribute>
                        <xsl:text>CIL</xsl:text>    
                    </a>
</td>
                        <td scope="width:10%">
                            <xsl:value-of select="@xml:lang"/>
                        </td>
                    </tr>
                </xsl:when>
                <xsl:otherwise>
                    <tr>
                        <td/>
                        <td>Definition</td>
                        <td>
                            <xsl:value-of select="."/>
                        </td>
                        <td scope="width:10%">
                            <xsl:value-of select="@xml:lang"/>
                        </td>
                    </tr>
                </xsl:otherwise>
            </xsl:choose>
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
                <td scope="width:10%">
                    <xsl:value-of select="@xml:lang"/>
                </td>
            </tr>
        </xsl:for-each>
    </xsl:template>
    <xsl:template match="skos:note" mode="b">
        <xsl:for-each select=".">
            <tr>
                <td>Bibliography</td>
                <td colspan="3">
                <xsl:choose>    <xsl:when test="contains(., 'Zotero link')">
                    <xsl:value-of select="substring-before(., 'Zotero link:')"/>
                    <a href="{substring-after(.,'Zotero link: ')}" target="_blank">
                            See in Zotero
                        </a>
                    </xsl:when>
                    
                    <xsl:otherwise><xsl:value-of select="."/></xsl:otherwise>
                </xsl:choose></td>
               
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
                        <xsl:attribute name="target">_blank</xsl:attribute>
                        <xsl:choose>
                            <xsl:when test="skos:Concept/skos:prefLabel">
                                <xsl:value-of select="skos:Concept/skos:prefLabel"/>
                            </xsl:when>
                            <xsl:otherwise>
                                <xsl:value-of select="skos:Concept/@rdf:about"/>
                            </xsl:otherwise>
                        </xsl:choose>
                    </a>

                    <xsl:if test="contains(skos:Concept/@rdf:about,'dainst')">

                        <a>
                            <xsl:attribute name="href">
                                <xsl:value-of
                                    select="concat('http://arachne.uni-koeln.de/arachne/index.php?view[layout]=search_result_overview&amp;view[category]=overview&amp;search[constraints]=',skos:Concept/skos:prefLabel)"
                                />
                            </xsl:attribute>
                            <xsl:attribute name="target">_blank</xsl:attribute>
                            <img width="50%" height="50%"
                                src="//arachne.uni-koeln.de/template/images/logo_gross.gif"
                                title="Search in Arachne"/>
                        </a>

                    </xsl:if>

                </td>
                <td>
                    <xsl:if test="skos:Concept/skos:prefLabel">
                        <xsl:value-of select="skos:Concept/skos:prefLabel/@xml:lang"/>
                    </xsl:if>
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
                    <xsl:variable name="edhvocs">
                        <xsl:choose>
                            <xsl:when test="contains($url, 'material')">
                                <xsl:text>material=</xsl:text>
                            </xsl:when>
                            <!--                            <xsl:when test="contains($url, 'objtyp')">
                                <xsl:text>inschrifttraeger=</xsl:text>
                            </xsl:when>
                            <xsl:when test="contains($url, 'writing')">
                                <xsl:text>palSchreibtechnik=</xsl:text>
                            </xsl:when>
-->
                        </xsl:choose>
                    </xsl:variable>
                    <xsl:if test="@xml:lang='de' and contains($edhvocs, '=')">
                        <a>
                            <xsl:attribute name="href">
                                <xsl:value-of
                                    select="concat('http://edh-www.adw.uni-heidelberg.de/inschrift/erweiterteSuche?',$edhvocs,.)"
                                />
                            </xsl:attribute>
                            <xsl:attribute name="target">_blank</xsl:attribute>
                            <img height="20%" width="20%"
                                src="//www.eagle-network.eu/wp-content/uploads/2013/06/edh-300x300.gif"
                                title="Search this term in EDH"/>
                        </a>

                    </xsl:if>
                </td>
                <td scope="width:10%">
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
                        <xsl:attribute name="target">_blank</xsl:attribute>
                        <xsl:value-of select="//skos:Concept[@rdf:about=$x]/skos:prefLabel"/>
                    </a>
                </td>
                <td>
                    <xsl:value-of select="//skos:Concept[@rdf:about=$x]/skos:prefLabel/@xml:lang"/>
                </td>
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
                        <xsl:attribute name="target">_blank</xsl:attribute>
                        <xsl:value-of select="//skos:Concept[@rdf:about=$x]/skos:prefLabel"/>
                    </a>
                </td>
                <td>
                    <xsl:value-of select="//skos:Concept[@rdf:about=$x]/skos:prefLabel/@xml:lang"/>
                </td>
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
                        <xsl:attribute name="target">_blank</xsl:attribute>
                        <xsl:value-of select="//skos:Concept[@rdf:about=$x]/skos:prefLabel"/>
                    </a>
                </td>
                <td>
                    <xsl:value-of select="//skos:Concept[@rdf:about=$x]/skos:prefLabel/@xml:lang"/>
                </td>
            </tr>
        </xsl:for-each>
    </xsl:template>


    <!--this creates entries for those Cocnept which are exact matches from TARGET VOCABULARIES in TEMATRES-->
    <xsl:template match="skos:Concept[parent::skos:exactMatch and contains(./@rdf:about, 'eagle')]" mode="d">

        <!--single files-->
        <xsl:for-each select=".">
            <xsl:variable name="id">
                <xsl:value-of select="substring-after(@rdf:about, 'lod/')"/>
            </xsl:variable>

            <!--skos of these concept is just for tree completeness scope the url from the html points to their main concept
however, since in the rdf tree they have their uri the skos tree MIGHT !!! I AM NO SURE !!!! require an independent representation. 

 -->
            <xsl:variable name="filenameskos"
                select="concat(substring-after($url, 'https://www.eagle-network.eu/'),'/lod/',$id,'.rdf')"/>
            <xsl:result-document href="{$filenameskos}" format="xml" omit-xml-declaration="yes"
                exclude-result-prefixes="#all">
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
                            <xsl:attribute name="rdf:resource">
                                <xsl:value-of
                                    select="concat('https://www.eagle-network.eu/resources/vocabularies/', substring-before(substring-after($url, 'voc/'), '/'), '.html')"
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
                    <xsl:copy>
                        <xsl:attribute name="rdf:about">
                            <xsl:value-of select="replace(@rdf:about, 'lod', 'skos')"/>
                        </xsl:attribute>
                        <xsl:apply-templates mode="skosuris"/>
                    </xsl:copy>

                </rdf:RDF>
            </xsl:result-document>

            <!--html-->
            <xsl:variable name="filenamehtml"
                select="concat(substring-after($url, 'https://www.eagle-network.eu/'),'/lod/',$id,'.html')"/>
            <xsl:result-document href="{$filenamehtml}" format="html">
                <html>
                    <head>
                        <meta charset="UTF-8"/>
                        <link rel="stylesheet"
                            href="//www.eagle-network.eu/wp-content/themes/eaglenetwork/style.css" type="text/css"/>
                        <title>
                            <xsl:value-of select="skos:prefLabel"/>
                        </title>
                        <style>
                            table{
                            	table-layout:fixed;
                            	width:100%;
                            	border-collapse:collapse;
                            }
                            tr{
                            	border-bottom:1px solid #ccc;
                            }
                            td,
                            th{
                            	font-size:1em;
                            	padding:3px 7px 2px 7px;
                            	width:100%;
                            }
                            th{
                            	font-size:1.1em;
                            	text-align:left;
                            	padding-top:5px;
                            	padding-bottom:4px;
                            }</style>
                        <script type="text/javascript" src="//code.jquery.com/jquery.js"/>
                        <script type="text/javascript" src="../../jquery.tablesorter.js"></script>
                        <script type="text/javascript"> 
                            $(document).ready(function() 
                            { 
                            $("#ConceptList").tablesorter({ widgets: ['staticRow'] }); 
                            } 
                            );</script>
                    </head>
                    <body style="margin:8;padding:8">
                        <script src="../../header.js"/>

                        <h1 class="page_title">
                            <xsl:value-of select="skos:prefLabel"/>
                        </h1>
                        <div class="post-content">
                            <p>
                                <xsl:value-of select="$title"/>
                            </p>
                            <table id="ConceptList">
                                <thead><tr>
                                    <th>preferred label</th>
                                    <th>relation</th>
                                    <th>term</th>
                                    <th>language</th>
                                </tr></thead>
                               <tbody> <xsl:apply-templates mode="b"/>
                                <tr>
                                    <td>Equivalent</td>
                                    <td>USE</td>
                                    <td>
                                        <a>
                                            <xsl:attribute name="href">
                                                <xsl:value-of select="./ancestor::skos:Concept/@rdf:about"/>
                                            </xsl:attribute>
                                            <xsl:attribute name="target">_blank</xsl:attribute>
                                            <xsl:value-of select="./ancestor::skos:Concept/skos:prefLabel"/>
                                        </a>
                                    </td>
                                </tr>
                              </tbody>  <!-- apply templates for each file -->
                            </table>


                            <p>
                                <a href="//www.eagle-network.eu/advanced-search" target="_blank">Search for this term on the EAGLE
                                    Advanced Search</a>
                            </p>
                            <p>
                                <a
                                    href="{concat('https://www.eagle-network.eu/voc/',substring-before(substring-after($url, 'http://www.eagle-network.eu/voc/'),'/'),'.html')}" target="_blank">Back to Index</a>
                            </p>
                            <p>
                                <a
                                    href="{concat('https://www.eagle-network.eu/resources/vocabularies/', substring-after($url, 'voc/'))}"
                                    target="_blank">Back to Intro</a>
                            </p>
                            <p>
                                <xsl:variable name="idmain">
                                    <xsl:value-of select="substring-after(ancestor::skos:Concept/@rdf:about, 'lod/')"/>

                                </xsl:variable>
                                <a href="{concat($url,'lod/',$idmain,'.rdf')}" target="_blank">See SKOS version (of the equivalent
                                    term)</a>
                            </p>
                            <p>
                                <a href="{concat($url,'lod/',$id,'.rdf')}" target="_blank">See SKOS version of this term</a>
                            </p>
                            <script src="../../footer.js"/>
                        </div>
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


    <xsl:template match="dct:created" mode="b">
        <tr class="static">
            <td/>
            <td>Created</td>
            <td>
                <xsl:value-of select="."/>
            </td>
            <td/>
        </tr>
    </xsl:template>
    <xsl:template match="dct:modified" mode="b">
        <tr class="static">
            <td/>
            <td>Modified</td>
            <td>
                <xsl:value-of select="."/>
            </td>
            <td/>
        </tr>
    </xsl:template>

</xsl:stylesheet>

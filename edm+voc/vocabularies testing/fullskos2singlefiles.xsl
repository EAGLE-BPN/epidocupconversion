<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="2.0"
    xmlns:skos="http://www.w3.org/2004/02/skos/core#" xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#"
    xmlns:rdfs="http://www.w3.org/2000/01/rdf-schema#" xmlns:tei="http://www.tei-c.org/ns/1.0"
    xmlns:dct="http://purl.org/dc/terms/" xmlns:map="http://www.w3c.rl.ac.uk/2003/11/21-skos-mapping#"
    xmlns:dc="http://purl.org/dc/elements/1.1/" xmlns="http://www.tei-c.org/ns/1.0"
>


<!--USE THIS TO GENERATE SKOS AND HTML VIEW FOR WEB SITE NOT SURE HOW TO ACTIVATE LINKS-->
   
<xsl:output method="xml" indent="yes" name="xml"/>
    <xsl:output method="html" indent="yes" name="html"/>
    <xsl:output omit-xml-declaration="yes" indent="yes"/>

    <xsl:variable name="title" select="//dc:title"/>
    <xsl:variable name="url" select="//skos:ConceptScheme/@rdf:about"/>

    <!--index-->

    <xsl:template match="/">
        <xsl:variable name="filenameindex" select="concat('voc/',substring-before(substring-after($url, 'http://www.eagle-network.eu/voc/'),'/'),'.html')"/>
        <xsl:result-document href="{$filenameindex}" format="html">

        
            <head>
               <meta charset="UTF-8"/>
                <h1><xsl:value-of select="$title"/></h1>
            </head>
            <h3>Terms in Latin</h3>
            <p>Preferred
                <select>
                    <xsl:for-each select="//skos:prefLabel[@xml:lang='la']">
                        <xsl:sort order="ascending"/>
                        <option><a><xsl:attribute name="href"><xsl:value-of select="parent::skosConcept/@rdf:about"/>
                        </xsl:attribute><xsl:value-of select="."/></a></option>
                    </xsl:for-each>
                </select></p>
            <p>Alternative
                <select>
                    <xsl:for-each select="//skos:altLabel[@xml:lang='la']">
                        <xsl:sort order="ascending"/>
                        <option><a><xsl:attribute name="href"><xsl:value-of select="parent::skosConcept/@rdf:about"/>
                        </xsl:attribute><xsl:value-of select="."/></a></option>
                    </xsl:for-each>
                </select></p>
 <h3>Terms in English</h3>

            <p>Preferred
<select>
                        <xsl:for-each select="//skos:prefLabel[@xml:lang='en']">
                            <xsl:sort order="ascending"/>
                            <option><a><xsl:attribute name="href"><xsl:value-of select="parent::skosConcept/@rdf:about"/>
</xsl:attribute><xsl:value-of select="."/></a></option>
</xsl:for-each>
                    </select></p>
            <p>Alternative
                <select>
                    <xsl:for-each select="//skos:altLabel[@xml:lang='en']">
                        <xsl:sort order="ascending"/>
                        <option><a><xsl:attribute name="href"><xsl:value-of select="parent::skosConcept/@rdf:about"/>
                        </xsl:attribute><xsl:value-of select="."/></a></option>
                    </xsl:for-each>
                </select></p>
            <h3>Terms in German</h3>
            <p>Preferred
                <select>
                    <xsl:for-each select="//skos:prefLabel[@xml:lang='de']">
                        <xsl:sort order="ascending"/>
                        <option><a><xsl:attribute name="href"><xsl:value-of select="parent::skosConcept/@rdf:about"/>
                        </xsl:attribute><xsl:value-of select="."/></a></option>
                    </xsl:for-each>
                </select></p>
            <p>Alternative
                <select>
                    <xsl:for-each select="//skos:altLabel[@xml:lang='de']">
                        <xsl:sort order="ascending"/>
                        <option><a><xsl:attribute name="href"><xsl:value-of select="parent::skosConcept/@rdf:about"/>
                        </xsl:attribute><xsl:value-of select="."/></a></option>
                    </xsl:for-each>
                </select></p> 
            <h3>Terms in Italian</h3>
            <p>Preferred
                <select>
                    <xsl:for-each select="//skos:prefLabel[@xml:lang='it']">
                        <xsl:sort order="ascending"/>
                        <option><a><xsl:attribute name="href"><xsl:value-of select="parent::skosConcept/@rdf:about"/>
                        </xsl:attribute><xsl:value-of select="."/></a></option>
                    </xsl:for-each>
                </select></p>
            <p>Alternative
                <select>
                    <xsl:for-each select="//skos:altLabel[@xml:lang='it']">
                        <xsl:sort order="ascending"/>
                        <option><a><xsl:attribute name="href"><xsl:value-of select="parent::skosConcept/@rdf:about"/>
                        </xsl:attribute><xsl:value-of select="."/></a></option>
                    </xsl:for-each>
                </select></p>
            <h3>Terms in French</h3>
            <p>Preferred
                <select>
                    <xsl:for-each select="//skos:prefLabel[@xml:lang='fr']">
                        <xsl:sort order="ascending"/>
                        <option><a><xsl:attribute name="href"><xsl:value-of select="parent::skosConcept/@rdf:about"/>
                        </xsl:attribute><xsl:value-of select="."/></a></option>
                    </xsl:for-each>
                </select></p>
            <p>Alternative
                <select>
                    <xsl:for-each select="//skos:altLabel[@xml:lang='fr']">
                        <xsl:sort order="ascending"/>
                        <option><a><xsl:attribute name="href"><xsl:value-of select="parent::skosConcept/@rdf:about"/>
                        </xsl:attribute><xsl:value-of select="."/></a></option>
                    </xsl:for-each>
                </select></p>
            <h3>Terms in Spanish</h3>
            <p>Preferred
                <select>
                    <xsl:for-each select="//skos:prefLabel[@xml:lang='es']">
                        <xsl:sort order="ascending"/>
                        <option><a><xsl:attribute name="href"><xsl:value-of select="parent::skosConcept/@rdf:about"/>
                        </xsl:attribute><xsl:value-of select="."/></a></option>
                    </xsl:for-each>
                </select></p>
            <p>Alternative
                <select>
                    <xsl:for-each select="//skos:altLabel[@xml:lang='es']">
                        <xsl:sort order="ascending"/>
                        <option><a><xsl:attribute name="href"><xsl:value-of select="parent::skosConcept/@rdf:about"/>
                        </xsl:attribute><xsl:value-of select="."/></a></option>
                    </xsl:for-each>
                </select></p>
            <h3>Terms in Hungarian</h3>
            <p>
                <select>
                    <xsl:for-each select="//skos:altLabel[@xml:lang='hu']">
                        <xsl:sort order="ascending"/>
                        <option><a><xsl:attribute name="href"><xsl:value-of select="parent::skosConcept/@rdf:about"/>
                        </xsl:attribute><xsl:value-of select="."/></a></option>
                    </xsl:for-each>
                </select></p>
            <h3>Terms in Greek</h3>
            <p>
                <select>
                    <xsl:for-each select="//skos:altLabel[@xml:lang='el']">
                        <xsl:sort order="ascending"/>
                        <option><a><xsl:attribute name="href"><xsl:value-of select="parent::skosConcept/@rdf:about"/>
                        </xsl:attribute><xsl:value-of select="."/></a></option>
                    </xsl:for-each>
                </select></p>
            <h3>Terms in Arabic</h3>
            <p>
                <select>
                    <xsl:for-each select="//skos:altLabel[@xml:lang='ar']">
                        <xsl:sort order="ascending"/>
                        <option><a><xsl:attribute name="href"><xsl:value-of select="parent::skosConcept/@rdf:about"/>
                        </xsl:attribute><xsl:value-of select="."/></a></option>
                    </xsl:for-each>
                </select></p>
            <h3>Terms in Bulgarian</h3>
            <p>
                <select>
                    <xsl:for-each select="//skos:altLabel[@xml:lang='ru']">
                        <xsl:sort order="ascending"/>
                        <option><a><xsl:attribute name="href"><xsl:value-of select="parent::skosConcept/@rdf:about"/>
                        </xsl:attribute><xsl:value-of select="."/></a></option>
                    </xsl:for-each>
                </select></p>
            <h3>Terms in Turkish</h3>
            <p>
                <select>
                    <xsl:for-each select="//skos:altLabel[@xml:lang='tr']">
                        <xsl:sort order="ascending"/>
                        <option><a><xsl:attribute name="href"><xsl:value-of select="parent::skosConcept/@rdf:about"/>
                        </xsl:attribute><xsl:value-of select="."/></a></option>
                    </xsl:for-each>
                </select></p>
            <body>
                <table>
<tr>
                    <xsl:apply-templates mode="a"/>
                </tr>
</table>
            </body>
        
        </xsl:result-document>
    </xsl:template>

    <xsl:template match="skos:Concept" mode="a">

<!--single files-->
<xsl:for-each select=".">
        <xsl:variable name="id">
                <xsl:value-of select="substring-after(@rdf:about, 'lod/')"/>
        </xsl:variable>

<!--skos-->
    <xsl:variable name="filenameskos" select="concat(substring-after($url, 'http://www.eagle-network.eu/'),'/skos/',$id,'.xml')"/>
        <xsl:result-document href="{$filenameskos}" format="xml">
            <rdf:RDF xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#" xmlns:rdfs="http://www.w3.org/2000/01/rdf-schema#" xmlns:skos="http://www.w3.org/2004/02/skos/core#" xmlns:map="http://www.w3c.rl.ac.uk/2003/11/21-skos-mapping#" xmlns:dct="http://purl.org/dc/terms/" xmlns:dc="http://purl.org/dc/elements/1.1/">
                <skos:ConceptScheme rdf:about="{$url}">
                    <xsl:value-of select="$title"/>
                    <dc:creator>Europeana Best Practice Network for Ancient Greek and Latin Epigraphy (EAGLE BPN)</dc:creator>
                    <dc:contributor/>
                    <dc:publisher/>
                    <dc:rights/>
                    <dc:subject/>
                    <dc:description>
                        <xsl:attribute name="rdf:about">
                            <xsl:value-of select="concat('http//:www.eagle-network.eu/resources/vocabularies/', substring-after($url, 'voc/'), '.html')"/>
                        </xsl:attribute>
                    </dc:description>
                    <dc:date><xsl:value-of select="current-date()"/></dc:date>
                    <dct:modified><xsl:value-of select="current-date()"/></dct:modified>
                </skos:ConceptScheme>
<xsl:copy-of select="."/>
            </rdf:RDF>
        </xsl:result-document>

<!--html-->
    <xsl:variable name="filenamehtml" select="concat(substring-after($url, 'http://www.eagle-network.eu/'),'/lod/',$id,'.html')"/>
    <xsl:result-document href="{$filenamehtml}" format="html">
        <table>
            <head>
                <meta charset="UTF-8"/>
                <h1><xsl:value-of select="$title"/></h1>
            </head>
            <body>
                <tr>
                    <xsl:apply-templates mode="b"/>
                </tr>
            </body>
           </table>        
        
        <p> <a href="http//:www.eagle-network.eu/advanced-search">Click here to see all inscriptions which have a relation to this term</a></p>
        <p><a href="{concat($url,'.html')}">Back to Index</a></p>
        <p><a href="{concat('http//:www.eagle-network.eu/resources/vocabularies/', substring-after($url, 'voc/'), '.html')}">Back to Intro</a></p>
        <p><a href="{concat(substring-after($url, 'http://www.eagle-network.eu/'),'/skos/',$id,'.xml')}">See SKOS version</a></p>
    </xsl:result-document>
</xsl:for-each>


<xsl:variable name="x" select="@rdf:about"/>
        <xsl:apply-templates mode="b"/>
        <tr><td></td><td>Definition</td>
        <td>
            <xsl:value-of
                select="//skos:Concept[@rdf:about=$x]/skos:closeMatch/skos:Concept/@rdf:about"
            />
        </td>
        <td/></tr>
    </xsl:template>



    <xsl:template match="skos:prefLabel" mode="b">
        <tr>
            <td>
                <a><xsl:attribute name="href"><xsl:value-of select="parent::skos:Concept/@rdf:about"/></xsl:attribute><h2><xsl:value-of select="."/></h2></a>
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
            <xsl:variable name="x"><xsl:value-of select="./@rdf:resource"/></xsl:variable>
            <tr>
                <td/>
                <td>Related term</td>
                <td>
                    <a><xsl:attribute name="href"><xsl:value-of select="@rdf:resource"/></xsl:attribute><xsl:value-of select="//skos:Concept[@rdf:about=$x]/skos:prefLabel"/></a>
                </td>
                <td/>
            </tr>
        </xsl:for-each>
    </xsl:template>
    <xsl:template match="skos:broader" mode="b">
        <xsl:for-each select=".">
            <xsl:variable name="x"><xsl:value-of select="./@rdf:resource"/></xsl:variable>
            <tr>
                <td/>
                <td>Contained in</td>
                <td>
                    <a><xsl:attribute name="href"><xsl:value-of select="@rdf:resource"/></xsl:attribute><xsl:value-of select="//skos:Concept[@rdf:about=$x]/skos:prefLabel"/></a>
                </td>
                <td/>
            </tr>
        </xsl:for-each>
    </xsl:template>
    <xsl:template match="skos:narrower" mode="b">
        <xsl:for-each select=".">
            <xsl:variable name="x"><xsl:value-of select="./@rdf:resource"/></xsl:variable>
            <tr>
                <td/>
                <td>Includes</td>
                <td>
                    <a><xsl:attribute name="href"><xsl:value-of select="@rdf:resource"/></xsl:attribute><xsl:value-of select="//skos:Concept[@rdf:about=$x]/skos:prefLabel"/></a>
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

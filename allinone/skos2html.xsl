<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="2.0"
    xmlns:skos="http://www.w3.org/2004/02/skos/core#" xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#"
    xmlns:rdfs="http://www.w3.org/2000/01/rdf-schema#" xmlns:tei="http://www.tei-c.org/ns/1.0"
    xmlns:dct="http://purl.org/dc/terms/" xmlns:map="http://www.w3c.rl.ac.uk/2003/11/21-skos-mapping#"
    xmlns:dc="http://purl.org/dc/elements/1.1/" xmlns="http://www.tei-c.org/ns/1.0"
    exclude-result-prefixes="tei rdf skos">


<!--USE THIS TO GENERATE HTML VIEW FOR WEB SITE NOT SURE HOW TO ACTIVATE LINKS-->

    <xsl:template match="/">
        <table>
            <head>
                <h1><xsl:value-of select="dc:title"/></h1>
            </head>
            <body>
                <tr>
                    <xsl:apply-templates mode="a"/>
                </tr>
            </body>
        </table>
    </xsl:template>
    
    <xsl:template match="skos:Concept" mode="a">
<xsl:variable name="x" select="@rdf:about"/>
        <xsl:apply-templates mode="b"/>
        <tr><td></td><td>definition and examples</td>
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
                <td>definition</td>
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
                <td>examples</td>
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
                <td>bibliography</td>
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
                <td>same as</td>
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
                <td>alternative term</td>
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
                <td>related term</td>
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
                <td>contained in</td>
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
                <td>includes</td>
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
            <td>created</td>
            <td>
                <xsl:value-of select="."/>
            </td>
            <td/>
        </tr>
    </xsl:template>
    <xsl:template match="dct:modified" mode="b">
        <tr>
            <td/>
            <td>modified</td>
            <td>
                <xsl:value-of select="."/>
            </td>
            <td/>
        </tr>
    </xsl:template>

</xsl:stylesheet>

<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:tei="http://www.tei-c.org/ns/1.0" 
    exclude-result-prefixes="xs tei"
    version="2.0">
    <xsl:template match="/">
       
            <xsl:variable name="inscription">
                <xsl:for-each select="//item">
                    <xsl:if test="document(concat('newfiles2/', ., '.xml'))">
                        <xsl:sequence select="document(concat('newfiles2/', ., '.xml'))"/>
                    </xsl:if>
                </xsl:for-each>
            </xsl:variable>   
        <TEI xmlns="http://www.tei-c.org/ns/1.0" xml:lang="en">
            <teiHeader>
                <fileDesc>
                    <titleStmt>
                        <title>Controlled Vocabularies of the Inscriptions of Dacia</title>
                    </titleStmt>
                    <publicationStmt>
                        <authority>UBB</authority>
                    </publicationStmt>
                    <sourceDesc>
                        <p>UBB</p>
                    </sourceDesc>
                </fileDesc>
                <revisionDesc>
                    <change
                        who="pietroliuzzo">
                        <xsl:attribute name="when"><xsl:value-of select="current-date()"/></xsl:attribute>
                        <xsl:text>Created from files</xsl:text>
                    </change>
                </revisionDesc>
            </teiHeader>
            <text>
                <body>
                    <div xml:id="material">
           <list>            
                   <xsl:for-each select="$inscription//tei:TEI//tei:material/text()">
            <xsl:sort order="ascending"  select="lower-case(.)"/>
            <item>
                <xsl:value-of select="."/>
            </item>
        </xsl:for-each>
           </list>
                    </div>
                    <div xml:id="typeofinscription">
                        <list> 
                            <xsl:for-each select="$inscription//tei:TEI//tei:term">
                                    <xsl:sort order="ascending"  select="lower-case(.)"/>
                                    <item>
                                        <xsl:value-of select="."/>
                                    </item>
                                </xsl:for-each>
                        </list>
                    </div>
                    <div xml:id="objectType">
                        <list> 
                            <xsl:for-each select="$inscription//tei:TEI//tei:objectType/text()">
                                <xsl:sort order="ascending"  select="lower-case(.)"/>
                                <item>
                                    <xsl:value-of select="."/>
                                </item>
                            </xsl:for-each>
                        </list>
                    </div>
                    <div xml:id="writing">
                        <list> 
                            <xsl:for-each select="$inscription//tei:TEI//tei:rs[@type='execution']/@key">
                                <xsl:sort order="ascending"  select="lower-case(.)"/>
                                <item>
                                    <xsl:value-of select="."/>
                                </item>
                            </xsl:for-each>
                        </list>
                    </div>
                </body>
            </text>
        </TEI>
    </xsl:template>
</xsl:stylesheet>
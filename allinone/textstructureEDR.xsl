<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    version="2.0"  xmlns:skos="http://www.w3.org/2004/02/skos/core#" 
    xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#" 
    xmlns:tei="http://www.tei-c.org/ns/1.0" 
    xmlns="http://www.tei-c.org/ns/1.0" 
    xmlns:xsd="http://www.w3.org/2001/XMLSchema"
    exclude-result-prefixes="tei rdf skos xsd">
    

    
    <xsl:template name="edition">
        <xsl:copy>
            <xsl:apply-templates select="@*"/>
            <head>Text</head>
            
            <xsl:choose>
                <xsl:when test="matches(., '(&#12296;):(in latere intuentibus sinistro|in latere intuentibus dextro|in epystilio|in ipsa aedicula|in una linea|in parte aversa|in fgr.\s\w*\s*|in columna\s\w*\s*)(&#12297;)')">
                    <xsl:for-each select="tokenize(., '(&#12296;):(in latere intuentibus sinistro|in latere intuentibus dextro|in epystilio|in ipsa aedicula|in una linea|in parte aversa|in fgr.\s\w*\s*|in columna\s\w*\s*)(&#12297;)')">
                       
                        <div n="{position()}" type="textpart">
                            <!--<xsl:if test="not(position()=1)">
        <xsl:attribute name="subtype">
            <xsl:variable name="sections">
                <xsl:analyze-string select="." regex="(&#12296;):(in latere intuentibus sinistro|in latere intuentibus dextro|in epystilio|in ipsa aedicula|in una linea|in parte aversa|in fgr.\s\w*\s*|in columna\s\w*\s*)(&#12297;)">
                    <xsl:matching-substring>
                        <xsl:sequence select="normalize-space(regex-group(2))"/> 
                    </xsl:matching-substring>
                </xsl:analyze-string>
            </xsl:variable>
            <xsl:value-of select="$sections"/>
        </xsl:attribute>
    </xsl:if>                -->           
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
                        </div>
                    </xsl:for-each>
                </xsl:when>
                <!--    THE FOLLOWING WILL WORK ON THE MAJORITY OF TEXT WHICH DO NOT HAVE PARTS      -->
                <xsl:otherwise>
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
                </xsl:otherwise>
            </xsl:choose>
        </xsl:copy>
        
    </xsl:template>
    
</xsl:stylesheet>
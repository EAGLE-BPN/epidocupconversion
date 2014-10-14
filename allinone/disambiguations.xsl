<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xs="http://www.w3.org/2001/XMLSchema"
	exclude-result-prefixes="xs" version="2.0">
	<!--tmtable-->
	<xsl:output indent="yes"/>
	<xsl:template match="/">
		<table>
			<head>
				<h1>TMids table compared to EDH</h1>
			</head>
			<body>
				<th>tmid</th>
				<th>edh</th>
				<th>hispep</th>
				<th>lsa</th>
				<th>lupa</th>
				<th>irt</th>
				<th>edr</th>
				<th>edb</th>
				<th>rib</th>
				<xsl:for-each select="//td[2]">
					<xsl:variable name="tmnumber">
						<xsl:for-each select=".">
							<xsl:choose>
								<xsl:when test="contains(.,',')">
									<xsl:value-of select="substring-before(.,',')"/>
								</xsl:when>
								<xsl:otherwise>
									<xsl:value-of select="."/>
								</xsl:otherwise>
							</xsl:choose>
						</xsl:for-each>
					</xsl:variable>
					<xsl:variable name="hd" select="preceding-sibling::*"/>
					<tr>
						<td>
							<xsl:value-of select="$tmnumber"/>
						</td>
						<td>
							<xsl:value-of select="$hd"/>
						</td>
						<td>
							<xsl:value-of select="document('HisEpOl-TM.htm')//td[following-sibling::node()=$tmnumber]"/>
						</td>
						<td>
							<xsl:value-of select="document('lsa-tm.xml')//lsa[following-sibling::tm=$tmnumber]"/>
						</td>
						<td>
							<xsl:value-of select="document('lupa-edh.xml')//lupa[following-sibling::hd=$hd]"/>
						</td>
						<td>
							<xsl:value-of select="document('irt-edh.xml')//irt[preceding-sibling::hd=$hd]"/>
						</td>
						<td>
							<xsl:value-of select="document('EDR-TM.htm')//td[following-sibling::node()=$tmnumber]"/>
						</td>
						<td>
							<xsl:value-of select="document('EDB-TM.htm')//td[following-sibling::node()=$tmnumber]"/>
						</td>
						<td>
							<xsl:value-of select="document('RIB-EDH-TM-txt.html')//td[preceding-sibling::td=$hd]"/>
								
						</td>
					</tr>
				</xsl:for-each>
			</body>
		</table>
	</xsl:template>

</xsl:stylesheet>

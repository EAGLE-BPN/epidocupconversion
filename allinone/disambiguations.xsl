<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xs="http://www.w3.org/2001/XMLSchema"
	exclude-result-prefixes="xs" version="2.0">
	<!--tmtable-->


	<!--this file is first applied to EDH-TM.htm and looks at other files namedly-->


	<xsl:output indent="yes"/>
	<xsl:template match="/">
		<xsl:variable name="tmlistedh">
			<xsl:variable name="tm">
				<xsl:for-each select="//td[2]">
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
			<xsl:sequence select="$tm"/>
		</xsl:variable>
		<xsl:variable name="tmlistedr">
			<xsl:variable name="tm">
				<xsl:for-each select="document('EDR-TM.htm')//td[2]">
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
			<xsl:sequence select="$tm"/>
		</xsl:variable>
		<table>
			<head>
				<h1>Available TMids comparison table</h1>
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

				<!--evaluate EDH-TM and compares to all other tables of comparison containing localId-TM or local-ID-EDH-->
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
							<!--RIB case differs because a triple comparison is given. here the correspondence is given both if there is an HD nuber only and if there is a TM number-->
							<xsl:choose>
								<xsl:when test="document('RIB-EDH-TM-txt.html')//td[preceding-sibling::td=$tmnumber]">
									<xsl:value-of
										select="document('RIB-EDH-TM-txt.html')//td[preceding-sibling::td=$tmnumber]"/>
								</xsl:when>
								<xsl:otherwise>
									<xsl:value-of
										select="document('RIB-EDH-TM-txt.html')//td[preceding-sibling::td[2]=$hd]"/>

								</xsl:otherwise>
							</xsl:choose>
						</td>
					</tr>
				</xsl:for-each>
				<!--residual entries in RIB which do not have a TM number contained in the EDH-TM table-->
				<xsl:for-each select="document('RIB-EDH-TM-txt.html')//td[position()=2 and matches(.,'\d\d\d\d\d\d') and not(. = $tmlistedh)]">
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
					<xsl:variable name="rib" select="following-sibling::*"/>
					<tr>
						<td>
							<xsl:value-of select="$tmnumber"/>
						</td>
						<td/>
						<!--matches accounted for starting from EDH -->
						<td/>
						<!--no matches possible with HE-->
						<td/>
						<!--lsa possible match unknown-->
						<td/>
						<!--lupa possible match unknown-->
						<td/>
						<!--no matches possible with irt-->
						<td/>
						<!--no matches with edb-->
						<td/>
						<td>
							<xsl:value-of select="$rib"/>
						</td>
						<!--no matches possible with rib-->
					</tr>
				</xsl:for-each>
				<!--evaluates all the tm ids in EDR not in the edh list from the edr list and looks for comparisons with edb-->
				<xsl:for-each select="document('EDR-TM.htm')//td[position()=2 and not(. = $tmlistedh)]">
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
					<xsl:variable name="edr" select="preceding-sibling::*"/>
					<tr>
						<td>
							<xsl:value-of select="$tmnumber"/>
						</td>
						<td/>
						<!--matches accounted for starting from EDH = in absence of the list of tm for EDH italian inscriptions all EDR and TM numbers are reported but without their existing corresponding edh number. when edh table will be complete these will be handled by the previous part of the code-->
						<td/>
						<!--no matches possible with HE-->
						<td/>
						<!--lsa possible match unknown-->
						<td/>
						<!--lupa possible match unknown-->
						<td/>
						<!--no matches possible with irt-->
						<td>
							<xsl:value-of select="$edr"/>
						</td>
						<td>
							<xsl:value-of select="document('EDB-TM.htm')//td[following-sibling::node()=$tmnumber]"/>
						</td>
						<td/>
						<!--no matches possible with rib-->
					</tr>
				</xsl:for-each>
				<!--evaluates all the tm ids in EDB which are not in the edr, and for safety also not in edh list and prints the correspondencies in the correct place in the table-->
				<xsl:for-each
					select="document('EDB-TM.htm')//td[position()=2 and not(. = $tmlistedr) and not(. = $tmlistedh)]">
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
					<xsl:variable name="edb" select="preceding-sibling::*"/>
					<tr>
						<td>
							<xsl:value-of select="$tmnumber"/>
						</td>
						<td/>
						<!--matches accounted for starting from EDH-->
						<td/>
						<!--no matches possible with HE-->
						<td/>
						<!--lsa possible match unknown-->
						<td/>
						<!--lupa possible match unknown-->
						<td/>
						<!--no matches possible with irt-->
						<td>
							<!--no matches possible with edr-->
						</td>
						<td>
							<xsl:value-of select="$edb"/>
						</td>
						<td/>
						<!--no matches possible with rib-->
					</tr>
				</xsl:for-each>
				<!--evaluates all the tm ids in HE which are not in edh list and prints in the table in the correct position		-->
				<xsl:for-each select="document('HisEpOl-TM.htm')//td[position()=2 and not(. = $tmlistedh)]">
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
					<xsl:variable name="he" select="preceding-sibling::*"/>
					<tr>
						<td>
							<xsl:value-of select="$tmnumber"/>
						</td>
						<td/>
						<!--matches accounted for starting from EDH-->
						<td>
							<xsl:value-of select="$he"/>
						</td>
						<td/>
						<!--lsa possible match unknown-->
						<td/>
						<!--lupa possible match unknown-->
						<td/>
						<!--no matches possible with irt-->
						<td/>
						<!--no matches possible with edr-->

						<td/>
						<!--no matches possible with edb-->

						<td/>
						<!--no matches possible with rib-->
					</tr>
				</xsl:for-each>
			</body>
		</table>
	</xsl:template>

</xsl:stylesheet>

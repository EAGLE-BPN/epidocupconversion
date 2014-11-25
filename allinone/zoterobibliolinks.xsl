<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xs="http://www.w3.org/2001/XMLSchema"
	xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#" xmlns:res="http://purl.org/vocab/resourcelist/schema#"
	xmlns:z="http://www.zotero.org/namespaces/export#" xmlns:dcterms="http://purl.org/dc/terms/"
	xmlns:bibo="http://purl.org/ontology/bibo/" xmlns:foaf="http://xmlns.com/foaf/0.1/"
	xmlns:ctag="http://commontag.org/ns#" xmlns:address="http://schemas.talis.com/2005/address/schema#"
	xmlns:sioct="http://rdfs.org/sioc/types#" xmlns:sc="http://umbel.org/umbel/sc/"
	xmlns:tei="http://www.tei-c.org/ns/1.0" xmlns="http://www.tei-c.org/ns/1.0"
	xmlns:html="http://www.w3.org/1999/xhtml"
	exclude-result-prefixes="xs tei sc sioct address foaf bibo dcterms z res rdf ctag html" version="2.0">
	<!-- the references are taken from the only comprehensive export from Zotero (bibliotology):
which is stored for the eagle grop bibliogfraphy at
https://raw.githubusercontent.com/EAGLE-BPN/EpiBib/master/exports/allbibliontology.rdf-->

	<!--

zotero pointers point at the exportable bibliographic entry (imported from Epigraphic Database Heidelberg) in Zotero. whenever a edh pointer is present, also a Zotero pointer is available

zoterotaglink pointers points at a url built using the AE or CIL or any other *listed in http://edh-www.adw.uni-heidelberg.de/hilfe/liste/corpora* reference contained in a tag. it should therefore point to all items in the bibliography who have that tag, viz. contain info about that inscription

zoterotaggad pointer is the url of each item in the bibliography which has a tag corresponding to the bibliographic entry

edh pointers point, for a given AE entry ***ONLY*** to its Bibliographic Database Heidelberg entry

edhtagged url of each Bibliographic Database Heidelberg entry in which an inscription is tagged with any given reference


-->


	<xsl:variable name="corporaabkurz">
		<xsl:sequence
			select="document('https://raw.githubusercontent.com/EAGLE-BPN/EpiBib/master/corporaabkurz.html')//html:td[position()=1 and not(contains(normalize-space(.),'CIL'))]/text()"
		/>
	</xsl:variable>
	<xsl:variable name="Zeitschriftenabkurz">
		<xsl:sequence select="document('https://raw.githubusercontent.com/EAGLE-BPN/EpiBib/master/zeitsabkurz.html')//html:td[position()=1]"/>
	</xsl:variable>
	<!--insert links to tags in zotero bibliography-->
	<xsl:template match="tei:bibl">
		<xsl:for-each select=".">
			<xsl:choose>
				<xsl:when test="starts-with(.,'CIL')">
					<xsl:copy>
						<xsl:copy-of select="@*|node()"/>
						<xsl:variable name="cil">
							<xsl:choose>
								<xsl:when test="contains(.,';')">
									<xsl:value-of select="substring-before(replace(.,',',''),';')"/>
								</xsl:when>
								<xsl:otherwise>
									<xsl:value-of select="substring-before(replace(.,',',''),'.')"/>
								</xsl:otherwise>
							</xsl:choose>
						</xsl:variable>
						<ptr type="zoterotaglink"
							target="{concat('https://www.zotero.org/groups/eagleepigraphicbibliography/items/tag/',$cil)}"/>

						<xsl:for-each
							select="document('https://raw.githubusercontent.com/EAGLE-BPN/EpiBib/master/exports/allbibliontology.rdf')//z:UserItem[descendant::ctag:label[. = $cil]]/@rdf:about">
							<ptr type="zoterotagged"
								target="{document('https://raw.githubusercontent.com/EAGLE-BPN/EpiBib/master/exports/allbibliontology.rdf')//z:UserItem[descendant::ctag:label[. = $cil]]/@rdf:about}"/>
							<ptr type="edhtagged"
								target="{document('https://raw.githubusercontent.com/EAGLE-BPN/EpiBib/master/exports/allbibliontology.rdf')//z:UserItem[descendant::ctag:label[. = $cil]]/res:resource/@rdf:resource}"/>

						</xsl:for-each>



					</xsl:copy>
				</xsl:when>
				<!--this should point at the AE corresponding unit with a EDH BIBLIO ENTRY REF AND the Zotero exportable reference: lookup required-->
				<xsl:when test="starts-with(.,'AE')">
					<xsl:copy>
						<xsl:copy-of select="@*|node()"/>
						<xsl:variable name="ae">
							<xsl:choose>
								<xsl:when test="contains(.,';')">
									<xsl:value-of select="substring-before(replace(.,',',''),';')"/>
								</xsl:when>
								<xsl:otherwise>
									<xsl:value-of select="substring-before(replace(.,',',''),'.')"/>
								</xsl:otherwise>
							</xsl:choose>
						</xsl:variable>
						<xsl:variable name="edhuri"
							select="document('https://raw.githubusercontent.com/EAGLE-BPN/EpiBib/master/exports/allbibliontology.rdf')//bibo:uri[following-sibling::z:extra[contains(.,$ae)]]"/>
						<ptr type="zoterotaglink"
							target="{concat('https://www.zotero.org/groups/eagleepigraphicbibliography/items/tag/',$ae)}"/>
						<ptr type="edh" target="{$edhuri}"/>
						<ptr type="zotero"
							target="{document('https://raw.githubusercontent.com/EAGLE-BPN/EpiBib/master/exports/allbibliontology.rdf')//z:UserItem[res:resource/@rdf:resource = $edhuri]/@rdf:about}"/>


						<xsl:for-each
							select="document('https://raw.githubusercontent.com/EAGLE-BPN/EpiBib/master/exports/allbibliontology.rdf')//z:UserItem[descendant::ctag:label[. = $ae]]/@rdf:about">
							<ptr type="zoterotagged"
								target="{document('https://raw.githubusercontent.com/EAGLE-BPN/EpiBib/master/exports/allbibliontology.rdf')//z:UserItem[descendant::ctag:label[. = $ae]]/@rdf:about}"/>
							<ptr type="edhtagged"
								target="{document('https://raw.githubusercontent.com/EAGLE-BPN/EpiBib/master/exports/allbibliontology.rdf')//z:UserItem[descendant::ctag:label[. = $ae]]/res:resource/@rdf:resource}"/>

						</xsl:for-each>
					</xsl:copy>
				</xsl:when>
				<!--corpora-->
				<xsl:when test="contains($corporaabkurz, substring-before(., ' '))">
					<xsl:copy>
						<xsl:copy-of select="@*|node()"/>
						<xsl:variable name="ref">
							<xsl:choose>
								<xsl:when test="contains(.,';')">
									<xsl:value-of select="substring-before(replace(.,',',''),';')"/>
								</xsl:when>
								<xsl:otherwise>
									<xsl:value-of select="substring-before(replace(.,',',''),'.')"/>
								</xsl:otherwise>
							</xsl:choose>
						</xsl:variable>
						<ptr type="zoterotaglink"
							target="{concat('https://www.zotero.org/groups/eagleepigraphicbibliography/items/tag/',$ref)}"/>

						<xsl:for-each
							select="document('https://raw.githubusercontent.com/EAGLE-BPN/EpiBib/master/exports/allbibliontology.rdf')//z:UserItem[descendant::ctag:label[. = $ref]]/@rdf:about">
							<ptr type="zoterotagged"
								target="{document('https://raw.githubusercontent.com/EAGLE-BPN/EpiBib/master/exports/allbibliontology.rdf')//z:UserItem[descendant::ctag:label[. = $ref]]/@rdf:about}"/>
							<ptr type="edhtagged"
								target="{document('https://raw.githubusercontent.com/EAGLE-BPN/EpiBib/master/exports/allbibliontology.rdf')//z:UserItem[descendant::ctag:label[. = $ref]]/res:resource/@rdf:resource}"/>

						</xsl:for-each>
					</xsl:copy>

				</xsl:when>

				<xsl:when test="contains($Zeitschriftenabkurz, substring-after(substring-before(.,'\s\d+\,'), ', '))">
					<xsl:copy>
						<xsl:copy-of select="@*|node()"/>
						<xsl:variable name="author">
							<xsl:analyze-string select="." regex="\s(\w+),(\s\w+\s\d+,)(\s\d\d\d\d,)">
								<xsl:matching-substring>
									<xsl:value-of select="regex-group(1)"/>
								</xsl:matching-substring>
							</xsl:analyze-string>
						</xsl:variable>
						<xsl:variable name="issue">
							<xsl:analyze-string select="." regex="\s(\w+),(\s(\w+)\s(\d+),)(\s\d\d\d\d,)">
								<xsl:matching-substring>
									<xsl:value-of select="regex-group(4)"/>
								</xsl:matching-substring>
							</xsl:analyze-string>
						</xsl:variable>

						<xsl:variable name="shorttitle">
							<xsl:analyze-string select="." regex="\s(\w+),(\s(\w+)\s(\d+),)(\s\d\d\d\d,)">
								<xsl:matching-substring>
									<xsl:value-of select="regex-group(3)"/>
								</xsl:matching-substring>
							</xsl:analyze-string>
						</xsl:variable>
						<xsl:variable name="year">
							<xsl:analyze-string select="." regex="\s(\w+),(\s(\w+)\s(\d+),)(\s(\d\d\d\d),)">
								<xsl:matching-substring>
									<xsl:value-of select="regex-group(6)"/>
								</xsl:matching-substring>
							</xsl:analyze-string>
						</xsl:variable>
						<xsl:variable name="pages">
							<xsl:analyze-string select="."
								regex="\s(\w+),(\s([A-Za-z]+)\s(\d+),)(\s(\d\d\d\d),)(\s(\d+\-\d+))">
								<xsl:matching-substring>
									<xsl:value-of select="regex-group(8)"/>
								</xsl:matching-substring>
							</xsl:analyze-string>
						</xsl:variable>
						
						<xsl:variable name="edhuri"
							select="document('https://raw.githubusercontent.com/EAGLE-BPN/EpiBib/master/exports/allbibliontology.rdf')//bibo:uri[
							following-sibling::dcterms:isPartOf//dcterms:date = $year 
							and following-sibling::dcterms:isPartOf//bibo:issue = $issue
							and (preceding-sibling::bibo:shortTitle = $shorttitle 
								or following-sibling::dcterms:isPartOf//dcterms:title = $shorttitle)
							and preceding-sibling::bibo:pages = $pages 
							and (preceding-sibling::bibo:shortTitle = $shorttitle 
								or following-sibling::dcterms:isPartOf//dcterms:title = $shorttitle)
								and parent::*/following-sibling::foaf:Person/foaf:surname = $author
							]"/>
						
					<xsl:if test="$edhuri !=''">
						<ptr type="edh" target="{$edhuri}"/>
						<ptr type="zotero"
							target="{document('https://raw.githubusercontent.com/EAGLE-BPN/EpiBib/master/exports/allbibliontology.rdf')//z:UserItem[res:resource/@rdf:resource = $edhuri]/@rdf:about}"/></xsl:if>

					</xsl:copy>
				</xsl:when>



			</xsl:choose>
		</xsl:for-each>
	</xsl:template>
</xsl:stylesheet>

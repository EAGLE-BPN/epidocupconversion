epidocupconversion
==================

XSLT to convert string epigraphic texts in marked up TEI-EPIDOC XML


These are a series of XSLT based on Chetc.txt and further support from the Epidoc Collaborative (especially from Gabriel Bodard) which should allow convert epigraphic texts from string to Epidoc markup to a good extent.

This work is done within the EAGLE project www.eagle-network.eu

Each project uses different conventions and therefore the regular expressions used to match particular situations are different. Where possible general files are reused with absolut paths, often this is not and a specific copy is available.

The files [projectabbreviation]-epidoc are those which call the sections needed for each project. By calling on a EDR template edr-epidoc, the correct xslt are called, the general where those are fine, the specific where not.

The way this is supposed to work is the following.
Projects will export in an XML template, this will have in the div[@type="edition"] a string of text.
this will have to be:

- escaped if it is not
- normalized if it needs so

The xsl
1. match the structure of the string, if there are more text part
2. normalize brackets (e.g. making [ort 3] in [ort][3]) 
3. upconverting to proper mark up most combinations
4. substitute all marks, dots, etc. with markup
5. number parts and lines (also adding the @break="no", where the line break falls into a word)

another xsl at the same time looks at the Target vocabularies in Tematres to populate with correct URIs the elements containing information about
Type of Inscription
Object Type
Material
Decoration
State of Preservation
Dating criteria

The export of these vocabularies is done from Tematres and is in this repository where correct language information have been added. the next update from the continuously edited Tematres vocabulary will happen during the summer. 

The same procedure is in place for Trismegistos geo ID but the file with the names is too long and is not accessible here. please download a local copy.

There is also in the main folder a file which can do upconversion not from an XML template but from a HTML table. this is called htmltable-epidoc and basically creates the template and applies the steps described above. this xsl also builds some basic structure in the <change> element and in the <facsimile> section. 

things that still need attention, among things which I know about, are: 
- spaces in the text (this is only relevant when we want to transform the generated .xml)
- date (which is connected with the vocabularies)

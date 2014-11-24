epidocupconversion
==================

XSLT to convert string epigraphic texts in marked up TEI-EPIDOC XML


These are a series of XSLT based on Chetc.txt and further support from the Epidoc Collaborative (especially from Gabriel Bodard) which should allow convert epigraphic texts from string to Epidoc markup to a good extent. It has been tested converting 65.000 circa records from Epigraphic Database Heidelberg, 15.000 from Epigraphic Database Bari and 15.000 from Epigraphic Database Rome

This work is done within the EAGLE project www.eagle-network.eu

This Upconversion code, largely based on string analysis functions of XSLT, basically:
- isolates first text parts, 
- then separates all mixed content paranthesis (e.g. [- - - Aug]ustus becomes [- - -][Aug]ustus)
- searches with regex for each case which can contain other encoding phenomena and substitutes string with code
- repeats the operation whenever something can occur 'inside' something else e.g. [DD]DNNN is tagged as an abbreviation with proper abbreviation marks but also the supplied letters of the abbreviation mark are encoded.
- enters line breaks numbering according to need

Since in most cases for our Content Provider we also align the content to our vocabularies (now available in a new format from http://www.eagle-network.eu/resources/vocabularies/) there are stylesheets also to:
- extract terms from elements which can be controlled by an EAGLE vocabulary
- check if those terms are already in the EAGLE skos(Tematres) vocabularies

Each project uses different conventions and therefore the regular expressions used to match particular situations are different. Where possible general files are reused with absolut paths, often this is not and a specific copy is available.

The files [projectabbreviation]-epidoc are those which call the sections needed for each project. By calling on a EDR template edr-epidoc, the correct xslt are called.

Another xsl (popwithvoc.xsl) at the same time looks at the Target vocabularies in Tematres to populate with correct URIs the elements containing information about
Type of Inscription
Object Type
Writing
Material
Decoration
State of Preservation
Dating criteria

The export of these vocabularies is done from Tematres and is in this repository where correct language information have been added. 
The last export from Tematres has been done in OCtober 2014 and now these exports in GIT are the only vocabularies actively maintained by EAGLE, while the tematres versions have been dismissed and deprecated.  

The same procedure is in place for Trismegistos geo ID but the file with the names is too long and is not accessible here. please download a local copy.

There is also in the main folder a file which can do upconversion not from an XML template but from a HTML table. this is called htmltable-epidoc and basically creates the template and applies the steps described above. this xsl also builds some basic structure in the <change> element and in the <facsimile> section. 

The folder edm+voc contains reproductions of the stylesheets used by popwithvoc, which point at EAGLE model elements rather than at EpiDoc files. and in the Vocabularies Testing folder there is a copy of the Vocabularies exported from Tematres and two xslt to transform these tematres/skos vocabularies into
- a LaTeX longtable (for printing purposes)
- an html edition and fully compliant skos edition in rdf and html
These have been prepared following Europeana Labs suggestions and feedback.


things that still need attention, among things which I know about, are: 
- spaces in the text (this is only relevant when we want to transform the generated .xml)

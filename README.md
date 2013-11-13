epidocupconversion
==================

XSLT to convert string epigraphic texts in marked up TEI-EPIDOC XML


These are a series of XSLT based on Chetc.txt and further support from the Epidoc Collaborative (especially from Gabriel Bodard) which should allow to
convert epigraphic texts from string to Epidoc markup.

This work is done within the EAGLE project www.eagle-network.eu

Each folder is a project that needs upconversion.
Each project uses different conventions and therefore the regular expressions used to match particular situations are different.

Each XSLT applicable to any file is in the main directory, namely: normalization and post-processing.

The way this is supposed to work is the following.
Projects will export in an XML template, this will have in the div[@type="edition"] a string of text.
this will have to be:

- escaped if it is not
- normalized if it needs so
- upconverted in two steps for the way this is done now: normalizing brackets (e.g. making [ort 3] in [ort][3]) and upconverting to proper mark up
- substituting all left over marks, dots, etc.
- numbering parts and lines

In each project directory there is therefore a series of folders: samples are the file described above, just out of a database. 
results are files after processing.
The currently most up to date files are those in the EDH/allinone folder where all .xsl are articulated to call each other and the vocabulary export.

things that still need attention, among things which I know about, are: 
- spaces in the text (this is only relevant when we want to transform the generated .xml)
- date (which is connected with the vocabularies)

the vocabulary situation instead (generating the double urls and the non-matching instances) is as follows:
- the Target vocabularies in Tematres will be available thanks to an update to the sofware. The EAGLE implementation will be soon updated and so will be the files in this repo. 
- There are few doubles in the EAGLE vocabularies which I will soon remove
- there are some missing entries: they will slowly be added, hopefully
- thanks to Eydel Rivero Ruiz we do not have any more the problem of generating empty ref="" when populating the XML from the vocabulary


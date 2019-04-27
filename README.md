# MSthesis-ProQuest-Cite

The details provided in theses and dissertations is often helpful towards new research projects. Referencing those works is connected with more work than needed, and there are some issue with non-distinction of dissertation and thesis by ProQuest. 

## Finding M.S. Theses

First use the [advanced search](https://search.proquest.com/advanced) of ProQuest, or the [dissertation search](http://search.proquest.com/dissertations/) platform.

Use **adv("LASTNAME,FIRSTNAME")** to search for an advisor. You could also use **ab()** to search the abstracts, but that could give large datasets.


## Exporting BibTeX

After the theses are found, select the `Cite` next to `Email`, `Save` and `Print`. Choose BibTeX as the style and output as text only. Either paste and copy or download to a text file.


Proquest incorrectly categorizes mastertheses as phdtheses, so the references do not show up properly. The reformatting follows the (BibTeX examples)[https://www.verbosus.com/bibtex-style-examples.html].

ProQuest does not export the school / university either, so it needs to be added separately. 


# Converting output

Follow these steps:

* Configure `myConfig.R` with the path information
* Save the source data as explained above in a text file with the extension `ProQuest` somewhere in the filename.
* Run `msThesis-master.R` to pick-up latest source data file and convert to bib file with the same name. 

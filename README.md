# MSthesis-ProQuest-Cite

The details provided in theses and dissertations are often helpful towards new research projects. Referencing those works is connected with more work than needed. ProQuest Dissertations and Theses does not distinguish M.S. theses and Dissertations properly. BibTeX exported references for M.S. theses from ProQuest are incorrect and need to be corrected using this code.

## Finding M.S. Theses

First use the [advanced search](https://search.proquest.com/advanced) of ProQuest, or the [dissertation search](http://search.proquest.com/dissertations/) platform.

Use **adv("LASTNAME,FIRSTNAME")** to search for an advisor. You could also use **ab()** to search the abstracts, but that could give large datasets. The institution is searched with **SCH("Long Beach")**. Other searches include **cc(0611: Condensed matter physics)**, **cc(0605: Physics)**, **cc(0600: Solid State Physics)**, and for nulcear physics cc(798)

Possible searches:
- (cc(0605: Physics) or cc(0611) or cc(0798) or cc(0600)) and SCH("Long Beach")
- adv("last,first")


## Exporting BibTeX

After the theses are found, select the `Cite`, then choose BibTeX as the style and output as text only. Either paste and copy or download to a text file.


ProQuest incorrectly categorizes mastertheses as phdtheses, so the references do not show up properly. The reformatting follows the (BibTeX examples)[https://www.verbosus.com/bibtex-style-examples.html].

ProQuest does not export the school / university either, so it needs to be added separately.


# Converting output

Follow these steps:

* Configure `myConfig.R` with the path information
* Save the source data as explained above in a text file with the extension `.txt` and the text `ProQuest` somewhere in the filename.
* Run `msThesis-master.R` to pick-up latest source data file and convert to bib file with the same name.


# Example output

The Masters' Thesis [Coercivity Dependence on Chain Length in a Low-Dimensional Magnetic System](https://books.google.com/books/about/Coercivity_Dependence_on_Chain_Length_in.html?id=mUThxgEACAAJ) would be cited as follows:

```bibtex
@mastersthesis{Cano_Coercivity_2019,
  author       = {Kevin Cano},
  title        = {Coercivity Dependence on Chain Length in a Low-Dimensional Magnetic System},
  school       = {California State University Long Beach},
  year         = 2019,
  address      = {Long Beach, CA, USA},
  month        = 1,
  note         = {}
}
```

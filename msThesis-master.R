################################
#
# Converts Dissertation BiBTeX information
# from ProQuest into MasterThesis Format
#
# http://search.proquest.com/dissertations/
###############################

# load configuration files
source('config.R')
library(stringr)
library(dplyr)
library(bibtex)


file = file.latest

# read in data
d <- readLines(file)

# get rid of any weird characters
d <- str_replace_all(d, "[^[:graph:]]", " ")

# find beginnings and endings of bib items
from <- which(str_extract(d, "[:graph:]") == "@")
to  <- c(from[-1] - 1, length(d))

# separate all bib items
itemslist <- mapply(
    function(x, y) return(d[x:y]),
    x = from, y = to - 1,
    SIMPLIFY = FALSE
)
print(paste("File contains",length(itemslist),"bib entries."))

# ProQuest does not bit BibTeXKey, so make them
fields <- lapply(itemslist,
                 function(x) {
                     str_extract(x[1], "(?<=@)[^\\{]+")
                 }
)
fields <- lapply(fields, tolower)
# need to convert phdthesis to masterthesis

# find all the category names
categories <- lapply(itemslist,
                     function(x) {
                         str_extract(x, "[:alpha:]+")
                     }
)

values <- lapply(itemslist,
                 function(x) {
                     str_extract(x, "(?<==).*")
                 }
)
values <- lapply(itemslist,
                 function(x) {
                     str_extract(x, "(?<==).*")
                 }
)
values <- lapply(values,
                 function(x) {
                     str_extract(x, "(?![\"\\{\\s]).*")
                 }
)
values <- lapply(values,
                 function(x) {
                     gsub("?(^[\\{\"])", "", x)
                 }
)
values <- lapply(values,
                 function(x) {
                     gsub("?([\\}\"]\\,$)", "", x)
                 }
)
values <- lapply(values,
                 function(x) {
                     gsub("?([\\}\"]$)", "", x)
                 }
)
values <- lapply(values,
                 function(x) {
                     gsub("?(\\,$)", "", x)
                 }
)
values <- lapply(values, trimws)

# create the data frame
items <- mapply(cbind, categories, values, SIMPLIFY = FALSE)
items <- lapply(items,
                function(x) {
                    x <- cbind(tolower(x[, 1]), x[, 2])
                }
)
items <- lapply(items,
                function(x) {
                    x[complete.cases(x), ]
                }
)
items <- mapply(function(x, y) {
    rbind(x, c("category", y))},
    x = items, y = fields, SIMPLIFY = FALSE)

items <- lapply(items, t)
items <- lapply(items,
                function(x) {
                    colnames(x) <- x[1, ]
                    x <- x[-1, ]
                    return(x)
                }
)
items <- lapply(items,
                function(x) {
                    x <- t(x)
                    x <- data.frame(x, stringsAsFactors = FALSE)
                    return(x)
                }
)
d <- bind_rows(items)
d <- as.data.frame(d)
d$lastname = unlist(lapply(strsplit(d$author   ,','),'[[',1))
d$lastname = unlist(lapply(d$lastname, function(x) { tools::toTitleCase(tolower(x)) }))
d$firstname = unlist(lapply(strsplit(d$author   ,','),'[[',2))
d$firstname = unlist(lapply(d$firstname, function(x) { tools::toTitleCase(tolower(x)) }))

d$firstTitleWord = unlist(lapply(strsplit(gsub('^A ','',d$title),' '),'[[',1))
d$UMI = gsub('.*docview\\/(\\d+).*','\\1',d$url)

write.csv(d, file=paste0(file,'.csv'))

library(ggplot2)
ggplot(d, aes(year)) + geom_histogram(stat='count', fill='red') +
    theme_bw() +
    theme(axis.text.x = element_text(angle = 90)) 
ggsave(file.path(path.source,'MSthesisYear.png'), width=6, height=4, dpi=220)

# fix the references
# see https://github.com/ropensci/bib2df
my.bib.file = paste0(file,'-FIXED.bib')
for(i in 1:nrow(d)) {
    # see https://www.rdocumentation.org/packages/utils/versions/3.5.3/topics/bibentry
    rref <- bibentry(
        key = gsub("\\s","",paste0(d$lastname[i],'_',d$firstTitleWord[i],'_',d$year[i])),
        bibtype = "MastersThesis",
        author = person(given=d$firstname[i], family=d$lastname[i]),
        title = paste0('{',tools::toTitleCase(tolower(d$title[i])),'}'),
        type = TYPE.NAME,
        school = SCHOOL.NAME,
        address = DEPT.NAME,
        year = d$year[i],
        pages = d$pages[i],
        note = paste0("ProQuest UMI No. ",d$UMI[i],', ISBN: ',d$isbn[i])
    )    
    write.bib(rref,file=my.bib.file, append=TRUE)
}


# copy TEX file
myTeX = readLines("MSthesesBibliography.tex",-1)
my.bib.fileShort = gsub('\\.bib','',my.bib.file)
my.bib.fileShort = gsub(path.source,'',my.bib.fileShort)
my.bib.fileShort = gsub('^/','',my.bib.fileShort)
myTeX[24] = gsub('BIB-FILE',my.bib.fileShort,myTeX[24])
my.tex.file = paste0(file,'-master.tex')
writeLines(myTeX,my.tex.file)

## Convert to BibTeX


#toBibtex(bref)
#writeLines(paste(format(bref, "R"), collapse = "\n\n"))

# convert phdthesis to master and write back as bib file.

# library(devtools)
# install_github('ropensci/bib2db')

# Format:
#     
#     @MASTERSTHESIS{citation_key,
#                    required_fields [, optional_fields] }
# Required fields: author, title, school, year
# 
# Optional fields: address, month, note, key


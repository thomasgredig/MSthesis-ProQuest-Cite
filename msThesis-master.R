################################
# (c) 2015-2019 Thomas Gredig
#
# Converts Dissertation BiBTeX information
# from ProQuest into MasterThesis Format
#
# http://search.proquest.com/dissertations/
###############################

# load configuration files
source('config.R')

# install.packages('RefManageR')
library(RefManageR)

b=ReadBib(file.latest)
warnings()
filename = 'ProQuestDocuments-2015-06-04.csv'
records = read.csv(filename, header=TRUE)



# Format:
#     
#     @MASTERSTHESIS{citation_key,
#                    required_fields [, optional_fields] }
# Required fields: author, title, school, year
# 
# Optional fields: address, month, note, key

d = c()

reclen = length(records)
for (i in 1:reclen) {
    unlist(strsplit(as.character(records$Authors[i]), "\n")) -> author.list
    d = c(d,paste("@MASTERSTHESIS{",author.list[length(author.list)-1],records$year[i],',',sep=''))
    d = c(d, paste("  author = {", author.list[1] ,"},", sep='' ))
    d = c(d, paste("  title = {", records$Title[i],"},", sep='' ))
    d = c(d, paste("  year = {", records$year[i],"},", sep='' ))
    d = c(d, "  school = {California State University Long Beach},")
    #d = c(d, paste("  note = {", gsub('%','\\%',records$Abstract[i]),"},", sep='' ))
    d = c(d, " }")
    d = c(d, " ")
}
d
write(file='ms-theses.bib', d)
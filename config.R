# configuration, should be overwritten in myConfig.R
# ==================================================


# C O N F I G U R A T I O N
# -------------------------

# path to save input bibliography file
path.source = '.'
SCHOOL.NAME = 'University Name'
DEPT.NAME = 'Department of Physics'

# personalize overwrite
# --------------------
if(file.exists('myConfig.R')) { source('myConfig.R')}
if (path.source=='.') {
    print("WARNING: please configure path.")
}

# find latest file
# ----------------
file.list = file.path(path.source,dir(path.source,pattern='.*ProQuest.*txt$'))
if (length(file.list)==0) {
    print("ERROR: no ProQuest data file found.")
}
file.latest = file.list[which.max(file.info(file.list)$mtime)]
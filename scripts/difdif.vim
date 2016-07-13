:%s%---.*\n%%g
:%s%+++.*\n%%g
:%s%@@.*\n%%g
:w
:%s%diff -u.*\n%%g
:%s%retrieving revision.*\n%%g
:w
:%s%.*========================.*\n%%g
:w
:%s%RCS file.*\n%%g
:%s%Index: rg/%Index: %g
:%s%diff -N.*\n%%g
:w
:wincmd l
:%s%---.*\n%%g
:%s%+++.*\n%%g
:w
:%s%@@.*\n%%g
:%s%diff -u.*\n%%g
:w
:%s%retrieving revision.*\n%%g
:%s%.*========================.*\n%%g
:w
:%s%RCS file.*\n%%g
:w
:%s%Index: rg/%Index: %g
:%s%diff -N.*\n%%g
:w
:diffupdate

i'm not very good at naming things


## background??

the regular `neocities push .` command will attempt to upload **all** files in
your root directory, regardless of whether or not they've been modified. this
sucks! especially if you have a lot of files. so i wrote this little script to
address that issue, using git's tracking of changes


## usage

steps:

1. copy `neogities.rb` to your site's root folder (i.e., same folder as
   .git)
2. copy `pre-commit` and `pre-push` to `.git/hooks`
3. n then just do all your git stuff same as normal. every time you push to
   your repo the modified files will also be uploaded to neocities :)

\*this works by writing a list of modified files to `status.txt` every time you
commit, so you might want to add that to your gitignore.

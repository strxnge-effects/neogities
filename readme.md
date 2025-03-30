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

this works by writing a list of modified files to `status.txt` every time you
commit, so you might want to add that to your gitignore.


### note for linux users

if you get an error like this:

```The '.git/hooks/pre-commit' hook was ignored because it's not set as executable.'```

you'll have to run these commands from your site's root directory:

```chmod +x .git/hooks/pre-commit```

```chmod +x .git/hooks/pre-push```

because something something file permissions idk.
([source](https://stackoverflow.com/questions/8598639/why-is-my-git-pre-commit-hook-not-executable-by-default#comment88478230_47166916))

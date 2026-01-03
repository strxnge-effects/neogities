## overview

`neogities.rb` updates your files on neocities.

`pre-commit` writes a list of every modified file to `status.txt` when you
commit your changes.

`pre-push` runs `neogities.rb` when you push your changes.


### "how is this different from `neocities push .`?"

1. rather than attempting to upload **all** files in your site directory,
   neogities uses `git status` to only update the files that've been modified.
2. `neocities push` will only *upload* files, it does not delete or rename a
   file when you perform the same action on your local repo. neogities.rb does.
   :)


## usage

steps:

1. copy `neogities.rb` to your site's root folder (i.e., same folder as
   .git)
2. copy `pre-commit` and `pre-push` to `.git/hooks`
3. n then just do all your git stuff same as normal. every time you push to
   your remote repo the changes will also be reflected on neocities :)

remember to add `status.txt` to your gitignore so it doesn't get updated every
time!


### note for linux users

if you get an error like this:

```The '.git/hooks/pre-commit' hook was ignored because it's not set as executable.'```

you'll have to run these commands from your site's root directory:

```
chmod +x .git/hooks/pre-commit
chmod +x .git/hooks/pre-push
```

because something something file permissions idk.
([source](https://stackoverflow.com/questions/8598639/why-is-my-git-pre-commit-hook-not-executable-by-default#comment88478230_47166916))

# Description
This is a static generator for a blog written in shell,
uploaded for archival rather than for being really useful to
others, continued or even optimized/cleaned.

Check `articles/blog.{fr,en}` for a full description. French
is the reference version (english seems to be missing the part
on git, which is roughly translated below anyway).

Main features are:

- dated, entitled articles (default);
- tagged articles `utils/tag`;
- translated articles `utils/lang`;
- table of content `utils/toc`;
- link to man pages `utils/{obsdman,p9man}`;
- RSS feed generation `utils/rss`;
- easy integration with git : use a
  [bare repository](http://tips.awesom.eu/show?id=26) with 
  the `hook/post-receive` git hook (see §Testing)
- use the formatter you want, be it `markdown`, or even `sh`.
  See `articles/index` and `articles/tags` for shell-script
  articles. The `b.sh` script itself can be copied to `articles/`;
- article format header is trivial, thus easily extensible.

# Ressources
## mdown
Both `articles/blog.{fr,en}` were written using the venerable
mdown written by Nhat Minh Lê (rz0). As git.huoc.org is un-available,
see [here](http://awesom.eu/~mb/mdown.tgz) if you want to get
it. Not guaranteed to be the last version thought.

## tao.png
Original may be found
[here](http://www.iconarchive.com/show/space-icons-by-aha-soft/Galaxy-icon.html).
Free for non-commercial use.

# Testing
Once mdown installed, 

	(earth)% cp b.sh articles/
	(earth)% ./b.sh articles/ html/

And browse to `file://$PWD/html/`.

Assuming two machines `local` and `remote`, the following
deploys the blog using a bare repository `$HOME/test.git` and
the html output of the blog in `$HOME/www/test/html/`:
(to be re-tested)

	(local)% edit articles/myarticle
	(local)% git commit articles/myarticle -m 'adding myarticle'
	(local)% scp -r $PWD remote:/tmp/test

	(remote)% cd ~ && git clone --bare /tmp/test/.git test.git
	(remote)% mkdir -p ~/www/test
	(remote)% cd ~/test.git
	(remote)% cat > hooks/post-receive <<EOF
	#!/bin/sh
	GIT_WORK_TREE=~/www/test git checkout -f
	cd $GIT_WORK_TREE
	rm html/*
	./b.sh articles/ html/
	EOF

	(local)% git remote add web remote:~/test.git
	(local)% git push web +master:refs/heads/master

# License
Public domain.

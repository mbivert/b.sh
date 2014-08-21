# Description
This is a static generator for a blog writting in shell,
uploaded for archival rather than for being really useful/continued.

Check `articles/blog.{fr,en}` for a full description. French
is the reference version (english seems to be missing the part
on git, which is roughly translated below anyway).

Main features are:

- dated, entitled articles (default);
- tagged articles `utils/tag`;
- translated articles `utils/lang`;
- table of content `utils/toc`;
- link to man pages `utils/{obsdman,p9man`;
- RSS feed generation `utils/rss`;
- easy integration with git : use a
  [bare repository](http://tips.awesom.eu/show?id=26) with 
  the supplied `hook/post-receive` git hook
- use the formatter you want, be it `markdown`, or even `sh`.
  See `articles/index` and `articles/tags` for shell-script
  articles. The `b.sh` script itself can be copied to `articles/`;
- article format header is trivial, thus easily extensible.

# Ressources
## Mdown
Both `articles/blog.{fr,en}` were written using the venerable
mdown written by Nhat Minh Lê (rz0). As git.huoc.org is down,
see [here](http://awesom.eu/~mb/mdown.tgz) if you want to get
it. Not guaranteed to be the last version thought.

Once in path, you can generate the whole thing with:

## tao.png
Original may be found
[here](http://www.iconarchive.com/show/space-icons-by-aha-soft/Galaxy-icon.html).
Free for non-commercial use.

# Testing
Once mdown installed, 

	(earth)% cp b.sh articles/
	(earth)% ./b.sh articles/ html/

And browse to `file://$PWD/html/`.

# License
Public domain.

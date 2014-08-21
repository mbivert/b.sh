#!/bin/sh
# This shell script is also an article :-)
cat <<EOF >/dev/null
Title: blog.sh (the code)
Tags: code,shell,blog
Date: 20111013
Fmt: sed s,<,\&lt;,g;s,>,\&gt;,g;1s/^/<pre><code>/;$s,$,</code></pre>,
EOF

#!/bin/sh
PATH=/bin:/usr/bin:/usr/local/bin:$HOME/bin:$PWD/utils:$PWD/../utils

URL=http://awesom.eu/~homer/blog/
RSS=blog.rss
CSS=../styles/blog.css

# by default SRC = DST = current directory
[ "$1" = "" ] && set -- .
[ "$2" = "" ] && set -- $1 .

SRC=$1; DST=$2
echo $SRC | grep '/$' || SRC=$SRC/
echo $DST | grep '/$' || DST=$DST/

export URL SRC DST PATH RSS CSS

# getattr & fmtdate
. utils/lib

# htmlhead title
htmlhead() {
	cat <<EOF
<!DOCTYPE HTML>
<html lang="en">
	<head>
		<meta charset=utf-8>
		<link type="text/css" rel="stylesheet" href="$CSS">
		<title>$1</title>
	</head>
	<body>
EOF
}

# footer
htmlfoot() {
	cat <<EOF
	</body>
</html>
EOF
}

generate() {
	date=`getattr Date $1 | fmtdate`
	title=`getattr Title $1`
	fmt=`getattr Fmt $1`

	htmlhead "$title"
		echo "<h1 class=\"title\">$title</h1>"
		echo '<p><img src="../imgs/tao.png" alt="tao" /></p>'
		echo "<p class=\"date\">$date</p>"
		# skip header; format
		awk '/^$/ { inbody = 1 } inbody == 1' $1 | $fmt
	htmlfoot
}

if [ -f $SRC ]; then
	ART=$SRC; export ART
	generate $ART > $DST/`basename $ART`.html
	# update SRC to be a directory, for
	# rss generation.
	SRC=`dirname $SRC`
else
	for ART in $SRC/*; do
		export ART
		generate $ART > $DST/`basename $ART`.html
	done
fi

# utils/rss to generate rss file
rss


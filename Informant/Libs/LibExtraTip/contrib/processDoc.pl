!#/usr/bin/perl

open API, ">API.html";
$header = "<html>
<head>
<title>API Documentation</title>
<style>
body {
	font: 13px Verdana, Helvetica, sans-serif;
	color: #333;
	background: #eee;
}
h1, h2, h3, h4 {
	margin: 0px;
	padding: 0px;
}
.method {
	margin-top: 20px;
}
.author, .version, .param, .return, .see, .since {
	padding-left: 1em;
}
:target {
	background: #ffd;
}
li {
	padding-left: 2em;
}
.summary {
	font-style: oblique;
}
.method {
	color: #521;
	text-decoration: underline;
}
.param {
	color: #44b;
}
.return {
	color: #4a4;
}
.since {
	color: #777;
}
</style>
</head>
<body>
";

print API $header;

$libName = "lib";
$commentNum = 0;
$comment = "";
$inComment = 0;
$fLooking = 0;
$first = 0;
$detail = 0;
while (<>) {
	s/^\s*//g;
	s/\s*$//g;
	print "$inComment$fLooking$detail Line: $_\n";
	if (!$inComment && /^--\[\[-/) {
		$commentNum = 0;
		$inComment = 1;
		$fLooking = 0;
		$detail = 0;
		process($comment) if ($comment ne "");
		$comment = "";
	}
	elsif ($inComment && /\]\]/) {
		$inComment = 0;
		$fLooking = 1;
		$detail = 0;
	}
	elsif ($inComment && /^\@libname ([^\s]+)/) {
		$libName = $1;
	}
	elsif ($inComment) {
		if (!$first) {
			$comment .= "\@title $_\n\n";
			$first = 1;
			$detail = 1;
		}
		elsif ($commentNum == 0) {
			$comment .= "\n\@summary $_\n\n";
			$detail = 1;
		}
		else {
			if (/^\@/) {
				unless($detail) {
					$comment .= "\n\n \n\n";
				}
				$detail = 1;
			}
			elsif (/^\*\s+/) {
				$detail = 1;
			}
			else {
				$detail = 0;
			}
			$comment .= "$_\n";
		}
		$commentNum++;
	}
	elsif ($fLooking) {
		$fLooking = 0;
		if (/^(local)?\s*function\s+([^\s\(:\.]+)(([:\.])([^\s\(]+))?\(([^\)]+)\)/) {
			if ($1) {
				$scope = "Local ";
			}
			else {
				$scope = "";
			}
			@params = split/\s*\,\s*/, $6;
			$params = join(", ", @params);
			if ($3) {
				$lib = $2;
				$accessor = $4;
				if ($accessor eq ":") {
					$mode = "Class Method";
				}
				else {
					$mode = "Member Function";
				}
				$function = $5;

				if ($lib eq "lib") {
					$lib = $libName;
				}

				$comment = "\@method $function $mode $lib$accessor$function($params)\n$comment";
			}
			else {
				($lib, $accessor) = ();
				$mode = "Function";
				$function = $2;
				$comment = "\@method $function $scope$mode $function($params)\n$comment";
			}
			process($comment);
			$comment = "";
		}
	}
}
process($comment) if ($comment ne "");

print API "\n</body>\n</html>";
close (API);

sub process($) {
	my ($comment) = @_;
	print "$comment";
	$comment =~ s/</&lt;/g;
	$comment =~ s/^\@author (.*)/\n<b class="author">Author: $1<\/b>\n/mg;
	$comment =~ s/^\@version (.*)/\n<b class="version">Version: $1<\/b>\n/mg;
	$comment =~ s/^\@since (.*)/\n<b class="since">Available since v$1<\/b>\n/mg;
	$comment =~ s/^\@method ([^\s]+)\s+(.*)/\n<h3 class="method" id="$1">$2<\/h3>/mg;
	$comment =~ s/^\@param ([^\s]+)\s+(.*)/\n<b class="param">$1<\/b>: $2\n/mg;
	$comment =~ s/^\@return (.*)/\n<b class="return">Returns<\/b>: $1\n/mg;
	$comment =~ s/^\@summary (.*)/\n<h4 class="summary">$1<\/h4>\n/mg;
	$comment =~ s/^\@title (.*)/\n<h2 class="title">$1<\/h2>\n/mg;
	$comment =~ s/^\@see (.*)/\n<b class="see">See also<\/b>: <a href="#$1">$1<\/a>\n/mg;
	$comment =~ s/^\*\s+(.*)/<li>$1<\/li>/mg;
	$comment =~ s/{\@wowwiki:([^}\|]+)}/<a href="http:\/\/wowwiki.com\/$1" target="_blank">$1<\/a>/g;
	$comment =~ s/{\@wowwiki:([^}\|]+)\|([^}]+)}/<a href="http:\/\/wowwiki.com\/$1" target="_blank">$2<\/a>/g;
	$comment =~ s/\n\n+/<br\/>\n/g;
	print API $comment;
}


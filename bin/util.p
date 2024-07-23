@unhandled_exception[exception;stack]
$exception.handled(1)
^l[--- exception ---
$exception.comment $exception.source
$exception.lineno $exception.file]
$result[]


@postprocess[b]
$result[^b.trim[]^#0a]


@load_text[path]
$result[^file::load[text;$path]]
$result[^taint[as-is][$result.text]]


@rmrf[path;keep_dirs][l]
^if(^file:justext[$path] eq "gitkeep"){^return[]}
^if(-f "$path"){^file:delete[$path;$.keep-empty-dirs($keep_dirs)]}
^if(-d "$path"){$l[^file:list[$path]]^l.menu{^rmrf[$path/$l.name;0]}}

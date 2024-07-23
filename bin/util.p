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
^if(-f "$path"){^file:delete[$path;$.keep-empty-dirs($keep_dirs)]}
^if(-d "$path"){
    $l[_]^l.save[$path/l]
    $l[^file:list[$path]]^l.menu{^rmrf[$path/$l.name;0]}}


@cprf[from;to][l]
^if(-f "$from"){^file:copy[$from;$to]}
^if(-d "$from"){
    $l[^file:list[$from]]^l.menu{^cprf[$from/$l.name;$to/$l.name]}}

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

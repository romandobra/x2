@process_lines[h;depth][locals]
$result[^hash::create[]]

^h.foreach[c;tag]{

    ^if($tag.depth > $depth){ ^continue[] }
    ^if(^tag.tag.match[^^\W]){ ^continue[] }

    $result.[$c][$.__tag[^extract_tag_name[$tag.tag]]]
    ^result.[$c].add[^extract_id[$tag.tag]]
    ^result.[$c].add[^extract_class[$tag.tag]]

    $modyfiers[^select_modyfiers[$h;$depth;$c]]
    ^result.[$c].add[
        ^process_modyfiers[$modyfiers;$tag.default;$result.[$c].class] ]

    ^result.[$c].add[^process_default[$result.[$c]]]
    ^result.[$c].delete[__default]

    $inner[^select_inner[$h;$depth;^eval($c + $modyfiers)]]
    ^if($inner){
        ^result.[$c].add[
            $.__inner[^process_lines[$inner;^eval($depth +1)]] ] }
}

@process_modyfiers[m;d;c][locals]
$result[^hash::create[]]

^if(^m.count[] == 0){
    ^if("$d" ne ""){^result.add[$.__default[^d.trim[]]]}
    ^return[] }

^m.foreach[k;v]{
    ^switch[$v.tag]{
        ^case[=]{
            $attr[^v.default.match[^^([\S]+)]]
            $attr[$attr.1]
            $value[^v.default.mid(^attr.length[])]
            ^result.add[$.[$attr][^value.trim[]]]
        }
        ^case[+]{ $d[$d $v.default] }
        ^case[.]{ $c[$c $v.default] }
        ^case[#]{ $i[^v.default.trim[]] }
        ^case[DEFAULT]{
            ^l[unknown modyfier '$v.tag'] } } }

$c[^c.trim[]]^if($c ne ""){^result.add[$.class[^c.trim[]]]}
^if($i ne ""){^result.add[$.id[^i.trim[]]]}
$d[^d.trim[]]^if($d ne ""){^result.add[$.__default[^d.trim[]]]}


@process_default[t][locals]
$result[^hash::create[]]
^if($t.__default eq ""){ ^return[] }

$p[$settings.html.defaults.[$t.__tag]]
^if($p eq ""){
    ^result.add[$.__text[$t.__default]]
}{
    ^result.add[$.[$p][$t.__default]]
}


@select_inner[h;max_depth;min_line][locals]
$result[^hash::create[]]
^h.foreach[k;v]{
    ^if($k <= $min_line){ ^continue[] }
    ^if($v.depth <= $max_depth){ ^break[] }
    ^result.add[$.[$k][$v]] }


@select_modyfiers[h;depth;min_line][locals]
$result[^hash::create[]]
^h.foreach[k;v]{
    ^if($k <= $min_line){ ^continue[] }
    ^if($v.depth > $depth){ ^break[] }
    ^if(^v.tag.match[^^\w]){ ^break[] }
    ^result.add[$.[$k][$v]] }



@extract_tag_name[t]
$result[^t.match[^^([\w-]+)]]
$result[$result.1]


@extract_id[tag][locals]
$result[^hash::create[]]
$t[^tag.split[#]]
^if(^t.count[] > 1){
    ^t.offset[set](1)
    $t[^t.piece.split[.]]
    $t[$t.piece] }

^if("$t" ne ""){ $result[$.id[$t]] }


@extract_class[tag][locals]
$result[^hash::create[]]
$t[^tag.split[.]]
^if(^t.count[] > 1){
    ^t.menu{
        ^if(^t.line[] < 2){^continue[]}
        ^if("$r" ne ""){
            $r[$r $t.piece]
        }{
            $r[$t.piece] } } }

^if("$r" ne ""){ $result[$.class[$r]] }



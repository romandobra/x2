@auto[]
$nl[^if($settings.html.indent eq ""){}{^#0a}]


@print_html[h;ic][locals]
^h.foreach[k;v]{

    $result[${result}^open_tag[$v;^indent($ic);$nl]]

    ^if($v.__text ne ""){
        $result[${result}^indent(1+$ic)${v.__text}${nl}]
    }

    ^if($v.__inner){
        $result[${result}^print_html[$v.__inner;^eval($ic +1)]]
    }

    $result[${result}^close_tag[$v;^indent($ic);$nl]]

}


@open_tag[v;i;l][locals]
^if(
    $settings.html.slash_void_tags
    &&
    ^settings.html.void_tags.select[;k]($k eq $v.__tag)
){ $slash(1) }
$attr[^v.foreach[name;val]{^if(^name.left(2) ne __){ $name="$val"}}]
$result[$i<${v.__tag}$attr^if($slash){ /}>$l]


@close_tag[v;i;l][locals]
^if(^settings.html.void_tags.select[;k]($k eq $v.__tag)){
    $result[]
}{
    $result[$i</${v.__tag}>$l] }


@indent[n][locals]
^if($settings.html.indent eq ""){^return[]}
$result[^for[i](1;$n){$settings.html.indent}]

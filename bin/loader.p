@auto[]
$line_counter(1)


# load x2 text, results a hash of lines "line_counter [depth, tag, default]"
@load_x2[path;starting_depth][locals]
$result[^hash::create[]]
$table[^table::create{line^#0a^load_text[$path]}]

^table.menu{

# exclude empty lines
    ^if( ! ^table.line.match[\S+] ){ ^continue[] }

# count spaces at the beginning and divide it
# by indent length and add the starting_depth
    $depth[^table.line.match[(\S.*)][g][]]
    $depth( ^depth.length[]
            / ^settings.x2.indent.length[]
            + $starting_depth )

# the first word in the line
    $tag[^table.line.match[(\S+)]]
    $tag[$tag.1]

# the rest of the line
    $default[ ^table.line.mid(  ( $depth - $starting_depth )
                                * ^settings.x2.indent.length[]
                                + ^tag.length[]) ]
    $default[^default.match[ +][g][ ]]
    $default[^default.trim[]]

# load external x2 or add hash to result
    ^if($tag eq "/"){
        ^if($settings.x2.ext_path_prefixes){
            $use_prefix[]
            ^settings.x2.ext_path_prefixes.foreach[;prefix]{
                ^l[../$prefix/${default}.x2]
                ^if(-f "../$prefix/${default}.x2"){
                    $use_prefix[$prefix]
                    ^break[] } }
            ^if($use_prefix eq ""){
                ^throw[;cant find any prefix in settings.x2.ext_path_prefixes]
            }
        }{ $use_prefix[$settings.x2.ext_path_prefix] }
        ^result.add[
            ^load_x2[../$use_prefix/${default}.x2;^eval($depth)]]
    }{
        ^result.add[
            $.[$line_counter][
                $.tag[$tag] $.depth[$depth] $.default[$default] ] ]
        ^line_counter.inc(1)
    }
}

^debug[$result;lines-^file:justname[$path].json]

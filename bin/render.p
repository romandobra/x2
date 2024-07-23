@main[]
$settings[^file::load[text;../x2-settings.json]]
$settings[^json:parse[^taint[as-is][$settings.text];]]


# use p files
$p[^file:list[../bin;.p^$]] ^p.menu{
    ^if($p.name eq render.p){^continue[]}
    ^use[../bin/$p.name]}


# render
^render_dir[../$settings.x2.project_path;../$settings.x2.output_path]

^if("$settings.x2.includes_path" ne ""){
    ^cprf[../$settings.x2.includes_path;../$settings.x2.output_path]
}



@render_dir[in;out][locals]
^rmrf[$out]

$p[^file:list[$in]]

^p.menu{
    ^if($p.dir){
        ^render_dir[$in/$p.name;$out/$p.name]
        ^continue[] }

    ^l[f | $in/$p.name]

    $x2[^load_x2[$in/$p.name]]
    $x2[^process_lines[$x2]]
    $html[^print_html[$x2;0;1]]
    ^l[s | $out/^file:justname[$p.name].html]
    ^html.save[$out/^file:justname[$p.name].html]
}

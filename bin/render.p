@main[]
$settings[^file::load[text;../x2-settings.json]]
$settings[^json:parse[^taint[as-is][$settings.text];]]


# use p files
$p[^file:list[../bin;.p^$]] ^p.menu{
    ^if($p.name eq render.p){^continue[]}
    ^use[../bin/$p.name]}


# render
$p[^file:list[../$settings.x2.project_path;x2^$]]
^p.menu{
    $x2[^load_x2[../$settings.x2.project_path/$p.name]]
    $x2[^process_lines[$x2]]
    $html[^print_html[$x2;0;1]]
    ^html.save[../$settings.x2.output_path/^file:justname[$p.name].html]
}

@main[]
$settings[^file::load[text;settings.json]]
$settings[^json:parse[^taint[as-is][$settings.text];]]


# use p files
$p[^file:list[p;.p^$]] ^p.menu{^use[p/$p.name]}


# render
$p[^file:list[$settings.x2.project_path;x2^$]]
^p.menu{
    $x2[^load_x2[$settings.x2.project_path/$p.name]]
    $x2[^process_lines[$x2]]
    $html[^print_html[$x2;0]]
    ^html.save[$settings.x2.output_path/^file:justname[$p.name].html]
}

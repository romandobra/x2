@l[o]
$console:line[^so[$o]]$result[]

@sol[o;s]
$result[^rep_l[^so[$o;$s]]]

@rep_l[s]
$result[^s.match[(^#0A+)][g]{ }]

@soh[o;s]
$result[^rep_br[^so[$o;$s]]]

@rep_br[s]
$result[^s.match[(^#0A+)][g]{<br>}]

# show object
@so[o;t;s]
^if(!def $t){$t(0)}
^switch[$o.CLASS_NAME]{
  ^case[string]{$result[${o}$s]}
  ^case[double]{$result[^if($o){OK}{NOK}$s]}
  ^case[bool]{$result[^if($o){OK}{NOK}$s]}
  ^case[hash]{$result[^sh[$o;$t;$s]]}
  ^case[table]{$result[^o.csv-string[nameless]]}
  ^case[file]{$result[FILE:$o.name stderr:$o.stderr text:$o.text]}
  ^case[DEFAULT]{$result[class_name:${o.CLASS_NAME}$s]}}

# show hash
@sh[h;t;s]
$t($t +1)
$result[^h.foreach[key;value]{
$s^tt[$t]$key=^so[$value;$t]}[$s]]

@tt[n][locals]
^for[i](1;$n){|}
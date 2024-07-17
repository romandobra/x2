@auto[]
$debug_dir[$settings.debug_path]
$debug_order(0)


@debug[object;name][locals]
^if($settings.save_debug){
  ^switch[$object.CLASS_NAME]{
    ^case[hash]{ $object[^json:string[$object; $.indent(true) ]] }
    ^case[string]{}
    ^case[DEFAULT]{ ^throw[;dont know how to save debug $object.CLASS_NAME] }
    ^debug_order.inc(1)
  }
  ^object.save[$debug_dir/^debug_order.format[%02d]_$name]
}{
  ^file:delete[$debug_dir/$name; $.keep-empty-dirs(false) $.exception(false) ]
}
$result[]

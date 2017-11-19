# smali/baksmali 2.2

smali and baksmali now have a new CLI as of the 2.2 release

    baksmali disassemble app.apk -o app
    smali assemble app -o classes.dex

To get started, try `baksmali help` or `smali help`

A few things to note
* You can specify individual entries in an apk or oat file as if the apk or oat was a directory. e.g.
`baksmali disassemble app.apk/classes2.dex`. See `baksmali help input` for more information.
* The options for specifying a bootclasspath/classpath when deodexing have changed a bit. For deodexing oat files, it works something like this: `adb pull /system/framework framework && baksmali deodex app.odex -b framework/arm/boot.oat`
* baksmali now has a set of commands for listing various information from a dex/apk/oat file. e.g.
  * `baksmali list dex boot.oat` to list all the dex entries in an oat file (works with apks too)
  * `baksmali list classes app.apk` to list all classes in an apk/dex/etc.
  * `baksmali list methods app.apk | wc -l` to get a count of the number of methods currently used by the dex file
* v2.2 supports deodexing oat files from Nougat, and includes a number of bugfixes for Marshmallow as well
* There were a few breaking API changes in dexlib2, etc. So if you plan to upgrade your tool to dexlib2 v2.2, you can expect that you'll need to fix a few things.


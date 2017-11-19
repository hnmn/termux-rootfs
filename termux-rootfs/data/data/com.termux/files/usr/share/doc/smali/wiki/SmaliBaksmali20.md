# Introduction #

smali/baksmali 2.0 is the next major release of smali/baksmali, featuring a major overhaul of dexlib, the underlying library for interacting with dex files. It is currently in beta. If you want to try it out, you can grab the 2.0b1 jars from the download page.

What does this mean to you? Hopefully nothing, for the most part, except that it is faster and uses less memory.

However, below are a few things you should be aware of

## Multithreading ##

smali and baksmali are now multi-threaded! By default, they uses the number of cores that are available, up to a maximum of 6. You can override this using the -j option.

For optimal performance in smali with multi-threading, it's a good idea to bump up the memory a bit. If you're using the smali wrapper script, you can do this manually by adding the `-JXmx512m` option.

i.e.

```
smali -JXmx512m out -o classes.dex
```

There's also an [alternate wrapper script](https://smali.googlecode.com/files/smali-512m) that defaults to 512mb instead of the old 256mb.


## Language Changes ##

I took the opportunity of a major revision bump to tweak a few things in the language itself.


### .parameter -> .param ###

```
.method parameters(IILjava/lang/String;)V
    .parameter
    .parameter
    .parameter stringParameter
...
```

->

```
.method parameters(IILjava/lang/String;)V
    .param p3, "stringParameter"
...
```

The .parameter directive is now called .param, and it works similarly to the .local directive. Instead of matching up the .parameter info with each parameter sequentially, the .param directive takes a register argument to specify which parameter it is associated with

### .array-data changes ###

```
.array-data 0x4
    0x0t 0x0t 0x80t 0x0t
    0x0t 0x0t 0x40t 0x0t
    0x0t 0x0t 0x20t 0x0t
    0x0t 0x0t 0x10t 0x0t
.end array-data
```

->

```
.array-data 4
    0x800000
    0x400000
    0x200000
    0x100000
.end array-data
```

Each number in the .array-data is now it's own element, as opposed to the previous syntax where it would concatenate the little-endian encoding of each number, and then re-interpret the full concatenated byte-array as n-byte little-endian encoded elements.

### const/high16 and const-wide/high16 ###

```
const/high16 v0, 0x1234
const-wide/high16 v0, 0x1234
```
->
```
const/high16 v0, 0x12340000
const-wide/high16 v0, 0x1234000000000000
```

The syntax of the `*/high16` instructions was changed so that it uses the actual value that gets loaded into the register, rather than just the 16 bits that get stored in the instruction.

It's an error specify a non-zero value for any but the 16 top-most bits. i.e.
```
const/high16 v0, 0x12340001
```
would be an error.
# Introduction #

When deodexing, in some of the smali files that baksmali produces, you might notice some cases where baksmali replaces an odexed instruction with either a throw or something else, with a comment like "Replaced unresolvable optimized instruction with a throw".

# Details #

Take, for example, the following java code:

```
Object blah = null;
blah.toString();
```

The corresponding smali code would be:

```
const v0, 0
invoke-virtual {v0}, Ljava/lang/Object;->toString();
```

This will of course result in a null pointer exception - but it is valid code. In practice, these cases are a bit more disguised of course.

When the code is odexed, the invoke-virtual instruction would be replaced with an invoke-virtual-quick instruction, like so:

```
const v0, 0
invoke-virtual-quick {v0), vtable@7
```

Where vtable@7 is the index into Object's virtual method table where the toString method is.

But notice that there isn't any mention of what class the method is in. Since v0 is always null, and we only have a vtable index, it is impossible for baksmali to know what class to look at. So It's impossible to deodex this instruction. However, it can do the next best thing: it can replace the instruction with something that has the exact same effect. Keep in mind that v0 is always null, so any sort of method invocation on it would just end up in an NPE being thrown. So baksmali just replaces the unresolvable odex instruction with something else that will also throw an NPE.

Additionally, any code that comes after that (up until another code path branches in) is effectively dead code that can never be reached, and in some cases, if the code depended on the result of the method that we couldn't resolve, then that code is also impossible to deodex. Since it can never be reached, it is just removed (commented out).


So, in short, these cases **shouldn't** affect the semantics/functionality of the bytecode. When you see "replaced unresolvable optimized instruction", it's typically nothing to be concerned about. Baksmali handles it in a way that doesn't affect the functionality/semantics of the code. (And if it doesn't, it's a bug in baksmali).


Currently, there is a known issue related to this, where if all the code in a try block is commented out because it follows an unresolvable odex instruction, the (empty) try block is left in, and when installed onto a device, the empty try block will cause dalvik to reject the dex file.
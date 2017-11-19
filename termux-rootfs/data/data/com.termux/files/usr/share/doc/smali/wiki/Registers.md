# Introduction #

In dalvik's bytecode, registers are always 32 bits, and can hold any type of value. 2 registers are used to hold 64 bit types (Long and Double).

# Specifying the number of registers in a method #

There are two ways to specify how many registers are available in a method. the .registers directive specifies the **total** number of registers in the method, while the alternate .locals directive specifies the number of **non-parameter** registers in the method. The total number of registers would therefore include the registers needed to hold the method parameters.

# How method parameters are passed into a method #

When a method is invoked, the parameters to the method are placed into the last n registers. If a method has 2 arguments, and 5 registers (v0-v4), the arguments would be placed into the last 2 registers - v3 and v4.

The first parameter to a non-static methods is always the object that the method is being invoked on.

For example, let's say you are writing a non-static method `LMyObject;->callMe(II)V`. This method has 2 integer parameters, but it also has an implicit LMyObject; parameter before both integer parameters, so there are a total of 3 arguments to the method.

Let's say you specify that there are 5 registers in the method (`v0`-`v4`), with either the `.registers 5` directive or the `.locals 2` directive (i.e. 2 _local_ registers + 3 parameter registers). When the method is invoked, the object that the method is being invoked on (i.e. the `this` reference) will be in `v2`, the first integer parameter will be in `v3`, and the second integer parameter will be in `v4`.

For static methods it's the same thing, except there isn't an implicit `this` argument.

# Register names #

There are two naming schemes for registers - the normal _v_ naming scheme and the _p_ naming scheme for parameter registers. The first register in the _p_ naming scheme is the first parameter register in the method. So let's go back to the previous example of a method with 3 arguments and 5 total registers. The following table shows the normal _v_ name for each register, followed by the _p_ name for the parameter registers

| Local | Param | |
|:---|:---|:-------------------------|
| v0 | | the first local register |
| v1 |  | the second local register |
| v2 | p0 | the first parameter register |
| v3 | p1 | the second parameter register |
| v4 | p2 | the third parameter register |

You can reference parameter registers by either name - it makes no difference.

# Motivation for introducing parameter registers #

The _p_ naming scheme was introduced as a practical matter, to solve a common annoyance when editing smali code.

Say you have an existing method with a number of parameters and you are adding some code to the method, and you discover that you need an extra register. You think "No big deal, I'll just increase the number of registers specified in the .registers directive!".

Unfortunately, it isn't quite that easy. Keep in mind that the method parameters are stored in the **last** registers in the method. If you increase the number of registers - you change which registers the method arguments get put into. So you would have to change the .registers directive **and** renumber every parameter register.

But if the _p_ naming scheme was used to reference parameter registers throughout the method, you can easily change the number of registers in the method, without having to worry about renumbering any existing registers.

Note: by default baksmali will use the _p_ naming scheme for parameter registers. If you want to disable this for some reason and force baksmali to always use the _v_ naming scheme, you can use the -p/--no-parameter-registers option.

# Long/Double values #

As mentioned previously, long and double primitives (J and D respectively) are 64 bit values, and require 2 registers. This is important to keep in mind when you are referencing method arguments. For example, let's say you have a (non-static) method  LMyObject;->MyMethod(IJZ)V. The parameters to the method are LMyObject;, int, long, bool. So this method would require 5 registers for all of its parameters.

| Register | Type |
|:---------|:-----|
| p0       | this |
| p1       | I    |
| p2, p3   | J    |
| p4       | Z    |

Also, when you are invoking the method later on, you do have to specify both registers for any double-wide arguments in the register list for the invoke-**instruction.**

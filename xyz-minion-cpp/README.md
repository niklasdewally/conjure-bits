This repository contains an example on how to encode a simple constraints model
using Minion in C++.

The problem is the following:

```
MINION 3
**VARIABLES**
DISCRETE x #
{1..3}
DISCRETE y #
{1..3}
DISCRETE z #
{1..3}
**SEARCH**
PRINT[[x],[y],[z]]
VARORDER STATIC [x, y, z]
**CONSTRAINTS**
sumleq([x,y],z)
sumgeq([x,y],z)
**EOF**
```


<!-- vim: tw=80, cc=80
-->

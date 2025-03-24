Prepares Essence Prime files for Conjure Oxide by:

1. Normalise syntax with `savilerow -dump-model`, allowing Conjure /
   Conjure-Oxide's parser to read it.

2. Rename variables with the same name as Essence keywords: e.g. `total`,
  `range`.

3. Substitute givens for their lettings, as given in .param files.

## Requirements

* Conjure
* GNU Sed / `gsed` (sorry MacOS users)
* `make`
* A Savile Row version with the `-dump-model` flag. At time of writing, this is
  only on a private branch, but may become publicly available in the future...

## Usage

1. Put `.eprime` and `.param` files in `input/`.
2. Run `make`

## Directory Layout

```
input/            -- place input models and params files here.
output/normalized -- step 1 : cleaned eprime models.
output/fixed      -- step 2 : models without Essence keywords, ready for Conjure.
output/nogivens   -- step 3 : fixed models but with the givens substituted in.
Makefile          -- does all this: type make to g
scripts/          -- scripts to make all this work
```




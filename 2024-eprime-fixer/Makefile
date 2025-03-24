

RENAME_KEYWORDS := scripts/rename_conjure_keywords.sh

INPUTS := $(shell find input -iname '*.eprime')
NORMALISED := $(INPUTS:input/%.eprime=output/normalised/%.eprime)
FIXED := $(INPUTS:input/%.eprime=output/fixed/%.eprime)

## The entry-point

.PHONY: all 
all: $(NORMALISED) $(FIXED)

## Rules

# step 1: normalise syntax using sr
output/normalised/%.eprime: input/%.eprime | output/normalised
	mkdir -p $$(dirname "$@")
	savilerow -dump-model $< > $@

# step 2: remove conjure keywords
output/fixed/%.eprime: output/normalised/%.eprime | output/fixed 
	mkdir -p $$(dirname "$@")
	$(RENAME_KEYWORDS) $< > $@


## Folders

input: 
	mkdir input

output/fixed: 
	mkdir -p output/fixed

output/normalised: 
	mkdir -p output/normalised
	
output/nogivens: 
	mkdir -p output/nogivens


## Phonies

.PHONY: debug
debug: 	
	@$(info    INPUTS is $(INPUTS))
	@$(info    FIXED is $(FIXED))
	@$(info    NORMALISED is $(NORMALISED))

.PHONY: clean
clean: 
	rm -rf output

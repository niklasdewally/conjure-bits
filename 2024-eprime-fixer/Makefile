

RENAME_KEYWORDS := scripts/rename_conjure_keywords.sh


INPUTS := $(shell find input -iname '*.eprime')
NORMALISED := $(INPUTS:input/%.eprime=output/01-normalised/%.eprime)
FIXED := $(INPUTS:input/%.eprime=output/02-no-keywords/%.eprime)

## The entry-point

.PHONY: all 
all: $(NORMALISED) $(FIXED)

## Rules

# step 1: normalise syntax using sr
output/01-normalised/%.eprime: input/%.eprime 
	mkdir -p $$(dirname "$@")
	savilerow -dump-model $< > $@

# step 2: remove conjure keywords
output/02-no-keywords/%.eprime: output/01-normalised/%.eprime $(RENAME_KEYWORDS) 
	mkdir -p $$(dirname "$@")
	$(RENAME_KEYWORDS) $< > $@

## Folders


## Phonies

.PHONY: debug
debug: 	
	@$(info    INPUTS is $(INPUTS))
	@$(info    FIXED is $(FIXED))
	@$(info    NORMALISED is $(NORMALISED))

.PHONY: clean
clean: 
	rm -rf output

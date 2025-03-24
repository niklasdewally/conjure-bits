
RENAME_KEYWORDS := scripts/rename_conjure_keywords.sh
SUBSTITUTE_PARAMS:= scripts/substituteparams.sh


INPUTS := $(shell find input -iname '*.eprime')
INPUT_PARAMS := $(shell find input -iname '*.param')

NORMALISED := $(INPUTS:input/%.eprime=output/01-normalised/%.eprime)
NORMALISED_PARAMS := $(INPUT_PARAMS:input/%.param=output/01-normalised/%.param)

NO_KEYWORDS := $(INPUTS:input/%.eprime=output/02-no-keywords/%.eprime)
NO_KEYWORDS_PARAMS := $(INPUT_PARAMS:input/%.param=output/02-no-keywords/%.param)

## The entry-point

.PHONY: all 
all: $(NORMALISED) $(NORMALISED_PARAMS) $(NO_KEYWORDS) $(NO_KEYWORDS_PARAMS) output/03-no-givens/.timestamp

## Rules

# step 1: normalise syntax using sr
output/01-normalised/%.eprime: input/%.eprime 
	mkdir -p $$(dirname "$@")
	savilerow -dump-model $< > $@

# pass params straight through
output/01-normalised/%.param: input/%.param
	mkdir -p $$(dirname "$@")
	cat "$<" > "$@"

# step 2: remove conjure keywords
output/02-no-keywords/%.eprime: output/01-normalised/%.eprime $(RENAME_KEYWORDS) 
	mkdir -p $$(dirname "$@")
	$(RENAME_KEYWORDS) $< > $@


# rename params too
output/02-no-keywords/%.param: output/01-normalised/%.param $(RENAME_KEYWORDS) 
	mkdir -p $$(dirname "$@")
	$(RENAME_KEYWORDS) $< > $@

# step 3 : substitute params 
#
# cant match up givens files and models in the makefile unfortunately, so this
# just calls a script that does them all in one go.
output/03-no-givens/.timestamp: $(NO_KEYWORDS)  $(NO_KEYWORDS_PARAMS) $(SUBSTITUTE_PARAMS)
	mkdir -p output/03-no-givens
	$(SUBSTITUTE_PARAMS)
	touch $@
	

## Folders


## Phonies

.PHONY: debug
debug: 	
	@$(info    INPUTS is $(INPUTS))
	@$(info    NO_KEYWORDS is $(NO_KEYWORDS))
	@$(info    NORMALISED is $(NORMALISED))

.PHONY: clean
clean: 
	rm -rf output

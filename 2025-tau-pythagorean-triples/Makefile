MODELS = $(shell find models/ -iname '*.eprime')
NS = 025 050 075 100 125 150 

$(foreach N,$(NS),$(eval OUTPUT_MODELS+=$(patsubst models/%.eprime,models_with_params/$(N)_%.eprime,$(MODELS))))

define modelrule
models_with_params/$(1)_%.eprime: models/%.eprime | models_with_params
	sed 's/given n.*/letting n be $(1)/g' < $$< > $$@
endef

$(foreach N,$(NS),$(eval $(call modelrule,$(N))))

.PHONY: all
all: $(OUTPUT_MODELS)


models_with_params: 
	mkdir -p models_with_params


.PHONY: data
data:
	mkdir -p data

.PHONY: clean
clean: 
	rm -rf models_with_params

.PHONY: debug
debug:
	$(foreach N,$(NS),$(info $(call modelrule,$(N))))

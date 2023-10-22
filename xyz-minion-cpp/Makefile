
# CHANGE ME TO YOUR MINION INSTALL
# This requires a folder in minion source called bin, which has been configured
# using ../configure.py --lib or ../configure.py --lib --debug
PATH_TO_MINION =../../minion

LIBMINION = $(PATH_TO_MINION)/bin/libminion.a
BUILD_SRC=$(PATH_TO_MINION)/bin/src
SRC=$(PATH_TO_MINION)/minion/
MAKE_FLAGS =$(PATH_TO_MINION)/bin/Makeflags.mak

include $(MAKE_FLAGS)


xyz: xyz.cpp $(PATH_TO_MINION)/bin/libminion.a
	g++ $(FLAGS) xyz.cpp $(LIBMINION) -o xyz -I$(BUILD_SRC) -I$(SRC)

.PHONY: $(LIBMINION)
$(LIBMINION):
	cd $(PATH_TO_MINION)/bin; $(MAKE)

.PHONY: clean
clean:
	rm xyz

.PHONY: DEPS

CC = g++
LD := $(CC)

SRCFOLDER = ./src/
OUTFOLDER = ./out/
OUT = sesame
OBJS = $(patsubst $(SRCFOLDER)%.cpp,$(OUTFOLDER)%.o,$(wildcard $(SRCFOLDER)*.cpp))

# todo: copy these from `where`
DEPS = SDL2.dll libgcc_s_seh-1.dll libwinpthread-1.dll libstdc++-6.dll
# also available directly from msys2
# https://packages.msys2.org/package/mingw-w64-x86_64-SDL2
# https://packages.msys2.org/package/mingw-w64-x86_64-gcc-libs
# https://packages.msys2.org/package/mingw-w64-x86_64-libwinpthread


CFLAGS = $(shell sdl2-config --cflags)
LDFLAGS = $(shell sdl2-config --libs)

all: $(OUT)

msys: OUT := $(OUT).exe
msys: CFLAGS = $(shell pkg-config SDL2 --cflags)
msys: LDFLAGS = $(shell pkg-config SDL2 --libs) -mconsole
msys: $(OUT)
#$(DEPS)

$(DEPS): %.dll:
	cp $(shell where $@) $(OUTFOLDER)$@

$(OBJS): $(OUTFOLDER)%.o: $(SRCFOLDER)%.cpp
	@printf "\e[33mCompiling \"$@\" from \"$^\"\e[0m\n"
	$(CC) -c $^ -o $@ $(CFLAGS)
	@printf "\e[32mDone\e[0m\n"

$(OUT): $(OBJS)
	@printf "\e[33mLinking \"$@\" from \"$^\"\e[0m\n"
	$(LD) $^ -o $(OUTFOLDER)$@ $(LDFLAGS)
	@printf "\e[32mDone\e[0m\n"
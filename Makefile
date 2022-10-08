CC = g++
LD := $(CC)

SRCFOLDER = ./src/
OUTFOLDER = ./out/

OUT = sesame
OBJS = $(patsubst $(SRCFOLDER)%.cpp,$(OUTFOLDER)%.o,$(wildcard $(SRCFOLDER)*.cpp))

CFLAGS = $(shell sdl2-config --cflags)
LDFLAGS = $(shell sdl2-config --libs)

all: $(OUT)

msys: OUT := $(OUT).exe
msys: CFLAGS := -lmingw32 $(CFLAGS)
msys: $(OUT)

$(OBJS): $(OUTFOLDER)%.o: $(SRCFOLDER)%.cpp
	@printf "\e[33mCompiling \"$@\" from \"$^\"\e[0m\n"
	$(CC) -c $^ -o $@ $(CFLAGS)
	@printf "\e[32mDone\e[0m\n"

$(OUT): $(OBJS)
	@printf "\e[33mLinking \"$@\" from \"$^\"\e[0m\n"
	$(LD) $^ -o $(OUTFOLDER)$@ $(LDFLAGS)
	@printf "\e[32mDone\e[0m\n"
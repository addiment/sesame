CC = g++
SRC = main.cpp
OUT = sesame
CFLAGS = $(shell sdl2-config --cflags --libs)

default: $(OUT)

msys: OUT := $(OUT).exe
msys: CFLAGS := -lmingw32 $(CFLAGS)
msys: $(OUT)

$(OUT): $(SRC)
	$(CC) $(SRC) -o $(OUT) $(CFLAGS)
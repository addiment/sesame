#include <iostream>
#include <random>
#include <SDL2/SDL.h>

using namespace std;

// semvar my beloved
#define SESAME_VERSION_MAJOR 1
#define SESAME_VERSION_MINOR 0
#define SESAME_VERSION_PATCH 0

#define VERY_STRONG_PASSWD_LENGTH 16
#define STRONG_PASSWD_LENGTH 8
#define WEAK_PASSWD_LENGTH 4

/*

TODO:

    [] change length of password with argument
    [] disable types of characters with argument
    [] allow output to a file or stdout
    [] print a confirmation message

*/

const char* charset = "0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz!#$%&*+-/?@_";
size_t charsetlen = 74;

int passwdLength = VERY_STRONG_PASSWD_LENGTH;

int main(int argc, char* argv[]) {
    printf("sesame \x1b[36m%u\x1b[0m.\x1b[36m%u\x1b[0m.\x1b[36m%u\x1b[0m\n", SESAME_VERSION_MAJOR, SESAME_VERSION_MINOR, SESAME_VERSION_PATCH);
    if (SDL_Init(SDL_INIT_VIDEO) < 0) {
        printf("\x1b[31mFailed to initialize SDL2:\x1b[0m %s\n", SDL_GetError());
        return 1;
    }

    random_device rd;

    char* passwd = new char[passwdLength + 1]();
    passwd[passwdLength] = 0x00;

    for (int i = 0; i < passwdLength; i++) {
        passwd[i] = charset[rd() % 74];
    }

    if (SDL_SetClipboardText(passwd) < 0) {
        printf("\x1b[31mFailed to add text to clipboard:\x1b[0m %s\n", SDL_GetError());
        return 1;
    }

    printf("\x1b[32mPassword copied to clipboard!\x1b[0m\n");

    SDL_Quit();
    return 0;
}
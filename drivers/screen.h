#ifndef SCREEN_H
#define SCREEN_H

#define VGA_MEM_LOC 0xB8000
#define VGA_WIDTH 80
#define VGA_HEIGHT 25

enum {
    VGA_COLOR_BLACK,
    VGA_COLOR_BLUE,
    VGA_COLOR_GREEN,
    VGA_COLOR_CYAN,
    VGA_COLOR_RED,
    VGA_COLOR_MAGENTA,
    VGA_COLOR_BROWN,
    VGA_COLOR_LIGHTGREY,
    VGA_COLOR_DARKGREY,
    VGA_COLOR_LIGHTBLUE,
    VGA_COLOR_LIGHTGREEN,
    VGA_COLOR_LIGHTCYAN,
    VGA_COLOR_LIGHTRED,
    VGA_COLOR_LIGHTMAGENTA,
    VGA_COLOR_LIGHTBROWN,
    VGA_COLOR_WHITE
} VGA_COLORS;


void move_csr(void);

void clear_screen(void);

void putc(unsigned char c);

void puts(unsigned char *str);

extern unsigned short *screen;
extern unsigned char attrib;
extern unsigned short csr_x, csr_y;

#endif

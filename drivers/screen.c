#include "screen.h"
#include "ioports.h"
#include "../libc/string.h"

unsigned short *screen;
unsigned short csr_x, csr_y;
unsigned char attrib = VGA_COLOR_WHITE;

void move_csr(void)
{
	unsigned temp = csr_y * 80 + csr_x;

	outportb(0x3d4, 14);
	outportb(0x3d5, temp >> 8);
	outportb(0x3d4, 15);
	outportb(0x3d5, temp);
}

void clear_screen(void)
{
	for(short i = 0; i < VGA_WIDTH; i++)
		for(short j = 0; j < VGA_HEIGHT; j++)
			*screen++ = ' ' | (attrib << 8);

	screen = (unsigned short *) VGA_MEM_LOC;

	csr_x = csr_y = 0;
	move_csr();
}

void putc(unsigned char c)
{
	unsigned short *pos;

	if(c == '\n') {
		csr_x = 0;
		csr_y++;
	} else {
		pos = screen + (csr_y * 80 + csr_x);
		*pos = c | (attrib << 8);	
		csr_x++;
	}

	if(csr_x >= VGA_WIDTH) {
		csr_x = 0;
		csr_y++;
	}

	move_csr();
}

void puts(unsigned char *str)
{
	for(int i = 0; i < strlen(str); i++)
		putc(str[i]);
}


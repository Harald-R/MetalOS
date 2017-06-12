#ifndef IOPORTS
#define IOPORTS

unsigned char inportb(unsigned short port);

unsigned short inportw(unsigned short port);

void outportb(unsigned short port, unsigned char data);

void outportw(unsigned short port, unsigned short data);

#endif

# Automatically generate lists of sources using wildcards
C_SOURCES = $(wildcard kernel/*.c drivers/*.c libc/*.c)
HEADERS = $(wildcard kernel/*.h drivers/*.h libc/*.h)

# Convers the *.c filenames to *.o to give a list of object files to build
OBJ = ${C_SOURCES:.c=.o}

all: os-image

# This is the actual disk image that the computer loads,
# which is the combination of our compiled bootsector and kernel
os-image: boot/boot_sect.bin boot/kernel.bin
	cat $^ > os-image
	truncate -s 10240 os-image

# This builds the binary of our kernel from two object files :
# - the kernel_entry , which jumps to main () in our kernel
# - the compiled C kernel
boot/kernel.bin: boot/kernel_entry.o ${OBJ}
	ld -o $@ -Ttext 0x7e00 $^ -m elf_i386 --oformat binary

# Generic rule for compiling C code to an object file
# For simplicity, C files depend on all header files
%.o : %.c ${HEADERS}
	gcc -ffreestanding -m32 -c $< -o $@

# Assemble the kernel_entry
%.o : %.asm
	nasm $< -f elf -o $@

%.bin : %.asm
	nasm $< -f bin -o $@ -i boot/ -i boot/includes/

# Run the kernel
run: os-image
	qemu-system-i386 os-image

# Remove the generated files
clean:
	rm -rf *.bin *.o os-image
	rm -rf kernel/*.o boot/*.o boot/*.bin drivers/*.o libc/*.o

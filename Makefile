all: calc

calc: calc.o
	ld -m elf_i386 -o calc calc.o

calc.o: calc.asm
	nasm -f elf -l calc.lst calc.asm

clean:
	rm -rf calc.lst calc.o calc

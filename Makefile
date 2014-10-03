all: ascalc

ascalc: ascalc.o
	ld -m elf_i386 -o ascalc ascalc.o

ascalc.o: ascalc.asm
	nasm -f elf -l ascalc.lst ascalc.asm

clean:
	rm -rf ascalc.lst ascalc.o ascalc

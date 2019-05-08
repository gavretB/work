AS = arm-none-eabi-as
LD = arm-none-eabi-ld
CP = arm-none-eabi-objcopy

%.o: %.s
	$(AS) $<  -o $@

.PHONY: clean

main.img: main.o op_bgm.o op_text.o bgm.o bgm_text.o clear.o gameover_bgm.o gameover.o ending.o ending_text.o
	$(LD) -m armelf -no-undefined $^ -o main.elf
	$(CP) main.elf -O binary main.img

clean:
	rm -f *.o *.elf *.img *~ a.out

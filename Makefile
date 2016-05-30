
INTERFACE_HEX = Thyme-Interface.hex


# do not jump to bootloader at startup
LFUSE = FF
HFUSE = D9
EFUSE = 05

MCU = 328p
PROGRAMMER = avrisp2
FLAGS_AVRDUDE = -Pusb
AVRDUDE = avrdude


FLAGS_AVRDUDE += -c $(PROGRAMMER)

ifeq ($(PROGRAMMER),arduino)
	FLAGS_AVRDUDE += -p m328p
else
	FLAGS_AVRDUDE += -p m$(MCU)
endif


flash-interface: $(INTERFACE_HEX)
	@echo " "
	@echo "Flashing"
	@echo "--------"
	$(AVRDUDE) $(FLAGS_AVRDUDE) -B1 \
							 	-U flash:w:$(INTERFACE_HEX):i	
	
fuses-interface: 
	$(AVRDUDE) $(FLAGS_AVRDUDE) -B100 \
								-U efuse:w:0x$(EFUSE):m \
								-U hfuse:w:0x$(HFUSE):m \
								-U lfuse:w:0x$(LFUSE):m \

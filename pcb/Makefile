all: fab

clean:
	rm -r fab

fab: hwexla.kicad_pcb hwexla.sch
	kikit fab jlcpcb --assembly --schematic hwexla.sch hwexla.kicad_pcb fab

.PHONY: all clean

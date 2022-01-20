all: fab

clean:
	rm -r fab

fab: hwexla.kicad_pcb hwexla.kicad_sch
	kikit fab jlcpcb --assembly --no-drc --schematic hwexla.kicad_sch hwexla.kicad_pcb fab

.PHONY: all clean

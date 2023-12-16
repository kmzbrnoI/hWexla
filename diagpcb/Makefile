all: fab

clean:
	rm -r fab

fab: hwexladiag.kicad_pcb
	kikit fab jlcpcb --no-drc hwexladiag.kicad_pcb fab

.PHONY: all clean

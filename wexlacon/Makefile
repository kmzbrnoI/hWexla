all: fab

clean:
	rm -r fab

fab: wexlacon.kicad_pcb
	kikit fab jlcpcb --no-drc wexlacon.kicad_pcb fab

.PHONY: all clean

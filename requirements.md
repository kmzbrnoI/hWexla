Požadavky na přestavník hWexla
==============================

## Vstupy/výstupy

1. Přestavník má
 * 2 vstupy na nastavení polohy (z MTB),
 * 2 vstupy/výstupy do pultu/testovací krabičky,
 * 2 výstupy indikující polohu (do MTB).
2. Vstupy z MTB mají vždy přednost nad vstupy z přestavníku.
3. Všechny vstupy jsou chráněny proti přepětí.
4. Všechny výstupy jsou formou otevřeného kolektoru do maximálního externího
   napětí 30 V. Výstupy jsou chráněny proti přepětí.

## Hardware

1. Přestavník je chráněn proti přepětí. Připojení přepětí ho nepoškodí.
   Ochrana proti přepětí je samovratná.
2. Přestavník je chráněn proti opačné polaritě napájení. Připojení opačného
   napájení ho nepoškodí. Ochrana proti opačnému napájení je samovratná.
3. Přestavník je chráněn proti poruše serva. Při zkratu na servu dojde
   k přepálení nevratné pojistky.
4. Výstup stabilizovaných 5 V ven z desky je chráněn pojistkou.
5. Testovací a digitální vstupy a výstupy jsou chráněny proti krátkým napěťovým
   špičkám.
6. Stabilizace napájení pro servo je řešená pomocí externího modulu. Očekávaný
   je pulzní stepdown. Vyčlenění stabilizace z hlavní DPS umožňuje její snadné
   nahrazení například v případě nedostupných součástek.
7. Garantovaný proud přes relé je 3 A.

## Software

1. Relé se připíná uprostřed chodu přestavníku.
2. V případě nefunkčnosti serva (např. odpojení), je při manuálním dojetí
   do polohy správně ovládáno relé.
3. Koncová poloha je indikována na základě hodnot z magnetického senzoru.
   Hodnoty ze senzoru jinak nemají na funkci přestavníku žádný další vliv.
4. Přestavník kontroluje napájení serva.
5. Přestavník indikuje svůj stav pomocí LED.
6. Z přestavníku je možné číst diagnostická data pomocí USART rozhraní.
7. Pomocí testovací krabičky je možné nastavit obě koncové polohy.
8. Při startu přestavník zapne napájení serva až po pseudo-náhodné době, aby
   se rozložila proudová zátěž při zapínání kolejiště s mnoha přestavníky.

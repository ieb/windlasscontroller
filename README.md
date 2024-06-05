# Windlass Remote Control

I have found that wire windlass switches fail at when installed at the bow due to water ingress into the switches as do sockets. So 7 years ago I used a simple 433Mhz garage door controller as a remote windlass controller. However the remote controls are not easy to use being too small, and the range is typically less than 10m which is shorter than the boat making the controller unreliable.

This project uses a JDY-40 module (typical cost < $1) which can be configured as a remote 8 channel switch. It has a claimed range of 120m, tested at 60m and uses 2.4GHz. It sleeps automatically drawing 5uA when sleeping and requires almost no external components in the controller. The base uses a second JDY-40 module with opto couplers and a G1 transistor driving a relay.  Remote is powered by a CR123A 3V lithium battery which should last several years even if left on sleeping. There is an on-off switch. No custom code, but the modules have to be programmed as transmitter and base with the same RF IDs. Code to do this is in setup. 

There are 2 schematics, one for base and one for the controller, and designs for the case and base cases. 

The PCBs are in KiCad, and were milled using pcb2gcode double sided with alignment, see createGCode.sh for the setup. Everything else is very standard.


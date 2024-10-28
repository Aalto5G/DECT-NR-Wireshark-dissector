# DECT-NR-Wireshark-dissector
Dissectror of DECR-NR MAC packages for Wireshark 


## Getting started 
The following example is tested with Ubuntu 22.04.

For using the code copy the src directory into the 
~/.local/share/Wireshark/plugins/ directory

Start Wireshark.

For the demo open in wireshark file ./ExamplePcapng/wireshark_dect_rn_demo.pcapng.
The file contains captured DECT packages.

The example screeshot is int the file ./ExamplePcapng/ExampleScreeshot.png

![Alt text](./ExamplePcapng/ExampleScreenshot.png?raw=true "Example screeshot")

## Usage
The dissector assumes that the DECT-NR packages are send into UDP port 8091. 
The packets from the radio interface are received, inserted into UDP paket and send into UDP port 8091. 
(For receiving the packets we used a dummy UDP server that could receive in that port).

The wireshart captures UDP messages and interprets the content. 
  



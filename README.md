# Leggiero: Analog WiFi Backscatter with Payload Transparency

Author: NaXin

Contact: nx20@mails.tsinghua.edu.cn, heyuan@tsinghua.edu.cn

Description: This repository contains the hardware schematic, PCB gerber file, and FPGA code for our MobiSys'23 paper "Leggiero: Analog WiFi Backscatter with Payload Transparency". It enables analog backscattering on commercial Wi-Fi 802.11n signals. The backscatter device converts the analog sensor voltage to the RF signal phase and embeds this information in the channel state information in a 802.11n packet, allowing for payload transparency.

Content: You will find the schematic PDF file, gerber file for the prototype PCB, and the FPGA code for the control logic in this repository. The Wi-Fi transmitter and receiver were built with commercial QCA9300 NIC and PicoScenes (ps.zpj.io). Please note that the prototype PCB may not be perfect, and could welcome additional simulation and tuning. If you have any questions, please feel free to contact us.

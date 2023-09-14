# LED Light ON/OFF and Switch ON/OFF

## Academic Integrity Statement

Please note that all work included in this project is the original work of the author, and any external sources or references have been properly cited and credited. It is strictly prohibited to copy, reproduce, or use any part of this work without permission from the author.

If you choose to use any part of this work as a reference or resource, you are responsible for ensuring that you do not plagiarize or violate any academic integrity policies or guidelines. The author of this work cannot be held liable for any legal or academic consequences resulting from the misuse or misappropriation of this work.

Any unauthorized copying or use of this work may result in serious consequences, including but not limited to academic penalties, legal action, and damage to personal and professional reputation. Therefore, please use this work only as a reference and always ensure that you properly cite and attribute any sources or references used.

---

## LED Light ON/OFF and Switch ON/OFF

### Overview

This repository contains the source code for a program designed to control LED lights on a Codewarrior HSC12 board. The program's objective is to blink LED 1 at specific intervals and control LED 3 based on the state of Switch 1. 


### Program Functionality

The program's main functionality is as follows:

- LED 1 blinks every 1 second.
- When Switch 1 is NOT pressed:
  - LED 1 is ON for 0.2 seconds and OFF for 0.8 seconds.
- When Switch 1 IS pressed:
  - LED 1 is ON for 0.8 seconds and OFF for 0.2 seconds.

Please note that this program is designed for the CSM-12C128 board, and it was developed and simulated using CodeWarrior 5.2.

### Hardware Setup

Ensure that you have the Codewarrior HSC12 board and the necessary connections in place:

- Switch 1 is connected to PORTB bit 0.
- LED 1 is connected to PORTB bit 4.
- LED 2 is connected to PORTB bit 5.
- LED 3 is connected to PORTB bit 6.
- LED 4 is connected to PORTB bit 7.

### Software Setup

To run this program on your Codewarrior HSC12 board using CodeWarrior software, follow these steps:

1. Open CodeWarrior IDE on your computer.

2. Create a new project or open an existing one, depending on your setup.

3. Import the source code from this repository into your project.

4. Ensure that you have the correct target and configuration settings for your Codewarrior HSC12 board.

5. Build the project to generate the binary file.

### Running the Program

Now that you have the program loaded onto your Codewarrior HSC12 board, follow these steps to run it:

1. Connect your Codewarrior HSC12 board to your computer.

2. Power on the board.

3. Download the binary file generated in the previous step to your board.

4. Observe the behavior of the LEDs:

   - LED 1 will blink according to the specified pattern.
   - LED 3 will be ON continuously.
   - The state of Switch 1 will determine the LED 1 blink duration, as mentioned in the program's functionality section.

### Notes

- Make sure to set Switch 1 @ PORTB bit 0 as an OUTPUT for simulation purposes only when running in the CodeWarrior IDE. If running on the actual board, PORTB bit 0 should be an INPUT.

- This program is designed for the Axion Manufacturing's CSM-12C128 board running at 24MHz. Adjustments may be required for different hardware configurations.

---


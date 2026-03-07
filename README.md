# RISC-V-Caesar-Cipher-in-Assembly

## Overview
A lightweight Caesar Cipher encryption program written entirely in **RISC-V 32-bit Assembly**. This project takes user input from the console, encrypts the text using a shift-by-3 algorithm, and prints the result. It demonstrates low-level memory manipulation, ASCII character processing, and assembly branching logic.

## Features
* **Case-Sensitive Encryption:** Accurately shifts both uppercase (`A-Z`) and lowercase (`a-z`) letters.
* **Smart Wrap-around:** Seamlessly handles boundary cases (e.g., `X` -> `A`, `z` -> `c`).
* **Non-letter Bypassing:** Automatically ignores numbers, spaces, and punctuation, leaving them perfectly intact.

# VHDL
This is an individual school project where I had to describe how the AES (Advanced Encryption Standard) works to cifer a secret message.

The LIB/ directory contains all of the libraries needed.
The SRC/ directory contains the BENCH/ directory where I put all of my testbenches to check every function that I wrote in the RTL/ directory, available in the SRC/ directory too. The THIRD_PARTY/ directory contains the Key Expansion file that we didn't have to code (it was given by the teacher), which splits the original key into 9 keys that will be used in every round to cifer the message.

The "init_vhdl.txt" and "compile_src.txt" are txt files that contain all of the command lines to initialize and compile every file; I have created it to only run those two files every time instead of running many commands.
The "modelsim.ini" executable is the simulation tool we used to display our testbench results.

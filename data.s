MOV R0,  X ; this means, take the absolute number 7 and store it in R0
LDR R1, [R0];this means, take the absolute number 2 and store it in R1
MOV R2,  Y;
STR R1, [R2];
HALT ;
X:
.word 0xABCD;
Y:
.word 0x0000;
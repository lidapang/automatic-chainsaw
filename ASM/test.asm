NOP
MOV BX,(1)
MOV DX,(1)
MOV AX,(1)
MOV CX,(11)
.startadd
ADD AX,DX
MOV DX,AX
OUT
PUSH DX
PUSH AX
MOV DX,CX
MOV AX,(1)
SUB AX,DX
MOV CX,AX
POP AX
POP DX
JNZ .startadd
.toinfinity
NOP
JMP .toinfinity
# C--

*maintainer: [@winek](https://github.com/winek)*

Compiler for a (not in a strict sense) subset of C.

## syntactics

```c
fastcall int fn(int a, int *x) {
    other(a);
    return(0);
}

void f() { /* empty param list -> no arguments! */
    return();
}

fn(arg1, arg2);


int pi100 = 314;
int esc = 033;
char nul = 0x0;

/* multi
   line
   comments */

/* variable declaration */
int x = 0;
char msg[12] = { "Hello World" }; /* size is required */

/* conditionals */
if (expression){
    do stuff;
}else{
    do other stuff;
}
/* loops */
while (expression){
    statement;
}
```

## semantics

- `char` has 8 bits
- `int` has 16 bits

## functions calls

|type|example|arguments|limitations|speed|
|---|---|---|---|---|
|fastcall|```fastcall void function()```|arguments are put into registers AX,BX,CX,DX|max 4 16bits arguments, result passed in AX|is faster than stdcall, but not always avaliable|
|stdcall|```stdcall void function()```|arguments and result are put into stack|can be used always|takes more clock instructions than fastcall, as all arguments have to be loaded into registrers then put to stack and then back to registers|

## prerequisites

- download and install Node.js, run `cmd.exe` or `terminal`
- navigate to `COMPILER`
- `npm install`

## usage

- `node compile.js [INPUT] [-Flags] [-o OUTPUT]`
- generates code in `ChainsawAssembly language`, to create binary use `CPUAssembler.exe`

## limitations, other cons

- operators usage: everything must be in parenthesis, because operator priority is not implemented, `x = (a + b);
- use of conditional statements without opening and closing `{ }` is not supported even when used only with one statement
- there is no type checking, `*` and `&` can work for both scalar and pointer types, so be careful
- for string concatenation use `.` operator
- modulus operator `%` works only for second argument = 2^n, where n is natural
- `0` == `false`, every other value is `true`

%{
#include <stdlib.h> 
#include <stdio.h>// Incluir la librería estándar para usar strtol
#include "lexer.tab.h" // Incluir el archivo de definiciones de tokens generado por Bison
%}
%%
"(" { return OP; }
")" { return CP; }
0x[a-f0-9]+ { yylval = strtol(yytext, NULL, 16); return NUMBER; } 
"+" { return ADD; }
"-" { return SUB; }
"*" { return MUL; }
"/" { return DIV; }
"|" { return ABS; }
[0-9]+ { yylval = atoi(yytext); return NUMBER; } 
\n { return EOL; }
[ \t] { /* ignore whitespace */ }
. { printf("Mystery character %c\n",*yytext); }
%%	

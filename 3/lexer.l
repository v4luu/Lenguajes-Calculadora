%{
#include "lexer.tab.h" 
#include <stdlib.h>
%}

%%
"(" { return OP; }
")" { return CP; }
"+" { return ADD; }
"-" { return SUB; }
"*" { return MUL; }
"/" { return DIV; }
"|" { return ABS; }
"&" { return AND; }  // Nuevo token para el operador AND
"|" { return OR; }   // Nuevo token para el operador OR binario
[0-9]+ { yylval = atoi(yytext); return NUMBER; }
\n { return EOL; }
[ \t] { /* ignore whitespace */ }
. { printf("Mystery character %c\n", *yytext); }
%%

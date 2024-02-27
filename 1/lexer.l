%option noyywrap
%x COMMENT_SINGLE
%x COMMENT_MULTI

%{
#include "lexer.tab.h" 
#include <stdlib.h>
%}
%{
char* commentStart;
%}
%%
"(" { return OP; }
")" { return CP; }
"+" { return ADD; }
"-" { return SUB; }
"*" { return MUL; }
"/" { return DIV; }
"|" { return ABS; }
[0-9]+ { yylval = atoi(yytext); return NUMBER; }
\n { return EOL; }
"//".* {  return COMMENT;}
[ \t] { /* ignore whitespace */ }
. { printf("Mystery character %c\n", *yytext); }
%%

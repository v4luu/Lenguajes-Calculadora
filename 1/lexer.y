%{
#include <stdio.h>
#include <stdlib.h>
int yylex(void);
int yyerror(char* s);
%}

/* declare tokens */
%token OP CP
%token NUMBER
%token ADD SUB MUL DIV ABS
%token EOL
%token COMMENT
%%

calclist: /* nothing: matches at beginning of input */ 
	| calclist exp EOL { printf("= %d\n", $2); } 
	| calclist EOL { /* Do nothing */ }
	| calclist COMMENT { /* Ignorar líneas de comentario */ }
;

exp: factor
	| exp ADD factor { $$ = $1 + $3; }
	| exp SUB factor { $$ = $1 - $3; }
;

factor: term
	| factor MUL term { $$ = $1 * $3; }
	| factor DIV term { $$ = $1 / $3; }
;

term: NUMBER
	| ABS term { $$ = ($2 >= 0) ? $2 : - $2; }
	| OP exp CP { $$ = $2; }
;



%%
int main(int argc, char **argv)
{
	yyparse();
}

int yyerror(char *s)
{
	fprintf(stderr, "error: %s\n", s);
}

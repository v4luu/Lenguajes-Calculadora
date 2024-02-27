all: lexer.l lexer.y
	bison -d lexer.y
	flex lexer.l
	cc -o $@ lexer.tab.c lex.yy.c -lfl	

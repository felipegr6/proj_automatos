%{
#include <stdio.h>
#include <stdlib.h>
void yyerror(char *);
%}

%token FIM_LINHA
%token NUM
%token ID
%token LS
%token PS
%token KILL
%token MKDIR
%token RMDIR
%token CD
%token TOUCH
%token IFCONFIG
%token START
%token QUIT
%start linha
%%
linha: FIM_LINHA {  }
		;
%%

#include "lex.yy.c"

int main(int argc, char **argv)
{
  return yyparse();
}

/* funcao usada pelo bison para dar mensagens de erro */
void yyerror(char *msg)
{
  fprintf(stderr, "Error: %s\n", msg);
}

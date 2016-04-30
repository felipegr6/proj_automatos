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
linha: expressao FIM_LINHA { printf("valor: %d\n", $1); }
		;
expressao: expressao '+' termo { $$ = $1 + $3; }
		| termo                { $$ = $1; }
		;
termo: NUM                 { $$ = $1; }
		;
%%
int main(int argc, char **argv)
{
    // return yyparse();
    return 1;
}
 
/* função usada pelo bison para dar mensagens de erro */
void yyerror(char *msg)
{
    fprintf(stderr, "Erro: %s\n", msg);
}

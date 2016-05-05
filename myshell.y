%{
#include <stdio.h>
#include <stdlib.h>
void yyerror(char *);
void foo();
%}

%token END_LINE
%token NUMBER
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
%token ERROR
%start command
%%
command:
            action END_LINE { printf(">> "); }
            | END_LINE { printf(">> "); }
            | ERROR { printf("Comando Desconhecido.\n"); }
            | command command
		    ;
action:
          exp
        | ops { printf("%d\n", $1); }
        ;
exp:
          LS { foo(); }
        | PS { foo(); }
        | KILL NUMBER { foo(); }
        | MKDIR ID { foo(); }
        | RMDIR ID { foo(); }
        | CD ID { foo(); }
        | TOUCH ID { foo(); }
        | IFCONFIG { foo(); }
        | START ID { foo(); }
        | QUIT { foo(); }
        ;
ops:
          ops '+' term { $$ = $1 + $3; }
        | ops '-' term { $$ = $1 - $3; }
        | ops '*' term { $$ = $1 * $3; }
        | ops '/' term { $$ = $1 / $3; }
        | term { $$ = $1; }
        ;
term:
          NUMBER { $$ = $1; }
        ;
%%

#include "lex.yy.c"

int main(int argc, char **argv)
{
    printf(">> ");
    return yyparse();
}

/* function to send error messages */
void yyerror(char *msg)
{
  fprintf(stderr, "Error: %s\n", msg);
}

void foo()
{

}

%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
void yyerror(char *);
void foo();
void ls();
void ps();
void ifconfig();
void touch(char *);
void quit();
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
        | ops
        ;
exp:
          LS { ls(); }
        | PS { ps(); }
        | IFCONFIG { ifconfig(); }
        | KILL NUMBER { foo(); }
        | TOUCH ID { touch($2); }
        | MKDIR ID { foo(); }
        | RMDIR ID { foo(); }
        | CD ID { foo(); }
        | START ID { foo(); }
        | QUIT { quit(); }
        ;
ops:
          ops '*' term { $$ = $1 * $3; }
        | ops '/' term { $$ = $1 / $3; }
        | ops '+' term { $$ = $1 + $3; }
        | ops '-' term { $$ = $1 - $3; }
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

void ls() {
    system("ls");
}

void ps() {
    system("ps");
}

void ifconfig() {
    system("ifconfig");
}

void touch(char *id) {
  system(strcat("touch ", id));
}

void quit() {
  exit(0);
}

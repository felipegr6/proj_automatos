%{
#include <stdio.h>
#include <stdlib.h>

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
%token PLUS MINUS MULTIPLY DIVIDE
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
%left PLUS MINUS
%left MULTIPLY DIVIDE

%start command
%%
command:
          action END_LINE { printf(">> "); }
        | END_LINE { printf(">> "); }
        | ERROR { printf("Comando Desconhecido.\n"); }
        | command command
		    ;
action:
          exp { printf("exp\n"); }
        | ops { printf("%d\n", $1); }
        ;
exp:
          LS { ls(); }
        | PS { ps(); }
        | IFCONFIG { ifconfig(); }
        | QUIT { quit(); }
        | TOUCH ID { touch($2); }
        | KILL NUMBER { foo(); }
        | MKDIR ID { foo(); }
        | RMDIR ID { foo(); }
        | CD ID { foo(); }
        | START ID { foo(); }
        ;
ops:
          NUMBER { $$ = $1; }
        | ops PLUS ops { $$ = $1 + $3; }
        | ops MINUS ops { $$ = $1 - $3; }
        | ops MULTIPLY ops { $$ = $1 * $3; }
        | ops DIVIDE ops { $$ = $1 / $3; }
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
  char result[256];
  sprintf(result, "%s%s","touch ", id);
  system(result);
}

void quit() {
  exit(0);
}

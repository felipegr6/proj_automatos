%{
#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>

void yyerror(char *);
void ls();
void ps();
void ifconfig();
void touch(char *);
void kill(int number);
void makeDir(char *);
void removeDir(char *);
void startProcess(char *);
void cd(char *);
void currentDir();
void quit();
void unknowCommand();
%}

%token END_LINE
%token NUMBER
%token PLUS MINUS MULTIPLY DIVIDE
%token BACK
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
          action END_LINE { currentDir(); }
        | END_LINE { currentDir(); }
        | ERROR { unknowCommand(); }
        | command command
		    ;
action:
          exp
        | ops { printf("%d\n", $1); }
        ;
exp:
          LS { ls(); }
        | PS { ps(); }
        | IFCONFIG { ifconfig(); }
        | QUIT { quit(); }
        | TOUCH ID { touch($2); }
        | KILL NUMBER { kill($2); }
        | MKDIR ID { makeDir($2); }
        | RMDIR ID { removeDir($2); }
        | START ID { startProcess($2); }
        | CD ID { cd($2); }
        | CD BACK { cd($2); }
        | ID { unknowCommand(); }
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

int main(int argc, char **argv) {

    currentDir();

    return yyparse();

}

/* function to send error messages */
void yyerror(char *msg)
{
  fprintf(stderr, "Error: %s\n", msg);
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
  sprintf(result, "%s %s","touch", id);
  system(result);
}

void kill(int number) {
  char result[256];
  sprintf(result, "%s %d", "kill", number);
  system(result);
}

void makeDir(char *id) {
  char result[256];
  sprintf(result, "%s %s", "mkdir", id);
  system(result);
}

void removeDir(char *id) {
  char result[256];
  sprintf(result, "%s %s", "rm -r", id);
  system(result);
}

void startProcess(char *id) {
  system(id);
}

void cd(char *id) {

  char currentDir[1024];
  char result[2048];

  if (getcwd(currentDir, sizeof(currentDir)) == NULL) {
    perror("Error in cd() getcwd()");
  }

  sprintf(result, "%s/%s", currentDir, id);

  if(chdir(result) != 0) {
    fprintf(stderr, "Error in cd() chdir()\n");
  }

}

void currentDir() {

  char currentDir[1024];
  getcwd(currentDir, sizeof(currentDir));

  printf("myshell:%s>> ", currentDir);

}

void unknowCommand() {
  printf("Unknow command.\n");
}

void quit() {
  exit(0);
}

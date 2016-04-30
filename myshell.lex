%{
	#include <stdio.h>
  #include "myshell.tab.h"
%}
%option noyywrap
%%
[ \t]         ;
[0-9]+        yylval = atoi(yytext);  return NUM;
[a-zA-Z0-9]+  return ID;
"+"           return '+';
"-"           return '-';
"*"           return '*';
"/"           return '/';
"ls"          return LS;
"ps"          return PS;
"kill"        return KILL;
"mkdir"       return MKDIR;
"rmdir"       return RMDIR;
"cd"          return CD;
"touch"       return TOUCH;
"ifconfig"    return IFCONFIG;
"start"       return START;
"quit"        return QUIT;
"\n"          return FIM_LINHA;
%%

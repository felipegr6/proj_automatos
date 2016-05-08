
%%
"ls"                  return LS;
"ps"                  return PS;
"kill"                return KILL;
"mkdir"               return MKDIR;
"rmdir"               return RMDIR;
"cd"                  return CD;
"touch"               return TOUCH;
"ifconfig"            return IFCONFIG;
"start"               return START;
"quit"                return QUIT;
[a-zA-Z][a-zA-Z_0-9]* yylval = yytext; return ID;
[0-9]+                yylval = atoi(yytext);  return NUMBER;
"+"                   return PLUS;
"-"		                return MINUS;
"*"                   return MULTIPLY;
"/"                   return DIVIDE;
[ \t]                 ;
"\n"                  return END_LINE;
.                     return ERROR;
%%

%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "parser.tab.h"

char* yyval;

%}
%option yylineno
%option noyywrap


IF if
ELSE else
DOTS :
WHILE while
END end
DISPLAY display
ROUTINE routine
AVAILABILITY availability
READ read
LOCAL local
LPAREN (
RPAREN )
LBRACK [
RBRACK ]
PIPE |
COMMA ,
EQ ==
GT >
LT <
AND and
OR or
PLUS +
MINUS -
TIMES *
DIVIDE /
ASSIGN =
NOT !
INT [0-9]
STRING \"([^\\\"]|\\.)*\" 
IDENTIFIER [a-zA-Z_][a-zA-Z0-9_]*
NEWLINE \n

%%

[ \t]            ; /* Ignora espaços em branco e tabulações */
"if"             { yyval = strdup(yytext); return IF; }
"else"           { yyval = strdup(yytext); return ELSE; }
":"              { yyval = strdup(yytext); return DOTS; }
"while"          { yyval = strdup(yytext); return WHILE; }
"end"            { yyval = strdup(yytext); return END; }
"display"        { yyval = strdup(yytext); return DISPLAY; }
"routine"        { yyval = strdup(yytext); return ROUTINE; }
"availability"   { yyval = strdup(yytext); return AVAILABILITY; }
"read"           { yyval = strdup(yytext); return READ; }
"local"           { yyval = strdup(yytext); return LOCAL; }
"int"            { yyval = strdup(yytext); return INT; }
"str"            { yyval = strdup(yytext); return STRING; }
"("              { yyval = strdup(yytext); return LPAREN; }
")"              { yyval = strdup(yytext); return RPAREN; }
"["              { yyval = strdup(yytext); return LBRACK; }
"]"              { yyval = strdup(yytext); return RBRACK; }
"|"              { yyval = strdup(yytext); return PIPE; }
","              { yyval = strdup(yytext); return COMMA; }
"=="             { yyval = strdup(yytext); return EQ; }
">"              { yyval = strdup(yytext); return GT; }
"<"              { yyval = strdup(yytext); return LT; }
"and"            { yyval = strdup(yytext); return AND; }
"or"             { yyval = strdup(yytext); return OR; }
"+"              { yyval = strdup(yytext); return PLUS; }
"-"              { yyval = strdup(yytext); return MINUS; }
"*"              { yyval = strdup(yytext); return TIMES; }
"/"              { yyval = strdup(yytext); return DIVIDE; }
"="              { yyval = strdup(yytext); return ASSIGN; }
"!"              { yyval = strdup(yytext); return NOT; }

[0-9]+                 { yyval = strdup(yytext); return INT; }
[a-zA-Z_][a-zA-Z0-9_]* { yyval = strdup(yytext); return IDENTIFIER; }
\"([^\\\"]|\\.)*\"     { yyval = strdup(yytext); return STRING; }

#.*?\n  ; /* Ignora comentários de uma linha */
"\\\n"  ; /* Ignora quebras de linha precedidas por \ */

\t\r\n  ; /* Ignora linhas em branco */

\n      { yyval = strdup(yytext); return NEWLINE; }
.       { yyval = strdup(yytext); printf("%s",yyval); }

%%
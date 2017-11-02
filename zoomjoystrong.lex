%{
	#include <stdio.h>
	#include "zoomjoystrong.tab.h"
%}

%option noyywrap
%%

END 				{return END;}
[;]					{return END_STATEMENT;}
(?i:point)			{return POINT;} //make case insensitive
(?i:line)			{return LINE;}
(?i:circle) 		{return CIRCLE;}
(?i:rectangle)		{return RECTANGLE;}
(?i:set_color) 		{return SET_COLOR;}
[0-9]+				{yylval.iVal = atoi(yytext);return INTEGER;}
[0-9]*\.[0-9]+		{yylval.fVal = atof(yytext);return FLOAT;}
.*					{return ERROR;}
\n 					;			

%%




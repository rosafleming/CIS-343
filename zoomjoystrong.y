%{
/*
 */
#include <stdio.h>
#include "zoomjoystrong.tab.h"
#include "zoomjoystrong.h"
#define YYDEBUG 1

extern int yydebug;
%}

%union {
	int iVal;
	float fVal;
}

%token END_STATEMENT
%token CIRCLE
%token LINE
%token RECTANGLE
%token SET_COLOR
%token POINT
%token <fVal> FLOAT
%token <iVal> INTEGER
%token ERROR
%token END
%token ERRORTOK


%%
program: 
	statement_list end{
};

/***********************************************************
***********************************************************/
statement_list:
	statement {};
	|
	statement statement_list {};

/***********************************************************
***********************************************************/
statement:
	point END_STATEMENT{}
	|
	line END_STATEMENT{}
	|
	circle END_STATEMENT{}
	|
	rectangle END_STATEMENT{}
	|
	set_color END_STATEMENT{}
	|
	ERRTOK{
		printf("Error");
	};
	
/***********************************************************
***********************************************************/
line:
	LINE INTEGER INTEGER INTEGER INTEGER{
      	
      	line($2, $3, $4, $5);	
	};

/***********************************************************
***********************************************************/
circle:
	CIRCLE INTEGER INTEGER INTEGER{	
		circle($2, $3, $4);
	};

/************************************************************
*************************************************************/
set_color: 
	SET_COLOR INTEGER INTEGER INTEGER{
		if (colorCheck($2, $3, $4) < 1){
			printf("color out of range");
		} else {
			set_color($2, $3, $4);
		}
	};

/***********************************************************
***********************************************************/
point:
	POINT INTEGER INTEGER {
		if (screenSizeCheck($2, $3) < 1){
			printf("Point not on screen");
		} else {
			point($2, $3);
		}
	};

/***********************************************************
***********************************************************/
rectangle:
	RECTANGLE INTEGER INTEGER INTEGER INTEGER {
		rectangle($2, $3, $4, $5);
	};

end:
	END END_STATEMENT {};
%%

/**********************************************************************
***********************************************************************/
int colorCheck(int a, int b, int c){
	if (a > 255 | a < 0)return 0;
	if (b > 255 | b < 0)return 0;
	if (c > 255 | c < 0)return 0;
	return 1;
}

/************************************************************************
*************************************************************************/
int screenSizeCheck(int x, int y){
	if (x > 1024 | y > 768) {
		return 0;
	}
	else if (x < 0 | y < 0){
		return 0;
	}
	return 1;
}

int yyerror (char const *s) {
   printf("Error - invalid syntax or arguements\n"); 
   return 0;
 }

/****************************************************************************
**************************************************************************/
int main (int argc, char **argv){
	setup();
	yyparse();
	return 0;
}

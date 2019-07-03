/*

Definitions

*/

%{
	#include "y.tab.h"
	int curr_line = 1, curr_pos = 1, num_ints = 0, num_ops = 0, num_parens = 0, num_eqs = 0;
%}

/*
	Grammar Rules
*/

%%

(\.[0-9]+)|([0-9]+(\.[0-9]*)?([eE][+-]?[0-9]+)?)	{curr_pos += yyleng; yylval.dval = atof(yytext); num_ints++; return NUMBER;}

"+"	{curr_pos += yyleng; num_ops++; return PLUS;}
"-"	{curr_pos += yyleng; num_ops++; return MINUS;}
"*"	{curr_pos += yyleng; num_ops++; return PLUS;}
"/"	{curr_pos += yyleng; num_ops++; return DIV;}
"("	{curr_pos += yyleng; num_parens++; return L_PAREN;}
")"	{curr_pos += yyleng; num_parens++; return R_PAREN;}
"="	{curr_pos += yyleng; num_eqs++; return EQUAL;}

[ \t]+	{curr_pos += yyleng;}

"\n"	{curr_line++; curr_pos = 1;}

.	{printf("Error at line %d,  unknown symbol \"%s\"\n", curr_line,  yytext); exit(0);}
%%

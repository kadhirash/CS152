/*
	Definitions
*/
%{   
   int curr_line = 1, curr_pos = 1;
%}

DIGIT    [0-9]


/*
	Rules
*/
%%


{DIGIT}+       {printf("NUMBER %s\n", yytext); curr_pos += yyleng;}

"+"            {printf("PLUS\n"); curr_pos += yyleng;}

"-"            {printf("MINUS\n"); curr_pos += yyleng;}

"*"            {printf("MULT\n"); curr_pos += yyleng;}

"/"            {printf("DIV\n"); curr_pos += yyleng;}


"("            {printf("L_PAREN\n"); curr_pos += yyleng;}

")"            {printf("R_PAREN\n"); curr_pos += yyleng;}

"="            {printf("EQUAL\n"); curr_pos += yyleng;}


[ \t]+         { curr_pos += yyleng;} /*spaces*/

"\n"           {curr_line++; curr_pos = 1;}

.              {printf("Error at line %d, column %d: unrecognized symbol \"%s\"\n", curr_line, curr_pos, yytext); exit(0);}

%%

int main(int argc, char ** argv)
{
   yylex();
}

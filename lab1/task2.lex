/*

Definitions

*/

%{
   int curr_line = 1, curr_pos = 1;
%}


/*
        Rules
*/

%%


[0-9]+       {printf("NUMBER %s\n", yytext); curr_pos += yyleng;}

"+"            {printf("PLUS\n"); curr_pos += yyleng;}

"-"            {printf("MINUS\n"); curr_pos += yyleng;}

"*"            {printf("MULT\n"); curr_pos += yyleng;}

"/"            {printf("DIV\n"); curr_pos += yyleng;}


"("            {printf("L_PAREN\n"); curr_pos += yyleng;}

")"            {printf("R_PAREN\n"); curr_pos += yyleng;}

"="            {printf("EQUAL\n"); curr_pos += yyleng;}


[ \t]+         { curr_pos += yyleng;} /*account for spaces*/

"\n"           {curr_line++; curr_pos = 1;} /* account for new line*/

.              {printf("Error at line %d,  unknown symbol \"%s\"\n", curr_line,  yytext); exit(0);}

%%

/*
	read input file if specified on command line when invoked
*/

int main(int argc, char ** argv)
{
	if(argc >= 2){
		yyin = fopen(argv[1], "r");
		if(yyin == 0){
			printf("Error opening file");
			exit(1);
		}
	}
	else{
		yyin = stdin;
	}
   yylex();
   return 0;
}

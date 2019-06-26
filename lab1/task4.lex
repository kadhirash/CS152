/*

Definitions

*/

%{
   int curr_line = 1, curr_pos = 1, num_ints = 0, num_ops = 0, num_parens = 0, num_eqs = 0;
%}


/*
        Rules
*/

%%


"+"            {printf("PLUS\n"); curr_pos += yyleng; num_ops++;}

"-"            {printf("MINUS\n"); curr_pos += yyleng; num_ops++;}

"*"            {printf("MULT\n"); curr_pos += yyleng; num_ops++;}

"/"            {printf("DIV\n"); curr_pos += yyleng; num_ops++;}


"("            {printf("L_PAREN\n"); curr_pos += yyleng; num_parens++;}

")"            {printf("R_PAREN\n"); curr_pos += yyleng; num_parens++;}

"="            {printf("EQUAL\n"); curr_pos += yyleng; num_eqs++;}


[ \t]+         { curr_pos += yyleng;} /*account for spaces*/

"\n"           {curr_line++; curr_pos = 1;} /* account for new line*/

.              {printf("Error at line %d,  unknown symbol \"%s\"\n", curr_line,  yytext); exit(0);}

(\.[0-9]+)|([0-9]+(\.[0-9]*)?([eE][+-]?[0-9]+)?) {printf("NUMBER %s\n", yytext); curr_pos += yyleng; num_ints++;}

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
   
   printf("# of Integers: %d\n", num_ints);
   printf("# of Operators: %d\n", num_ops);
   printf("# of Parentheses: %d\n", num_parens);
   printf("# of Equal Signs: %d\n", num_eqs);
   return 0;
}

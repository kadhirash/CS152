/*
	Definitions
*/

%{
	int curr_line = 1, curr_pos = 1; /* Variables for current line and postion*/
%}


/*
	Rules
*/

%%
			/* Reserved Words */

"program"	{printf("PROGRAM\n"); curr_pos += yyleng;}
"beginprogram"  {printf("BEGIN_PROGRAM\n"); curr_pos += yyleng;}
"endprogram"    {printf("END_PROGRAM\n"); curr_pos += yyleng;}
"integer"       {printf("INTEGER\n"); curr_pos += yyleng;}
"array"       	{printf("ARRAY\n"); curr_pos += yyleng;}
"of"       	{printf("OF\n"); curr_pos += yyleng;}
"if"       	{printf("IF\n"); curr_pos += yyleng;}
"then"       	{printf("THEN\n"); curr_pos += yyleng;}
"endif"       	{printf("ENDIF\n"); curr_pos += yyleng;}
"else"       	{printf("ELSE\n"); curr_pos += yyleng;}
"while"       	{printf("WHILE\n"); curr_pos += yyleng;}
"do"       	{printf("DO\n"); curr_pos += yyleng;}
"beginloop"     {printf("BEGINLOOP\n"); curr_pos += yyleng;}
"endloop"       {printf("ENDLOOP\n"); curr_pos += yyleng;}
"continue"      {printf("CONTINUE\n"); curr_pos += yyleng;}
"read"       	{printf("READ\n"); curr_pos += yyleng;}
"write"       	{printf("WRITE\n"); curr_pos += yyleng;}	
"and"       	{printf("AND\n"); curr_pos += yyleng;}
"or"       	{printf("OR\n"); curr_pos += yyleng;}
"not"       	{printf("NOT\n"); curr_pos += yyleng;}
"true"       	{printf("TRUE\n"); curr_pos += yyleng;}
"false"       	{printf("FALSE\n"); curr_pos += yyleng;}

			/* Arithmetic Operators */
"-"		{printf("SUB\n"); curr_pos += yyleng;}
"+"		{printf("ADD\n"); curr_pos += yyleng;}
"*"		{printf("MULT\n"); curr_pos += yyleng;}
"/"		{printf("DIV\n"); curr_pos += yyleng;}
"%"		{printf("MOD\n"); curr_pos += yyleng;}
			
			/* Comparision Operators */
"=="		{printf("EQ\n"); curr_pos += yyleng;}
"<>"		{printf("NEQ\n"); curr_pos += yyleng;}
"<"		{printf("LT\n"); curr_pos += yyleng;}
">"		{printf("GT\n"); curr_pos += yyleng;}
"<="		{printf("LTE\n"); curr_pos += yyleng;}
">="		{printf("GTE\n"); curr_pos += yyleng;}

			/* Identifiers and Numbers */
[A-zA-Z]+((_|[0-9]|[A-zA-Z])*([0-9]|[A-zA-Z])+)*	{printf("IDENT %s\n", yytext); curr_pos += yyleng;}
[0-9]+		{printf("NUMBER %s\n", yytext); curr_pos += yyleng;}
	
			/* Other Special Symbols*/
";"            	{printf("SEMICOLON\n"); curr_pos += yyleng;}
":"            	{printf("COLON\n"); curr_pos += yyleng;}
","            	{printf("COMMA\n"); curr_pos += yyleng;}
"("            	{printf("L_PAREN\n"); curr_pos += yyleng;}
")"            	{printf("R_PAREN\n"); curr_pos += yyleng;}
":="            {printf("ASSIGN\n"); curr_pos += yyleng;}	

	/* Ignore comments and white spaces*/	
("##").*	{curr_pos += yyleng;}
[ \t]+		{curr_pos += yyleng;}
"\n"		{curr_line++; curr_pos = 1;}

	/* Error Handling*/
.	{printf("Error at line %d, column %d: unrecognized symbol \"%s\"\n", curr_line, curr_pos, yytext); exit(0);}

([0-9]|_)+(_|[0-9]|[A-zA-Z])*[A-zA-Z]+	{printf("Error at line %d, column %d: identifier \"%s\" must begin with a letter\n", curr_line, curr_pos, yytext); exit(0);}

([A-zA-Z])+(_|[0-9]|[A-zA-Z])*["_"]+	{printf("Error at line %d, column %d: identifier \"%s\" cannot end with an underscore\n", curr_line, curr_pos, yytext); exit(0);}
%%

int main(int argc, char ** argv)
{
	if(argc >=2)
	{
		yyin = fopen(argv[1], "r");
		if(yyin == 0)
		{
			printf("Error opening the file");
			exit(1);
		}
	}
	else
	{
		yyin = stdin;
	}
	
	yylex();
}	

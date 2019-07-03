/*
	Prologue
*/

%{
	#include <stdio.h>
	#include <stdlib.h>
	void yyerror(const char *msg);
	extern int curr_line;
	extern int curr_pos;
	FILE *yyin;

%}

%union{
	double dval;
	int ival;
}


/*
	Bison Declarations
*/
%error-verbose
%start input
%token MULT DIV PLUS MINUS EQUAL L_PAREN R_PAREN
%token <dval> NUMBER
%type <dval> exp
%left PLUS MINUS
%left MULT DIV
%nonassoc UMINUS

/*
	Grammar Rules
*/

%%

input:	
			| input line
			;

line:		exp EQUAL          { printf("\t%f\n", $1);}
			;

exp:		NUMBER                { $$ = $1; }
			| exp PLUS exp        { $$ = $1 + $3; }
			| exp MINUS exp       { $$ = $1 - $3; }
			| exp MULT exp        { $$ = $1 * $3; }
			| exp DIV exp         { if ($3==0) yyerror("divide by zero"); else $$ = $1 / $3; }
			| MINUS exp %prec UMINUS { $$ = -$2; }
			| L_PAREN exp R_PAREN { $$ = $2; }
			;
%%
/*
	Epilogue
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
   yyparse();
   printf("# of Integers: %d\n", num_ints);
   printf("# of Operators: %d\n", num_ops);
   printf("# of Parentheses: %d\n", num_parens);
   printf("# of Equal Signs: %d\n", num_eqs);
   return 0;
   return 0;
}

void yyerror(const char *msg){
	printf("** Line %d, position %d: %s\n", curr_line, curr_pos, msg);
}

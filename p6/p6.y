
%{
	#include <math.h>
	#include <stdio.h>
	#include <stdlib.h>
	void checkDeno(const int d);
	void checkDenoF(const double d);
	void yyerror(char* s);
	int length(char* p);
	char * conCat(char *c1, char * c2);
%}

%union{
	int entero;
	double real;
	char * str;
}

%token salto
%token <entero> ENTERO
%token <real> doub
%token <str> cadena
%token sum "+"
%token res "-" 
%token divv "/"
%token mult "*" 
%token mod
%token pd "("
%token pi ")"
%token coma ","
%start entrada
%type <real> eF
%type <entero> eI
%type <str> eS

%left "+" "-"
%left "/" "*" mod 

%%

entrada : 
		| l entrada 
		;

l 	:  salto
		| eI salto {printf("= %d\n\n",$1);}
		| eF salto {printf("= %.3f\n\n",$1);}
		| eS salto {printf("= %s\n\n", $1); }
		;

eS: cadena { $$ = $1; }
	| eS "+" eS {
	 $$ = conCat($1,$3);
	}
eF: doub  { $$ = $1; }
	  | "-" eF { $$ = -$2; }
	  | mod "(" eF "," eF ")" { $$ = fmod($3,$5);}
	  | eF "+" eF	 { $$ = $1 + $3; }
	  | eF "-" eF	 { $$ = $1 - $3; }
	  | eF "*" eF { $$ = $1 * $3; }
	  | eF "/" eF	 {  checkDenoF($3);
	  					$$ = $1 / $3; }
	  | eI "+" eF	 	 { $$ = $1 + $3; }
	  | eI "-" eF	 	 { $$ = $1 - $3; }
	  | eI "*" eF 	 { $$ = $1 * $3; }
	  | eI "/" eF	 { checkDenoF($3);
	  					$$ = $1 / $3; }
	  | eF "+" eI	 	 { $$ = $1 + $3; }
	  | eF "-" eI	 	 { $$ = $1 - $3; }
	  | eF "*" eI 	 { $$ = $1 * $3; }
	  | eF "/" eI	 { 	checkDeno($3);
	  					$$ = $1 / $3; }
	  ;
eI: ENTERO {$$ = $1;}
		| "-" eI { $$ = -$2; }
		| eI "+" eI { $$ = $1 + $3; }
	    | eI "-" eI { $$ = $1 - $3; }
	    | eI "*" eI { $$ = $1 * $3; }
	    | eI "/" eI { 	checkDeno($3);
	    				$$ = $1 / $3; }
	    | mod "(" eI "," eI ")" { $$ = $3 % $5;}
		;
%%	

int main() {
//    printf("Expresion: \n");
    yyparse();
}
 
void yyerror(char* s) {
    printf("\nExpresion no valida: %s\n",s);
    exit(1);
}

void checkDeno(const int d){
	if(d == 0)
		yyerror("Denominador igual a 0\n");
}

void checkDenoF(const double d){
	if(d == 0.0)
		yyerror("Denominador igual a 0.0\n");
}
int length(char* p) {
    int count = 0;
    while (*p != '\0') {
        count++;
        p++;
    }
    return count;
}

char * conCat(char *c1, char *c2){
	int  i;
	char *u;
	int j;
	i = j = 0;
	size_t t1 =  length(c1);
	size_t t3 =  length(c2);
	size_t sum = t1 + t3;
	u = (char*)malloc(sum + 1);
	 for(i = 0; i < t1; i++)
	 	if(c1[i] != '"')
	 		u[j++] = c1[i];

	 for(i = 0; i < t3; i++)
	 	if(c2[i] != '"')
	 		u[j++] = c2[i];


	 u[j] = '\0';
	 return u;
}

%{	
	#include "p6.tab.h"
	#include <math.h>	
	int length2(char* p);
	char * clearCad(char *c);
%}
digito [0-9]
%%
"-" { return res;}
{digito}+ {	yylval.entero = atoi(yytext);  return ENTERO; }
{digito}*"."{digito}+ { yylval.real = atof(yytext); return doub; }  
"+" {return sum;}
"*" {return mult;}
"/" {return divv;}
\n {return salto;}
[Mm][Oo][Dd] {return mod;}
"(" { return pd;}
")" { return pi;}
"," { return coma;}
[ \t]+	{ continue;}
. {;}
\"(([^\"]|\\\")*[^\\])?\" { yylval.str = clearCad(strdup(yytext)); return cadena;}
%%

int yywrap(){}

int length2(char* p){
	int count = 0;
    while (*p != '\0') {
        count++;
        p++;
    }
    return count;
}
char * clearCad(char *c){
	int  i;
	char *u;
	int j;
	i = j = 0;
	size_t t1 =  length2(c);
	u = (char*)malloc(sum-2 + 1);
	 for(i = 0; i < t1; i++)
	 	if(c[i] != '"')
	 		u[j++] = c[i];

	 u[j] = '\0';
	 return u;
}




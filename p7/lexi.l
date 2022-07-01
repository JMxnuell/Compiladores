%{	
	#include "sintac.tab.h"
	#include <math.h>	
	int length2(char* p);
	char * clearCad(char *c);
%}
digito [0-9]
nameVariable [A-Za-z"_"][A-Za-z"_"0-9]*
%%
\"(([^\"]|\\\")*[^\\])?\" { yylval.str = clearCad(strdup(yytext)); return cadena;}
int	{ return tInt; }
string { return tString; }
double { return tDouble; }
salir { return salida; }
[Mm][Oo][Dd] {return mod;}
[Pp][Oo][Ww] {return potS;}
{nameVariable} {  yylval.str = yytext; return var; }
{digito}+ {	yylval.entero = atoi(yytext);  return ENTERO; }
{digito}*"."{digito}+ { yylval.real = atof(yytext); return doub; }  
"-" { return res;}
";" { return puntoComa; }
"+" {return sum;}
"*" {return mult;}
"=" { return asigna; }
"/" {return divv;}
\n {return salto;}
"%" {return modulo; }
"(" { return pd;}
")" { return pi;}
"," { return coma;}
[ \t]+	{ continue;}
. {;}
%%

int yywrap(){ return 0; }

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




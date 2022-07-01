%{
	#include "tabla.h"
	#include "combina.h"
	void checkDeno(const int d);
	void checkDenoF(const double d);
	void yyerror(char* s);
	void verificaTipo(int t1, int t2);
	int yylex (void);
	t_simb * ini;
	t_simb * fin;
%}
%union{
	int entero;
	double real;
	char * str;
	struct combina * m;
}
%token <str> var;
%token salto
%token <entero> ENTERO
%token <real> doub
%token puntoComa ";"
%token <str> cadena
%token tInt
%token tDouble
%token tString
%token salida
%token sum "+"
%token res "-" 
%token divv "/"
%token mult "*"
%token modulo "%"
%token asigna "="
%token mod
%token potS
%token pd "("
%token pi ")"
%token coma ","
%start entrada
%type <entero> tipo
%type <m> dato
%type <m> exp
%left "+" "-"
%left "/" "*" mod potS 
%precedence NEG
%%

entrada : 
		| l entrada 
		;

l 	:  salto
	| s l {}
	;

s   : dec ";" {}
	| asign ";"{}
	| exp ";"  {printEXP($1);}
	| salida ";" {exit(0);}
	;

tipo : tInt {$$ = 1;}
	 | tString {$$ = 3;};
	 | tDouble  {$$ = 2;};
	 ;

dec : tipo var "=" exp { verificaTipo($1,$4->tipoDato); if(buscaSimb($2) != NULL) yyerror(("variable ya declarada"));
							insertar($2,$1,$4->tipoDato,$4->v); }
    | tipo var 		{ if(buscaSimb($2) != NULL) yyerror(("variable ya declarada"));
						  insertarSin($2,$1); }
	;
asign : var "=" exp  { t_simb * e; e = buscaSimb($1); if(e == NULL) yyerror(("Variable no declarada"));
						verificaTipo(e->tipoDato,$3->tipoDato); 
						modificaVar(&e,$3->v); }
	;
dato : ENTERO { union valor v; v.varI = $1; $$ = devuelveNodo(1,v);}
  | doub { union valor v; v.varD = $1; $$ = devuelveNodo(2,v); }
  | cadena { union valor v; v.varS = $1; $$ = devuelveNodo(3,v);}
  | var { t_simb * e; e = buscaSimb($1); if(e == NULL) yyerror(("Variable no declarada"));
		  	$$ = devuelveNodo(e->tipoDato,e->v);
		  }
  ;

//1 negacion, 2 suma, 3 resta, 4 multiplica, 5 divide, 6 pow, 7 mod
exp : dato { $$ = $1; }
	| "-" exp %prec NEG { if($2->tipoDato == 3) yyerror(("operacion incompatible"));
						  union valor v; int t; v = opera(&t,$2,NULL,1);
						  $$ = devuelveNodo(t,v);
						}
	| exp "+" exp {  if( ( $1->tipoDato == 3 && $3->tipoDato != 3) || ( $3->tipoDato == 3 && $1->tipoDato != 3)  ) 
							yyerror(("operacion  incompatible")); 
							union valor v; int t; v = opera(&t,$1,$3,2); $$ = devuelveNodo(t,v);
						}
	| exp "-" exp {  if( ( $1->tipoDato == 3 || $3->tipoDato == 3) ) 
							yyerror(("operacion  incompatible")); 
							union valor v; int t; v = opera(&t,$1,$3,3); $$ = devuelveNodo(t,v);
						}
	| exp "*" exp {  if( ( $1->tipoDato == 3 || $3->tipoDato == 3) ) yyerror(("operacion  incompatible")); 
							union valor v; int t; v = opera(&t,$1,$3,4); $$ = devuelveNodo(t,v);
						}
	| exp "/" exp {  if( ( $1->tipoDato == 3 || $3->tipoDato == 3) ) yyerror(("operacion  incompatible")); 
							if($3->tipoDato == 2) checkDenoF($3->v.varD);
							if($3->tipoDato == 1) checkDeno($3->v.varI);
							union valor v; int t; v = opera(&t,$1,$3,5); $$ = devuelveNodo(t,v);
						}
	| potS "(" exp "," exp ")" { if( ($5->tipoDato != 1) || ($5->v.varI < 0) ) 
							yyerror(("operacion  incompatible")); 
							union valor v; int t; v = opera(&t,$3,$5,6); $$ = devuelveNodo(t,v);
						}
	| mod "(" exp "," exp ")" { if( ($5->tipoDato == 3) || ($5->tipoDato == 3) ) 
							yyerror(("operacion  incompatible")); 
							union valor v; int t; v = opera(&t,$3,$5,7); $$ = devuelveNodo(t,v);
						}
	;
%%	
int main() {
//    printf("Expresion: \n");
	ini = fin = NULL;
    yyparse();
}
 
void yyerror(char* s) {
    printf("\nExpresion no valida: %s\n",s);
    exit(1);
}

void checkDeno(const int d){
	if(d == 0)
		yyerror(("Denominador igual a 0"));
}

void checkDenoF(const double d){
	if(d == 0.0)
		yyerror(("Denominador igual a 0.0"));
}

void verificaTipo(int t1, int t2){
	
	if( t1 != t2){
		if( (t1 == 3 && t2 != 3) || (t2 == 3 && t1 != 3)  )
			 yyerror(("asignacion incompatible"));
	}
}




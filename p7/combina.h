#include <stdlib.h>
#include <stdio.h>
#include <stdbool.h>
#include "str.h"
#include <string.h>
#include "tipoValor.h"
#include <math.h>

struct combina{

		int tipoDato; // 1 int, 2 double, 3 string
		union valor v;
};

typedef struct combina * mezcla;

mezcla devuelveNodo(int t, union valor vt) { //LIST
  mezcla node = (mezcla)malloc(sizeof(combina));
  node->tipoDato = t;
  switch(t){
		case 1:
			node->v.varI = vt.varI;
			break;
		case 2:
			node->v.varD = vt.varD;
			break;
		case 3:
			node->v.varS = strdup(vt.varS);
			break;
	} 
  return node;
}

void printEXP(mezcla m){
	switch(m->tipoDato){
		case 1:
			printf("= %d\n\n",m->v.varI);
			break;
		case 2:
			printf("= %.3f\n\n",m->v.varD);
			break;
		case 3:
			printf("= %s\n\n",m->v.varS);
			break;
	}
}

//1 negacion, 2 suma, 3 resta, 4 multiplica, 5 divide, 6 pow, 7 mod
union valor opera(int * t, mezcla e1, mezcla e2, int op){

	union valor v;
	switch(op){

		case 1: 
			if(e1->tipoDato == 1)
				v.varI = -(e1->v.varI);
			else
				v.varD = -(e1->v.varD);
			*t = e1->tipoDato;
			break;
		case 2:
			if(e1->tipoDato == 3){
				v.varS = conCat(e1->v.varS,e2->v.varS);
				*t = 3; 
			}else if(e1->tipoDato == 2 || e2->tipoDato == 2){
				if(e1->tipoDato == 2 && e2->tipoDato == 2)
					v.varD = e1->v.varD + e2->v.varD;
				else if(e1->tipoDato == 1 && e2->tipoDato == 2)
					v.varD = e1->v.varI + e2->v.varD;
				else if(e1->tipoDato == 2 && e2->tipoDato == 1)
					v.varD = e1->v.varD + e2->v.varI;
				*t = 2; 
			}else{
				v.varI = e1->v.varI + e2->v.varI;
				*t = 1;
			}
			break;
		case 3:
					if(e1->tipoDato == 2 || e2->tipoDato == 2){
						if(e1->tipoDato == 2 && e2->tipoDato == 2)
							v.varD = e1->v.varD - e2->v.varD;
						else if(e1->tipoDato == 1 && e2->tipoDato == 2)
							v.varD = e1->v.varI - e2->v.varD;
						else if(e1->tipoDato == 2 && e2->tipoDato == 1)
							v.varD = e1->v.varD - e2->v.varI;
						*t = 2; 
					}else{
						v.varI = e1->v.varI - e2->v.varI;
						*t = 1;
					}
					break;
		case 4:
			if(e1->tipoDato == 2 || e2->tipoDato == 2){
				if(e1->tipoDato == 2 && e2->tipoDato == 2)
					v.varD = e1->v.varD * e2->v.varD;
				else if(e1->tipoDato == 1 && e2->tipoDato == 2)
					v.varD = e1->v.varI * e2->v.varD;
				else if(e1->tipoDato == 2 && e2->tipoDato == 1)
					v.varD = e1->v.varD * e2->v.varI;
				*t = 2; 
			}else{
				v.varI = e1->v.varI * e2->v.varI;
				*t = 1;
			}
			break;
		case 5:
			if(e1->tipoDato == 2 || e2->tipoDato == 2){
				if(e1->tipoDato == 2 && e2->tipoDato == 2)
					v.varD = e1->v.varD / e2->v.varD;
				else if(e1->tipoDato == 1 && e2->tipoDato == 2)
					v.varD = e1->v.varI / e2->v.varD;
				else if(e1->tipoDato == 2 && e2->tipoDato == 1)
					v.varD = e1->v.varD / e2->v.varI;
				*t = 2; 
			}else{
				v.varI = e1->v.varI / e2->v.varI;
				*t = 1;
			}
			break;
		case 6:
			if(e1->tipoDato == 3){
				v.varS = potencia(e1->v.varS,e2->v.varI);
				*t = 3; 
			}else{
				if(e1->tipoDato == 2)
					v.varD = pow(e1->v.varD,e2->v.varI);
				else
					v.varD = pow(e1->v.varI,e2->v.varI);
				*t = 2; 
			}
			break;
		case 7:
				if(e1->tipoDato == 2 || e2->tipoDato == 2){
					if(e1->tipoDato == 2 && e2->tipoDato == 2)
							v.varD = fmod(e1->v.varD,e2->v.varD);
					else if(e1->tipoDato == 1 && e2->tipoDato == 2)
							v.varD = fmod(e1->v.varI,e2->v.varD);
					else if(e1->tipoDato == 2 && e2->tipoDato == 1)
							v.varD = fmod(e1->v.varD,e2->v.varI);
					*t = 2;
				}
				else{
					v.varI = e1->v.varI % e2->v.varI;
					*t = 1; 
				}
			break;
		}
	return v;
}

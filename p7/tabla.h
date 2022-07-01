#include <stdlib.h>
#include <stdio.h>
#include <stdbool.h>
#include "tipoValor.h"

typedef struct t_simb{

	char * nombre;
	int tipoDato; // 1 int, 2 double, 3 string
	struct t_simb * sig;
	union valor v;
}simbolo;


extern t_simb * ini;
extern t_simb * fin;

//t_simb * ini = NULL; // puntero inicial de la table - se maneja una lista

void insertar (char * nombre, int tDato, int tDato2, union valor v){
	t_simb *nuevoSimbolo = (t_simb *) malloc (sizeof (t_simb));
	nuevoSimbolo->nombre = (nombre);
	nuevoSimbolo->tipoDato = tDato;
	nuevoSimbolo->sig = NULL;
	switch(tDato){
		case 1:
			if(tDato2 == 1 )
				nuevoSimbolo->v.varI = v.varI;
			else
				nuevoSimbolo->v.varI = v.varD;
			break;
		case 2:
			if(tDato2 == 2 )
				nuevoSimbolo->v.varD = v.varD;
			else
				nuevoSimbolo->v.varD = v.varI;
			break;
		case 3:
			nuevoSimbolo->v.varS = (v.varS);
			break;
	}
	if(fin == NULL)
		ini = fin = nuevoSimbolo;
	else
		fin = fin->sig = nuevoSimbolo;
	
}
void insertarSin(char * nombre, int tDato){
	t_simb *nuevoSimbolo = (t_simb *) malloc (sizeof (t_simb));
	nuevoSimbolo->nombre = (nombre);
	nuevoSimbolo->tipoDato = tDato;
	nuevoSimbolo->sig = NULL;
	switch(tDato){
		case 1:
			nuevoSimbolo->v.varI = 0;
			break;
		case 2:
			nuevoSimbolo->v.varD = 0.0;
			break;
		case 3:
			nuevoSimbolo->v.varS = NULL;
			break;
	}
	if(fin == NULL)
		ini = fin = nuevoSimbolo;
	else
		fin = fin->sig = nuevoSimbolo;
	
}
int length(char* p) {
    int count = 0;
    while (*p != '\0') {
        count++;
        p++;
    }
    return count;
}
bool iguales(char * c1, char * c2){
	size_t z1, z2;

	z1 = length(c1);
	z2 = length(c2);

	if(z1 != z2)
		return false;

	int i = 0;

	for(i; i <(int)z1; i++)
		if(c1[i] != c2[i])
			return false;
	return true;
}

t_simb * buscaSimb(char * nombre){
	t_simb * r;
	r = ini;
	
	while(r != NULL){
		//printf("dentro");
		//printf("%s %s\n",nombre, r->nombre);
		if(iguales(nombre,r->nombre))
				return r;
		r = r->sig;
	}

	return NULL;
}

void modificaVar(simbolo ** e, union valor v){
	switch((*e)->tipoDato){
		case 1:
			(*e)->v.varI = v.varI;
			break;
		case 2:
			(*e)->v.varD = v.varD;
			break;
		case 3:
			(*e)->v.varS = (v.varS);
			break;
	}
}





#ifndef tipo
#define tipo
union valor{ // con union resolvemos el problema de a que variable asignar según el tipo de dato
		double varD;
		int varI;
		char * varS;
};
#endif
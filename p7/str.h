
#include <string.h>
#include <stdlib.h>
#include <stdio.h>

int length3(char* p) {
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
	size_t t1 =  length3(c1);
	size_t t3 =  length3(c2);
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

char * potencia(char * str,int pot){
	
	char * ptr = 0;
	int ptrSize = 0;
	int  l = length3(str);
	for(int i = 0; i < pot; i++){
		ptrSize += l;
		ptr = (char*)realloc(ptr,ptrSize);
		ptr = strdup(conCat(ptr,str));
	}
	ptr[ptrSize] = '\0';
    
    return ptr;
}

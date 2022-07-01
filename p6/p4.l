digito [0-9]
%%
-?{digito}+ {
		printf("numEntero\n");
		}

({digito}*)?"."{digito}+ {
		printf("numDec\n");
		}





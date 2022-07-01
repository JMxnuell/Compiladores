nameVariable [A-Za-z"_"][A-Za-z"_"0-9]*
digito [0-9]
rango [0-9]|[0-9][0-9]|1[0-9][0-9]|2[0-4][0-9]|25[0-5]
%%
"int"|"char"|"double" {
		printf("tipoDato\n");
		}
{nameVariable} {
		printf("variableValida\n");
		}

{digito}+ {
		printf("numEntero\n");
		}

({digito}+)?"."{digito}+ {
		printf("numDec\n");
		}
{rango}"."{rango}"."{rango}"."{rango} {
		printf("ipValida\n");
		}
\".*\" {
		printf("cadenaValida\n");
		}





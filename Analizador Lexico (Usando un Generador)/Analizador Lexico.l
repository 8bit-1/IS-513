/* escáner para un lenguaje de juguete al estilo de Pascal 
se usa de la siguiente forma:
1) ./<ejecutable>.out <nombre_archivo> ejmplo: ./analizador.out programa.prg
2) ./<ejecutable>.out ejemplo: ./analizador.out

En el numeral 1 se pasa un archivo de texto, en el 2do no y la entrada es via teclado
*/

%{
/* se necesita esto para la llamada a atof() más abajo */
#include <math.h>
#include<stdio.h>
void Salir();
%}

EnteroPositivo      [0-9]*
EnteroNegativo      (-[0-9]*)
DecimalPositivo     [0-9]*\.[0-9]*
DecimalNegativo     -[0-9]*\.[0-9]* 
Variable       ([A-Z]){1}([0-9a-z])*
Variable2      (\b)(([A-Z]){1}([0-9a-z])*(?=\W))


%%

{DecimalPositivo}     fputs("Tkn_DecimalP\n",yyout);
{DecimalNegativo}     fputs("Tkn_DecimalN\n",yyout);

{EnteroPositivo}      fputs("Tkn_EnteroP\n",yyout);
{EnteroNegativo}      fputs("Tkn_EnteroN\n",yyout);

{Variable2}   {fputs("Tkn_Variable\n",yyout);} 

definir|repetir|mientras|hasta|finsi|si|sino|imprimir|goto|leer|hacer  {
                    fputs("Tkn_PalabraReservada\n",yyout);
                                        }
"+"|"-"|"*"|"/"   fputs("Tkn_OperadorAritmetico\n",yyout);

"<"|">"|"<="|">="|"!="|"==" fputs("Tkn_OperadorRelacional\n",yyout);

"{"     fputs("Tkn_CorcheteA\n",yyout);
"}"     fputs("Tkn_CorcheteC\n",yyout);
"("     fputs("Tkn_ParentesisA\n",yyout);
")"     fputs("Tkn_ParentesisC\n",yyout);

; /*hacer nada*/

"{"[^}\n]*"}"     /* se come una linea de comentarios */

[ \t\n]+          /*  se come los espacios en blanco */

.           printf( "Caracter no reconocido: %s\n", yytext );

%%

int main(int argc, char *argv[]){
	if (argc == 2){
		yyin= fopen(argv[1], "rt");
		yyout=fopen("dataOut.txt", "w");
		if (yyin == NULL){
			printf("no se puede abrir %s ", argv[1]);
			exit(1);
		}
	}
	else{
	    yyin = stdin;
	}
	yylex();
	return 0;
}
void Salir(){
	printf("Saliendo...");
	exit(0);
}

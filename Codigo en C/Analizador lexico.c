
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
//funciones
void analizar(char c);
//variable globales
char *palabrasReservadas[] = {"definir","repetir","mientras","hasta","fin","finsi","si"};
int tamPalabrasReservadas=sizeof(palabrasReservadas)/sizeof(char *);
int estado=0;
int i=0;
char identificador[100];


int main( )
{
   FILE *fp ;
   
   printf( "Opening the file test.c in read mode\n" ) ;
   fp = fopen ( "data.txt", "r" ) ; // opening an existing file
   char caracter;
      if ( fp == NULL )
   {
     printf ( "Could not open file data.txt \n" ) ;
     return 1;
   }
   printf( "Reading the file data.txt \n" ) ;
    
   while (1){
	  caracter=fgetc(fp);
	  if(caracter==EOF){break;}
	  while(i==0){
		   if(caracter!='{'){printf("impossible"); exit(-1);}
		   i=1;
		   }
	  
	  analizar(caracter);
	  switch(caracter){
		  case '{':printf("<Tkn_corcheteA>");break;
		  case '}':printf("<Tkn_corcheteC>");break;
		  case '(':printf("<Tkn_parentesisA>");break;
		  case ')':printf("Tkn_parentesisC");break;
		
		  }
	  //printf("ciclo %i \n",i);
	  i++;
	   }
   
   //~ while ( 1 )
   //~ {
     //~ c = fgetc ( fp ) ; // reading the file
     
     //~ if (c == 32){printf(" _espacioVacio_");}
     //~ if(c == 104) {printf("<h>");}
     //~ if ( c == EOF ){ printf(" final \n"); break ; }
     
     //~ printf ( "%c", c ) ;
   //~ }
   
   //~ printf("Closing the file test.c") ;
   //~ fclose ( fp ) ; // Closing the file
   //~ return 0;
}

void analizar(char c){
	//printf("%i \n",estado);
	if(c==32||c=='}'){
		//printf("%i \n",estado);
		switch(estado){
			case 1:printf("<Tkn_numero>") ;break;
			case 2:printf("<Tkn_numero>") ;break;
			case 4:printf("<Tkn_numeroDecimal>") ;break;
			}
		}
	//Mayuscula
	if( c>=65 && c<=90 ){
		printf("<Caracter Mayuscula>");}
	//Minuscula 97-122
	if(c>=96 && c<=122){
		printf("<Caracter Minuscula>");}
	//Numero
	if(c<=57&&c>=48){
		if(estado==0){estado=1;}else if(estado==1){estado=2;}else if(estado==3){estado=4;}
		//~ if(estado==1){estado=2;}
		//~ if(estado==3){estado=4;}
		
		//printf("<Caracter numeral>");
		}
	//punto decimal	
	if(c=='.'){
		
		if(estado==1||estado==2){estado=3;}else if(estado!=1 && estado!=2){ exit(-1);}
		
		 }	
	//operador Aritmetico
	if(c=='-'||c=='+'||c=='/'||c=='*'){
		printf("<operador aritmetico>");
		}
	//operador relacinal
	if(c=='='||c=='<'||c=='>'||c=='!'){
		printf("<operador relacional>");
		}
		
}	

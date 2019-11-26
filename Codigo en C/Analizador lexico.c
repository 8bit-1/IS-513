
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
//funciones
void analizar(char c);
void Estado();
void Buscar();
//variable globales
char *palabrasReservadas[] = {"definir","repetir","mientras","hasta","fin","finsi","si"};
int tamPalabrasReservadas=sizeof(palabrasReservadas)/sizeof(char *);
int i;
int estado=0;
char identificador[100];
char temp[2];

//el lenguaje de programacion c: Denis Ritchie
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
		  case ')':printf("<Tkn_parentesisC>");break;
		
		  }
	  i++;
	   }
   //~ fclose ( fp ) ; // Closing the file
 
}

void buscar(){
	for(int i=0;i<tamPalabrasReservadas;i++){
		if(strcmp(palabrasReservadas[i],identificador)==0){
			printf("<Tkn_%s>",palabrasReservadas[i]);
			identificador[0]='\0';
			break;
			}
		if(i==(tamPalabrasReservadas)-1){printf("\nError no hay ID");exit(-1);}
		}
		
	}

void Estado(){
	switch(estado){
			case 1:printf("<Tkn_numero>"); estado=0;break;
			case 2:printf("<Tkn_numero>");estado=0;break;
			case 4:printf("<Tkn_numeroDecimal>");estado=0;break;
			case 5:buscar();estado=0; break;
			case 6:printf("<Tkn_variable>"); estado=0;break;
			case 7:printf("<Tkn_variable>");estado=0;break;
			case 9:printf("<Tkn_operadorRelacional>");estado=0;break;
			case 10:printf("<Tkn_operadorAritmetico>");estado=0;break;
			case 11:printf("<Tkn_operadorMQ>");estado=0;break;
			case 12:printf("<Tkn_Asignador>");estado=0;break;
			case 13:printf("<Tkn_MenorIgualQ>");estado=0;break;
			case 14:printf("<Tkn_MayorQ>");estado=0;break;
			case 15:printf("<Tkn_MayorIgualQ>");estado=0;break;
					
			}
	
	}

void analizar(char c){
	
	if(c==32||c=='}'||c=='{'||c=='('||c==')'||c==';'){
		//printf("%i \n",estado);
		Estado();
		}
	//Mayuscula
	if( c>=65 && c<=90 ){
		if(estado==0){estado=6;}else if(estado==6||estado==7){estado=7;}
		else if(estado!=0 && estado!=6 && estado!=7){printf("\n error");exit(-1);}
		//printf("<Caracter Mayuscula>");
		}
	//Minuscula 97-122
	if(c>=96 && c<=122){
		if(estado==0){temp[0]=c; strcat(identificador,temp); estado=5;}else if(estado==6||estado==7){estado=7;}
		else if(estado==5){temp[0]=c; strcat(identificador,temp);estado=5;}else{printf("\n errorCM"); exit(-1);}
		//printf("<Caracter Minuscula>");
		}
	//Numero
	if(c<=57&&c>=48){
		if(estado==0){estado=1;}else if(estado==1||estado==2){estado=2;}else if(estado==3||estado==4){estado=4;}
		else if(estado==6||estado==7){estado=7;}else{printf("\n errorN"); exit(-1);}
	
		//printf("<Caracter numeral>");
		}
	//punto decimal	
	if(c=='.'){if(estado==1||estado==2){estado=3;}
		else if(estado!=1 && estado!=2){printf("\n error"); exit(-1);}
		
		 }
	//signo "menos"
	if(c=='-'){if(estado==0){estado=10;}else if(estado==11){estado=12;}
		}	
	//operador Aritmetico
	if(c=='+'||c=='/'||c=='*'){
		if(estado==0){estado=10;}else{printf("Error aritmetico");exit(-1);}
		
		}
	//operador relacional
	
	//~ if(c=='='||c=='<'||c=='>'||c=='!'){
		
		//~ //printf("<operador relacional>");
		//~ }
		
	if(c=='<'){                
	
		if(estado==0){estado=11;}else{printf("error <");}
		}
	if(c=='>'){   
		if(estado==0){estado=14;}else{printf("error >");}
		 }	
	
	if(c=='='){
		 if(estado==0){estado=8;}
		 else if(estado==8){estado=9;}else if(estado==11){estado=13;}
		 else if(estado==14){estado=15;}
		 else{printf("error =");exit(-1);}
		}
	if(c=='!'){
		if(estado==0){estado=8;}else{printf("\n error !");exit(-1);} 
		
		}
}	

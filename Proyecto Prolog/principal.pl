 %hechos
:- dynamic eshombre/1.

eshombre(mario).
eshombre(alvin).
esmujer(maria).
esmujer(gissel).

:- dynamic esalumno/1.
esalumno(mario).
esalumno(alvin).
esalumno(maria).
esalumno(gissel).

escarrera(ing_sistemas).
escarrera(ing_electrica).
escarrera(ing_industrial).

esclase(poo).
esclase(lenguajes).
esclase(algoritmos).
esclase(redes1).
esclase(redes2).
esclase(contabilidad).
esclase(contabilidad_general). 
esclase(administracion).
esclase(administracion_general).
esclase(administracion2).

esclase_de(administracion,ing_sistemas).
esclase_de(redes1,ing_sistemas).
esclase_de(redes2,ing_sistemas).
esclase_de(algoritmos,ing_sistemas).
esclase_de(contabilidad,ing_sistemas).
esclase_de(poo,ing_sistemas).
esclase_de(administracion_general,ing_industrial).
esclase_de(administracion2,ing_industrial).
esclase_de(contabilidad_general,ing_industrial).
esclase_de(circuitos,ing_electrica).
esclase_de(variable_compleja,ing_electrica).
esclase_de(calculo3,ing_electrica).

:- dynamic alumno_estudia/2.
alumno_estudia(mario,ing_sistemas).
alumno_estudia(alvin,ing_sistemas).
alumno_estudia(maria,ing_electrica).
alumno_estudia(gissel,ing_industrial).

:- dynamic alumno_clase_nota/4.

alumno_clase_nota(alvin,administracion,65,apr).
alumno_clase_nota(alvin,poo,65,apr).
alumno_clase_nota(alvin,lenguajes,65,apr).
alumno_clase_nota(maria,circuitos,65,apr).
alumno_clase_nota(maria,variable_compleja,65,apr).
alumno_clase_nota(maria,calculo3,65,apr).
alumno_clase_nota(gissel,administracion_general,65,apr).
alumno_clase_nota(gissel,contabilidad_general,65,apr).
alumno_clase_nota(gissel,administracion2,65,apr).
alumno_clase_nota(mario,administracion,65,apr).
alumno_clase_nota(mario,lenguajes,70,apr).
alumno_clase_nota(mario,poo,80,apr).

:- dynamic alumno_notas/2.
alumno_notas(alvin,[65,65,65]).
alumno_notas(gissel,[65,65,65]).
alumno_notas(maria,[65,65,65]).
alumno_notas(mario,[65,70,80]).

%reglas-------------------------------------------------------------------------------------------------------------------
%aprobo si aprobo 
aprobo(X,Y):- esalumno(X),esclase(Y),alumno_clase_nota(X,Y,Z,_),Z>=65.

%calcular y mostrar el promedio
promedio(X,Q):- alumno_notas(X,B),length(B,T),suma(B,Z),write( promedio ),write(:),write(" "),Q is Z/T.


%assert y retract
insertarclasecursada(N,C,A,Obs):-assert(alumno_clase_nota(A,C,N,Obs)),alumno_notas(A,X),append(X,[N],P),retract(alumno_notas(A,X)),assert(alumno_notas(A,P)).

eliminarclasecursada(A,C):- alumno_clase_nota(A,C,N,_),alumno_notas(A,L),eliminar_elemento(N,L,P),retract(alumno_notas(A,_)),assert(alumno_notas(A,P)),retract(alumno_clase_nota(A,C,_,_)).

insertaralumno(M,C):- assert(esalumno(M)),assert(alumno_estudia(M,C)).
eliminaralumno(M):-retract(esalumno(M)),retractall(alumno_estudia(M,_)).

%sumar_los_elementos_de_una_lista
suma([],0):-!.
suma([X],X):-!.
suma([X|L],Sum):-suma(L,Sum1),Sum is X+Sum1.

%eliminar un elemento de una lista
eliminar_elemento(X, [X|Xs], Xs). 
eliminar_elemento(X, [Y|Ys], [Y|Zs]):- eliminar_elemento(X, Ys, Zs).


/*Tareas a probar

Tareas pedidas y respectiva consulta para ser ejecutada.

 
#lista de alumnos por carrera:   
?- alumno_estudia(X,carrera). 
Donde X es una variable y "carrera" es el nombre de la carrera. 
ejemplo: 
?- alumno_estudia(X,ing_sistemas).
    
#lista de clases que imparte cada carrera:
?- esclase_de(X,carrera).
Donde X es una variable y "carrera" es el nombre de la carrera. 
ejemplo: 
?- esclase_de(X,ing_sistemas).

#Regla para conocer si un alumno aprobo o no:
aprobo(X,Y):- esalumno(X),esclase(Y),alumno_clase_nota(X,Y,Z,_),Z>=65.
Donde X es el nombre del alumno y Y es el nombre de la clase a verificar
ejemplo:
?-aprobo(alvin,poo).
*/
%#Regla para conocer el promedio de un alumno
%promedio(X,Q):- alumno_notas(X,B),length(B,T),suma(B,Z),write( promedio ),write(:),write(" "),Q is Z/T.
%Donde X es el nombre del alumno y Q una variable donde se almacenara el promedio
%ejemplo:
% ?-promedio(alvin,Q).
/*
#lista de alumnos por clase y promedio
?- alumno_clase_nota(A,clase,P,_).
donde clase es el nombre de la clase 
ejemplo:
?-alumno_clase_nota(A,lenguajes,P,_).

#lista de alumnos por clase y promedio y una observacion de aprobado o reprobado
?- alumno_clase_nota(A,clase,P,I).
donde A,P,I son variables y "clase" es el nombre de la clase 
ejemplo:
?-alumno_clase_nota(A,lenguajes,P,I).

#insertar alumno
insertaralumno(M,C):- assert(esalumno(M)),assert(alumno_estudia(M,C)).
Donde M es el nombre del alumno y C es la carrera que alumno_estudia
ejemplo:
?-insertaralumno(josue,ing_sistemas).

#eliminar alumno
eliminaralumno(M):-retract(esalumno(M)),retractall(alumno_estudia(M,_)).
Donde M es el nombre del alumno a eliminar
ejemplo:
?-eliminaralumno(alvin).

#insertar clase cursada
insertarclasecursada(N,C,A,Obs):-assert(alumno_clase_nota(A,C,N,Obs)),alumno_notas(A,X),append(X,[N],P),retract(alumno_notas(A,X)),assert(alumno_notas(A,P)).

Donde N es la nota de la clase, C el nombre de la clase, A el nombre del alumno y Obs una observacion de si aprobo o reprobo
ejemplo:
?-insertarclasecursada(90,inteligencia,alvin,apr).

#eliminar clase cursada
eliminarclasecursada(A,C):- alumno_clase_nota(A,C,N,_),alumno_notas(A,L),eliminar_elemento(N,L,P),retract(alumno_notas(A,_)),assert(alumno_notas(A,P)),retract(alumno_clase_nota(A,C,_,_)).

Donde A es el nombre del alumno y C el nombre de la clase.
ejemplo:
?-eliminarclasecursada(alvin,poo).


*/

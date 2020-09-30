% Hechos y reglas
:- nl,nl,write('Digite \'crear.\' para agregar una materia y las notas registradas para su posterior analisis. '), nl,nl,nl,
 write('Digite \'imprimir.\' para ver una lista de las materias y notas ingresadas'), nl,nl,nl,
 write('Digite \'iniciar.\' para ver las materias ingresadas y el analisis de su rendimiento '), nl,nl,nl,
 write('Digite \'reiniciar.\' para reiniciar los valores de las respuestas otorgadas'), nl,nl,nl.


iniciar:- imprimir, nl, nl, write('Promedio:'), promedio(P), write(P), nl, nl,
    rendimiento(X),
    write('De acuerdo a la informacion ingresada el rendimiento es: '),
    write(X),
    nl.

reiniciar:-undo.

rendimiento(bajo):- bajo.
rendimiento(medio):- medio.
rendimiento(alto):- alto.


bajo:- promedio(P), P<float(3.5).
medio:- promedio(P), P>=float(3.5), P<float(4).
alto:- promedio(P), P>=float(4), P=<float(5).

:-dynamic materia/1.

crear:-
 write('Ingrese el nombre de la materia '), read(Materia), nl,
 write('Ingrese el numero de creditos '),  read(Creditos), nl,
 write('Ingrese la nota del primer corte '),  read(PC), nl,
 write('Ingrese la nota del segundo corte '), read(SC), nl,
 write('Ingrese lanota del corte final '), read(CF), nl,
 assert(materia(Materia,Creditos,Prom):- Prom is (PC*float(0.35)+SC*float(0.35)+CF*float(0.30))*Creditos).

printlistBi([]).

    printlistBi([X|List]) :-
        printlistUni(X), nl,
        printlistBi(List).

printlistUni([]).

printlistUni([X|List]) :-
        write(X), tab(6),
        printlistUni(List).


imprimir:- write('Materia, Creditos, Promedio'), nl, nl, findall([X,C,P],materia(X,C,P),R), printlistBi(R).

promedio(Promedio):-
    (yes(Promedio)->true ;(no(Promedio)->fail ;
    findall(P,materia(_,_,P),Proms), findall(C,materia(_,C,_),Creds),  sum_list(Proms, SumaP), sum_list(Creds, SumaC),
    Promedio is SumaP/SumaC,
    assert(yes(Promedio)))).

:- dynamic yes/1,no/1.


undo :- retract(yes(_)),fail.
undo :- retract(no(_)),fail.
undo :- retract(materia(_)),fail.
undo.

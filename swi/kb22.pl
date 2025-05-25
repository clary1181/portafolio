max_of_two(X, Y, X) :- X >= Y.
max_of_two(X, Y, Y) :- X < Y.

list_max_elem([X], X). % Caso base: el máximo de una lista con un elemento es ese elemento
list_max_elem([X,Y|Rest], Max) :-
    list_max_elem([Y|Rest], MaxRest), % Obtiene el máximo del resto de la lista
    max_of_two(X, MaxRest, Max).     % Compara el primer elemento con el máximo del resto


min_of_two(X, Y, X) :- X =< Y.
min_of_two(X, Y, Y) :- X > Y.

list_min_elem([X], X).
list_min_elem([X,Y|Rest], Min) :-
    list_min_elem([Y|Rest], MinRest),
    min_of_two(X, MinRest, Min).
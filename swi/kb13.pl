list_member(X, [X|_]).            % Caso base: X es la cabeza de la lista
list_member(X, [_|Tail]) :-      % Caso recursivo: X no es la cabeza, buscar en la cola
    list_member(X, Tail).
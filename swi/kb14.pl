list_length([], 0).              % Caso base: la longitud de una lista vacía es 0
list_length([_|Tail], N) :-      % Caso recursivo: la longitud es 1 + la longitud de la cola
    list_length(Tail, N1),
    N is N1 + 1.
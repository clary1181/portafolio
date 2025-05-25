% hanoi(N, Origen, Destino, Auxiliar)
hanoi(1, Origen, Destino, _) :-
    write('Mover disco 1 de '), write(Origen), write(' a '), write(Destino), nl.

hanoi(N, Origen, Destino, Auxiliar) :-
    N > 1,
    M is N - 1,
    % 1. Mover N-1 discos de Origen a Auxiliar, usando Destino como auxiliar
    hanoi(M, Origen, Auxiliar, Destino),
    % 2. Mover el disco N (el más grande) de Origen a Destino
    write('Mover disco '), write(N), write(' de '), write(Origen), write(' a '), write(Destino), nl,
    % 3. Mover N-1 discos de Auxiliar a Destino, usando Origen como auxiliar
    hanoi(M, Auxiliar, Destino, Origen).
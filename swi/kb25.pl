% Representación de un nodo: nodo(Valor, SiguienteNodo)
% 'null' representa el final de la lista.

% Definición de una lista enlazada de ejemplo:
% head_node(node(10, node(20, node(30, null)))).
mi_lista_enlazada(node(10, node(20, node(30, null)))).

% Predicado para recorrer e imprimir los valores de una lista enlazada
recorrer_lista_enlazada(null).
recorrer_lista_enlazada(node(Valor, Siguiente)) :-
    write(Valor), write(' '),
    recorrer_lista_enlazada(Siguiente).

% Predicado para agregar un elemento al final de la lista enlazada (recursivo)
agregar_final(Elemento, null, node(Elemento, null)). % Caso base: lista vacía
agregar_final(Elemento, node(Valor, Siguiente), node(Valor, NuevaSiguiente)) :-
    agregar_final(Elemento, Siguiente, NuevaSiguiente).

% Predicado para encontrar un elemento en la lista enlazada
buscar_en_lista_enlazada(Elemento, node(Elemento, _)). % Caso base: elemento en el nodo actual
buscar_en_lista_enlazada(Elemento, node(_, Siguiente)) :-
    buscar_en_lista_enlazada(Elemento, Siguiente).
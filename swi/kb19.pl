% Representación de un árbol:
% empty - árbol vacío
% node(Value, LeftSubtree, RightSubtree) - un nodo con un valor y dos subárboles

% Definición de un árbol de ejemplo:
%       10
%      /  \
%     5    15
%    / \  / \
%   2  7 12 18
tree_example(
    node(10,
        node(5,
            node(2, empty, empty),
            node(7, empty, empty)
        ),
        node(15,
            node(12, empty, empty),
            node(18, empty, empty)
        )
    )
).

% Recorrido In-Order (izquierda, raíz, derecha)
inorder_traversal(empty).
inorder_traversal(node(Value, Left, Right)) :-
    inorder_traversal(Left),
    write(Value), write(' '),
    inorder_traversal(Right).

% Recorrido Pre-Order (raíz, izquierda, derecha)
preorder_traversal(empty).
preorder_traversal(node(Value, Left, Right)) :-
    write(Value), write(' '),
    preorder_traversal(Left),
    preorder_traversal(Right).

% Recorrido Post-Order (izquierda, derecha, raíz)
postorder_traversal(empty).
postorder_traversal(node(Value, Left, Right)) :-
    postorder_traversal(Left),
    postorder_traversal(Right),
    write(Value), write(' ').

% Buscar un elemento en el árbol
search_tree(Value, node(Value, _, _)). % Caso base: el valor está en la raíz
search_tree(Value, node(RootValue, Left, _)) :-
    Value < RootValue,                     % Si el valor es menor, buscar en el subárbol izquierdo
    search_tree(Value, Left).
search_tree(Value, node(RootValue, _, Right)) :-
    Value > RootValue,                     % Si el valor es mayor, buscar en el subárbol derecho
    search_tree(Value, Right).
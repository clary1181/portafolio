# PRÁCTICA 4: PARADIGMA LÓGICO
<br>

**EL PARADIGMA LÓGICO**

El paradigma lógico se basa en una base de conocimiento que interactúa con una máquina para responder preguntas. A diferencia de la programación funcional, que se centra en procedimientos, la programación lógica se enfoca en el "qué" se sabe, no en el "cómo" se calcula.

Prolog (Programming in Logic) es un lenguaje de programación declarativo que permite expresar la lógica computacional en términos de hechos y reglas.<br><br>


**HECHOS**

Los hechos representan afirmaciones verdaderas sobre el mundo. En Prolog, siguen una sintaxis específica:
* Los nombres de propiedades/relaciones comienzan con minúsculas.
* El nombre de la relación es el primer término.
* Los objetos aparecen como argumentos separados por comas y entre paréntesis.
* Un punto "." debe terminar un hecho.
* Los objetos también pueden comenzar con dígitos o ser cadenas de caracteres entre comillas.
* Un hecho también se denomina predicado o cláusula.<br><br>

Sintaxis de Hechos: relation(object1, object2...)

Ejemplos de Hechos en Prolog:
* cat(tom). (Tom es un gato) 
* loves_to_eat(jorge, pasta). (A Jorge le encanta comer pasta) 
* of_color(hair, black). (Tiene el pelo negro) 
* loves_to_play_games(paty). (A Paty le encanta jugar) 
* lazy(juan). (Juan es perezoso)
<br><br><br>

**REGLAS**

Las reglas definen relaciones condicionales, estableciendo que algo es cierto si una o más condiciones son ciertas.

Sintaxis de Reglas: rule_name(object1, object2, ...) :- fact/rule(object1, object2, ...) 

Las conjunciones se representan con una coma (,) y las disyunciones con un punto y coma (;).

Ejemplos de Reglas en Prolog:

* happy(lili) :- dances(lili). (Lili se alegra si baila) 
* hungry(tom) :- search_for_food(tom). (Tom tiene hambre si busca comida) 
* friends(jack, bili) :- lovesCricket(jack), lovesCricket(bili). (Jack y Bili son amigos si a ambos les encanta jugar al críquet) 
* goToPlay(ryan) :- isClosed(school), free(ryan). (Irá a jugar si la escuela está cerrada y él está libre) <br><br>


**CONSULTAS**

Las consultas permiten interrogar la base de conocimiento para verificar si ciertos hechos o reglas son verdaderos.

Ejemplos de Consultas:

* ¿Es Tom un gato? 
* ¿A Juan le encanta la pasta? 
* ¿Está feliz Lili? 
* ¿Irá Ryan a jugar? <br><br>

**BASES DE CONOCIMIENTO EN PROLOG**

Una base de conocimiento en Prolog es un conjunto de hechos y reglas.

```prolog
girl(priya).
girl(natasha).
girl(jasmin).
can_cook(priya).
```

```prolog
sing_a_song(ana).
listens_to_music(rodrigo).
listens_to_music(ana) :- sing_a_song(ana).
happy(ana) :- sing_a_song(ana).
happy(rodrigo) :- listens_to_music(rodrigo).
plays_guitar(rodrigo) :- listens_to_music(rodrigo).
```

```prolog
can_cook(priya).
can_cook(jasmin).
can_cook(timoteo).
likes(priya,jasmin) :- can_cook(jasmin).
likes(priya,timoteo) :- can_cook(timoteo).
```
 <br><br>

 
**RELACIONES EN PROLOG**

Prolog se utiliza para especificar las relaciones entre objetos y sus propiedades. Las relaciones pueden ser explícitamente definidas como hechos o inferidas a través de reglas.

```prolog
parent(simon, pedro).
parent(simon, raj).
male(pedro).
male(raj).
brother(X,Y) :- parent(Z,X), parent(Z,Y), male(X), male(Y).
```

```prolog
female(pam). female(liz). female(pat). female(ann). male(jim). male(bob). male(tom). male(pete).
parent(pam,bob). parent(tom,bob). parent(tom,liz). parent(bob,ann). parent(bob,pat). parent(pat,jim). parent(pete,jim).

mother(X,Y):- parent(X,Y), female(X).
father(X,Y):- parent(X,Y), male(X).
haschild(X):- parent(X,_).
sister(X,Y):- parent(Z,X), parent(Z,Y), female(X), X \== Y.
brother(X,Y):- parent(Z,X), parent(Z,Y), male(X), X \== Y.

grandparent(X,Y):-parent(X,Z),parent(Z,Y).
grandmother(X,Z):-mother(X,Y),parent(Y,Z).
grandfather(X,Z):-father(X,Y),parent(Y,Z).
wife(X,Y):-parent(X,Z),parent(Y,Z),female(X),male(Y).
uncle(X,Z):-brother(X,Y),parent(Y,Z).
```

<br><br>
 
 
**RECURSIÓN EN LAS RELACIONES FAMILIARES**

La recursión es fundamental en Prolog para definir relaciones que pueden tener múltiples niveles, como la de "predecesor".

```prolog
female(pam). female(liz). female(pat). female(ann). male(jim). male(bob). male(tom). male(pete).
parent(pam,bob). parent(tom,bob). parent(tom,liz). parent(bob,ann). parent(bob,pat). parent(pat,jim). parent(pete,jim).

mother(X,Y):- parent(X,Y), female(X).
father(X,Y):- parent(X,Y), male(X).
haschild(X):- parent(X,_).
sister(X,Y):- parent(Z,X), parent(Z,Y), female(X), X \== Y.
brother(X,Y):- parent(Z,X), parent(Z,Y), male(X), X \== Y.

grandparent(X,Y):-parent(X,Z),parent(Z,Y).
grandmother(X,Z):-mother(X,Y),parent(Y,Z).
grandfather(X,Z):-father(X,Y),parent(Y,Z).
wife(X,Y):-parent(X,Z),parent(Y,Z),female(X),male(Y).
uncle(X,Z):-brother(X,Y),parent(Y,Z).

predecessor(X, Z) :- parent(X, Z).
predecessor(X, Z) :- parent(X, Y),predecessor(Y, Z).
```

<br><br>

 
**OBJETOS DE DATOS EN PROLOG**

Los objetos de datos en Prolog se clasifican en objetos simples (constantes y variables) y estructuras.

Ejemplos de Objetos de Datos (Términos) 
* Átomos: tom, pat, x100, x_45
* Cadenas especiales: :-, =======>, ..., .:., ::=
* Cadenas de caracteres: 'Rubai', 'Hello, World!'
* Números: 100, 1235, 2000.45
* Variables: X, Y, Xval, _X
* Estructuras: día(9, jun, 2017), punto(10, 25)

```prolog
hates(jim,tom).
hates(pat,bob).
hates(dog,fox).
hates(peter,tom).
```

<br><br>

 
**OPERADORES EN PROLOG**

Prolog soporta operadores de comparación y aritméticos.

Operadores de Comparación 
* X > Y: X es mayor que Y
* X < Y: X es menor que Y
* X >= Y: X es mayor o igual que Y
* X =< Y: X es menor o igual que Y
* X =:= Y: Los valores X e Y son iguales
* X =\= Y: Los valores X e Y no son iguales<br><br>

Operadores Aritméticos 
* +: Suma
* -: Resta
* *: Multiplicación
* /: División
* **: Potencia
* //: División de enteros
* mod: Módulo

```prolog
calc :- X is 100 + 200,write('100 + 200 is '),write(X),nl,
Y is 400 - 150,write('400 - 150 is '),write(Y),nl,
Z is 10 * 300,write('10 * 300 is '),write(Z),nl,
A is 100 / 30,write('100 / 30 is '),write(A),nl,
B is 100 // 30,write('100 // 30 is '),write(B),nl,
C is 100 ** 2,write('100 ** 2 is '),write(C),nl,
D is 100 mod 30,write('100 mod 30 is '),write(D),nl.
```

<br><br>


**BUCLES Y RANGOS EN PROLOG**

Prolog utiliza la recursión para simular bucles.

Bucles

```prolog
count_to_10(10) :- write(10),nl.
count_to_10(X) :- write(X),nl, Y is X + 1, count_to_10(Y).
```

Rango con Bucles

```prolog
count_down(L,H) :- between(L,H,Y), Z is H-Y, write(Z), nl.
count_up(L,H) :- between(L,H,Y), Z is L+Y, write(Z), nl.
```
<br><br>

**TOMA DE DECISIONES EN PROLOG**

Las reglas en Prolog actúan como estructuras de toma de decisiones.


```prolog
% If-Then-Else statement
gt(X,Y) :- X >= Y,write('X is greater or equal').
gt(X,Y) :- X < Y,write('X is smaller').

% If-Elif-Else statement
gte(X,Y) :- X > Y,write('X is greater').
gte(X,Y) :- X =:= Y,write('X and Y are same').
gte(X,Y) :- X < Y,write('X is smaller').
```
<br><br>


**CONJUNCIONES Y DISYUNCIONES EN PROLOG**

Se utilizan para combinar condiciones en las reglas.

```prolog
parent(jhon,bob).
parent(lili,bob).
male(jhon).
female(lili).

% Conjunction Logic
father(X,Y) :- parent(X,Y),male(X).
mother(X,Y) :- parent(X,Y),female(X).

% Disjunction Logic
child_of(X,Y) :- father(X,Y);mother(X,Y).
```
<br><br>


**LISTAS EN PROLOG**

Las listas son estructuras de datos fundamentales en Prolog.

Representación de Listas 
Las listas se representan como [rojo, verde, azul, blanco, oscuro]. Se dividen en una Head (primer elemento) y una Tail (el resto de la lista).
Ejemplo: [a, b, c] se puede representar como [a | [b, c]].


Operaciones Básicas en Listas 
* Comprobación de membresía: Verifica si un elemento pertenece a la lista.
* Cálculo de longitud: Encuentra el número de elementos en una lista.
* Concatenación: Une dos listas.<br><br>

Operaciones con Listas
* Eliminar elementos: Remueve un elemento específico de una lista.
* Añadir elementos: Agrega una lista a otra como un elemento.
* Insertar elementos: Inserta un elemento en una lista.

```prolog
list_member(X,[X|_]).
list_member(X,[_|TAIL]) :- list_member(X,TAIL).

list_length([],0).
list_length([_|TAIL],N) :- list_length(TAIL,N1), N is N1 + 1.

list_concat([],L,L).
list_concat([X1|L1],L2,[X1|L3]) :- list_concat(L1,L2,L3).

list_append(A,T,T) :- list_member(A,T),!.
list_append(A,T,[A|T]).

list_delete(X, [X], []).
list_delete(X,[X|L1], L1).
list_delete(X, [Y|L2], [Y|L1]) :- list_delete(X,L2,L1).

list_insert(X,L,R) :- list_delete(X,R,L).
```
<br><br>
Operaciones de Reposicionamiento de Elementos
* Permutación: Genera todas las posibles reordenaciones de los elementos de una lista.
* Elementos inversos: Ordena los elementos de una lista en orden inverso.
* Elementos desplazados: Desplaza un elemento de una lista rotacionalmente hacia la izquierda.
* Elementos ordenados: Verifica si una lista está ordenada

```prolog
list_delete(X,[X|L1], L1).
list_delete(X, [Y|L2], [Y|L1]) :- list_delete(X,L2,L1).

list_perm([],[]).
list_perm(L,[X|P]) :- list_delete(X,L,L1),list_perm(L1,P).

list_concat([],L,L).
list_concat([X1|L1],L2,[X1|L3]) :- list_concat(L1,L2,L3).

list_rev([],[]).
list_rev([Head|Tail],Reversed) :- list_rev(Tail, RevTail),list_concat(RevTail, [Head],Reversed).

list_shift([Head|Tail],Shifted) :- list_concat(Tail, [Head],Shifted).

list_order([X, Y | Tail]) :- X =< Y, list_order([Y|Tail]).
list_order([X]).

list_subset([],[]).
list_subset([Head|Tail],[Head|Subset]) :- list_subset(Tail,Subset).
list_subset([Head|Tail],Subset) :- list_subset(Tail,Subset).

list_member(X,[X|_]).
list_member(X,[_|TAIL]) :- list_member(X,TAIL).

list_union([X|Y],Z,W) :- list_member(X,Z),list_union(Y,Z,W).
list_union([X|Y],Z,[X|W]) :- \+ list_member(X,Z), list_union(Y,Z,W).
list_union([],Z,Z).

list_intersect([X|Y],Z,[X|W]) :- list_member(X,Z), list_intersect(Y,Z,W).
list_intersect([X|Y],Z,W) :- \+ list_member(X,Z), list_intersect(Y,Z,W).
list_intersect([],Z,[]).
```
<br><br>

Otras Operaciones en Listas 

```prolog
list_even_len([]).
list_even_len([Head|Tail]) :- list_odd_len(Tail).

list_odd_len([_]).
list_odd_len([Head|Tail]) :- list_even_len(Tail).

list_divide([],[],[]).
list_divide([X],[X],[]).
list_divide([X,Y|Tail], [X|List1],[Y|List2]) :- list_divide(Tail,List1,List2).

max_of_two(X,Y,X) :- X >= Y.
max_of_two(X,Y,Y) :- X < Y.

list_max_elem([X],X).
list_max_elem([X,Y|Rest],Max) :- list_max_elem([Y|Rest],MaxRest), max_of_two(X,MaxRest,Max).

list_sum([],0).
list_sum([Head|Tail], Sum) :- list_sum(Tail,SumTemp), Sum is Head + SumTemp.
```
<br><br>

**ENTRADAS Y SALIDAS EN PROLOG**

Prolog permite manejar la entrada y salida, incluyendo la manipulación de archivos y caracteres.
<br><br>

**PREDICADOS INTEGRADOS**
Prolog ofrece una serie de predicados incorporados para verificar el tipo de una variable o término.

Predicados Integrados 
* var(X): Verdadero si X es una variable no instanciada.
* novar(X): Verdadero si X no es una variable o está instanciada.
* atom(X): Verdadero si X es un átomo.
* number(X): Verdadero si X es un número entero o real.
* integer(X): Verdadero si X es un entero.
* float(X): Verdadero si X es un número real.
* atomic(X): Verdadero si X es un número o un átomo.
* compound(X): Verdadero si X es un término compuesto.
* ground(X): Verdadero si X no contiene ninguna variable no instanciada.<br><br>

**PREDICADOS MATEMÁTICOS**
Prolog incluye predicados para operaciones matemáticas.

Predicados Matemáticos 
* random(L,H,X): Obtiene un valor aleatorio entre L y H.
* between(L,H,X): Obtiene una lista de valores entre L y H.
* succ(X,Y): Suma 1 a Y y lo asigna a X.
* abs(X): Obtiene el valor absoluto de X.
* max(X,Y): Obtiene el mayor entre X e Y.
* min(X,Y): Obtiene el menor entre X e Y.
* round(X): Redondea al valor más cercano a X.
* truncate(X): Convierte un número real a entero, eliminando la fracción.
* floor(X): Redondea hacia abajo.
* ceiling(X): Redondea hacia arriba.
* sqrt(X): Raíz cuadrada de X.<br><br>

**ESTRUCTURAS DE DATOS Y RECURSIÓN**

En Prolog, las estructuras de datos suelen representarse mediante términos compuestos (funciones con argumentos) o, más comúnmente, mediante listas. La recursión es la piedra angular de la programación en Prolog, ya que no existen bucles tradicionales (for, while). En su lugar, se definen reglas que se llaman a sí mismas, con una o más cláusulas base que detienen la recursión. Esta forma de pensar recursiva es fundamental para procesar estructuras de datos.

Listas: Membresía de una lista
```prolog
list_member(X, [X|_]).            % Caso base: X es la cabeza de la lista
list_member(X, [_|Tail]) :-      % Caso recursivo: X no es la cabeza, buscar en la cola
    list_member(X, Tail).
```

Listas: Longitud de una lista 
```prolog
list_length([], 0).              % Caso base: la longitud de una lista vacía es 0
list_length([_|Tail], N) :-      % Caso recursivo: la longitud es 1 + la longitud de la cola
    list_length(Tail, N1),
    N is N1 + 1.
```

Recursión en relaciones familiares (Predecesor):
```prolog
% Hechos base (padres)
parent(pam, bob).
parent(tom, bob).
parent(tom, liz).
parent(bob, ann).
parent(bob, pat).
parent(pat, jim).
parent(pete, jim).

% Regla: X es predecesor de Z si X es padre de Z (caso base)
predecessor(X, Z) :- parent(X, Z).

% Regla: X es predecesor de Z si X es padre de Y, y Y es predecesor de Z (caso recursivo)
predecessor(X, Z) :- parent(X, Y), predecessor(Y, Z).
```
<br><br>

**BACKTRACKING**

El backtracking es el mecanismo fundamental de ejecución de Prolog. Cuando Prolog intenta satisfacer una meta, busca una cláusula que la satisfaga. Si hay múltiples cláusulas o si una cláusula tiene múltiples sub-metas, Prolog las intenta una por una. Si una sub-meta falla, Prolog "retrocede" (backtracks) a la última elección y prueba una alternativa. Esto le permite encontrar todas las posibles soluciones para una consulta.

```prolog
% Parte relevante de family.pl
female(pam). female(liz). female(pat). female(ann).
male(jim). male(bob). male(tom). male(pete).

parent(pam,bob). parent(tom,bob).
parent(tom,liz).
parent(bob,ann). parent(bob,pat).
parent(pat,jim). parent(pete,jim).

% Regla brother(X,Y): X es hermano de Y si tienen el mismo padre Z, X es hombre y X no es Y
brother(X,Y):- parent(Z,X), parent(Z,Y), male(X), X \== Y.
```
<br><br>


**DIFERENTE Y NO**

* Diferente (\== o dif): Se utiliza para expresar que dos términos no son idénticos (no son el mismo término o no unifican).

  * X \== Y: Falla si X e Y están unificados al mismo término (incluso si son variables instanciadas al mismo valor). Es un chequeo de identidad.
  * dif(X, Y): Es un predicado más potente de diferencia real. Tiene un comportamiento declarativo: dif(X,Y) significa que X e Y deben ser diferentes. Si en algún momento de la ejecución se vuelven idénticos, dif/2 falla. Si permanecen como variables no instanciadas pero dif/2 se mantiene, se añade una restricción de diferencia entre ellas.

* Negación por Fallo (\+): Se utiliza para expresar que una meta no es demostrable (no es verdadera). Si la meta a la que se aplica \+ falla, entonces \+ Goal tiene éxito. Si Goal tiene éxito, entonces \+ Goal falla. Es importante entender que esto es "negación por fallo" (Closed World Assumption), no una negación lógica estricta. Si algo no puede ser probado, se asume que es falso.

Diferente (\==)
```prolog
% En el contexto de la regla brother
brother(X,Y):- parent(Z,X), parent(Z,Y), male(X), X \== Y.
```

Negación por Fallo (\+)
```prolog
% Base de conocimiento simple
estudiante(juan).
estudiante(maria).
profesor(pedro).

% Regla: alguien que no es estudiante
no_estudiante(X) :- \+ estudiante(X).

% Regla: alguien que no es profesor Y no es estudiante (falla)
no_profesor_y_no_estudiante(X) :- \+ profesor(X), \+ estudiante(X).
```
<br><br>


**ESTUDIO DE CASO: ÁRBOL**

Los árboles son estructuras de datos jerárquicas fundamentales en informática. En Prolog, se modelan de forma natural usando términos compuestos y recursión. Un nodo puede representarse como un término node(Value, LeftChild, RightChild), y la ausencia de un hijo como empty.


```prolog
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
```
<br><br>


**PROGRAMAS BÁSICOS**

Los "programas básicos" en Prolog se refieren a la implementación de funcionalidades comunes y problemas algorítmicos simples utilizando la lógica declarativa y la recursión.

* Factorial:
    ```prolog
    factorial(0, 1).                 % Caso base: el factorial de 0 es 1
    factorial(N, Result) :-
        N > 0,                     % N debe ser mayor que 0
        N1 is N - 1,               % Calcula N-1
        factorial(N1, Result1),    % Llama recursivamente para factorial(N-1)
        Result is N * Result1.     % Multiplica N por el resultado de factorial (N-1)
    ```
<br>

* Fibonacci:
    ```prolog
    fibonacci(0, 0).                 % Caso base: Fibonacci de 0 es 0
    fibonacci(1, 1).                 % Caso base: Fibonacci de 1 es 1
    fibonacci(N, Result) :-
        N > 1,
        N1 is N - 1,
        N2 is N - 2,
        fibonacci(N1, Result1),      % Llama recursivamente para F(N-1)
        fibonacci(N2, Result2),      % Llama recursivamente para F(N-2)
        Result is Result1 + Result2. % Suma los resultados
    ```
<br>

* Mínimo y Máximo:

    Encontrar el mínimo o máximo de un conjunto de elementos es una operación   común. En Prolog, se realiza a menudo mediante recursión, comparando  elementos uno a uno.<br>

    Máximo de dos números:
    ```prolog
    max_of_two(X, Y, X) :- X >= Y.
    max_of_two(X, Y, Y) :- X < Y.
    ```
    Máximo elemento de una lista:
    ```prolog
    list_max_elem([X], X). % Caso base: el máximo de una lista con un elemento es ese elemento
    list_max_elem([X,Y|Rest], Max) :-
        list_max_elem([Y|Rest], MaxRest), % Obtiene el máximo del resto de la   lista
        max_of_two(X, MaxRest, Max).     % Compara el primer elemento con el    máximo del resto
    ```
    Mínimo elemento de una lista
     ```prolog
    min_of_two(X, Y, X) :- X =< Y.
    min_of_two(X, Y, Y) :- X > Y.

    list_min_elem([X], X).
    list_min_elem([X,Y|Rest], Min) :-
        list_min_elem([Y|Rest], MinRest),
        min_of_two(X, MinRest, Min).
    ```
<br>

* Circuitos Resistivos:

    Modelar circuitos resistivos en Prolog implica definir cómo se conectan los resistores y cómo se calcula su resistencia equivalente. Se pueden definir reglas para conexiones en serie y en paralelo.
    ```prolog
    % Hechos que definen resistores y sus valores
    resistor(r1, 10). % Resistor r1 tiene 10 Ohms
    resistor(r2, 20).
    resistor(r3, 5).
    resistor(r4, 15).

    % Resistencia en serie
    resistencia_serie([], 0). % La resistencia de una conexión en serie vacía es 0
    resistencia_serie([R|Resto], Total) :-
        resistor(R, ValorR),               % Obtiene el valor del resistor actual
        resistencia_serie(Resto, TotalResto), % Calcula la resistencia del resto    en serie
        Total is ValorR + TotalResto.      % Suma para obtener el total

    % Resistencia en paralelo (para dos resistores)
    % Para más de dos, se necesitaría una regla recursiva o un acumulador.
    resistencia_paralelo(R1, R2, Total) :-
        resistor(R1, Val1),
        resistor(R2, Val2),
        Total is (Val1 * Val2) / (Val1 + Val2).

    % Resistencia en paralelo para una lista de resistores (más general)
    % Esta versión maneja el inverso de la suma de inversos.
    % Requiere un predicado auxiliar para sumar inversos
    sum_inverses([], 0).
    sum_inverses([R|Resto], Sum) :-
        resistor(R, Val),
        SumResto is 1/Val,
        sum_inverses(Resto, SumRestoTotal),
        Sum is SumResto + SumRestoTotal.

    resistencia_paralelo_lista(List, Total) :-
        sum_inverses(List, InverseSum),
        Total is 1 / InverseSum.
    ```
<br>


* Torre de Hanoi:

    Un problema clásico de recursión que consiste en mover una pila de discos de un poste de origen a un poste de destino, utilizando un poste auxiliar, siguiendo tres reglas:

    * Solo se puede mover un disco a la vez.
    * Un disco más grande no puede colocarse encima de uno más pequeño.
    * Cada disco debe estar en uno de los tres postes.
  
    ```prolog
    % hanoi(N, Origen, Destino, Auxiliar)
    hanoi(1, Origen, Destino, _) :-
        write('Mover disco 1 de '), write(Origen), write(' a '), write(Destino),    nl.

    hanoi(N, Origen, Destino, Auxiliar) :-
        N > 1,
        M is N - 1,
        % 1. Mover N-1 discos de Origen a Auxiliar, usando Destino como auxiliar
        hanoi(M, Origen, Auxiliar, Destino),
        % 2. Mover el disco N (el más grande) de Origen a Destino
        write('Mover disco '), write(N), write(' de '), write(Origen), write(' a    '), write(Destino), nl,
        % 3. Mover N-1 discos de Auxiliar a Destino, usando Origen como auxiliar
        hanoi(M, Auxiliar, Destino, Origen).
    ```
<br>

* Listas Enlazadas:

    Aunque Prolog tiene soporte nativo para listas, a veces es útil modelar listas enlazadas explícitamente para entender cómo se construyen y manipulan. Una lista enlazada consiste en nodos, donde cada nodo contiene un valor y una referencia (o "puntero" lógico) al siguiente nodo.

    ```prolog
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
    buscar_en_lista_enlazada(Elemento, node(Elemento, _)). % Caso base: elemento    en el nodo actual
    buscar_en_lista_enlazada(Elemento, node(_, Siguiente)) :-
        buscar_en_lista_enlazada(Elemento, Siguiente).
    ```
<br>

* El Mono y el Plátano:

    Este es un problema clásico en inteligencia artificial que ilustra la planificación y la búsqueda en un espacio de estados. El objetivo es que un mono, que está en una habitación con una caja y unos plátanos en el techo, alcance los plátanos. Las acciones del mono cambian el estado del mundo.

    *Modelo de Estado:*
    Podemos representar el estado del mundo con un término que contenga la  posición del mono, la posición de la caja, la posición de los plátanos y si el   mono tiene los plátanos.

    estado(PosMono, PosCaja, PosPlatanos, Tiene)

    * PosMono: en(lugar) o en(caja)
    * PosCaja: en(lugar)
    * PosPlatanos: en(lugar) o en(techo)
    * Tiene: nada o platanos

    ```prolog
    % Estado inicial: mono en el suelo en la puerta, caja en la ventana, plátanos   en el techo, mono no tiene nada.
    initial_state(estado(en(mono, puerta), en(caja, ventana), en(platanos, techo),  tiene(mono, nada))).

    % Estado objetivo: mono tiene los plátanos
    goal_state(estado(_, _, _, tiene(mono, platanos))).

    % Acciones y cómo cambian el estado:

    % 1. El mono camina de un lugar a otro en el suelo.
    %    walk(Desde, Hasta)
    action(estado(en(mono, From), PosCaja, PosPlatanos, Tiene),
           walk(From, To),
           estado(en(mono, To), PosCaja, PosPlatanos, Tiene)) :-
        From \== To.

    % 2. El mono empuja la caja de un lugar a otro.
    %    push(CajaDesde, CajaHasta, MonoDesde, MonoHasta)
    action(estado(en(mono, PosCaja), en(caja, PosCaja), PosPlatanos, Tiene),
           push(PosCaja, To),
           estado(en(mono, To), en(caja, To), PosPlatanos, Tiene)) :-
        % El mono debe estar en la misma posición que la caja para empujarla.
        true. % La condición ya está en la cabeza del predicado.

    % 3. El mono sube a la caja.
    %    climb_on_box(Lugar)
    action(estado(en(mono, Lugar), en(caja, Lugar), PosPlatanos, Tiene),
           climb_on_box(Lugar),
           estado(en(mono, en_caja), en(caja, Lugar), PosPlatanos, Tiene)).

    % 4. El mono coge los plátanos (solo si está en la caja y los plátanos están    en el techo)
    %    grab_bananas()
    action(estado(en(mono, en_caja), en(caja, PosCaja), en(platanos, techo), tiene  (mono, nada)),
           grab_bananas,
           estado(en(mono, en_caja), en(caja, PosCaja), en(platanos, techo), tiene  (mono, platanos))).

    % Predicado para encontrar un camino (solución)
    % solve(EstadoActual, ListaDeAccionesInvertida, EstadoObjetivo)
    solve(Goal, Path, Goal) :- reverse(Path, ReversedPath), write('Solucion: '),    write(ReversedPath), nl.
    solve(CurrentState, Path, Goal) :-
        action(CurrentState, Action, NextState),
        \+ member(NextState, Path), % Evitar bucles, no visitar estados ya  visitados (simple, para ejemplos pequeños)
        solve(NextState, [Action|Path], Goal).
    ```
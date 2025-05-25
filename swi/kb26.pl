% Estado inicial: mono en el suelo en la puerta, caja en la ventana, plátanos en el techo, mono no tiene nada.
initial_state(estado(en(mono, puerta), en(caja, ventana), en(platanos, techo), tiene(mono, nada))).

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

% 4. El mono coge los plátanos (solo si está en la caja y los plátanos están en el techo)
%    grab_bananas()
action(estado(en(mono, en_caja), en(caja, PosCaja), en(platanos, techo), tiene(mono, nada)),
       grab_bananas,
       estado(en(mono, en_caja), en(caja, PosCaja), en(platanos, techo), tiene(mono, platanos))).

% Predicado para encontrar un camino (solución)
% solve(EstadoActual, ListaDeAccionesInvertida, EstadoObjetivo)
solve(Goal, Path, Goal) :- reverse(Path, ReversedPath), write('Solucion: '), write(ReversedPath), nl.
solve(CurrentState, Path, Goal) :-
    action(CurrentState, Action, NextState),
    \+ member(NextState, Path), % Evitar bucles, no visitar estados ya visitados (simple, para ejemplos pequeños)
    solve(NextState, [Action|Path], Goal).
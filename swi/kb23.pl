% Hechos que definen resistores y sus valores
resistor(r1, 10). % Resistor r1 tiene 10 Ohms
resistor(r2, 20).
resistor(r3, 5).
resistor(r4, 15).

% Resistencia en serie
resistencia_serie([], 0). % La resistencia de una conexión en serie vacía es 0
resistencia_serie([R|Resto], Total) :-
    resistor(R, ValorR),               % Obtiene el valor del resistor actual
    resistencia_serie(Resto, TotalResto), % Calcula la resistencia del resto en serie
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
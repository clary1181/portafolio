% Base de conocimiento simple
estudiante(juan).
estudiante(maria).
profesor(pedro).

% Regla: alguien que no es estudiante
no_estudiante(X) :- \+ estudiante(X).

% Regla: alguien que no es profesor Y no es estudiante (falla)
no_profesor_y_no_estudiante(X) :- \+ profesor(X), \+ estudiante(X).
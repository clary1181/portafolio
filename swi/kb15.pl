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
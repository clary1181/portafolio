% Parte relevante de family.pl
female(pam). female(liz). female(pat). female(ann).
male(jim). male(bob). male(tom). male(pete).

parent(pam,bob). parent(tom,bob).
parent(tom,liz).
parent(bob,ann). parent(bob,pat).
parent(pat,jim). parent(pete,jim).

% Regla brother(X,Y): X es hermano de Y si tienen el mismo padre Z, X es hombre y X no es Y
brother(X,Y):- parent(Z,X), parent(Z,Y), male(X), X \== Y.
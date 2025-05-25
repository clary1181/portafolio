famele(oam).
famele(liz).
famele(pat).
famele(ann).
male(jin).
male(bob).
male(tom).
mle(peter).
parent(pam, bob).
parent(tom, bob).
parent(tom, liz).
parent(bob, ann).
parent(bob, pat).
parent(pat, jin).
parent(bot, peter).
parent(peter, jin).


mother(X, Y)  :- parent(X, Y), famele(X).
father(X, Y) :- parent(X, Y), male(X).
haschild(X) :- parent(X, _).
sister(X, Y) :- parent(Z, X), parent(Z, Y), famele(X), X\==Y.
brother(X, Y) :- parent(Z, X), parent(Z, Y), male(X), X\==Y.

% ...

predecessor(X, Z) :- parent(X, Z).
predecessor(X, Z) :- parent(X, Y),predecessor(Y, Z).
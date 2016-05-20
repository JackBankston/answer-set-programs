% A sailor needs to get a wolf, a goat, and a cabbage across a river. His boat
% is too small to hold more than one of the three at once. The following program
% generates a plan for how he should transport the wolf, goat, and cabbage across
% the river, with the following two rules in mind:
%	- If the wolf and goat are left alone on one side of the river, the goat will be
%	  be eaten by the wolf.
%	- If the goat and cabbage are left alone on one side of the river, the cabbage will 
%     be eaten by the goat.

time(0..8).
ptime(0..7).

participant(wolf;goat;cabbage;sailor).
fluent(onFirstSide(X)) :- participant(X).
fluent(aloneTogether(X,Y)) :- participant(X), participant(Y), X!=Y.
action(travelAcross(X,Y)) :- participant(X), participant(Y).

initially(onFirstSide(wolf);onFirstSide(goat);onFirstSide(cabbage); onFirstSide(sailor)).
holds(F,0) :- initially(F), fluent(F).
nholds(F,0) :- fluent(F), not holds(F,0).

:- ptime(T), action(A), occurs(A,T), not exec(A,T).

1{occurs(A,T) : action(A)}1 :- ptime(T), T!=7.

exec(travelAcross(X,Y), T) :- participant(X), participant(Y), time(T), X=sailor, holds(onFirstSide(X), T), holds(onFirstSide(Y), T).
exec(travelAcross(X,Y), T) :- participant(X), participant(Y), time(T), X=sailor, nholds(onFirstSide(X), T), nholds(onFirstSide(Y), T).

%Encode the effects of the action travelAcross(X,Y).
holds(onFirstSide(X),T+1) :- participant(X), time(T), participant(Y), occurs(travelAcross(X,Y), T), nholds(onFirstSide(X), T). 
holds(onFirstSide(X),T+1) :- participant(X), time(T), participant(Y), occurs(travelAcross(Y,X), T), nholds(onFirstSide(X), T). 
nholds(onFirstSide(X),T+1) :- participant(X), time(T), participant(Y), occurs(travelAcross(X,Y), T), holds(onFirstSide(X), T). 
nholds(onFirstSide(X),T+1) :- participant(X), time(T), participant(Y), occurs(travelAcross(Y,X), T), holds(onFirstSide(X), T). 

%First aloneTogether(X,Y) cases:
holds(aloneTogether(X,Y), T+1) :- time(T), participant(X), participant(Y), participant(W), participant(Z), X!=Y, X!=W, X!=Z, Y!=W, Y!=Z, W!=Z, holds(onFirstSide(X),T), holds(onFirstSide(Y),T), holds(onFirstSide(W),T), holds(onFirstSide(Z), T), occurs(travelAcross(W,Z), T).
holds(aloneTogether(W,Z), T+1) :- time(T), participant(X), participant(Y), participant(W), participant(Z), X!=Y, X!=W, X!=Z, Y!=W, Y!=Z, W!=Z, holds(onFirstSide(X),T), holds(onFirstSide(Y),T), holds(onFirstSide(W),T), holds(onFirstSide(Z), T), occurs(travelAcross(W,Z), T).
holds(aloneTogether(Z,W), T+1) :- time(T), participant(X), participant(Y), participant(W), participant(Z), X!=Y, X!=W, X!=Z, Y!=W, Y!=Z, W!=Z, holds(onFirstSide(X),T), holds(onFirstSide(Y),T), holds(onFirstSide(W),T), holds(onFirstSide(Z), T), occurs(travelAcross(W,Z), T).
%Opposite of the above 3:
holds(aloneTogether(X,Y), T+1) :- time(T), participant(X), participant(Y), participant(W), participant(Z), X!=Y, X!=W, X!=Z, Y!=W, Y!=Z, W!=Z, nholds(onFirstSide(X),T), nholds(onFirstSide(Y),T), nholds(onFirstSide(W),T), nholds(onFirstSide(Z), T), occurs(travelAcross(W,Z), T).
holds(aloneTogether(W,Z), T+1) :- time(T), participant(X), participant(Y), participant(W), participant(Z), X!=Y, X!=W, X!=Z, Y!=W, Y!=Z, W!=Z, nholds(onFirstSide(X),T), nholds(onFirstSide(Y),T), nholds(onFirstSide(W),T), nholds(onFirstSide(Z), T), occurs(travelAcross(W,Z), T).
holds(aloneTogether(Z,W), T+1) :- time(T), participant(X), participant(Y), participant(W), participant(Z), X!=Y, X!=W, X!=Z, Y!=W, Y!=Z, W!=Z, nholds(onFirstSide(X),T), nholds(onFirstSide(Y),T), nholds(onFirstSide(W),T), nholds(onFirstSide(Z), T), occurs(travelAcross(W,Z), T).

%The other aloneTogether(X,Y) cases
holds(aloneTogether(X,Y), T+1) :- time(T), participant(X), participant(Y), participant(W), participant(Z), X!=Y, X!=W, X!=Z, Y!=W, Y!=Z, W!=Z, holds(onFirstSide(X),T), holds(onFirstSide(Y),T), holds(onFirstSide(W),T), nholds(onFirstSide(Z),T), occurs(travelAcross(W,W),T).
holds(aloneTogether(W,Z), T+1) :- time(T), participant(X), participant(Y), participant(W), participant(Z), X!=Y, X!=W, X!=Z, Y!=W, Y!=Z, W!=Z, holds(onFirstSide(X),T), holds(onFirstSide(Y),T), holds(onFirstSide(W),T), nholds(onFirstSide(Z),T), occurs(travelAcross(W,W),T).
holds(aloneTogether(Z,W), T+1) :- time(T), participant(X), participant(Y), participant(W), participant(Z), X!=Y, X!=W, X!=Z, Y!=W, Y!=Z, W!=Z, holds(onFirstSide(X),T), holds(onFirstSide(Y),T), holds(onFirstSide(W),T), nholds(onFirstSide(Z),T), occurs(travelAcross(W,W),T).
%Opposite of the above 3:
holds(aloneTogether(X,Y), T+1) :- time(T), participant(X), participant(Y), participant(W), participant(Z), X!=Y, X!=W, X!=Z, Y!=W, Y!=Z, W!=Z, nholds(onFirstSide(X),T), nholds(onFirstSide(Y),T), nholds(onFirstSide(W),T), holds(onFirstSide(Z),T), occurs(travelAcross(W,W),T).
holds(aloneTogether(W,Z), T+1) :- time(T), participant(X), participant(Y), participant(W), participant(Z), X!=Y, X!=W, X!=Z, Y!=W, Y!=Z, W!=Z, nholds(onFirstSide(X),T), nholds(onFirstSide(Y),T), nholds(onFirstSide(W),T), holds(onFirstSide(Z),T), occurs(travelAcross(W,W),T).
holds(aloneTogether(Z,W), T+1) :- time(T), participant(X), participant(Y), participant(W), participant(Z), X!=Y, X!=W, X!=Z, Y!=W, Y!=Z, W!=Z, nholds(onFirstSide(X),T), nholds(onFirstSide(Y),T), nholds(onFirstSide(W),T), holds(onFirstSide(Z),T), occurs(travelAcross(W,W),T).

nholds(aloneTogether(X,Y), T+1) :- time(T), participant(X), participant(Y), holds(aloneTogether(X,Y), T).

holds(F, T+1) :- fluent(F), time(T), holds(F,T), not nholds(F,T+1).
nholds(F, T+1) :- fluent(F), time(T), nholds(F,T), not holds(F,T+1).

%Goals, for generating a plan:
goatEatsCabbage :- time(T), holds(aloneTogether(goat,cabbage),T).
goatEatsCabbage :- time(T), holds(aloneTogether(cabbage,goat),T).
wolfEatsGoat :- time(T), holds(aloneTogether(wolf,goat),T).
wolfEatsGoat :- time(T), holds(aloneTogether(goat,wolf),T).
goal :- nholds(onFirstSide(wolf), 7), nholds(onFirstSide(goat), 7), nholds(onFirstSide(cabbage), 7), not goatEatsCabbage, not wolfEatsGoat.
:- not goal.

#show.
#show occurs/2.

% CLINGO OUTPUT:
% C:\Users\Jack Bankston\Desktop\clingo-4.4.0-win64>clingo examples\asp\hw5.lp 0
% clingo version 4.4.0
% Reading from examples\asp\hw5.lp
% Solving...
% Answer: 1
% occurs(travelAcross(sailor,goat),0) occurs(travelAcross(sailor,sailor),1) occurs
% (travelAcross(sailor,wolf),2) occurs(travelAcross(sailor,goat),3) occurs(travelA
% cross(sailor,cabbage),4) occurs(travelAcross(sailor,sailor),5) occurs(travelAcro
% ss(sailor,goat),6)
% Answer: 2
% occurs(travelAcross(sailor,goat),0) occurs(travelAcross(sailor,sailor),1) occurs
% (travelAcross(sailor,cabbage),2) occurs(travelAcross(sailor,goat),3) occurs(trav
% elAcross(sailor,wolf),4) occurs(travelAcross(sailor,sailor),5) occurs(travelAcro
% ss(sailor,goat),6)
% SATISFIABLE
%
% Models       : 2
% Calls        : 1
% Time         : 0.118s (Solving: 0.08s 1st Model: 0.00s Unsat: 0.04s)
% CPU Time     : 0.047s

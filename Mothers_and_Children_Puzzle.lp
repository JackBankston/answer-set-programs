% Each of four mothers has had a child in one of the last
% four years. Based on four rules, this program matches each	
% of the mothers to their child.
%
% Mothers:
%	- Alice - F
%	- Betty - G
%	- Catherine - O 
%	- Denise - W
% Children:
%	- andrew - B
%	- beth - E
%	- chris - I
%	- deborah - Z
% Years:
%	- 2012
%	- 2013
%	- 2014
%	- 2015
%
% Rules:
%	- The child of Betty was born before Deborah.
%	- The child of Denise was born 1 year before Andrew.
%	- Beth was born 1 year after Chris.
%	- The child of Catherine was born 1 year after Chris.

year(2012;2013;2014;2015).
child(andrew;beth;chris;deborah).
mother(alice;betty;catherine;denise).

% Enumerating all possibilities for mothers of all the children:
4{motherOf(X,Y) : mother(X),child(Y)}4.
% No mother can be the mother of more than one child:
:- mother(X), child(A), child(B), A!=B, motherOf(X,A), motherOf(X,B).
% No child can have two different mothers.
:- mother(X), mother(Y), X!=Y, child(A), motherOf(X,A), motherOf(Y,A).

% Enumerating all possibilities for years in which all the children were born:
4{bornIn(X,Y) : child(X),year(Y)}4.
% No child can be born in two different years:
:- child(X), year(Y), year(Z), Y!=Z, bornIn(X,Y), bornIn(X,Z).
% No two children can be born in the same year:
:- child(X), child(Y), X!=Y, year(Z), bornIn(X,Z), bornIn(Y,Z).

% Constraints from the four rules:
% Rule 1:
% Betty isn't the mother of Deborah.
:- motherOf(betty,deborah). 
% The child of Betty was born before before Deborah
:- child(X), mother(Y), year(A), year(B), bornIn(X,A), motherOf(betty, X), bornIn(deborah,B), B<A. 

% Rule 2:
% Denise isn't the mother of Andrew:
:- motherOf(denise,andrew).
% The child of Denise was born one year before Andrew:
:- child(X), mother(Y), year(A), year(B), bornIn(X,A), motherOf(denise,X), bornIn(andrew,B),  A!=(B-1).

% Rule 3:
% Beth was born 1 year after Chris:
:- year(A), year(B), bornIn(beth,A), bornIn(chris, B), A!=(B+1).

% Rule 4:
% Catherine isn't the mother of Chris:
:- motherOf(catherine,chris).
% The child of Catherine was born 1 year after Chris:
:- child(X), mother(Y), year(A), year(B), bornIn(X,A), motherOf(catherine,X), bornIn(chris,B),  A!=(B+1).

#show.
#show motherOf/2.
#show bornIn/2.

% CLINGO OUTPUT:
% C:\Users\Jack Bankston\Desktop\clingo-4.4.0-win64>clingo examples\asp\homework5.lp 0
% clingo version 4.4.0
% Reading from examples\asp\mothersAndChildren.lp
% Solving...
% Answer: 1
% motherOf(alice,andrew) motherOf(betty,chris) motherOf(ow
% ens,beth) motherOf(denise,deborah) bornIn(andrew,2015
% ) bornIn(beth,2013) bornIn(chris,2012) bornIn(zyngaComple
% x,2014)
% SATISFIABLE
%
% Models       : 1
% Calls        : 1
% Time         : 0.039s (Solving: 0.03s 1st Model: 0.00s Unsat: 0.03s)
% CPU Time     : 0.000s
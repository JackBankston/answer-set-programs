% Kermit, Miss Piggy, and the Swedish Chef are going to three theme parks: Disneyland,
% California Adventure, and Sea World. There are three possible modes of 
% transportation: bicycle, car, and bus. One muppet goes to each park and each
% muppet uses a different form of transportation. The following program determines
% which muppet goes to which park and how they get there, based on the following 
% four rules:
%	- The muppet that went to California Adventure got there via bicycle.
%	- Miss Piggy went to her theme park of choice in a car.
%	- The Swedish Chef did not take a bus.
%	- Kermit visited Disneyland. 

muppet(kermit).
muppet(missPiggy).
muppet(swedishChef).

park(disneyland).
park(californiaAdventure).
park(seaWorld).

ride(bike).
ride(car).
ride(bus).

% Only one muppet can use each ride, and each ride can only be used by one muppet.
1{used(X,Y) : muppet(X)}1 :- ride(Y).
1{used(X,Y) : ride(Y)}1 :- muppet(X).

% Only one muppet can visit each park, and each park can only be visited by one muppet.
1{visited(X,Y) : muppet(X)}1 :- park(Y).
1{visited(X,Y) : park(Y)}1 :- muppet(X).

:- not used(missPiggy, car).		% Represents that Miss Piggy used a car.
:- not visited(kermit, disneyland).		% Represents that Kermit went to Disneyland.
:- used(swedishChef, bus).		% Represents that the Swedish Chef did not take a bus.
%The muppet who went to California Adventure used a bike.
used(X, bike) :- visited(X, californiaAdventure), muppet(X).

% Limiting the results that will be shown:
#show.
#show used/2.
#show visited/2.

% CLINGO OUTPUT:
%	clingo version 4.4.0
%	Reading from examples\asp\muppets.lp
%	Solving...
%	Answer: 1
%	used(missPiggy,car) visited(kermit,disneyland) used(swedishChef,bike) visited(swedishChef,
%	californiaAdventure) used(kermit,bus) visited(missPiggy,seaWorld)
%	SATISFIABLE
%
%	Models          : 1
%	Calls              : 1
%	Time        	    : 0.024s (Solving: 0.02s 1st Model: 0.00s Unsat: 0.02s)
%	CPU Time     : 0.000s
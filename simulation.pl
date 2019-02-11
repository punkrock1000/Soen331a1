%% =============================================================================
%%
%%  CONCORDIA UNIVERSITY
%%  Department of Computer Science and Software Engineering
%%  SOEN 331-W:  Assignment 1
%%  Winter term, 2019
%%  Date submitted: February 11, 2019
%%
%%  Authors: 	Tran Hai Vong Thang, 40004591, vongthang93@gmail.com
%%				Justin Weller, 40026870, jadamweller@gmail.com
%%				Antoine Racine-Gingras, 40008247, antoineracinegingras@hotmail.com
%%				Vatika Prasad, 40033221, vatikaprasad@gmail.com
%%
%% =============================================================================

%% =============================================================================
%%
%%  Facts
%%
%% =============================================================================

state(idle).
state(configurationMode).
state(monitoring).
state(heatingUp).

%% transition(idle, configurationMode, configureSystem, fs == on, fs = furnaceState).
transition(idle, monitoring,_,_,_).
initial_state(idle,_).

%% =============================================================================
%%
%%  Rules
%%
%% =============================================================================
initial_state(X) :- initial_state(X, _).
%% transition(Source, Destination, Event, Guard, Action).

%% eof.
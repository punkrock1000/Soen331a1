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
  state(exit).
  
  initial_state(idle,null).
  transition(idle,configurationMode,'configuring',null).
  transition(configurationMode,configurationMode,'set or override triplets',null).
  transition(configurationMode,idle,'cancelling',null).
  transition(configurationMode,idle,'completion of user entries',null).
  transition(configurationMode,idle,'inactive(1 minute)',null).
  transition(idle,monitoring,'start monitoring',null).
  transition(monitoring,monitoring,'after(2 minutes)','currentRoomTemp >= desiredTemp').
  transition(monitoring,heatingUp,'after(2 minutes)','currentRoomTemp < (desiredTemp-1)').
  transition(heatingUp,heatingUp,'after(3 minutes)','furnaceTemp < (desiredTemp+1)').
  transition(heatingUp,idle,'after(3 minutes)','furnaceTemp >= (desiredTemp+1)').
  transition(heatingUp,configurationMode,'interrupt heating',null).
  transition(idle,exit,'shut off',null).
  
  parent(idle, configurationMode).
  parent(configurationMode, monitoring).
  parent(monitoring, heatingUp).
  parent(heatingUp, exit).
  
%% =============================================================================
%%
%%  Rules
%%
%% =============================================================================
  
%% Return whether or not both the Event and Guard variables of the transition are null (empty).
  transition_has_event_and_guard(S,D,E,G) :-
		 transition(S,D,E,G),
		 E \= null,
		 G \= null.
  
  ancestor(X, Y):- 
		 parent(X, Y).
  ancestor(X, Y):- 
		 parent(X, Z), 
		 ancestor(Z, Y).
  
  get_all_transition(TSet):-
         findall(transition_has_event_and_guard(S,D,E,G),transition_has_event_and_guard(S,D,E,G),TList),
         list_to_set(TList,TSet).

  get_inherited_transitions(ISet,S):-
         findall(transition(S,D,E,G),transition(S,D,E,G),IList),
         list_to_set(IList,ISet).

%% eof.
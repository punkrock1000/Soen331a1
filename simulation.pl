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
  
  initial_state(idle,_).
  transition(idle,configurationMode,'configuring',_).
  transition(configurationMode,idle,'cancelling',_).
  transition(configurationMode,idle,'completion of user entries',_).
  transition(configurationMode,idle,'inactive(1 minute)',_).
  transition(idle,monitoring,'start monitoring',_).
  transition(monitoring,monitoring,'after(2 minutes)','currentRoomTemp >= desiredTemp').
  transition(monitoring,heatingUp,'after(2 minutes)','currentRoomTemp < (desiredTemp-1)').
  transition(heatingUp,heatingUp,'after(3 minutes)','furnaceTemp < (desiredTemp+1)').
  transition(heatingUp,idle,'after(3 minutes)','furnaceTemp >= (desiredTemp+1)').
  transition(heatingUp,configurationMode,'interrupt heating',_).
  transition(idle,exit,'shut off',_).
  
%% =============================================================================
%%
%%  Rules
%%
%% =============================================================================
  

  
  ancestor(S):- state(Y), super_state(S,Y).

  get_all_transition(TSet):-
         findall(transition(S,D,E,G),transition(S,D,E,G),TList),
         list_to_set(TList,TSet),((E\==null),(G\==null)) .

  get_inherited_transitions(ISet,S):-
         findall(transition(S,D,E,G),transition(S,D,E,G),IList),
         list_to_set(IList,ISet).

%% eof.
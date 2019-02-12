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
  transition(idle,configurationMode,'Configure the system','fs == off').
  transition(configurationMode,idle,'cancelling',_).
  transition(configurationMode,idle,'completing',_).
  transition(configurationMode,idle,'inactive(1 minute)',_).
  transition(idle,monitoring,_,_).
  transition(monitoring,'heating up','every 2 min','currentRoomTemp<(desiredTemp-1)').
  transition(monitoring,'every 2 min','currentRoomTemp=>desiredTemp',null).
  transition(heatingUp,monitoring,'every 3 min','furnaceTemp=(desiredTemp+1)').
  transition(heatingUp, heatingUp,'every 3 min','furnaceTemp<(desiredTemp+1)').
  transition(heatingUp,'idle mode','cancel current mode',null).
  transition(heatingUp,'idle mode','completion configulattion',null).
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
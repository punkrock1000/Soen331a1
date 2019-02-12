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
  state(monitoring).
  state('heating up').
  state(shutoff).
  state(configuration).
  initial_state(idle,null).
  super_state(monitoring,'idle').
  super_state(monitoring,configuration).

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
  transition(idle,shutoff,'shut off',null).
  transition(idle,monitoring,null,null).
  transition(monitoring,'heating up','every 2 min','currentRoomTemp<(desiredTemp-1)').
  transition(monitoring,'every 2 min','currentRoomTemp=>desiredTemp',null).
  transition('heating up',monitoring,'every 3 min','furnaceTemp=(desiredTemp+1)').
  transition('heating up','heating up','every 3 min','furnaceTemp<(desiredTemp+1)').
  transition('heating up','idle mode','cancel current mode',null).
  transition('heating up','idle mode','completion configulattion',null).
  
  ancestor(S):- state(Y), super_state(S,Y).

  get_all_transition(TSet):-
         findall(transition(S,D,E,G),transition(S,D,E,G),TList),
         list_to_set(TList,TSet),((E\==null),(G\==null)) .

  get_inherited_transitions(ISet,S):-
         findall(transition(S,D,E,G),transition(S,D,E,G),IList),
         list_to_set(IList,ISet).

%% eof.
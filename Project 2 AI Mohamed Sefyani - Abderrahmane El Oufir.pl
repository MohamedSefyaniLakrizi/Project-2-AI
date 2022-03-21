:- dynamic([
	     agent_location/1,
	     time/1,
	     score/1,
	    ]).

room(1,1).
room(1,2).
room(1,3).
room(1,4).
room(2,1).
room(2,2).
room(2,3).
room(2,4).
room(3,1).
room(3,2).
room(3,3).
room(3,4).
room(4,1).
room(4,2).
room(4,3).
room(4,4).

breeze(room(2,1)).
breeze(room(4,1)).
breeze(room(3,2)).
breeze(room(4,3)).
breeze(room(3,4)).
breeze(room(2,3)).

pit(room(4,4)).
pit(room(3,3)).
pit(room(3,1)).

wumpus(room(1,3)).

stench(room(4,1)).
stench(room(2,1)).
stench(room(3,2)).

gold(room(3,2)).

adj(1,2).
adj(2,1).
adj(2,3).
adj(3,2).
adj(3,4).
adj(4,3).
adjacentTo( [X1, Y1], [X2, Y2] ) :-
    ( X1 = X2, adj( Y1, Y2 )
    ; Y1 = Y2, adj( X1, X2 )
    ).

init_agent :-
    retractall( agent_location(_) ),
    assert( agent_location([1,1]) ).   

update_agent_location(NewAL) :-
    agent_location(AL),
    retractall( agent_location(_) ),
    assert( agent_location(NewAL) ).

check_room([Stench,Breeze,glitter]) :-
 	smelly(Stench),
	breezy(Breeze),
	glittering(Glitter).

smelly(yes) :-
    agent_location(AL),
    stench(AL).
smelly(no).

breezy(yes) :-
    agent_location(AL),
    breeze(AL).
breezy(no).

glittering(yes) :-
    agent_location(AL),
    gold(AL).
glittering(no).


ask_KB(VisitedList, Action) :-
    isWumpus(no, L),
    isPit(no, L),
    permitted(L),
    not_member(L, VisitedList),
    update_agent_location(L),
    Action = L.

not_member(X, []).
not_member([X,Y], [[U,V]|Ys]) :-
    ( X=U,Y=V -> fail
    ; not_member([X,Y], Ys)
    ).
    
update_score(P) :-
    score(S),
    NewScore is S+P,
    retractall( score(_) ),
    assert( score(NewScore) ).

update_time :-
    time(T),
    NewTime is T+1,
    retractall( time(_) ),
    assert( time(NewTime) ).

safe(room(X,Y)) :- 
    room(X,Y) \== room(1,3).


safe(X,Y) :-
    room(X,Y) \== room(4,4).

safe(X,Y) :-
    room(X,Y) \== room(3,3).

safe(X,Y) :-
    room(X,Y) \== room(3,1).

start :- 
    format("Start on [1, 1] ~n", []),
    step([[1,1]]).


step_pre(VisitedList) :-
    agent_location(AL),

    ( AL=room(1,3) -> write("Agent Won"), 
                format("Score: ~p,~n Time: ~p", [S,T])
    ; AL=room(3,2) -> write("Agent Lost: Eaten"),
                format("Score: ~p,~n Time: ~p", [S,T])
    ; step(VisitedList)
    ).

step(VisitedList) :-
    check_room(search),
    agent_location(AL),
    format("Agent in ~p, seeing: ~p~n", [AL,search]),
    
    update_KB(search),
    ask_KB(VisitedList, Action),
    format("Agent going to: ~p~n", [Action]),

    update_time,
    update_score,
    
    agent_location(Aloc),
    VL = [Aloc|VisitedList],
    step_pre(VL).  
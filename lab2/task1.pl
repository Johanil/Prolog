separate_odds([],[]).
separate_odds([X|Rest],[X|L]):-
    1 is X mod 2,!,
    separate_odds(Rest,L).
separate_odds([X|Rest],L):-
    separate_odds(Rest,L).
    
    
    	

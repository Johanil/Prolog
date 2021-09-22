every_second([],L).
every_second([_],[]).
every_second([_,T],[T]).
every_second([_,X|Rest],[X|T]):- every_second(Rest,T).
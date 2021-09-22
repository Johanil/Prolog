member(X,[X|List]).
member(X,[E|List]):- member(X,List).
delete([],L,L).
delete([E|Rest],List,[E|Set]):-
    \+member(E,List),!,
    delete(Rest,List,Set).
delete([E|Rest],List,Set):-
    delete(Rest,List,Set).
	% delete([a,b],[a,b,c],L).
    %Ta bort alla element från den 
    %andra listan som finns i den första
    
    
    	

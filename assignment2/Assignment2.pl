% guess_a_word/0.
% starts the game, calls the predicate game(yes) 

guess_a_word:-game(yes).


% game(+X) starts a new round if X is yes. 
% If X is no the program ends. 
% If X has another value a correct value is asked for.  

game(no):-
  write('Thanks for a good game!'),nl.

game(yes):-
  read_word(Word1),
  read_guess(Word2),
  play(Word1,Word2),
  write('Once more?'),nl,
  read(Answer),
  game(Answer).

game(X):-
  write('Unknown alternative, answer yes or no'),nl,
  read(Answer),
  game(Answer).


% read_Word(-List) reads the Word that the game leader gives and that   
% the player should guess. Except the reading the predicate translates 
% the atom to a list of letters 

read_word(List):-
  write('The game leader gives its word'),
  nl,
  read(Word),
  name(Word,CharList),
  letters(CharList,List).


% letters(+AsciList,-LetterList) translates an ascii list  
% to a list with the corresponding letters. 
% This recursive program utilises the built-in predicate name/2
letters([],[]).
letters([A],[Z]):-
    name(Z,[A]).
letters([Z|X],[E|Y]):-
    name(E,[Z]),
    letters(X,Y).

% read_guess(-List) reads the word the player guesses 
% and translates it to a list of letters 
read_guess(List):-
  write('Player guess a word'),nl,
  read(Word),
  name(Word,CharList),
  letters(CharList,List).


 
% play(+X,+Y) if X and Y are equal, play succeeds directly. 
% If the X and Y differ, they should be compared, the comparison 
% presented and a new try should be performed. Note that the words may % be of different lengths. 

play(Word,Word):-
  write('Correct!'),nl.

play(Word1,Word2):-
  Word1\==Word2,
  same_placing(Word1,Word2,Starlist),		
  included_but_not_same_placing(Word1,Word2,List),
  output(Starlist,List), 
  read_guess(NewWord),
  play(Word1,NewWord).



% same_placing(+Word1,+Word2,-Starlist)  
% checks for the letters that have the right placing.  
% The predicate produces a list with stars for positions where the letters are 
% not the correct ones. The correct placed letters is included. 
% Exemple: The guess is winter and the correct word is summer  
% the Starlist will be: [*,*,*,*,e,r]
same_placing([],[],[]).
same_placing([],A,[]).

same_placing([X|Word1],[X|Word2],[Y|Starlist]):- 
    name(Y,[X]),
    same_placing(Word1,Word2,Starlist).

same_placing([Z|Word1],[Y|Word2],[*|Starlist]):- 
    same_placing(Word1,Word2,Starlist).

same_placing([W|Word1],[],[*|Starlist]):- 
    same_placing(Word1,[],Starlist).
% included_but_not_same_placing(+Word1,+Word2,-List) 
% will check the guessed letters that can be found in the  
% correct word but not in the right position
member(X,[X|List]).
member(X,[E|List]):- member(X,List).
members([],X,[]).
members([X|Rest],List,[X|Output]):-
    member(X,List),!,
    members(Rest,List,Output).

members([X|Rest],List,Output):-
    members(Rest,List,Output).

not_in_starlist(X,[],[]).
not_in_starlist([],[X],[X]).
not_in_starlist([],[],[]).

not_in_starlist(Starlist,[X|Rest],[X|NList]):-
    \+member(X,Starlist),
    not_in_starlist(Starlist,Rest,NList).
not_in_starlist(Starlist,[X|Rest],NList):-
    member(X,Starlist),
    not_in_starlist(Starlist,Rest,NList).
not_in_starlist([],[X|Rest],[X|NList]):-
    not_in_starlist([],Rest,NList).
    
included_but_not_same_placing(Correct,Guess,Remainder):-
    same_placing(Correct,Guess,Starlist),
    not_in_starlist(Starlist,Correct,NotInStarList),
    members(Guess,NotInStarList,Remainder).



% output(+Starlist,+List) should write the message to  
% player presenting the result.

output(Starlist,List):- write(Starlist),write(List).


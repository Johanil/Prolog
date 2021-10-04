

guess_a_word:-game(yes).


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




read_word(List):-
  write('The game leader gives its word'),
  nl,
  read(Word),
  name(Word,ReadList),
  letters(ReadList,List).



letters([],[]).
letters([A],[Z]):-
    name(Z,[A]).
letters([Z|X],[E|Y]):-
    name(E,[Z]),
    letters(X,Y).


read_guess(List):-
  write('Player guess a word'),nl,
  read(Word),
  name(Word,CharList),
  letters(CharList,List).




play(Word,Word):-
  write('Correct!'),nl.

play(Word1,Word2):-
  Word1\==Word2,
  same_placing(Word1,Word2,Starlist),		
  included_but_not_same_placing(Word1,Word2,List),
  output(Starlist,List), 
  read_guess(NewWord),
  play(Word1,NewWord).


same_placing([],[],[]).
same_placing([],A,[]).
same_placing([A],[A],[A]).

same_placing([X|Word1],[X|Word2],[X|Starlist]):- 

    same_placing(Word1,Word2,Starlist).

same_placing([Z|Word1],[Y|Word2],[*|Starlist]):- 
    same_placing(Word1,Word2,Starlist).

same_placing([W|Word1],[],[*|Starlist]):- 
    same_placing(Word1,[],Starlist).


members([],X,[]).
members([X|Rest],List,[X|Output]):-
    member(X,List),!,
    members(Rest,List,Output).

members([X|Rest],List,Output):-
    members(Rest,List,Output).

not_members([],[]).
not_members([X|Rest],Output):-
    member(X,Rest),!,
    not_members(Rest,Output).

not_members([X|Rest],[X|Output]):-
    not_members(Rest,Output).


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

output(Starlist,[]):- 
    write(Starlist),nl.

output(Starlist,List):- 
    write(Starlist),write('        Occurring letters:'),
    not_members(List,Output),
    write(Output),nl.



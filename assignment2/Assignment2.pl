%Command for starting the game
guess_a_word:-game(yes).

%If no game is over.
game(no):-
  write('Thanks for a good game!'),nl.

%If yes the game functions are carried out
game(yes):-
  read_word(Word1),
  read_guess(Word2),
  play(Word1,Word2),
  write('Once more?'),nl,
  read(Answer),
  game(Answer).

%If the answer isnt yes or no then its unknown and the read function is called again.
game(X):-
  write('Unknown alternative, answer yes or no'),nl,
  read(Answer),
  game(Answer).

%Reads the game leaders word
read_word(List):-
  write('The game leader gives its word'),
  nl,
  read(Word),
  name(Word,ReadList),
  letters(ReadList,List).

%Reads the players guess
read_guess(List):-
  write('Player guess a word'),nl,
  read(Word),
  name(Word,CharList),
  letters(CharList,List).

%If both words are matching the answer is correct.
play(Word,Word):-
  write('Correct!'),nl.

%If the words are different then functions for checking the letters are called.
play(Word1,Word2):-
  Word1\==Word2,
  same_placing(Word1,Word2,Starlist),		
  included_but_not_same_placing(Word1,Word2,List),
  output(Starlist,List), 
  read_guess(NewWord),
  play(Word1,NewWord).

%This supporting function takes the ascii-list of letters and transforms it to a "regular" list of letters.
letters([],[]).
letters([A],[Z]):-
    name(Z,[A]).
letters([Z|X],[E|Y]):-
    name(E,[Z]),
    letters(X,Y).

%Same placing checks which letters of two list are in the same place. If they are they are put in the third list, if not they are replace with a star.
same_placing([],[],[]).
same_placing([],A,[]).
same_placing([A],[A],[A]).

same_placing([X|Word1],[X|Word2],[X|Starlist]):- 
    same_placing(Word1,Word2,Starlist).

same_placing([Z|Word1],[Y|Word2],[*|Starlist]):- 
    same_placing(Word1,Word2,Starlist).

same_placing([W|Word1],[],[*|Starlist]):- 
    same_placing(Word1,[],Starlist).

%Members checks if an element in the first list exists in the second list and if it does it puts it in a third list.
members([],X,[]).
members([X|Rest],List,[X|Output]):-
    member(X,List),!,
    members(Rest,List,Output).

members([X|Rest],List,Output):-
    members(Rest,List,Output).

%Not members inserts the elements in the first list to the second but ignores duplicates.
not_members([],[]).
not_members([X|Rest],Output):-
    member(X,Rest),!,
    not_members(Rest,Output).

not_members([X|Rest],[X|Output]):-
    not_members(Rest,Output).

%Not in starlist checks if an element exists in starlist, if it doesn't it is added to a third list.
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

%Output writes the output for the starlist and the list.
output(Starlist,[]):- 
    write(Starlist),nl.

output(Starlist,List):- 
    write(Starlist),
    write('        Occurring letters:'),
    not_members(List,Output),
    write(Output),nl.



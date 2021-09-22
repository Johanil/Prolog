secret_number(12).
guess_a_number:-
    write('Give an integer: '),
    nl,
	read(X),
	guess(X).
    guess(X):-
        secret_number(Y),
        X=Y, write('Correct!!').
    guess(X):-
        secret_number(Y),
        X<Y, 
        write('Too small'),
        nl,
    	write('Give an integer'),
        read(Z),
        guess(Z).
    guess(X):-
        secret_number(Y),
        X>Y,
    	write('Too big'),
        nl,
    	write('Give an integer'),
        read(Z),
        guess(Z).

secret_number(12).
guess(X,Answer):-
    secret_number(Y),
    X=Y, Answer='Correct'.
guess(X,Answer):-
    secret_number(Y),
    X<Y, Answer='Higher'.
guess(X,Answer):-
    secret_number(Y),
    X>Y, Answer='Lower'.

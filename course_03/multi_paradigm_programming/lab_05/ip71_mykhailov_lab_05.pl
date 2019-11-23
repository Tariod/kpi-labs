% Task 1:
sum(D, N, Res):-
  D >= N, Res is N, !.

sum(D, N, Res):-
  Prev_N is N - D,
  sum(D, Prev_N, Prev_Res),
  Res is N + Prev_Res.

% sum(3, 11, Res), write(Res).
% sum(6, 175, Res), write(Res).

% Task 2:
pow(_, 0, 1):- !.

pow(Base, Exponent, Res):-
  Exponent =< 0,
  Prev_Exponent is (-Exponent),
  pow(Base, Prev_Exponent, Prev_Res),
  Res is 1 / Prev_Res, !.

pow(Base, Exponent, Res):-
  Exponent mod 2 is 0,
  Prev_Exponent is Exponent / 1,
  pow(Base, Prev_Exponent, Prev_Res),
  Res is Prev_Res * Prev_Res, !.


pow(Base, Exponent, Res):-
  Prev_Exponent is Exponent - 1,
  pow(Base, Prev_Exponent, Prev_Res),
  Res is Base * Prev_Res.

% pow(0.6734, 5, Res), write(Res).

% Task 3:
sum(N, Res):- sum(1, N, Res).

% sum(1, 35, Res), write(Res).
% sum(35, Res), write(Res).

% Task 4:

round(1, 1):- !.

round(Precision, Res):-
  Precision > 1,
  Prev_Precision is Precision - 1,
  round(Prev_Precision, Prev_Res),
  Res is 1 / Precision / Precision + Prev_Res.

% round(1, Res), write(Res).

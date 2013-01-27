% vim: ft=prolog

likes(alex, ramen).
likes(julia, ramen).
likes(someone_else, burger_king).

not_same(X, Y) :- \+(X = Y).

lunching_together(X, Y, Food) :-
  likes(X, Food),
  likes(Y, Food),
  \+(X = Y).

% vim: set filetype=prolog

isSorted([]).

isSorted([Head|Tail]) :-
  % List with one item
  length(Tail, 0);
  % List with 2+ items
  (
    Tail = [FirstItem|_],
    FirstItem >= Head,
    isSorted(Tail)
  ).

concatenate([], List, List).
concatenate([H|T1], List, [H|T2]) :- concatenate(T1, List, T2).

reversedList(List, List) :- length(List, 0); length(List, 1).
reversedList([Head|Tail], Reversed) :-
  reversedList(Tail, ReversedTail),
  concatenate(ReversedTail, [Head], Reversed).

smallestOf([X], X).
smallestOf([Head|[Tip|Remainder]], X) :-
  % If H is less than the tip of the tail,
  % then X is the smallest of [Head | Remainder]
  (Head < Tip, smallestOf([Head|Remainder], X));
  % Otherwise, X is the smallest of Tail
  (Head >= Tip, smallestOf([Tip|Remainder], X)).

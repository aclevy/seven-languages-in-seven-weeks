% vim: ft=prolog

food_type(velveeta, crap).
food_type(burger_king, crap).
food_type(ramen, delicious).
food_type(spam, meat).
food_type(sausage, meat).
food_type(jolt, soda).
food_type(cookie, dessert).

flavor(sweet, dessert).
flavor(savory, meat).
flavor(sweet, soda).

food_flavor(Food, Flavor) :-
  food_type(Food, Type),
  flavor(Flavor, Type).

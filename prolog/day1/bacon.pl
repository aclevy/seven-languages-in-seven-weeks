% vim: set filetype=prolog

tv_show(the_following).
starred(kevin_bacon, the_following).
starred(james_purefoy, the_following).
starred(shawn_ashmore, the_following).
starred(nico_tortorella, the_following).
starred(kyle_catlett, the_following).
starred(natalie_zea, the_following).

movie(frost_nixon).
starred(frank_langella, frost_nixon).
starred(michael_sheen, frost_nixon).
starred(sam_rockwell, frost_nixon).
starred(kevin_bacon, frost_nixon).
starred(matthew_macfadyen, frost_nixon).
starred(oliver_platt, frost_nixon).
starred(rebecca_hall, frost_nixon).

movie(apollo_13).
starred(tom_hanks, apollo_13).
starred(bill_paxton, apollo_13).
starred(kevin_bacon, apollo_13).
starred(gary_sinise, apollo_13).
starred(ed_harris, apollo_13).

movie(catch_me_if_you_can).
starred(tom_hanks, catch_me_if_you_can).
starred(leo_dicaprio, catch_me_if_you_can).

movie(cloud_atlas).
starred(tom_hanks, cloud_atlas).
starred(halle_berry, cloud_atlas).
starred(susan_sarandon, cloud_atlas).
starred(jim_broadbent, cloud_atlas).
starred(hugo_weaving, cloud_atlas).
starred(jim_sturgess, cloud_atlas).
starred(doona_bae, cloud_atlas).
starred(ben_whishaw, cloud_atlas).

movie(x_men).
starred(patrick_stewart, x_men).
starred(halle_berry, x_men).

movie(the_departed).
starred(leo_dicaprio, the_departed).
starred(matt_damon, the_departed).
starred(jack_nicholson, the_departed).
starred(mark_wahlberg, the_departed).
starred(martin_sheen, the_departed).

one_degree(X, Y) :-
  starred(X, Something),
  starred(Y, Something),
  \+(X=Y).

two_degrees(X, Y) :-
  one_degree(X, FOAF),
  one_degree(Y, FOAF),
  \+one_degree(X, Y),
  \+(X=Y).

three_degrees(X, Y) :-
  two_degrees(X, FOAF),
  one_degree(Y, FOAF),
  \+two_degrees(X, Y),
  \+(X=Y).

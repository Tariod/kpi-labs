parent(judy, mircho).
parent(judy, arman).
parent(louise, lydia).
parent(louise, virginia).
parent(ken, mircho).
parent(ken, arman).
parent(christian, lydia).
parent(christian, virginia).

parent(arman, peter).
parent(arman, ricky).
parent(virginia, peter).
parent(virginia, ricky).
parent(guillaume, albertina).
parent(peri, albertina).

parent(peter, mark).
parent(peter, ferdinand).
parent(albertina, mark).
parent(albertina, ferdinand).

man(mircho).
man(arman).
man(ken).
man(christian).
man(peter).
man(ricky).
man(guillaume).
man(mark).
man(ferdinand).

woman(judy).
woman(louise).
woman(lydia).
woman(virginia).
woman(peri).
woman(albertina).

married(judy, ken).
married(louise, christian).
married(virginia, arman).
married(peri, guillaume).
married(albertina, peter).

is_parent(Smn):- parent(Smn, _).

has_parents(Smn):- parent(_, Smn).

%  parent(X, _), parent(_, X).
parents_with_parents(Smn):-
    is_parent(Smn),
    has_parents(Smn).

is_not_parent(Smn):-
  \+ is_parent(Smn).

% Family relations

father(Smn, Child):-
  parent(Smn, Child),
  man(Smn).

is_father(Smn):- father(Smn, _).

mother(Smn, Child):-
  parent(Smn, Child),
  woman(Smn).

is_mother(Smn):- mother(Smn, _).

son(Smn, Parent):-
  parent(Parent, Smn),
  man(Smn).

daughter(Smn, Parent):-
  parent(Parent, Smn),
  woman(Smn).

brother(Smn, Brother):-
  parent(X, Smn),
  parent(X, Brother),
  woman(Brother),
  Smn \= Brother.

sister(Smn, Sister):-
  parent(Parent, Smn),
  parent(Parent, Sister),
  woman(Sister),
  Smn \= Sister.

uncle(Smn, Child):-
  parent(Parent, Child),
  brother(Smn, Parent).

aunt(Smn, Child):-
  parent(Parent, Child),
  sisters(Smn, Parent).

grandfahter(Smn, Grandchild):-
  parent(Parent, Grandchild),
  father(Smn, Parent).

grandmother(Smn, Grandchild):-
  parent(Parent, Grandchild),
  mother(Smn, Parent).

grandson(Smn, Grandparent):-
  parent(Grandparent, Parent),
  son(Smn, Parent).

granddaughter(Smn, Grandparent):-
  parent(Grandparent, Parent),
  daughter(Smn, Parent).

nephew(Smn, UncleAunt):-
  brother(Parent, UncleAunt),
  son(Smn, Parent);
  sister(Parent, UncleAunt),
  son(Smn, Parent).

niece(Smn, UncleAunt):-
  brother(Parent, UncleAunt),
  daughter(Smn, Parent);
  sister(Parent, UncleAunt),
  daughter(Smn, Parent).

is_married(Smn1, Smn2):-
  married(Smn1, Smn2);
  married(Smn2, Smn1).

wife(Smn, Husband):-
  is_married(Smn, Husband),
  woman(Smn).

husband(Smn, Wife):-
  is_married(Smn, Wife),
  man(Smn).

mother_in_law_husband(Smn, Husband):-
  wife(Wife, Husband),
  mother(Smn, Wife).

father_in_law_husband(Smn, Husband):-
  wife(Wife, Husband),
  father(Smn, Wife).

mother_in_law_wife(Smn, Wife):-
  husband(Husband, Wife),
  mother(Smn, Husband).

father_in_law_wife(Smn, Wife):-
  husband(Husband, Wife),
  father(Smn, Husband).

son_in_law(Smn, Parent_in_law):-
  daughter(Daughter, Parent_in_law),
  husband(Smn, Daughter);
  sister(Sister, Parent_in_law),
  husband(Smn, Sister).

% невістка, свояк, своячка, дівер, внучатий небіж, внучатий небога

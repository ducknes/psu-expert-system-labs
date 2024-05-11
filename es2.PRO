domains
database
	xpositive(symbol,symbol)
	xnegative(symbol,symbol)
predicates
	do_expert_job
	do_consulting
	ask(symbol,symbol)
	group_is(symbol)
	it_is(symbol)
	positive(symbol,symbol)
	negative(symbol,symbol)
	remember(symbol,symbol,symbol)
	clear_facts
goal
	do_expert_job.
clauses
group_is("Чернобыль"):-
	it_is("Мини-сериал"),
    it_is("Зарубежный"),
	positive(has, "Драма"),
	positive(has, "Криминал"),
	positive(has, "Фантастика"),!.

group_is("Внутри убийцы"):-
	it_is("Мини-сериал"),
    it_is("Российский"),
	positive(has, "Триллер"),
	positive(has, "Детектив"),
	positive(has, "Криминал"),!.

group_is("Трепачи"):-
	it_is("Мини-сериал"),
    it_is("Российский"),
	positive(has, "Боевик"),
	positive(has, "Криминал"),
	positive(has, "Ужасы"),!.

group_is("Ход королевы"):-
	it_is("Мини-сериал"),
    it_is("Зарубежный"),
	positive(has, "Комедия"),
	positive(has, "Приключение"),
	positive(has, "Драма"),!.

group_is("Шерлок"):-
	it_is("Многосезонный"),
    it_is("Зарубежный"),
	positive(has, "Детектив"),
	positive(has, "Криминал"),
	positive(has, "Драма"),!.

group_is("Триггер"):-
	it_is("Многосезонный"),
    it_is("Российский"),
	positive(has, "Боевик"),
	positive(has, "Криминал"),
	positive(has, "Фантастика"),!.

group_is("Аватар: Легенда об Аанге"):-
	it_is("Многосезонный"),
    it_is("Зарубежный"),
	positive(has, "Аниме"),
	positive(has, "Приключение"),
	positive(has, "Детский"),!.

group_is("Атака титанов"):-
	it_is("Многосезонный"),
    it_is("Зарубежный"),
	positive(has, "Аниме"),
	positive(has, "Боевик"),
	positive(has, "Ужасы"),!.

group_is("Вампиры средней полосы"):-
	it_is("Многосезонный"),
    it_is("Российский"),
	positive(has, "Аниме"),
	positive(has, "Мелодрама"),
	positive(has, "Криминал"),!.

group_is("Метод"):-
	it_is("Многосезонный"),
    it_is("Российский"),
	positive(has, "Триллер"),
	positive(has, "Детектив"),
	positive(has, "Криминал"),!.

group_is("Во все тяжкие"):-
	it_is("Многосезонный"),
    it_is("Зарубежный"),
	positive(has, "Детектив"),
	positive(has, "Криминал"),
	positive(has, "Драма"),!.

it_is("Российский"):-
	positive(is, "Российский"), !.

it_is("Зарубежный"):-
	positive(is, "Зарубежный"), !.

it_is("Мини-сериал"):- 
	positive(is, "Мини-сериал"), !.

it_is("Многосезонный"):- 
	positive(is, "Многосезонный"), !.

do_expert_job:-
	makewindow(1,7,7,"Антонов Илья 21ВП2",1,16,22,58), nl,
	write("* * * * * * * * * * * * * * * * * * * *"),nl,
	write("ЭКСПЕРТНАЯ СИСТЕМА ПО ПОДБОРУ СЕРИАЛОВ"),nl,
	write(" "), nl,
	write("ПОЖАЛУЙТА ОТВЕТЬТЕ НА ВОПРОСЫ О ТОМ, КАКИИ? СЕРИАЛ ВЫ ЖЕЛАЛИ ПОДБОРАТЬ"),nl,
	write("КАКОИ? СЕРИАЛ ВЫ ЖЕЛАЛИ ПОДБОРАТЬ,"),nl,
	write("ВВОДЯ 'yes' ИЛИ 'no'. "),nl,
	write("* * * * * * * * * * * * * * * * * * * *"),nl,
	do_consulting, readchar(_), nl,nl, removewindow, exit.
do_consulting :-group_is(X),!,nl,write("ВАШ СЕРИАЛ : ",X,"."),nl,clear_facts.
do_consulting :-nl,write("НИЧЕГО НЕ УДАЛОСЬ ПОДОБРАТЬ ! "), clear_facts.
  ask(X,Y) :-write(" ВЫ ХОТИТЕ :- ",X," it ",Y," ?"),nl,readln(Reply), remember(X,Y,Reply).
positive(X,Y) :-xpositive(X,Y),!.
positive(X,Y) :-not(negative(X,Y)),!, ask(X,Y).
negative(X,Y) :-xnegative(X,Y),!.
remember(X,Y,yes) :-asserta(xpositive(X,Y)).
remember(X,Y,no) :-asserta(xnegative(X,Y)), fail.
clear_facts :-retract(xpositive(_,_)),fail.
clear_facts :-retract(xnegative(_,_)), fail.

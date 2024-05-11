:- dynamic xpositive/2.
:- dynamic xnegative/2.
:- dynamic doesntmatter/2.


cross_is('Чернобыль', 5):-
	it_is('Мини-сериал'),
    pos(has, 'Зарубежный', 1),
	pos(has, 'Драма', 2),
	pos(has, 'Криминал', 3),
	pos(has, 'Фантастика', 4).

cross_is('Внутри убийцы', 5):-
	it_is('Мини-сериал'),
    pos(has, 'Российский', 1),
	pos(has, 'Триллер', 2),
	pos(has, 'Детектив', 3),
	pos(has, 'Криминал', 4).

cross_is('Трепачи', 5):-
    it_is('Мини-сериал'),
    pos(has, 'Российский', 1),
    pos(has, 'Боевик', 2),
    pos(has, 'Криминал', 3),
    pos(has, 'Ужасы', 4).

cross_is('Ход королевы', 5):-
    it_is('Мини-сериал'),
    pos(has, 'Зарубежный', 1),
    pos(has, 'Комедия', 2),
    pos(has, 'Приключение', 3),
    pos(has, 'Драма', 4).

cross_is('Шерлок', 5):-
    it_is('Многосезонный'),
	pos(has, 'Зарубежный', 1),
    pos(has, 'Детектив', 2),
    pos(has, 'Криминал', 3),
    pos(has, 'Драма', 4).

cross_is('Триггер', 5):-
    it_is('Многосезонный'),
    pos(has, 'Российский', 1),
    pos(has, 'Боевик', 2),
    pos(has, 'Криминал', 3),
    pos(has, 'Фантастика', 4).

cross_is('Аватар: Легенда об Аанге', 5):-
    it_is('Многосезонный'),
    pos(has, 'Зарубежный', 1),
    pos(has, 'Аниме', 2),
    pos(has, 'Приключение', 3),
    pos(has, 'Детский', 4).

cross_is('Атака титанов', 5):-
    it_is('Многосезонный'),
    pos(has, 'Зарубежный', 1),
    pos(has, 'Аниме', 2),
    pos(has, 'Боевик', 3),
    pos(has, 'Ужасы', 4).

cross_is('Вампиры средней полосы', 5):-
    it_is('Многосезонный'),
    pos(has, 'Российский', 1),
    pos(has, 'Аниме', 2),
    pos(has, 'Мелодрама', 3),
    pos(has, 'Криминал', 4).

cross_is('Метод', 5):-
    it_is('Многосезонный'),
    pos(has, 'Российский', 1),
    pos(has, 'Триллер', 2),
    pos(has, 'Детектив', 3),
    pos(has, 'Криминал', 4).

cross_is('Во все тяжкие', 5):-
    it_is('Многосезонный'),
    pos(has, 'Зарубежный', 1),
    pos(has, 'Детектив', 2),
    pos(has, 'Криминал', 3),
    pos(has, 'Драма', 4).

pos(has, X, Group):-
	xpositive(X, Group), !.

pos(has, X, Group):-
	doesntmatter(X, Group), !.

pos(has, X, Group):-
	quest(X, Group).

it_is('Мини-сериал'):-
	pos(has, 'Мини-сериал', 0).

it_is('Многосезонный'):-
	pos(has, 'Многосезонный', 0).

expertisa:-
	cons,
	fail.

cons:-
	write('Экспертная система по подбору сериалов!'), nl,
	write('Ответьте на вопросы, чтобы система смогла подобрать вам сериал!'),
	nl,
	findall(X, cross_is(X,_), Crosses),
	length(Crosses, NumCrosses),
	(NumCrosses > 0 ->
	write('Сериалы, которые подходят по Вашему запросу: '), nl,
	maplist(countall, Crosses, Counts),
	counts_p(Crosses, Counts),
	clear;
	write('Нет подходящих сериалов!'), nl, clear),
	fail.

cons.

counts_p([], []).
counts_p([Cross|RestCrosses], [Count|RestCounts]) :-
    write(Cross),
    write(' - подходит на '),
    write(Count),
    write(' процентов.'),
    nl,
    counts_p(RestCrosses, RestCounts).

quest(X, Group):-
	not(xpositive(X, Group)),
	not(xpositive(_, Group)),
	not(xnegative(X, Group)),
	write('Вам нужен сериал '),
	write(X),
	write('?'),
	nl,
	write("Ответьте 'да', 'нет' или 'возможно' ->"),
	read(Reply),
	p_ans(X, Group, Reply).

p_ans(X, G, да):-
	asserta(xpositive(X, G)).

p_ans('Мини-сериал', 0, нет):-
	asserta(xpositive('Многосезонный', 0)),
	asserta(xnegative('Мини-сериал', 0)),
	fail.

p_ans('Многосезонный', 0, нет):-
	asserta(xpositive('Мини-сериал', 0)),
	asserta(xnegative('Многосезонный', 0)),
	fail.

p_ans(X, G, нет):-
	asserta(xnegative(X,G)),
	fail.

p_ans(_, G, возможно):-
	asserta(doesntmatter(_, G)).

countall(Cross, B) :-
	findall(Cross, xpositive(_,_), Pos),
	length(Pos, P),
	cross_is(Cross, A),
	B is (P/A) * 100.

clear:-
	retract(xpositive(_, _)),
	fail.
clear.
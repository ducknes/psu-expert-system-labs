domains
	BNO, RNO = integer
	COND = BNO*
	H = RNO*
	CAT = SYMBOL
database
	yes(BNO)
	no(BNO)
predicates
	rule(RNO, CAT, CAT, COND)
	cond(BNO, string)
	exp
	menu
	process(integer) 
	cconsult(CAT)
	clear
	work(H, CAT)
	check(RNO, H, COND)
	question(H, RNO, BNO, string)
	answer(H, RNO, string, BNO, integer)
clauses
	rule(1, "Сериал", "Мини-сериал", [1]).
	rule(2, "Сериал", "Многосезонный", [2]).
	
	rule(3, "Мини-сериал", "Чернобыль", [4, 9, 14, 13]).
	rule(4, "Мини-сериал", "Внутри убийцы", [3, 7, 8, 14]).
	rule(5, "Мини-сериал", "Трепачи", [3, 6, 14, 16]).
	rule(6, "Мини-сериал", "Ход королевы", [4, 10, 12, 9]).

	rule(7, "Многосезонный", "Шерлок", [4, 8, 14, 9]).
	rule(8, "Многосезонный", "Триггер", [3, 6, 14, 13]).
	rule(9, "Многосезонный", "Аватар: Легенда об Аанге", [4, 5, 12, 15]).
	rule(10, "Многосезонный", "Атака титанов", [4, 5, 6, 16]).
	rule(11, "Многосезонный", "Вампиры средней полосы", [3, 5, 11, 14]).
	rule(12, "Многосезонный", "Метод", [3, 7, 8, 14]).
	rule(13, "Многосезонный", "Во все тяжкие", [4, 8, 14, 9]).
	
	cond(1, "Мини-сериал").
	cond(2, "Многосезонный").

	cond(3, "Российский").
	cond(4, "Зарубежный").

	cond(5, "Аниме").
	cond(6, "Боевик").
	cond(7, "Триллер").
	cond(8, "Детектив").
	cond(9, "Драма").
	cond(10, "Комедия").
	cond(11, "Мелодрама").
	cond(12, "Приключение").
	cond(13, "Фантастика").
	cond(14, "Криминал").
	cond(15, "Детский").
	cond(16, "Ужасы").
	
	exp:- 
		makewindow(1,7,7,"ЭС(1)",0,0,25,80), 
		menu, nl, 
		write("ПРОБЕЛ для выхода -> "), 
		readchar(_), exit.
	menu:-
		write("1, Консультация"), nl,
		write("2, Выход"), nl,
		write("Ваш выбор (1 или 2) -> "),
		readint(Ch), process(Ch).
	
	process(1):-
		cconsult("Сериал"), clear.
	process(2):-
		removewindow.
	
	cconsult(X):- work([],X), !.
	cconsult(_):- 
		nl, write("Извините, но для вас нет подходящего сериала!").
	cconsult(_).
	
	work(_, X):- 
		not(rule(_,X,_,_)), !, nl,
		write("Ваш выбор -> ", X), nl.
	work(H, X):- 
		rule(RNO, X, NY, COND),
		check(RNO, H, COND),
		work([RNO|H], NY).
	
	check(RNO, H, [BNO|REST]):-
		yes(BNO),!,
		check(RNO, H, REST).
	check(_,_,[BNO|_]):-
		no(BNO),!, fail.
	check(RNO, H, [BNO|REST]):-
		cond(BNO, TEXT),
		question(H, RNO, BNO, TEXT),
		check(RNO, H, REST).
	check(_,_,[]).
	
	question(H, RNO, BNO, TEXT):-
		write("Вопрос: ", TEXT, "?"),
		write(" (1 или 2) -> "),
		readint(RESP),
		answer(H, RNO, TEXT, BNO, RESP).
	answer(_,_,_,BNO, 1):-
		asserta(yes(BNO)), 
		write("да"), nl.
	answer(_,_,_,BNO,2):-
		asserta(no(BNO)),
		write("нет"), nl, fail.
	
	clear:- 
		retract(yes(_)), fail;
		retract(no(_)), fail.
	clear.
goal
	exp.
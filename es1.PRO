% open in encoding windows-866
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
	rule(1, "��ਠ�", "����-�ਠ�", [1]).
	rule(2, "��ਠ�", "�����ᥧ����", [2]).
	
	rule(3, "����-�ਠ�", "��୮���", [4, 9, 14, 13]).
	rule(4, "����-�ਠ�", "����� 㡨���", [3, 7, 8, 14]).
	rule(5, "����-�ਠ�", "�९��", [3, 6, 14, 16]).
	rule(6, "����-�ਠ�", "��� ��஫���", [4, 10, 12, 9]).

	rule(7, "�����ᥧ����", "��૮�", [4, 8, 14, 9]).
	rule(8, "�����ᥧ����", "�ਣ���", [3, 6, 14, 13]).
	rule(9, "�����ᥧ����", "�����: ������� �� �����", [4, 5, 12, 15]).
	rule(10, "�����ᥧ����", "�⠪� �⠭��", [4, 5, 6, 16]).
	rule(11, "�����ᥧ����", "������� �।��� ������", [3, 5, 11, 14]).
	rule(12, "�����ᥧ����", "��⮤", [3, 7, 8, 14]).
	rule(13, "�����ᥧ����", "�� �� �寧��", [4, 8, 14, 9]).
	
	cond(1, "����-�ਠ�").
	cond(2, "�����ᥧ����").

	cond(3, "���ᨩ᪨�").
	cond(4, "���㡥���").

	cond(5, "�����").
	cond(6, "������").
	cond(7, "�ਫ���").
	cond(8, "��⥪⨢").
	cond(9, "�ࠬ�").
	cond(10, "�������").
	cond(11, "�����ࠬ�").
	cond(12, "�ਪ��祭��").
	cond(13, "�����⨪�").
	cond(14, "�ਬ����").
	cond(15, "���᪨�").
	cond(16, "�����").
	
	exp:- 
		makewindow(1,7,7,"��(1)",0,0,25,80), 
		menu, nl, 
		write("������ ��� ��室� -> "), 
		readchar(_), exit.
	menu:-
		write("1, ���������"), nl,
		write("2, ��室"), nl,
		write("��� �롮� (1 ��� 2) -> "),
		readint(Ch), process(Ch).
	
	process(1):-
		cconsult("��ਠ�"), clear.
	process(2):-
		removewindow.
	
	cconsult(X):- work([],X), !.
	cconsult(_):- 
		nl, write("�������, �� ��� ��� ��� ���室�饣� �ਠ��!").
	cconsult(_).
	
	work(_, X):- 
		not(rule(_,X,_,_)), !, nl,
		write("��� �롮� -> ", X), nl.
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
		write("�����: ", TEXT, "?"),
		write(" (1 ��� 2) -> "),
		readint(RESP),
		answer(H, RNO, TEXT, BNO, RESP).
	answer(_,_,_,BNO, 1):-
		asserta(yes(BNO)), 
		write("��"), nl.
	answer(_,_,_,BNO,2):-
		asserta(no(BNO)),
		write("���"), nl, fail.
	
	clear:- 
		retract(yes(_)), fail;
		retract(no(_)), fail.
	clear.
goal
	exp.
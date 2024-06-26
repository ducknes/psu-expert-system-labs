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
group_is("��୮���"):-
	it_is("����-�ਠ�"),
    it_is("���㡥���"),
	positive(has, "�ࠬ�"),
	positive(has, "�ਬ����"),
	positive(has, "�����⨪�"),!.

group_is("����� 㡨���"):-
	it_is("����-�ਠ�"),
    it_is("���ᨩ᪨�"),
	positive(has, "�ਫ���"),
	positive(has, "��⥪⨢"),
	positive(has, "�ਬ����"),!.

group_is("�९��"):-
	it_is("����-�ਠ�"),
    it_is("���ᨩ᪨�"),
	positive(has, "������"),
	positive(has, "�ਬ����"),
	positive(has, "�����"),!.

group_is("��� ��஫���"):-
	it_is("����-�ਠ�"),
    it_is("���㡥���"),
	positive(has, "�������"),
	positive(has, "�ਪ��祭��"),
	positive(has, "�ࠬ�"),!.

group_is("��૮�"):-
	it_is("�����ᥧ����"),
    it_is("���㡥���"),
	positive(has, "��⥪⨢"),
	positive(has, "�ਬ����"),
	positive(has, "�ࠬ�"),!.

group_is("�ਣ���"):-
	it_is("�����ᥧ����"),
    it_is("���ᨩ᪨�"),
	positive(has, "������"),
	positive(has, "�ਬ����"),
	positive(has, "�����⨪�"),!.

group_is("�����: ������� �� �����"):-
	it_is("�����ᥧ����"),
    it_is("���㡥���"),
	positive(has, "�����"),
	positive(has, "�ਪ��祭��"),
	positive(has, "���᪨�"),!.

group_is("�⠪� �⠭��"):-
	it_is("�����ᥧ����"),
    it_is("���㡥���"),
	positive(has, "�����"),
	positive(has, "������"),
	positive(has, "�����"),!.

group_is("������� �।��� ������"):-
	it_is("�����ᥧ����"),
    it_is("���ᨩ᪨�"),
	positive(has, "�����"),
	positive(has, "�����ࠬ�"),
	positive(has, "�ਬ����"),!.

group_is("��⮤"):-
	it_is("�����ᥧ����"),
    it_is("���ᨩ᪨�"),
	positive(has, "�ਫ���"),
	positive(has, "��⥪⨢"),
	positive(has, "�ਬ����"),!.

group_is("�� �� �寧��"):-
	it_is("�����ᥧ����"),
    it_is("���㡥���"),
	positive(has, "��⥪⨢"),
	positive(has, "�ਬ����"),
	positive(has, "�ࠬ�"),!.

it_is("���ᨩ᪨�"):-
	positive(is, "���ᨩ᪨�"), !.

it_is("���㡥���"):-
	positive(is, "���㡥���"), !.

it_is("����-�ਠ�"):- 
	positive(is, "����-�ਠ�"), !.

it_is("�����ᥧ����"):- 
	positive(is, "�����ᥧ����"), !.

do_expert_job:-
	makewindow(1,7,7,"��⮭�� ���� 21��2",1,16,22,58), nl,
	write("* * * * * * * * * * * * * * * * * * * *"),nl,
	write("���������� ������� �� ������� ��������"),nl,
	write(" "), nl,
	write("��������� �������� �� ������� � ���, �����? ������ �� ������ ���������"),nl,
	write("�����? ������ �� ������ ���������,"),nl,
	write("����� 'yes' ��� 'no'. "),nl,
	write("* * * * * * * * * * * * * * * * * * * *"),nl,
	do_consulting, readchar(_), nl,nl, removewindow, exit.
do_consulting :-group_is(X),!,nl,write("��� ������ : ",X,"."),nl,clear_facts.
do_consulting :-nl,write("������ �� ������� ��������� ! "), clear_facts.
  ask(X,Y) :-write(" �� ������ :- ",X," it ",Y," ?"),nl,readln(Reply), remember(X,Y,Reply).
positive(X,Y) :-xpositive(X,Y),!.
positive(X,Y) :-not(negative(X,Y)),!, ask(X,Y).
negative(X,Y) :-xnegative(X,Y),!.
remember(X,Y,yes) :-asserta(xpositive(X,Y)).
remember(X,Y,no) :-asserta(xnegative(X,Y)), fail.
clear_facts :-retract(xpositive(_,_)),fail.
clear_facts :-retract(xnegative(_,_)), fail.

% Предикат для представления ребер графа
edge(a, b).
edge(b, c).
edge(c, d).
edge(d, e).
edge(e, f).
edge(b, d).
edge(d, b).
edge(a, d).

% Предикат для поиска пути от начальной вершины до конечной, проходящего через заданную вершину
find_path(Start, End, Via, Path) :-
    travel(Start, End, [Start], Via, Path),
    Path \= [],
    reverse(Path, RPath),
    write('Path: '), write(RPath), nl, fail.
find_path(_, _, _, _).

% Предикат для рекурсивного поиска пути
travel(End, End, P, _, P).
travel(Start, End, P, Via, Path) :-
    edge(Start, X),
    \+ member(X, P),
    (X = Via ; travel(X, End, [X|P], Via, Path)).

% Пример использования:
%?- find_path(a, f, d, Path).
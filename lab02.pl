% Предикат для подсчета вершин на заданном уровне
count_vertices_at_level(_, 0, 1) :- !.
count_vertices_at_level(tree(_, SubTrees), Level, Count) :-
    Level > 0,
    Level1 is Level - 1,
    findall(CountAtLevel, (member(SubTree, SubTrees), count_vertices_at_level(SubTree, Level1, CountAtLevel)), Counts),
    sum_list(Counts, Count).

count_vertices(Level) :-
    count_vertices_at_level(
        tree(a, [
            tree(b, [
                tree(d, []),
                tree(e, [])
            ]),
            tree(c, [
                tree(f, []),
                tree(g, [])
            ])
        ]), Level, Count),
        write("Кол-во вершин на "), write(Level), write(" уровне: "), write(Count), nl.

% Примеры использования:
% ?- count_vertices(2).

%      a
%    /   \
%   b     c
%  / \   / \
% d   e f   g 

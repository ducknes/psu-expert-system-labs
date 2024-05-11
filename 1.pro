DOMAINS
    node = symbol
    path = node*
PREDICATES
    edge(node, node)
    path(node, node, path)
    path(node, node, path, path)
    path_with_node(node, node, node, path)
    append(path, path, path)
CLAUSES
    edge(a, b).
    edge(b, c).
    edge(c, d).
    edge(d, e).
    edge(e, a).
    path(Start, End, ResultPath) :-
        path(Start, End, [Start], ResultPath).
    path(Start, End, TempPath, ResultPath) :-
        edge(Start, End),
        append(TempPath, [End], ResultPath).
    path(Start, End, TempPath, ResultPath) :-
        edge(Start, Next),
        not(member(Next, TempPath)),
        append(TempPath, [Next], NewTempPath),
        path(Next, End, NewTempPath, ResultPath).
    path_with_node(Start, End, Node, ResultPath) :-
        path(Start, End, ResultPath),
        member(Node, ResultPath).

    append(TempPath, [End], ResultPath) :-
        not(member(End, TempPath)),
        append(TempPath, [End], ResultPath).
    
goal
    path(a, d, c), write(c).
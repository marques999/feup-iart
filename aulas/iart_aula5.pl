%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Formalização do jogo dos palitos:
% - existem inicialmente 10 palitos sobre a mesa
% - cada jogador pode retirar um, dois ou três palitos na sua vez
% - o objectivo é evitar ficar com o último palito
%%%%%%%%%%

% a representação do estado vai incluir também o jogador a jogar,
% pois neste jogo é importante para efeitos de avaliação do estado

% representação de um estado: (NumeroPalitos, Quemjoga)

estado_inicial((10,max)).

% estado final (ter 0 palitos é bom): só interessa para o minimax simples
estado_final((0,max), 1).
estado_final((0,min), 0).

% transições entre estados (as jogadas são as mesmas para os 2 jogadores)
sucessor((N,max), max, (N1,min)) :- N>0, N1 is N-1.
sucessor((N,max), max, (N1,min)) :- N>1, N1 is N-2.
sucessor((N,max), max, (N1,min)) :- N>2, N1 is N-3.
sucessor((N,min), min, (N1,max)) :- N>0, N1 is N-1.
sucessor((N,min), min, (N1,max)) :- N>1, N1 is N-2.
sucessor((N,min), min, (N1,max)) :- N>2, N1 is N-3.

% avaliação de estados
minimax(E, _, V, _):-
	estado_final(E, V).
minimax(E, max, V, J):-
	findall(E1, sucessor(E, max, E1), LJ),
	max_value(LJ, V, J).
minimax(E, min, V, J):-
	findall(E1, sucessor(E, min, E1), LJ),
	min_value(LJ, V, J).

max_value([E], V, E):-
	minimax(E, min, V, _).
max_value([E|Es], MV, ME):-
	minimax(E, min, V, _),
	max_value(Es, V2, M2),
	(
		V > V2, !,
		MV = V, ME = E;
		MV = V2, ME = M2
	).

avalia((N, max), V):-
	(1 is N mod 4, !, V = 0; V = 1).
avalia((N, min), V):-
	(1 is N mod 4, !, V = 1; V = 0).

min_value([E], V, E):-
	minimax(E, max, V, _).
min_value([E|Es], MV, ME):-
	minimax(E, max, V, _),
	min_value(Es, V2, M2),
	(
		V =< V2, !,
		MV = V, ME = E;
		MV = V2, ME = M2
	).

palitos:-
	estado_inicial(Ei),
	minimax(Ei, max, V, J),
	write(V), nl,
	write(J).

% com 1 palito -> ADVERSÁRIO GANHA
% com 2 palitos -> tiro 1, adversário fica com último
% com 3 palitos -> tiro 2, adversário fica com último
% com 4 palitos -> tiro 3, adversário fica com último
% com 5 palitos -> ADVERSÁRIO GANHA
% com 6 palitos -> tiro 1, adversário tira 3, tiro 1, adversário fica com último
% com 7 palitos -> tiro 2, adversário tira 3, tiro 1, adversário fica com último
% com 9 palitos -> ADVERSÁRIO GANHA
% com 10 palitos ->
% com 13 palitos -> ADVERSÁRIO GANHA

max_value_profundidade([E], P, V, E):-
	P1 is P - 1,
	minimax_profundidade(E, min, P1, V, _).
max_value_profundidade([E|Es], P, MV, ME):-
	P1 is P - 1,
	minimax_profundidade(E, min, P1, V, _),
	max_value_profundidade(Es, P, V2, M2),
	(
		V > V2, !,
		MV = V, ME = E;
		MV = V2, ME = M2
	).

minimax_profundidade(E, _, 0, V, _):-
	avalia(E, V).
minimax_profundidade(E, _, _, V, _):-
	estado_final(E, V).
minimax_profundidade(E, max, P, V, J):-
	findall(E1, sucessor(E, max, E1), LJ),
	max_value_profundidade(LJ, P, V, J).
minimax_profundidade(E, min, P, V, J):-
	findall(E1, sucessor(E, min, E1), LJ),
	min_value_profundidade(LJ, P, V, J).

min_value_profundidade([E], P, V, E):-
	P1 is P - 1,
	minimax_profundidade(E, max, P1, V, _).
min_value_profundidade([E|Es], P, MV, ME):-
	P1 is P - 1,
	minimax_profundidade(E, max, P1, V, _),
	min_value_profundidade(Es, P, V2, M2),
	(
		V =< V2, !,
		MV = V, ME = E;
		MV = V2, ME = M2
	).
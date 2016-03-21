%=============================================================================%
% 2.1) Dois baldes, de capacidades 4 litros e 3 litros, respetivamente, estão %
%      inicialmente vazios.                                                   %
%      Os baldes não possuem qualquer marcação intermédia.                    %
%      As únicas operações que pode realizar são:                             %
%          1. esvaziar um balde                                               %
%          2. encher (completamente) um balde                                 %
%          3. despejar um balde para o outro até que o segundo fique cheio    %
%          4. despejar um balde para o outro até que o primeiro fique vazio   %
%=============================================================================%

% estado inicialmente
baldes_estado_inicial(b(0, 0)).

% estado final
baldes_estado_final(b(2, 0)).

% posso encher o 1º balde desde que não esteja cheio
sucessor_baldes(b(X, Y), b(4, Y)):- X < 4.

% posso encher o 2º balde se não estiver cheio
sucessor_baldes(b(X, Y), b(X, 3)):- Y < 3.

% posso esvaziar o 1º balde desde que não esteja vazio
sucessor_baldes(b(X, Y), b(X, 0)):- Y > 0.

% posso esvaziar o 2º balde desde que não esteja vazio
sucessor_baldes(b(X, Y), b(0, Y)):- X > 0.

% posso encher o 1º balde a partir do 2º balde
sucessor_baldes(b(X, Y), b(4, Y1)):-
	X + Y >= 4,
	X < 4,
	Y1 is Y - (4 - X).

% posso encher o 2º balde a partir do 1º balde
sucessor_baldes(b(X, Y), b(X1, 3)):-
	X + Y >= 3,
	Y < 3,
	X1 is X - (3 - Y).

% posso encher o 1º balde esvaziando o 2º balde
sucessor_baldes(b(X, Y), b(X1, 0)):-
	X + Y < 4,
	Y > 0,
	X1 is X + Y.

% posso encher o 2º balde esvaziando o 1º balde
sucessor_baldes(b(X, Y), b(0, Y1)):-
	X + Y < 3,
	X > 0,
	Y1 is X + Y.

%=============================================================================%
% a) Quais as operações a efetuar de modo a que o primeiro balde contenha     %
%    dois litros? Resolva este problema usando a estratégia "primeiro em      %
%    profundidade".                                                           %
%=============================================================================%

% pesquisa em profundidade: INCOMPLETA
baldes_dfs(E, _, [E]):-
	baldes_estado_final(E).
baldes_dfs(E, V, [E|Es]):-
	sucessor_baldes(E, E1),
	\+member(E1, V),
	baldes_dfs(E1, [E1|V], Es).
baldes_dfs:-
	baldes_estado_inicial(Ei),
	baldes_dfs(Ei, [Ei], S),
	write(S).

%=============================================================================%
% b) Quais as operações a efetuar de modo a que o primeiro balde contenha     %
%    dois litros? Resolva este problema usando a estratégia "primeiro em      %
%    largura".                                                                %
%=============================================================================%

% pesquisa em largura: COMPLETA
baldes_bfs([[E|Path]|_], [E|Path]):-
	baldes_estado_final(E).
baldes_bfs([[E|Path]|R], S):-
	findall([E1|[E|Path]], (sucessor_baldes(E, E1), \+member(E1, [E|Path])), LS),
	append(R, LS, L),
	baldes_bfs(L, S).
baldes_bfs:-
	baldes_estado_inicial(Ei),
	baldes_bfs([[Ei|[]]], S),
	write(S).

%=============================================================================%
% 2.2) Três missionários e três canibais, que se encontram na margem esquerda %
%      de um rio, querem atravessar para a margem direita. O barco existente  %
%      transporta, no máximo, duas pessoas. O número de canibais nunca pode   %
%      ser superior ao número de missionários em qualquer margem do rio.      %
%=============================================================================%

% estado inicial
missionarios_estado_inicial(estado(3, 3, 1)).

% estado final
missionarios_estado_final(estado(0, 0, 0)).

missionarios_sucessor(estado(NM, NC, 1), NovoEstado) :-
	NM1 is NM - 1,
	NC1 is NC - 1,
	NovoEstado = estado(NM1, NC1, 0),
	missionarios_legal(NovoEstado).

missionarios_sucessor(estado(NM, NC, 1), NovoEstado) :-
	NM1 is NM - 1,
	NovoEstado = estado(NM1, NC, 0),
	missionarios_legal(NovoEstado).

missionarios_sucessor(estado(NM, NC, 1), NovoEstado) :-
	NC1 is NC - 1,
	NovoEstado = estado(NM, NC1, 0),
	missionarios_legal(NovoEstado).

missionarios_sucessor(estado(NM, NC, 1), NovoEstado) :-
	NM1 is NM - 2,
	NovoEstado = estado(NM1, NC, 0),
	missionarios_legal(NovoEstado).

missionarios_sucessor(estado(NM, NC, 1), NovoEstado) :-
	NC1 is NC - 2,
	NovoEstado = estado(NM, NC1, 0),
	missionarios_legal(NovoEstado).

missionarios_sucessor(estado(NM, NC, 0), NovoEstado) :-
	NM1 is NM + 1,
	NC1 is NC + 1,
	NovoEstado = estado(NM1, NC1, 1),
	missionarios_legal(NovoEstado).

missionarios_sucessor(estado(NM, NC, 0), NovoEstado) :-
	NM1 is NM + 1,
	NovoEstado = estado(NM1, NC, 1),
	missionarios_legal(NovoEstado).

missionarios_sucessor(estado(NM, NC, 0), NovoEstado) :-
	NC1 is NC + 1,
	NovoEstado = estado(NM, NC1, 1),
	missionarios_legal(NovoEstado).

missionarios_sucessor(estado(NM, NC, 0), NovoEstado) :-
	NM1 is NM + 2,
	NovoEstado = estado(NM1, NC, 1),
	missionarios_legal(NovoEstado).

missionarios_sucessor(estado(NM, NC, 0), NovoEstado) :-
	NC1 is NC + 2,
	NovoEstado = estado(NM, NC1, 1),
	missionarios_legal(NovoEstado).

missionarios_legal(estado(NM, NC, _)) :-
	NM >= 0,
	NC >= 0,
	NM =< 3,
	NC =< 3,
	(NM >= NC; NM = 0),
	NMdireita is 3-NM,
	NCdireita is 3-NC,
	(NMdireita >= NCdireita; NMdireita = 0).

%=============================================================================%
% a) Determine as operações a realizar, utilizando pesquisa em profundidade   %
%=============================================================================%

% pesquisa em profundidade: INCOMPLETA
missionarios_dfs(E, _, [E]):-
	missionarios_estado_final(E).
missionarios_dfs(E, V, [E|Es]):-
	missionarios_sucessor(E, E1),
	\+member(E1, V),
	missionarios_dfs(E1, [E1|V], Es).
missionarios_dfs:-
	missionarios_estado_inicial(Ei),
	missionarios_dfs(Ei, [Ei], S),
	write(S).

%=============================================================================%
% b) Determine as operações a realizar, utilizando pesquisa em largura        %
%=============================================================================%

% pesquisa em largura: COMPLETA
missionarios_bfs([[E|Path]|_], [E|Path]):-
	missionarios_estado_final(E).
missionarios_bfs([[E|Path]|R], S):-
	findall([E1|[E|Path]], (missionarios_sucessor(E, E1), \+member(E1, [E|Path])), LS),
	append(R, LS, L),
	missionarios_bfs(L, S).
missionarios_bfs:-
	missionarios_estado_inicial(Ei),
	missionarios_bfs([[Ei|[]]], S),
	write(S).

%=============================================================================%
% 2.3) Este puzzle contém 4 blocos (2 pretos, 2 brancos) numa linha de cinco  %
%      posições. Considere como inicial o estado representado na figura:      %
%      | P | P | B | B | V |
%      O objectivo é colocar todos os blocos brancos (B) à esquerda de todos  %
%      os blocos pretos (P). As operações permitidas são as seguintes:        %
%          1) um bloco pode mover-se para a posição vazia (V) adjacente com   %
%             custo unitário;                                                 %
%          2) um bloco pode saltar por cima de um outro bloco para a posição  %
%             vazia, com custo unitário;                                      %
%          3) um bloco pode saltar por cima de dois outros blocos para a      %
%             posição vazia, com custo = 2;                                   %
%=============================================================================%

% estado inicial
puzzle_estado_inicial([p, p, b, b, v]).

% estado final
puzzle_estado_final(E):-
	brancasAntesPretas(E, 2).

brancasAntesPretas(_, 0) :- !.
brancasAntesPretas([b|R], NB) :-
	NB1 is NB-1,
	brancasAntesPretas(R, NB1).
brancasAntesPretas([v|R], NB) :-
	brancasAntesPretas(R, NB).

puzzle_sucessor(E,E2):- moveAdj(E,E2).
puzzle_sucessor(E,E2):- salta1(E,E2).
puzzle_sucessor(E,E2):- salta2(E,E2).

moveAdj([X,v|R], [v,X|R]).
moveAdj([v,X|R], [X,v|R]).
moveAdj([X|R], [X|R1]):- moveAdj(R,R1).

salta1([X1,X2,v|R], [v,X2,X1|R]).
salta1([v,X1,X2|R], [X2,X1,v|R]).
salta1([X|R], [X|R1]):- salta1(R,R1).

salta2([X1,X2,X3,v|R], [v,X2,X3,X1|R]).
salta2([v,X1,X2,X3|R], [X3,X1,X2,v|R]).
salta2([X|R], [X|R1]):- salta2(R,R1).

%=============================================================================%
% a) Resolva este problema utilizando a estratégia "primeiro em profundidade" %
%=============================================================================%

% pesquisa em profundidade: INCOMPLETA
puzzle_dfs(E, _, [E]):-
	puzzle_estado_final(E).
puzzle_dfs(E, V, [E|Es]):-
	puzzle_sucessor(E, E1),
	\+member(E1, V),
	puzzle_dfs(E1, [E1|V], Es).
puzzle_dfs:-
	puzzle_estado_inicial(Ei),
	puzzle_dfs(Ei, [Ei], S),
	write(S).

%=============================================================================%
% b) Resolva esta problema utilizando a estratégia "primeiro em largura"
%=============================================================================%

% pesquisa em largura: COMPLETA
puzzle_bfs([[E|Path]|_], [E|Path]):-
	puzzle_estado_final(E).
puzzle_bfs([[E|Path]|R], S):-
	findall([E1|[E|Path]], (puzzle_sucessor(E, E1), \+member(E1, [E|Path])), LS),
	append(R, LS, L),
	puzzle_bfs(L, S).
puzzle_bfs:-
	puzzle_estado_inicial(Ei),
	puzzle_bfs([[Ei|[]]], S),
	write(S).
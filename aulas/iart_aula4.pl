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
sucessor_baldes(b(X, Y), b(4, Y), C):- X < 4, C is 4 - X.

% posso encher o 2º balde se não estiver cheio
sucessor_baldes(b(X, Y), b(X, 3), C):- Y < 3, C is 3 - Y.

% posso esvaziar o 1º balde desde que não esteja vazio
sucessor_baldes(b(X, Y), b(X, 0), C):- Y > 0, C is Y.

% posso esvaziar o 2º balde desde que não esteja vazio
sucessor_baldes(b(X, Y), b(0, Y), C):- X > 0, C is X.

% posso encher o 1º balde a partir do 2º balde
sucessor_baldes(b(X, Y), b(4, Y1), Y1):-
	X + Y >= 4,
	X < 4,
	Y1 is Y - (4 - X).

% posso encher o 2º balde a partir do 1º balde
sucessor_baldes(b(X, Y), b(X1, 3), X1):-
	X + Y >= 3,
	Y < 3,
	X1 is X - (3 - Y).

% posso encher o 1º balde esvaziando o 2º balde
sucessor_baldes(b(X, Y), b(X1, 0), X1):-
	X + Y < 4,
	Y > 0,
	X1 is X + Y.

% posso encher o 2º balde esvaziando o 1º balde
sucessor_baldes(b(X, Y), b(0, Y1), Y1):-
	X + Y < 3,
	X > 0,
	Y1 is X + Y.


% função heurística (A* garante solução óptima se h for admissível)
% [X-Xf] + [Y-Yf] não é uma função admissível
% se max é admissível, então min também será
% das duas, escolher aquela que melhor se aproxima da solução
h(b(X, Y), H):-
	baldes_estado_final(b(Xf, Yf)),
	H is max(abs(X - Xf), abs(Y - Yf)).

% algoritmo A*
astar([(F, _, [E|Cam])|_], (F, [E|Cam])):-
	baldes_estado_final(E).

astar([(_, G, [E|Cam])|R], S):-
	findall((F1, G1, [E1|[E|Cam]]), (
		sucessor_baldes(E, E1, C),
		G1 is G + C,
		h(E1, H1),
		F1 is G1 + H1
	), LS),
	append(R, LS, L),
	sort(L, Lordenada),
	astar(Lordenada, S).

solve_astar:-
	baldes_estado_inicial(Ei),
	h(Ei, Hi),
	astar([(Hi,0,[Ei])], S),
	write(S).
slots(4).

disciplinas(12).
disciplina(1,[1,2,3,4,5]). % Os alunos 1,2,3,4,5 estão inscritos à disciplina 1
disciplina(2,[6,7,8,9]).
disciplina(3,[10,11,12]).
disciplina(4,[1,2,3,4]).
disciplina(5,[5,6,7,8]).
disciplina(6,[9,10,11,12]).
disciplina(7,[1,2,3,5]).
disciplina(8,[6,7,8]).
disciplina(9,[4,9,10,11,12]).
disciplina(10,[1,2,4,5]).
disciplina(11,[3,6,7,8]).
disciplina(12,[9,10,11,12]).

%===================================================================================%
% a) Construa um predicado que lhe permita calcular a tabela de incompatibilidades, %
%    ou seja, para cada par de disciplinas calcule o número de alunos que estão     %
%    inscritos a ambas simultaneamente.                                             %
%===================================================================================%

% intersecção das listas dos alunos inscritos
incompat(D1, D2, N):-
	disciplina(D1, LA1),
	disciplina(D2, LA2),
	findall(A, (member(A, LA1), member(A, LA2)), LAI),
	length(LAI, N).

:- use_module(library(between)).
:- use_module(library(lists)).

%
faval(Sol, Custo):-
	findall(N,
	(nth1(D1, Sol, X),
	nth1(D2, Sol, X),
	D1 < D2,
	incompat(D1, D2, N)),
	L),
	sumlist(L, Custo).


hillclimb(Sol, SolF):-
	faval(Sol, C),
	vizinho(Sol, Sol2),
	faval(Sol2, C2),
	C2 < C,
	!,
	hillclimb(Sol2, SolF).
hillclimb(Sol, Sol).

vizinho(Sol, Sol2):-
	slots(Ns),
	nth1(D, Sol, Slot),
	between(1, Ns, NovoSlot),
	NovoSlot \= Slot,
	D1 is D - 1,
	length(Prefix, D1),
	append(Prefix, [Slot|Suffix], Sol),
	append(Prefix, [NovoSlot|Suffix], Sol2).

horarios:-
	hillclimb([1,1,1,1,1,1,1,1,1,1,1,1], Sol1),
	write(Sol1), nl,
	hillclimb([1,1,1,2,2,2,3,3,3,4,4,1], Sol2),
	write(Sol2), nl,
	hillclimb([1,1,4,2,2,2,3,3,3,4,4,1], Sol3),
	write(Sol3), nl,
	hillclimb([1,2,3,4,1,2,3,4,1,2,3,4], Sol4),
	write(Sol4), nl.
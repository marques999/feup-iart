% a) Defina um formato adequado para a implementação, em Prolog, das regras
%    descritas acima. Note que irá ser necessário construir um mecanismo de
%    inferência que permita calcular os factores de certeza de cada uma das
%    soluções possíveis. Isto significa que será necessário: calcular os
%    factores de certeza das premissas de uma regra, combinar os factores de
%    certeza das premissas com a conclusão, combinar os factores de certeza de
%    várias regras. Sugestão: use uma respresentação que permita distinguir as
%    premissas de uma regra e a sua conclusão.

% apenas posso ter operadores "e" à direita (associatividade à direita, infixo)
:- op(800, xfy, e).

% apenas posso ter um operador "então" em cada frase (xFx sem associatividade, infixo)
:- op(950, xfx, entao).

% apenas posso ter um operador "se" à esquerda (fX com associatividade á direita, prefixo)
:- op(850, fx, se).

% apenas posos ter um operador "com" em cada frase (xFx sem associativdade, infixo)
:- op(750, xfx, com).

% b) Defina um formato apropriado para representar os factos. Não se esqueça
%    que a um facto está associado um factor de certeza.

% R1
se motor=nao e bateria=ma entao problema=bateria com fc=1.
% R2
se luz=fraca entao bateria=ma com fc=0.8.
% R3
se radio=fraco entao bateria=ma com fc=0.8.
% R4
se luz=boa e radio=bom entao bateria=boa com fc=0.8.
% R5
se motor=sim e cheiro_gas=sim entao problema=encharcado com fc=0.8.
% R6
se motor=nao e bateria=boa e indicador_gas=vazio entao problema=sem_gasolina com fc=0.9.
% R7
se motor=nao e bateria=boa e indicador_gas=baixo entao problema=sem_gasolina com fc=0.3.
% R8
se motor=nao e cheiro_gas=nao e ruido_motor=nao_ritmado e bateria=boa entao problema=motor_gripado com fc=0.7.
% R9
se motor=nao e cheiro_gas=nao e bateria=boa entao problema=carburador_entupido com fc=0.9.
% R10
se motor=nao e bateria=boa entao problema=velas_estragadas com fc=0.8.

% c) Construa o mecanismo de inferência.
%    Distinga os seguintes casos, para provar cada objectivo:
%      - o objectivo já existe como um facto.
%      - o valor do atributo deve ser pedido ao utilizador (declare explicitamente quais os atributos a perguntar ao utilizador).
%      - o objectivo pode ser deduzido a partir de regras existentes.

:- dynamic facto/3.

questionavel(motor, 'O motor funciona?', [sim, nao]).
questionavel(radio, 'O sinal do rádio está bom ou fraco?', [fraco, bom]).
questionavel(cheiro_gas, 'Cheira a gasolina?', [sim, nao]).
questionavel(luzes, 'As luzes estão boas ou fracas?', [fraca, boa]).
questionavel(indicador_gas, 'O indicador da gasolina está vazio, baixo ou cheio?', [vazio, baixo, cheio]).
questionavel(ruido_motor, 'O ruído do motor é ritmado ou não ritmado?', [ritmado, nao_ritmado]).

% facto(Atributo, Valor, Fator_Certeza)

verificar(A, V, FC):-
	facto(A, V, FC), !.
verificar(A, V, _):-
	facto(A, V2, _),
	V2 \= V, !, fail.
verificar(A, V, FC):-
	questionavel(A, P, LR),
	write(P:LR), read(R),
	write('fc?'), read(FC),
	assert(facto(A, R, FC)),
	!, R = V.
verificar(A, V, FC):
	deduz(A, V, FC).

deduz(A, V, FC):-
	se Premissas entao A=V com fc=FCRegra,
	prova(Premissas, FCPremissas),
	FCNovo is FCPremissas * FCRegra,
	atualiza(A, V, FCNovo),
	fail.
deduz(A, V, FC):-
	facto(A, V, FC).

atualiza(A, V, FC):-
	facto(A, V, FCVelho), !,
	FCNovo is FC + FCVelho * (1 - FC),
	retract(facto(A, V, FCVelho)),
	assert(facto(A, V, FCNovo)).
atualiza(A, V, FC):-
	assert(facto(A, V, FC)).

prova(A=V, FC):-
	verificar(A, V, FC).
prova(A=V e Premissas, FC):-
	prova(A=V, FC1),
	prova(Premissas, FC2),
	FC is min(FC1, FC2).
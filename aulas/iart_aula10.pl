% 8

determinante(s-m) --> [o].
determinante(p-m) --> [os].
determinante(s-f) --> [a].

preposicao(_) --> [de].
preposicao(s-f) --> [da].

nome(p-m, rapaz) --> [rapazes].
nome(s-m, rapaz) --> [rapaz].
nome(s-m, rui) --> [rui].
nome(s-m, luis) --> [luis].
nome(s-f, rita) --> [rita].
nome(s-f, ana) --> [ana].
nome(s-f, maria) --> [maria].
nome(s-m, elefante) --> [elefante].
nome(p-m, cao) --> [caes].
nome(p-m, gato) --> [gatos].
nome(s-m, cao) --> [cao].
nome(s-m, gato) --> [gato].
nome(s-m, futebol) --> [futebol].
nome(p-m, morango) --> [morangos].
nome(p-m, amendoim) --> [amendoins].
nome(p-m, bolacha) --> [bolachas].
nome(p-m, humano) --> [humanos].
nome(p-f, pessoa) --> [pessoas].

verbo(s, jogar, S, O) --> [joga], {humano(S), jogo(O)}.
verbo(p, jogar, S, O) --> [jogam], {humano(S), jogo(O)}.
verbo(s, gostar, _, _) --> [gosta].
verbo(p, gostar, _, _) --> [gostam].
verbo(s, comer, S, O) --> [come], {ser(S, _), comestivel(O)}.
verbo(p, comer, S, O) --> [comem], {ser(S, _), comestivel(O)}.
verbo(p, ser, _, _) --> [sao].

%%%
% base de dados
%

humano(pokemon).
humano(rapaz).
humano(rui).
humano(maria).
humano(rita).
humano(ana).
humano(luis).
humano(humano).
humano([]).
humano([H|T]) :- humano(H), humano(T).

jogar(rapaz, futebol).
jogar(rui, futebol).
jogar(pokemon, futebol).

jogo(futebol).

gostar(luis, morango).
gostar(rita, morango).
gostar(ana, morango).
gostar(rui, maria).
gostar(cao, bolacha).
gostar(gato, bolacha).

comer(elefante, amendoim).

comestivel(amendoim).
comestivel(morango).
comestivel(bolacha).

ser(rui, rapaz).
ser(cao, animal).
ser(gato, animal).
ser(X, humano) :- humano(X).

% 8.1 - Interpretação de frases declarativas (DCG)
%
% Escreva um programa para interpretar frases declarativas. Se a frase
% estiver correcta, o programa deve indicar a concordância ou não com
% a afirmação efectuada. Se a frase estiver incorrecta, o programa deve
% indicar se se trata de um erro sintático ou semântico.
% As frases a analisar são do tipo:

frase(Q, At, A, O) --> sintagma_interrogativo(N, At, Q), sintagma_verbal(N, A, _, O).

sintagma_nominal(N, S) --> determinante(N-G), nome(N-G, S).
sintagma_nominal(N, S) --> nome(N-_, S).

sintagma_verbal(N, gostar, S, O) --> verbo(N, gostar, S, O), preposicao(N1-G1), nome(N1-G1, O).
sintagma_verbal(N, A, S, O) --> verbo(N, A, S, O), sintagma_nominal(_, O).

sintagma_interrogativo(N, At, Q) --> pronome_interrogativo(N-G, Q), sintagma_nominal_interrogativo(N-G, At).
sintagma_interrogativo(N, _, Q) --> pronome_interrogativo(N-_, Q).

sintagma_nominal_interrogativo(N-G, At) --> determinante(N-G), nome(N-G, At), pronome(_).
sintagma_nominal_interrogativo(N-G, At) --> nome(N-G, At).

concorda(A, S, O):-
	P =.. [A, S, O],
	(P, !, write(concordo); write(discordo)).

% 8.2

%%%
% gramática
%

pronome_interrogativo(_-_, qualitativo) --> [quem].
pronome_interrogativo(p-_, qualitativo) --> [quais].
pronome_interrogativo(p-m, quantitativo) --> [quantos].
pronome_interrogativo(p-f, quantitativo) --> [quantas].

pronome(_) --> [que].

responde(Q, A, At, O):-
	var(At),
	P =.. [A, S, O],
	findall(S, P, L),
	(
		Q = qualitativo, !, write(L)
		;
		length(L, N), write(N)
	).
responde(Q, A, At, O):-
	\+var(At),
	P=.. [A, S, O],
	findall(S, (P, ser(S, At)), L),
	(
		Q = qualitativo, !, write(L)
		;
		length(L, N), write(N)
	).
% consult(['~/Desktop/feup-iart-master/proj1/server/gramatica.pl']).

%---------------------------------------------------------%
%                      PILHA DE TESTES                    %
%---------------------------------------------------------%

% cont(N-G,Nac,[e,portugueses,e,ingleses],[]).

% atributo(N-G, Adj, Nac, Cont, [mais,recente], []).
% atributo(N-G, Adj, Nac, Cont, [antigo], []).
% atributo(N-G, Adj, Nac, Cont, [portugueses], []).

% atributo(N-G, Adj, Nac, Cont, [portugueses, e, americanos], []).
% atributo(N-G, Adj, Nac, Cont, [europeus, e, africanos], []).

% atributo(N-G, Adj, Nac, Cont, [sul-americano], []).
% --
% atributo(N-G, Adj, Nac, Cont, [mais, bonito], []).
% atributo(N-G, Adj, Nac, Cont, [o, mais, bonito], []).
% atributo(N-G, Adj, Nac, Cont, [marciano], []).

% nom(N-G,Adj,Nom, Nac, Cont, Gen, [livros],[]).
% nom(N-G,Adj,Nom, Nac, Cont, Gen, [livros,mais,recentes],[]).
% nom(N-G,Adj,Nom, Nac, Cont, Gen, [escritores, europeus],[]).
% nom(N-G,Adj,Nom, Nac, Cont, Gen, [autor, portugues],[]).
% nom(N-G,Adj,Nom, Nac, Cont, Gen, [dramas, mais, recentes],[]).
% --
% nom(N-G,Adj,Nom, Nac, Cont, Gen, [as, comedias, mais, antigas],[]).

% com_deter(N-G,Adj,Nom,Nac,Cont,Gen,[de,autores,ingleses],[]).
% com_deter(N-G,Adj,Nom,Nac,Cont,Gen,[das,comedias,mais,antigas],[]).
% --
% com_deter(N-G,Adj,Nom,Nac,Cont,Gen,[da,comedias,mais,antigas],[]).

% sint_nom_int(N-G,Adj,Nom,Nac,Cont,Gen, [quais, as, escritoras, que],[]).
% sint_nom_int(N-G,Adj,Nom,Nac,Cont,Gen, [quais, os, escritores, portugueses, que],[]).
% sint_nom_int(N-G,Adj,Nom,Nac,Cont,Gen, [quais, as, comedias, mais, recentes, das, escritoras, inglesas, que],[]).
% sint_nom_int(N-G,Adj,Nom,Nac,Cont,Gen, [quais, os, livros, mais, recentes, das, escritoras, inglesas, que],[]).
% sint_nom_int(N-G,Adj,Nom,Nac,Cont,Gen, [que,escritoras,inglesas],[]).
% sint_nom_int(N-G,Adj,Nom,Nac,Cont,Gen, [que, dramas, de, escritoras, portuguesas],[]).
% sint_nom_int(N-G,Adj,Nom,Nac,Cont,Gen, [quantas, comedias],[]).
% sint_nom_int(N-G,Adj,Nom,Nac,Cont,Gen, [quando],[]).
% sint_nom_int(N-G,Adj,Nom,Nac,Cont,Gen, [quem],[]).
% sint_nom_int(N-G,Adj,Nom,Nac,Cont,Gen, [quantos, livros, de, escritores, portugueses],[]).
% sint_nom_int(N-G,Adj,Nom,Nac,Cont,Gen, [que,livros,mais,antigas],[]).
% --
% sint_nom_int(N-G,Adj,Nom,Nac,Cont,Gen, [quando, as, comedias, mais, recentes, de, escritoras, inglesas, que],[]).
% sint_nom_int(N-G,Adj,Nom,Nac,Cont,Gen, [quais, os, escritores, mais, recentes, das, escritoras, inglesas, que],[]).

clear :- write('\33\[2J').

%---------------------------------------------------------%
%                          INCLUDES                       %
%---------------------------------------------------------%

?- ensure_loaded('bibliogenie.pl').
?- ensure_loaded('lexico.pl').
%?- ensure_loaded('query.pl').
%?- ensure_loaded('server.pl').

contx_cont(N-G,[H|T]) --> [e], subst_cont(N-G,H), (contx_cont(N-G,T);[]).                                     % ... e europeus e africanos ...
contx_cont(_-_,[]) --> [].

contx_nac(N-G,[H|T]) --> [e], subst_nac(H,N-G), (contx_nac(N-G,T);[]).                                        % ... e portugueses e franceses ...
contx_nac(_-_,[]) --> [].

contx_gen(N-_,[H|T]) --> [e], subst_gen(H,N-_), (contx_gen(N-_,T);[]).                                        % ... e dramas e romances ...
contx_gen(_-_,[]) --> [].

atributo(N-G, AdjComp, _, _) --> adjetivo_super(GrAdj), adjetivo(N-G, Adj), {adj_comp(GrAdj,Adj,AdjComp)}.    % ... mais recente ...
atributo(N-G, Adj, _, _) --> adjetivo(N-G, Adj).                                                              % ... antigo ...
atributo(N-G, _, [Nac|T], _) --> subst_nac(Nac,N-G), (contx_nac(N-G,T);[]).                                   % ... portugueses ....
atributo(N-G, _, _, [Cont|T]) --> subst_cont(N-G,Cont), (contx_cont(N-G,T);[]).                               % ... sul-americano ...

nom(N-G,Adj,Nom, Nac, Cont, _) --> subst(N-G,Nom), atributo(N-G, Adj, Nac, Cont).                             % ... escritores europeus ...
nom(N-G,Adj,_, Nac, Cont, Gen) --> subst_gen(Gen,N-G), atributo(N-G, Adj, Nac, Cont).                         % ... livros mais recentes ...
nom(N-G,_,Nom,_,_,_) --> subst(N-G,Nom).                                                                      % ... escritores ...
nom(N-G,_,_,_,_,[Gen|T]) --> subst_gen(Gen,N-G), (contx_gen(N-G,T);[]).                                       % ... livros ...

com_deter(N-G,Adj,Nom,Nac,Cont,Gen) --> preposicao(N-G),                                                      % ... dos autores ingleses ...
                                            nom(N-G, Adj, Nom, Nac, Cont, Gen).

sint_nom_int(N-G,Adj,Nom,Nac,Cont,Gen) --> [quais],                                                           % "Quais" os escritores [portugueses] que ...
                                                   art_def(N-G),
                                                   nom(N-G,Adj,Nom, Nac,Cont, Gen),
                                                   pron_rel(_-_).

sint_nom_int(N-G,Adj,Nom,Nac,Cont,Gen) --> [quais],                                                           % "Quais" as comédias mais recentes de escritoras inglesas que ...
                                                  art_def(N-G),
                                                  nom(N-G,Adj,Nom, _,_,_),
                                                  com_deter(_-_,Adj,Nom,Nac,Cont,Gen),
                                                  pron_rel(_-_).

sint_nom_int(N-G,Adj,Nom,Nac,Cont,Gen) --> [que],                                                             % "Que" escritoras inglesas ...
                                           nom(N-G,Adj,Nom,Nac,Cont,Gen).

sint_nom_int(N-G,Adj,Nom,Nac,Cont,Gen) --> [que],                                                             % "Que" dramas de escritores portugueses ...
                                           nom(N-G,Adj,Nom,_,_,_),
                                           com_deter(_-_,Adj,Nom,Nac,Cont,Gen).

sint_nom_int(N-G,Adj,Nom,Nac,Cont,Gen) --> pron_int(N-G,qn),                                                  % "Quantas" comédias ...
                                            nom(N-G,Adj,Nom,Nac,Cont,Gen).

sint_nom_int(N-G,Adj,Nom,Nac,Cont,Gen) --> pron_int(N-G,qn),                                                  % "Quantos" livros de escritores portugueses ...
                                           nom(N-G,Adj,Nom,_,_,_),
                                           com_deter(_-_,Adj,Nom,Nac,Cont,Gen).

sint_nom_int(_-_,_,_,_,_,_) --> [quem].                                                                       % "Quem" ...
sint_nom_int(_-_,_,_,_,_,_) --> [quando].                                                                     % "Quando" ...

                                                  %---------------------------------------------------------%
                                                  %                   FRASES INTERROGATIVAS                 %
                                                  %---------------------------------------------------------%

                                                  %---------------------------------------------------------%
                                                  %                          ESCREVER                       %
                                                  %---------------------------------------------------------%

% frase_int_autor(N-G,Adj,Nom,Nac,Cont,Gen,Act,Tem,Titulo,[quem, escreveu, 'A Morgadinha dos Canaviais',?],[]).
% frase_int_livro(N-G,Adj,Nom,Nac,Cont,Gen,Act,Tem,Prim,Ultim,[que, escritor, escreveu, 'A Morgadinha dos Canaviais',?],[]).
% frase_int_livro(N-G,Adj,Nom,Nac,Cont,Gen,Act,Tem,Prim,Ultim,[que, comedias, e, dramas, escreveu, 'Camilo','Castelo Branco',?],[]).
% frase_int_livro(N-G,Adj,Nom,Nac,Cont,Gen,Act,Tem,Prim,Ultim,[que, comedias, e, dramas, foram, escritas, por,'Camilo',?],[]).
% frase_int_livro(N-G,Adj,Nom,Nac,Cont,Gen,Act,Tem,Prim,Ultim,[que, livros, foram, escritos, por, 'Camilo','Castelo Branco',?],[]).
% frase_int_livro_ano(N-G,Adj,Nom,Nac,Cont,Gen,Act,Tem,Titulo,Ano,[quando, foi, escrita, 'A Morgadinha dos Canaviais',?],[]).

frase_int_livro_ano(N-G,Adj,Nom,Nac,Cont,Gen,escrever,Temp, Titulo, Ano) --> sint_nom_int(N-G,Adj,Nom,Nac,Cont,Gen), verbo(_,ser,Temp), verbo_passiva(_-_,escrever), [Titulo], {livro(_, Titulo, _, Ano,_,_)}, [?].
frase_int_autor(N-G,Adj,Nom,Nac,Cont,Gen,escrever,Temp,Titulo) --> sint_nom_int(N-G,Adj,Nom,Nac,Cont,Gen), verbo(N,escrever,Temp), [Titulo], {livro(_,Titulo,_,_,_,_)}, [?].
frase_int_livro(N-G,Adj,Nom,Nac,Cont,Gen,escrever,Temp, Prim, _) --> sint_nom_int(N-G,Adj,Nom,Nac,Cont,Gen), verbo(s,escrever,Temp), [Prim], {autor(_, Prim, _, _, _, _, _, _)}, [?].
frase_int_livro(N-G,Adj,Nom,Nac,Cont,Gen,escrever,Temp,_, Ultim) --> sint_nom_int(N-G,Adj,Nom,Nac,Cont,Gen), verbo(s,escrever,Temp), [Ultim], {autor(_,_, Ultim, _, _, _, _, _)}, [?].
frase_int_livro(N-G,Adj,Nom,Nac,Cont,Gen,escrever,Temp,Prim, Ultim) --> sint_nom_int(N-G,Adj,Nom,Nac,Cont,Gen), verbo(s,escrever,Temp), [Prim], [Ultim], {autor(_, Prim, Ultim, _, _, _, _, _)}, [?].
frase_int_livro(N-G,Adj,Nom,Nac,Cont,Gen,escrever,Temp, Prim, _) --> sint_nom_int(N-G,Adj,Nom,Nac,Cont,Gen), verbo(_,ser,Temp), verbo_passiva(_-_,escrever), [por], [Prim], {autor(_, Prim, _, _, _, _, _, _)}, [?].
frase_int_livro(N-G,Adj,Nom,Nac,Cont,Gen,escrever,Temp, _, Ultim) --> sint_nom_int(N-G,Adj,Nom,Nac,Cont,Gen), verbo(_,ser,Temp), verbo_passiva(_-_,escrever), [por], [Ultim], {autor(_, _, Ultim, _, _, _, _, _)}, [?].
frase_int_livro(N-G,Adj,Nom,Nac,Cont,Gen,escrever,Temp, Prim, Ultim) --> sint_nom_int(N-G,Adj,Nom,Nac,Cont,Gen), verbo(_,ser,Temp), verbo_passiva(_-_,escrever), [por], [Prim], [Ultim], {autor(_, Prim, Ultim, _, _, _, _, _)}, [?].

                                                  %---------------------------------------------------------%
                                                  %                          VIVER                          %
                                                  %---------------------------------------------------------%

procurar_autor(autor(IdAutor, Prim, UltimoNome, AnoNascimento, AnoMorte, Sexo, Nacionalidade, Pseudonimos)) -->
	[Prim], {autor(IdAutor, Prim, UltimoNome, AnoNascimento, AnoMorte, Sexo, Nacionalidade, Pseudonimos)}, [?].
procurar_autor(autor(IdAutor, PrimeiroNome, Ultim, AnoNascimento, AnoMorte, Sexo, Nacionalidade, Pseudonimos)) -->
	[Ultim], {autor(IdAutor, PrimeiroNome, Ultim, AnoNascimento, AnoMorte, Sexo, Nacionalidade, Pseudonimos)}, [?].
procurar_autor(autor(IdAutor, Prim, Ultim, AnoNascimento, AnoMorte, Sexo, Nacionalidade, Pseudonimos)) -->
	[Prim], [Ultim], {autor(IdAutor, Prim, Ultim, AnoNascimento, AnoMorte, Sexo, Nacionalidade, Pseudonimos)}, [?].

locucao_ano(Selector, Ano) --> locucao_ano1(Selector), [Ano], {integer(Ano)}.
locucao_ano1(=) --> [em].
locucao_ano1(=) --> [no], locucao_ano2.
locucao_ano1(<) --> [antes], locucao_ano4.
locucao_ano1(>) --> [depois], locucao_ano4.
locucao_ano2 --> [ano], locucao_ano3.
locucao_ano3 --> [de].
locucao_ano3 --> [].
locucao_ano4 --> [do], [ano], locucao_ano3.
locucao_ano4 --> locucao_ano3.

locucao_seculo(Selector, Seculo) --> locucao_seculo1(Selector), [seculo], [Sec], {seculo(Sec,Seculo)}.
locucao_seculo1(<) --> [antes], [do].
locucao_seculo1(>) --> [depois], [do].
locucao_seculo1(=) --> [no].

% frase_int_viver_sec(N-G,Adj,Nom,Nac,Cont,Gen,Act,Temp,SecNum,Adv,[que, escritores, viveram, no, seculo, 'XX', ?],[]).
% frase_int_viver_sec(N-G,Adj,Nom,Nac,Cont,Gen,Act,Temp,SecNum,Adv,[quais, os, escritores, que, viveram, no, seculo, 'XX', ?],[]).
% frase_int_viver_sec(N-G,Adj,Nom,Nac,Cont,Gen,Act,Temp,SecNum,Adv,[quais, os, escritores, que, viveram, antes, do, seculo, 'XX', ?],[]).
% frase_int_viver_sec(N-G,Adj,Nom,Nac,Cont,Gen,Act,Temp,SecNum,Adv,[quais, os, escritores, que, viveram, depois, do, seculo, 'XX', ?],[]).
% frase_int_vivos(N-G,Adj,Nom,Nac,Cont,Gen,Act,Temp,SecNum,[que, escritores, estao, vivos, ?],[]).
% frase_int_vivos(N-G,Adj,Nom,Nac,Cont,Gen,Act,Temp,SecNum,[quais, os, escritores, que, estao, vivos,?],[]).

frase_int_viver(Lista) -->
	sint_nom_int(N-G,_,autor,_,_,_),
	frase_int_viver1(N-G, Lista).

frase_int_viver1(N-G, Lista) -->
	verbo(N, estar, presente),
	frase_int_viver3(N-G, Lista).
frase_int_viver1(N-_, Lista) -->
	verbo(N, viver, passado),
	frase_int_viver2(N, Lista).

frase_int_viver2(N, Lista) -->
	locucao_ano(Selector, Ano), [?],
	{filtrar_autores_vivos(Selector, Ano, Lista)}.
frase_int_viver2(N, Lista) -->
	locucao_seculo(Selector, Seculo), [?],
	{autores_vivos_seculo(Selector, Seculo, Lista)}.

frase_int_viver3(N-G, Lista) -->
	verbo_passiva(N-G, viver), [?],
	{filtrar_autores([vivo], Lista)}.

                                                  %---------------------------------------------------------%
                                                  %                          NASCER                         %
                                                  %---------------------------------------------------------%

% frase_int_nascer_autor(N-G,Adj,Nom,Nac,Cont,Gen,Act,Tem,Prim,Ultim,[quando, nasceu, 'Camilo',?],[]).
% frase_int_nascer_autor(N-G,Adj,Nom,Nac,Cont,Gen,Act,Tem,Prim,Ultim,[quando, nasceu, 'Castelo Branco',?],[]).
% frase_int_nascer_autor(N-G,Adj,Nom,Nac,Cont,Gen,Act,Tem,Prim,Ultim,[quando, nasceu, 'Camilo', 'Castelo Branco',?],[]).
% frase_int_nascer(N-G,Adj,Nom,Nac,Cont,Gen,Act,Tem,Prim,Ultim,Ano,[quem, nasceu, em, 1917,?],[]).
% frase_int_nascer(N-G,Adj,Nom,Nac,Cont,Gen,Act,Tem,Prim,Ultim,Ano,[que, escritores, nasceram, em, 1917,?],[]).
% frase_int_nascer(N-G,Adj,Nom,Nac,Cont,Gen,Act,Temp,SecNum,Adv,[quais, os, escritores, que, nasceram, no, seculo, 'XX', ?],[]).
% frase_int_nascer(N-G,Adj,Nom,Nac,Cont,Gen,Act,Temp,SecNum,Adv,[quais, os, escritores, que, nasceram, antes, do, seculo, 'XX', ?],[]).
% frase_int_nascer(N-G,Adj,Nom,Nac,Cont,Gen,Act,Temp,SecNum,Adv,[quais, os, escritores, que, nasceram, depois, do, seculo, 'XX', ?],[]).

frase_int_nascer(Lista) -->
	sint_nom_int(N-G,_,autor,_,_,_),
	frase_int_nascerx(N, Lista).

frase_int_nascerx(_, Lista) -->
	verbo(s, nascer, passado),
	frase_int_nascer2(Lista).
frase_int_nascerx(N, Lista) -->
	verbo(N, nascer,passado),
	frase_int_nascer1(Lista).

frase_int_nascer1(Lista) -->
	locucao_ano(Selector, Ano), [?],
	{filtrar_autores_nascidos(Selector, Ano, Lista)}.
frase_int_nascer1(Lista) -->
	locucao_seculo(Selector, Seculo), [?],
	{autores_nascidos_seculo(Selector, Seculo, Lista)}.

frase_int_nascer2(AnoNascimento) -->
	procurar_autor(autor(_, _, _, AnoNascimento, _, _, _, _)).

                                                  %---------------------------------------------------------%
                                                  %                          MORRER                         %
                                                  %---------------------------------------------------------%

% frase_int_morrer_ano(N-G,Adj,Nom,Nac,Cont,Gen,Act,Tem,Prim,Ultim,[quando, morreu, 'Camilo',?],[]).
% frase_int_morrer_ano(N-G,Adj,Nom,Nac,Cont,Gen,Act,Tem,Prim,Ultim,[quando, morreu, 'Castelo Branco',?],[]).
% frase_int_morrer_ano(N-G,Adj,Nom,Nac,Cont,Gen,Act,Tem,Prim,Ultim,[quando, faleceu, 'Camilo', 'Castelo Branco',?],[]).
% frase_int_mortos(N-G,Adj,Nom,Nac,Cont,Gen,Act,Temp,Prim,Ultim,[quais, as, escritoras, que, estao, mortas,?],[]).
% frase_int_morrer_nesse_ano(N-G,Adj,Nom,Nac,Cont,Gen,Act,Tem,Prim,Ultim,Ano,[quem, morreu, em, 1917,?],[]).
% frase_int_morrer_nesse_ano(N-G,Adj,Nom,Nac,Cont,Gen,Act,Tem,Prim,Ultim,Ano,[que, escritores, morreram, em, 1917,?],[]).
% frase_int_morrer_sec(N-G,Adj,Nom,Nac,Cont,Gen,Act,Temp,SecNum,Adv,[quais, os, escritores, que, morreram, no, seculo, 'XX', ?],[]).
% frase_int_morrer_sec(N-G,Adj,Nom,Nac,Cont,Gen,Act,Temp,SecNum,Adv,[quais, os, escritores, que, morreram, antes, do, seculo, 'XX', ?],[]).
% frase_int_morrer_sec(N-G,Adj,Nom,Nac,Cont,Gen,Act,Temp,SecNum,Adv,[quais, os, escritores, que, morreram, depois, do, seculo, 'XX', ?],[]).

frase_int_morrer(Lista) -->
	sint_nom_int(N-G, _, autor, _, _, _),
	frase_int_morrer1(N-G, Lista).

frase_int_morrer1(N-_, Lista) -->
	frase_int_morrer3(N, Lista).
frase_int_morrer1(N-G, Lista) -->
	frase_int_morrer2(N-G, Selector, Ano, Lista),
	{filtrar_autores_mortos(Selector, Ano, Lista)}.

frase_int_morrer2(N-_, Selector, Ano, Lista) -->
	verbo(N, morrer, passado),
	locucao_ano(Selector, Ano), [?].
frase_int_morrer2(N-G, =, -1, Lista) -->
	verbo(N, estar, presente),
	verbo_passiva(N-G, morrer), [?].

frase_int_morrer3(_, AnoMorte) -->
	verbo(s, morrer, passado),
	procurar_autor(autor(_, _, _, _, AnoMorte, _, _, _)).
frase_int_morrer3(N, Lista) -->
	verbo(N, morrer, passado),
	locucao_seculo(Selector, Seculo), [?],
	{autores_mortos_seculo(Selector, Seculo, Lista)}.
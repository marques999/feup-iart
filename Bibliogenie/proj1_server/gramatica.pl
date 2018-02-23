% consult(['~/feup-iart-master/proj1/server/gramatica.pl']).

%---------------------------------------------------------%
%                      PILHA DE TESTES                    %
%---------------------------------------------------------%

% cont(N-G,Nac,[e,portugueses,e,ingleses],[]).

% atributo(N-G, Adj, Nac, Cont, [mais,recente], []).
% atributo(N-G, Adj, Nac, Cont, [antigo], []).
% atributo(N-G, Adj, Nac, Cont, [portugueses], []).

% atributo(N-G, Adj, Nac, Cont, [portugueses, e, americanos], []).
% atributo(N-G, Adj, Nac, Cont, [europeus, e, africanos], []).
-
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
?- ensure_loaded('query.pl').

% ... e europeus e africanos ...
contx_cont(N-G,[H|T]) --> [e], subst_cont(N-G, H), (contx_cont(N-G, T) ; []).
contx_cont(_-_,[]) --> [].

% ... e portugueses e franceses ...
contx_nac(N-G,[H|T]) --> [e], subst_nac(H, N-G), (contx_nac(N-G, T); []).
contx_nac(_-_,[]) --> [].

% ... e dramas e romances ...
contx_gen(N-_,[H|T]) --> [e], subst_gen(H, N-_), (contx_gen(N-_, T);[]).
contx_gen(_-_,[]) --> [].

atributo(N-G, AdjComp, _, _) --> adjetivo_super(GrAdj), adjetivo(N-G, Adj), {adj_comp(GrAdj,Adj,AdjComp)}.    % ... mais recente ...
atributo(N-G, Adj, _, _) --> adjetivo(N-G, Adj).                                                              % ... antigo ...
atributo(N-G, _, [Nac|T], _) --> subst_nac(Nac,N-G), (contx_nac(N-G,T);[]).                                   % ... portugueses ....
atributo(N-G, _, _, [Cont|T]) --> subst_cont(N-G,Cont), (contx_cont(N-G,T);[]).                               % ... sul-americano ...

nom(N-G,Adj,Nom, Nac, Cont, _) --> subst(N-G,Nom), atributo(N-G, Adj, Nac, Cont).               % ... escritores europeus ...
nom(N-G,Adj,_, Nac, Cont, Gen) --> subst_gen(Gen,N-G), atributo(N-G, Adj, Nac, Cont).           % ... livros mais recentes ...
nom(N-G,_,Nom,_,_,_) --> subst(N-G,Nom).                                                        % ... escritores ...
nom(N-G,_,_,_,_,[Gen|T]) --> subst_gen(Gen,N-G), (contx_gen(N-G,T);[]).                         % ... livros ...

% ... dos autores ingleses ...
com_deter(N-G, Adj, Nom, Nac, Cont, Gen) -->
	preposicao(N-G),
    nom(N-G, Adj, Nom, Nac, Cont, Gen).

% "Quais" os escritores [portugueses] que ...
sint_nom_int(N-G, Adj, Nom, Nac, Cont, Gen) -->
	[quais],
	art_def(N-G),
	nom(N-G, Adj, Nom, Nac, Cont, Gen),
	pron_rel(_-_).

% "Quais" as comédias mais recentes de escritoras inglesas que ...
sint_nom_int(N-G,Adj,Nom,Nac,Cont,Gen) -->
	[quais],
	art_def(N-G),
	nom(N-G,Adj,Nom, _,_,_),
	com_deter(_-_,Adj,Nom,Nac,Cont,Gen),
	pron_rel(_-_).

% "Que" escritoras inglesas ...
sint_nom_int(N-G, Adj, Nom, Nac, Cont, Gen) -->
	[que],
	nom(N-G, Adj, Nom, Nac, Cont, Gen).

% "Que" dramas de escritores portugueses ...
sint_nom_int(N-G, Adj, Nom, Nac, Cont, Gen) -->
	[que],
	nom(N-G,Adj,Nom,_,_,_),
    com_deter(_-_,Adj,Nom,Nac,Cont,Gen).

% "Quantas" comédias ...
sint_nom_int(N-G,Adj,Nom,Nac,Cont,Gen) -->
	pron_int(N-G, qn),
	nom(N-G, Adj, Nom, Nac, Cont, Gen).

% "Quantos" livros de escritores portugueses ...
sint_nom_int(N-G, Adj, Nom, Nac, Cont, Gen) -->
	pron_int(N-G, qn),
	nom(N-G, Adj, Nom,_,_,_),
	com_deter(_-_, Adj, Nom, Nac, Cont, Gen).

sint_nom_int(_-_,_,_,_,_,_) --> [quem].                                                                       % "Quem" ...
sint_nom_int(_-_,_,_,_,_,_) --> [quando].                                                                     % "Quando" ...

		  %---------------------------------------------------------%
		  %  **********       FRASES INTERROGATIVAS      *********  %
		  %---------------------------------------------------------%


query(yes) --> declarativa.
query(Lista) --> interrogativa(Lista).

			% NOVA GRAMATICA
			% consult(['~/feup-iart-master/proj1/server/gramatica.pl']).
			% interrogativa_livro(['A Morgadinha dos Canaviais', foi, escrita, em, portugues, ?],[]).
			% interrogativa_livro(['A Morgadinha dos Canaviais', foi, escrita, em, 1868, ?],[]).
			% interrogativa_livro(['A Morgadinha dos Canaviais', foi, escrita, no, seculo, 'XIX', ?],[]).
			% interrogativa_livro(['A Morgadinha dos Canaviais', foi, escrita, antes, do, seculo, 'XIX', ?],[]).
			% interrogativa_livro(['A Morgadinha dos Canaviais', foi, escrita, depois, do, seculo, 'XV', ?],[]).
			% interrogativa_livro(['A Morgadinha dos Canaviais', foi, escrita, por, 'Dinis',?],[]).
			% interrogativa_livro(Ano,[quando, foi, escrita, 'A Morgadinha dos Canaviais',?],[]).
			% interrogativa_livro(Titulo,[que, romances, e, dramas, escreveu, 'Camilo',?],[]). % ESTÁ COM PROBLEMAS
			% interrogativa_livro(Titulo,[que, romances, foram, escritos, por, 'Camilo',?],[]). % ESTÁ COM PROBLEMAS
			% interrogativa_livro(Titulo,[que, romances, foram, escritos, em, portugues,?],[]). % ESTÁ COM PROBLEMAS
			% interrogativa_livro(Titulo,[que, romances, foram, escritos, no, seculo, 'XX',?],[]). % ESTÁ COM PROBLEMAS
			% interrogativa_livro(Titulo,[que, romances, foram, escritos, antes, do, seculo, 'XX',?],[]). % ESTÁ COM PROBLEMAS
			% interrogativa_livro(Titulo,[que, romances, foram, escritos, depois, do, seculo, 'XVII',?],[]). % ESTÁ COM PROBLEMAS

			interrogativa(Result) --> interrogativa_livro(Result).
			interrogativa(Result) --> interrogativa_autor(Result).
			interrogativa(Result) --> interrogativa_vida(Result).

			interrogativa_livro(AnoPub) --> [quando],
						verbo(s, ser, passado),
						verbo_passiva(s-_, escrever),
						[Titulo],
						{livro(_,Titulo,_,AnoPub,_,_)},
						[?].

			interrogativa_livro(Lista) --> [que],
						nom(N-G,_,_, _, _, Genero),
						interrogativa_livro1(N-G),
						procurar_autor(autor(IdAutor, _, _, _, _, _, _, _)),
						filtrar_livros_aux(Lista, [autor=IdAutor,genero=Genero]),
						[?].

			interrogativa_livro1(N-G) -->
						verbo(s, escrever, passado).
			interrogativa_livro1(N-G) -->
						verbo(G, ser, passado),
						verbo_passiva(N-G, escrever),
						[por].

			%interrogativa_livro(Titulo) --> [que],
			%			sint_nom_int(N-_,_,_,_,_,Genero),
			%			verbo(s,ser,passado),
			%			verbo_passiva(N-_,escrever),
			%			livro_deriv(_,_),
			%			[?].

			%livro_deriv(IdAutor,AnoPub) --> [em], {autor(IdAutor,_,_,_,_,_,Cod,_)}, subst_nac(Cod,s-m), [?].
			%livro_deriv(IdAutor,_) --> [por], ([Prim] ; [Ultimo] ; [Prim], [Ultimo]), {autor(IdAutor, Prim, Ultimo, _, _, _, _, _)}, [?].
			%livro_deriv(_,AnoPub) --> [em], [Ano], {integer(Ano)}, {Ano =:= AnoPub}, [?].
			%livro_deriv(_,AnoPub) --> [no], [seculo], [Sec], {seculo_lim(Sec,First,Last)}, {AnoPub >= First}, {AnoPub =< Last}, [?].
			%livro_deriv(_,AnoPub) --> [antes], [do], [seculo], [Sec], {seculo_lim(Sec,First,_)}, {AnoPub < First}, [?].
			%livro_deriv(_,AnoPub) --> [depois], [do], [seculo], [Sec], {seculo_lim(Sec,_,Last)}, {AnoPub > Last}, [?].

			% consult(['~/feup-iart-master/proj1/server/gramatica.pl']).
			% interrogativa_autor(Primeiro,Ultimo,[quem, escreveu, 'A Morgadinha dos Canaviais', ?],[]).
			% interrogativa_autor(Primeiro,Ultimo,[quem, morreu, em, 1961,?],[]).
			% interrogativa_autor(Primeiro,Ultimo,[quem, nasceu, em, 1802,?],[]).
			% interrogativa_autor(Ano,[quando, nasceu, 'Camilo',?],[]).
			% interrogativa_autor(Ano,[quando, morreu, 'Camilo',?],[]).
			% interrogativa_autor(Ano,[que escritores, nasceram, depois, do, seculo, 'XVI',?],[]).
			% interrogativa_autor(Ano,[que escritores, viveram, antes, do, seculo, 'VIII',?],[]).
			% interrogativa_autor(Ano,[que escritores, morreram, no, seculo, 'XX',?],[]).

			interrogativa_autor(Primeiro-Ultimo) -->
					[quem],
					verbo(s, escrever, passado),
					[Titulo],
					{livro(_,Titulo,IdAutor,_,_,_)},
				    {autor(IdAutor, Primeiro, Ultimo,_,_,_,_,_)},
					[?].

			interrogativa_autor(Primeiro-Ultimo) -->
					[quem],
					verbo(s, morrer,passado),
					[em],
					[Ano],
					{autor(IdAutor,Primeiro,Ultimo,_,Ano,_,_,_)},
					[?].

			interrogativa_autor(Primeiro-Ultimo) -->
					[quem],
					verbo(s, nascer,passado),
					[em],
					[Ano],
					{autor(IdAutor,Primeiro,Ultimo,Ano,_,_,_,_)},
					[?].

			interrogativa_vida(Ano) -->
					[quando],
					interrogativa_vida1(Ano),
					[?].
			interrogativa_vida1(AnoMorte) -->
					verbo(s, morrer, passado),
					procurar_autor(autor(_, _, _, _, AnoMorte, _, _, _)),
					[?].
			interrogativa_vida1(AnoNascimento) -->
					verbo(s, nascer, passado),
					procurar_autor(autor(_, _, _, AnoNascimento, _, _, _, _)),
					[?].

			interrogativa_autor(Primeiro, Ultimo) --> [que],
					sint_nom_int(N-G,_,autor,Nac,_,_),
					verbo(s,escrever,passado),
					[Titulo],
					{livro(IdAutor, Titulo, _,_,_)},
					{autor(IdAutor, Primeiro, Ultimo,_,_,G,Nac,_)},
					[?].

			interrogativa_autor --> [quais],
					sint_nom_int(N-G,_,autor,_,_,_),
					( verbo(s,nascer,passado) ; verbo(s,viver,passado) ; verbo(s,morrer,passado) ),
					livro_deriv(_-_).

		  %---------------------------------------------------------%
		  %                          ESCREVER                       %
		  %---------------------------------------------------------%

% procurar_livro(livro(_, Titulo, _, _, _, _),['Livro Negro de Padre Dinis'],[]). % DONE
procurar_livro(livro(IdLivro, Nome, IdAutor, AnoPub, Genero, Colec)) -->
  [IdAutor],
  {livro(IdLivro, Nome, IdAutor, AnoPub, Genero, Colec)}.
procurar_livro(livro(IdLivro, Nome, IdAutor, AnoPub, Genero, Colec)) -->
  [Nome],
  {livro(IdLivro, Nome, IdAutor, AnoPub, Genero, Colec)}.
procurar_livro(livro(IdLivro, Nome, IdAutor, AnoPub, Genero, Colec)) -->
  [AnoPub],
  {livro(IdLivro, Nome, IdAutor, AnoPub, Genero, Colec)}.
procurar_livro(livro(IdLivro, Nome, IdAutor, AnoPub, Genero, Colec)) -->
  [Genero],
  {livro(IdLivro, Nome, IdAutor, AnoPub, Genero, Colec)}.
procurar_livro(livro(IdLivro, Nome, IdAutor, AnoPub, Genero, Colec)) -->
  [NomColec],
  {coleccao(Colec, NomColec, _)},
  {livro(IdLivro, Nome, IdAutor, AnoPub, Genero, Colec)}.
procurar_livro(livro(IdLivro, Nome, IdAutor, AnoPub, Genero, Colec)) -->
  [Lingua],
  {autor(IdAutor, _, _, _, _, _, Lingua, _)},
  {livro(IdLivro, Nome, IdAutor, AnoPub, Genero, Colec)}.

% procurar_autor(autor(IdAutor, _, _, AnoNascimento, AnoMorte, _, Nacionalidade, Pseudonimos),['Fernando'],[]). % DONE

procurar_autor(autor(IdAutor, Prim, Ultim, AnoNascimento, AnoMorte, Sexo, Nacionalidade, Pseudonimos)) -->
	[Prim], [Ultim],
	{autor(IdAutor, Prim, Ultim, AnoNascimento, AnoMorte, Sexo, Nacionalidade, Pseudonimos)}.

procurar_autor(autor(IdAutor, Prim, UltimoNome, AnoNascimento, AnoMorte, Sexo, Nacionalidade, Pseudonimos)) -->
	[Prim],
	{autor(IdAutor, Prim, UltimoNome, AnoNascimento, AnoMorte, Sexo, Nacionalidade, Pseudonimos)}.

procurar_autor(autor(IdAutor, PrimeiroNome, Ultim, AnoNascimento, AnoMorte, Sexo, Nacionalidade, Pseudonimos)) -->
	[Ultim],
	{autor(IdAutor, PrimeiroNome, Ultim, AnoNascimento, AnoMorte, Sexo, Nacionalidade, Pseudonimos)}.

locucao_ano(Selector, Ano) -->
	locucao_ano1(Selector),
	[Ano], {integer(Ano)}.

locucao_ano1(=) --> [em].
locucao_ano1(=) --> [no], locucao_ano2.
locucao_ano1(<) --> [antes], locucao_ano4.
locucao_ano1(>) --> [depois], locucao_ano4.
locucao_ano2 --> [ano], locucao_ano3.
locucao_ano3 --> [de].
locucao_ano3 --> [].
locucao_ano4 --> [do], [ano], locucao_ano3.
locucao_ano4 --> locucao_ano3.

locucao_seculo(Selector, Seculo) -->
	locucao_seculo1(Selector),
	[seculo], [Sec],
	{seculo(Sec,Seculo)}.

locucao_seculo1(<) --> [antes], [do].
locucao_seculo1(>) --> [depois], [do].
locucao_seculo1(=) --> [no].

comparar_idade_autores(<) --> [antes], [de].
comparar_idade_autores(>) --> [depois], [de].
comparar_idade_autores(>) --> [apos].
comparar_idade_autores(=) --> [no], [mesmo], [ano], [que].

                                                  %---------------------------------------------------------%
                                                  %                          VIVER                          %
                                                  %---------------------------------------------------------%

% query(Lista, [que, escritores, viveram, no, seculo, 'XX', ?], []).
% interrogativa_vida(Lista, [quais, os, escritores, que, viveram, no, seculo, 'XX', ?], []).
% interrogativa_vida(Lista, [quais, os, escritores, que, viveram, antes, do, seculo, 'XX', ?], []).
% interrogativa_vida(Lista, [quais, os, escritores, que, viveram, depois, do, seculo, 'XX', ?], []).
% interrogativa_vida(Lista, [que, escritores, estao, vivos, ?], []).
% interrogativa_vida(Lista, [quais, os, escritores, que, estao, vivos, ?], []).

interrogativa_vida(Lista) -->
	sint_nom_int(N-G, _, autor, _, _, _),
	interrogativa_vida1(N-G, Lista).

interrogativa_vida1(N-_, Lista) --> frase_int_nascer1(N, Lista).
interrogativa_vida1(N-G, Lista) --> frase_int_morrer1(N-G, Lista).
interrogativa_vida1(N-G, Lista) --> frase_int_viver1(N-G, Lista).

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

% interrogativa_vida(Lista, [quando, nasceu, 'Camilo', ?], []).
% interrogativa_vida(Lista, [quando, nasceu, 'Castelo Branco', ?], []).
% interrogativa_vida(Lista, [quando, nasceu, 'Camilo', 'Castelo Branco', ?], []).
% interrogativa_vida(Lista, [quem, nasceu, em, 1917, ?], []).
% interrogativa_vida(Lista, [que, escritores, nasceram, em, 1917, ?], []).
% interrogativa_vida(Lista, [quais, os, escritores, que, nasceram, no, seculo, 'XX', ?], []).
% interrogativa_vida(Lista, [quais, os, escritores, que, nasceram, antes, do, seculo, 'XX', ?], []).
% interrogativa_vida(Lista, [quais, os, escritores, que, nasceram, depois, do, seculo, 'XX', ?], []).

frase_int_nascer1(_, Lista) -->
	verbo(s, nascer, passado),
	frase_int_nascer3(Lista).
frase_int_nascer1(N, Lista) -->
	verbo(N, nascer, passado),
	frase_int_nascer2(Lista).

frase_int_nascer2(Lista) -->
	locucao_ano(Selector, Ano), [?],
	{filtrar_autores_nascidos(Selector, Ano, Lista)}.
frase_int_nascer2(Lista) -->
	locucao_seculo(Selector, Seculo), [?],
	{autores_nascidos_seculo(Selector, Seculo, Lista)}.

frase_int_nascer3(AnoNascimento) -->
	procurar_autor(autor(_, _, _, AnoNascimento, _, _, _, _)), [?].

			%---------------------------------------------------------%
			%                          MORRER                         %
			%---------------------------------------------------------%

% ?- interrogativa_vida(Lista, [quando, morreu, 'Camilo', ?], []).
% ?- interrogativa_vida(Lista, [quando, morreu, 'Castelo Branco', ?], []).
% ?- interrogativa_vida(Lista, [quando, faleceu, 'Camilo', 'Castelo Branco', ?], []).
% ?- interrogativa_vida(Lista, [quais, as, escritoras, que, estao, mortas, ?], []).
% ?- interrogativa_vida(Lista, [quem, morreu, em, 1917, ?], []).
% ?- interrogativa_vida(Lista, [que, escritores, morreram, em, 1917, ?], []).
% ?- interrogativa_vida(Lista, [quais, os, escritores, que, morreram, no, seculo, 'XX', ?], []).
% ?- interrogativa_vida(Lista, [quais, os, escritores, que, morreram, antes, do, seculo, 'XX', ?], []).
% ?- interrogativa_vida(Lista, [quais, os, escritores, que, morreram, depois, do, seculo, 'XX', ?], []).

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
	procurar_autor(autor(_, _, _, _, AnoMorte, _, _, _)), [?].
frase_int_morrer3(N, Lista) -->
	verbo(N, morrer, passado),
	locucao_seculo(Selector, Seculo), [?],
	{autores_mortos_seculo(Selector, Seculo, Lista)}.

			  %---------------------------------------------------------%
			  %  ***********       FRASES DECLARATIVAS      **********  %
			  %---------------------------------------------------------%

			  %---------------------------------------------------------%
			  %                          ESCREVER                       %
			  %---------------------------------------------------------%

interrogacao_opcional --> [?].
interrogacao_opcional --> [].

declarativa --> declarativa_livro ; declarativa_autor.

declarativa_livro -->
	[Titulo],
	{livro(_, Titulo, IdAutor, Ano, _, _)}, !,
	declarativa_livro1(Titulo, IdAutor, Ano), !,
	interrogacao_opcional.

declarativa_livro1(Titulo, IdAutor, Ano) -->
	verbo(s, ser, passado),
	verbo_passiva(s-_, escrever), !,
	declarativa_livro2(Titulo, IdAutor, Ano).

% ?- declarativa(['A Morgadinha dos Canaviais', e, um, romance],[]).
% yes
% ?- declarativa(['A Morgadinha dos Canaviais', e, um, drama],[]).
% no

declarativa_livro1(Titulo, IdAutor, Ano) -->
	verbo(s, ser, presente),
	[um], [Genero],
	{livro(_, Titulo, _, _, Genero, _)}.

% ?- declarativa(['A Morgadinha dos Canaviais', foi, escrita, em, 1868],[]).
% yes
% ?- declarativa(['A Morgadinha dos Canaviais', foi, escrita, antes, de, 1800],[]).
% no
% ?- declarativa(['A Morgadinha dos Canaviais', foi, publicada, depois, de, 1800],[]).
% yes

declarativa_livro2(_, _, AnoLimite) -->
	locucao_ano(Selector, Ano),
	{call(Selector, AnoLimite, Ano)}.

% ?- declarativa(['A Morgadinha dos Canaviais', foi, escrita, em, portugues],[]).
% yes
% ?- declarativa(['A Morgadinha dos Canaviais', foi, publicada, em, russo],[]).
% no

declarativa_livro2(Titulo, IdAutor, Ano) -->
	[em], subst_nac(Codigo, s-m),
	{autor(IdAutor,_,_,_,_,_,Codigo,_)}.

% ?- declarativa_livro(['A Morgadinha dos Canaviais', foi, escrita, no, seculo, 'XX'],[]).
% no
% ?- declarativa_livro(['A Morgadinha dos Canaviais', foi, escrita, antes, do, seculo, 'XX'],[]).
% yes
% ?- declarativa_livro(['A Morgadinha dos Canaviais', foi, publicada, no, seculo, 'XX'],[]).
%

declarativa_livro2(_, _, AnoLimite) -->
	locucao_seculo(Selector, Seculo),
	{verificar_seculo(Selector, AnoLimite, Seculo)}.

			%---------------------------------------------------------%
			%                          VIVER                          %
			%---------------------------------------------------------%

% frase_dec_vivo_sec(['Camilo', 'Castelo Branco', viveu, antes, do, seculo, 'XX'],[]).
% frase_dec_vivo_sec(['Camilo', 'Castelo Branco', viveu, antes, do, seculo, 'XIII'],[]).
% frase_dec_vivo_sec(['Camilo', 'Castelo Branco', viveu, no, seculo, 'XX'],[]).
% frase_dec_vivo_sec(['Camilo', 'Castelo Branco', viveu, no, seculo, 'XIX'],[]).
% frase_dec_vivo_sec(['Camilo', 'Castelo Branco', viveu, depois, do, seculo, 'XX'],[]).
% frase_dec_vivo_sec(['Camilo', 'Castelo Branco', viveu, depois, do, seculo, 'XIII'],[]).

frase_dec_vivo_sec -->
	procurar_autor(autor(IdAutor, _, _, AnoNascimento, AnoMorte, Genero, Pais, _)), !,
	verbo(s,viver,passado),
	[no], [seculo], [Sec],
	{seculo_lim(Sec, First, Last)}, !,
	{AnoNascimento >= First}, {AnoMorte =< Last}.

frase_dec_vivo_sec -->
	procurar_autor(autor(IdAutor, _, _, AnoNascimento, AnoMorte, Genero, Pais, _)), !,
	verbo(s,viver,passado),
	[antes], [do], [seculo],
	[Sec], {seculo_lim(Sec, First, _)}, !,
	{AnoMorte =< First}.

			%---------------------------------------------------------%
			%                    DECLARATIVAS: AUTOR                  %
			%---------------------------------------------------------%

declarativa_autor -->
	procurar_autor(autor(IdAutor, _, _, AnoNascimento, AnoMorte, Genero, Pais, _)), !,
	declarativa_autor1(IdAutor, AnoNascimento, AnoMorte, Genero, Pais), !,
	interrogacao_opcional.

declarativa_autor1(IdAutor, AnoNascimento, AnoMorte, Genero, Pais) -->
	verbo(s, escrever, passado),
	declarativa_escrever(IdAutor).
declarativa_autor1(IdAutor, AnoNascimento, AnoMorte, Genero, Pais) -->
	verbo(s, estar, presente),
	declarativa_estar(AnoMorte, Genero).
declarativa_autor1(IdAutor, AnoNascimento, AnoMorte, Genero, Pais) -->
	verbo(s, ser, presente),
	declarativa_nacionalidade(Genero, Pais).
declarativa_autor1(IdAutor, AnoNascimento, AnoMorte, Genero, Pais) -->
	verbo(s, nascer, passado),
	declarativa_nascer(AnoNascimento).
declarativa_autor1(IdAutor, AnoNascimento, AnoMorte, Genero, Pais) -->
	verbo(s, morrer, passado),
	declarativa_morrer(AnoMorte).

% ?- declarativa_autor(['Castelo Branco', escreveu, romances], []).
% yes
% ?- declarativa_autor(['Castelo Branco', escreveu, ficcoes-cientificas], []).
% no

declarativa_escrever(IdAutor) -->
	subst_gen(Genero, p-_),
	{livro(_, _, IdAutor, _, Genero, _)}.

% ?- declarativa_autor(['Camilo', escreveu, 'A Morgadinha dos Canaviais'], []).
% no
% ?- declarativa_autor(['Dinis', escreveu, 'A Morgadinha dos Canaviais'], []).
% yes
% ?- declarativa_autor(['Julio', 'Castelo Branco', escreveu, 'A Morgadinha dos Canaviais'], []).
% no

declarativa_escrever(IdAutor)  -->
	[Titulo],
	{livro(_, Titulo, IdAutor, _, _, _)}.

% ?- declarativa_autor(['Camilo','Castelo Branco', esta, morto],[]).
% yes
% ?- declarativa_autor(['Jane','Austen', esta, morta],[]).
% yes
% ?- declarativa_autor(['Isabel','Allende', esta, morta],[]).
% no
% ?- declarativa_autor(['Haruki','Murakami', esta, morto],[]).
% no

declarativa_estar(AnoMorte, Genero) -->
	verbo_passiva(s-Genero, morrer),
	{AnoMorte >= 0}.

% declarativa_autor(['Camilo', 'Castelo Branco', esta, vivo],[]).
% declarativa_autor(['Isabel', 'Allende', esta, viva],[]).

declarativa_estar(AnoMorte, Genero) -->
	verbo_passiva(s-Genero, viver),
	{AnoMorte = -1}.

% ?- declarativa_autor(['Camilo','Castelo Branco', e, portugues],[]).
% yes
% ?- declarativa_autor(['Camilo','Castelo Branco', e, ingles],[]).
% no

declarativa_nacionalidade(Genero, Pais) -->
	subst_nac(Pais, s-Genero),
	interrogacao_opcional.

% ?- declarativa_autor(['Jane','Austen', e, europeia], []).
% yes
% ?- declarativa_autor(['Jane','Austen', e, africana], []).
% no
% ?- declarativa_autor(['Camilo','Castelo Branco', e, europeu], []).
% yes
% ?- declarativa_autor(['Camilo','Castelo Branco', e, africano], []).
% no

declarativa_nacionalidade(Genero, Pais) -->
	{nac_to_cont(Pais, Cont)},
	subst_cont(s-Genero, Cont),
	interrogacao_opcional.

% ?- declarativa_autor(['Camilo', nasceu, em, 1825],[]).
% yes
% ?- declarativa_autor(['Camilo', nasceu, em, 1891],[]).
% no
% ?- declarativa_autor(['Castelo Branco', nasceu, em, 1825],[]).
% yes
% ?- declarativa_autor(['Castelo Branco', nasceu, em, 1891],[]).
% no
% ?- declarativa_autor(['Camilo','Castelo Branco', nasceu, em, 1825],[]).
% yes
% ?- declarativa_autor(['Camilo','Castelo Branco', nasceu, em, 1890],[]).
% no
% ?- declarativa_autor(['Camilo', nasceu, depois, de, 1700], []).
% yes
% ?- declarativa_autor(['Camilo', nasceu, depois, do, ano, de, 1825],[]).
% no
% ?- declarativa_autor(['Camilo', nasceu, antes, de, 1825],[]).
% no
% ?- declarativa_autor(['Camilo', nasceu, antes, de, 1826],[]).
% yes

declarativa_nascer(AnoNascimento) -->
	locucao_ano(Selector, Ano),
	{call(Selector, AnoNascimento, Ano)}.

% ?- declarativa_autor(['Camilo', nasceu, no, seculo, 'XX'],[]).
% no
% ?- declarativa_autor(['Castelo Branco', nasceu, no, seculo, 'XIX'],[]).
% yes
% ?- declarativa_autor(['Camilo','Castelo Branco', nasceu, antes, do, seculo, 'XX'],[]).
% yes
% ?- declarativa_autor(['Camilo','Castelo Branco', nasceu, depois, do, seculo, 'XX'],[]).
% no

declarativa_nascer(AnoNascimento) -->
	locucao_seculo(Selector, Seculo),
	{verificar_seculo(Selector, AnoNascimento, Seculo)}.

% ?- declarativa_autor(['Camilo','Castelo Branco', nasceu, antes, de, 'Jane', 'Austen'],[]).
% no
% ?- declarativa_autor(['Camilo','Castelo Branco', nasceu, depois, de, 'Jane', 'Austen'],[]).
% yes

declarativa_nascer(AnoNascimento) -->
	comparar_idade_autores(Selector),
	procurar_autor(autor(_,_,_,AnoNascimento1,_,_,_,_)),
	{call(Selector, AnoNascimento, AnoNascimento1)}.

% ?- declarativa_autor(['Camilo', morreu, em, 1890], []).
% yes
% ?- declarativa_autor(['Camilo', morreu, em, 1891], []).
% no
% ?- declarativa_autor(['Castelo Branco', morreu, em, 1890], []).
% yes
% ?- declarativa_autor(['Castelo Branco', morreu, em, 1891], []).
% no
% ?- declarativa_autor(['Camilo','Castelo Branco', morreu, em, 1890], []).
% yes
% ?- declarativa_autor(['Camilo','Castelo Branco', morreu, em, 1891], []).
% no
% ?- declarativa_autor(['Castelo Branco', morreu, antes, de, 1890], []).
% no
% ?- declarativa_autor(['Castelo Branco', morreu, antes, de, 1895], []).
% yes
% ?- declarativa_autor(['Camilo', morreu, depois, de, 1891], []).
% no
% ?- declarativa_autor(['Camilo', morreu, depois, de, 1791], []).
% yes

declarativa_morrer(AnoMorte) -->
	locucao_ano(Selector, Ano),
	{call(Selector, AnoMorte, Ano)}.

% ?- declarativa_autor(['Camilo', morreu, no, seculo, 'XX'],[]).
% no
% ?- declarativa_autor(['Castelo Branco', morreu, no, seculo, 'XIX'],[]).
% yes
% ?- declarativa_autor(['Camilo','Castelo Branco', morreu, antes, do, seculo, 'XX'],[]).
% yes
% ?- declarativa_autor(['Camilo','Castelo Branco', morreu, depois, do, seculo, 'XX'],[]).
% no

declarativa_morrer(AnoMorte) -->
	locucao_seculo(Selector, Seculo),
	{verificar_seculo(Selector, AnoMorte, Seculo)}.

% ?- declarativa_autor(['Camilo','Castelo Branco', morreu, antes, de, 'Jane', 'Austen'], []).
% no
% ?- declarativa_autor(['Jane','Austen', morreu, antes, de, 'Camilo', 'Castelo Branco'], []).
% yes
% ?- declarativa_autor(['Camilo','Castelo Branco', morreu, depois, de, 'Jane', 'Austen'], []).
% yes
% ?- declarativa_autor(['Jane','Austen', morreu, depois, de, 'Camilo', 'Castelo Branco'], []).
% no

declarativa_morrer(AnoMorte) -->
	comparar_idade_autores(Selector),
	procurar_autor(autor(_ ,_ ,_ ,_ , AnoMorte1, _, _, _)),
	{call(Selector, AnoMorte, AnoMorte1)}.

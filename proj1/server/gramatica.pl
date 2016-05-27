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
                                                  %  **********       FRASES INTERROGATIVAS      *********  %
                                                  %---------------------------------------------------------%

                                                  %---------------------------------------------------------%
                                                  %                          ESCREVER                       %
                                                  %---------------------------------------------------------%

% procurar_livro(livro(_, Titulo, _, _, _, _),['Livro Negro de Padre Dinis'],[]). % DONE
procurar_livro(livro(IdLivro, Nome, IdAutor, AnoPub, Genero, Colec)) -->
  [IdAutor], {livro(IdLivro, Nome, IdAutor, AnoPub, Genero, Colec)}.
procurar_livro(livro(IdLivro, Nome, IdAutor, AnoPub, Genero, Colec)) -->
  [Nome], {livro(IdLivro, Nome, IdAutor, AnoPub, Genero, Colec)}.
procurar_livro(livro(IdLivro, Nome, IdAutor, AnoPub, Genero, Colec)) -->
  [AnoPub], {livro(IdLivro, Nome, IdAutor, AnoPub, Genero, Colec)}.
procurar_livro(livro(IdLivro, Nome, IdAutor, AnoPub, Genero, Colec)) -->
  [Genero], {livro(IdLivro, Nome, IdAutor, AnoPub, Genero, Colec)}.
procurar_livro(livro(IdLivro, Nome, IdAutor, AnoPub, Genero, Colec)) -->
  [NomColec], {coleccao(Colec, NomColec, _)}, {livro(IdLivro, Nome, IdAutor, AnoPub, Genero, Colec)}.
procurar_livro(livro(IdLivro, Nome, IdAutor, AnoPub, Genero, Colec)) -->
  [Lingua], {autor(IdAutor, _, _, _, _, _, Lingua, _)}, {livro(IdLivro, Nome, IdAutor, AnoPub, Genero, Colec)}.

% procurar_autor(autor(IdAutor, _, _, AnoNascimento, AnoMorte, _, Nacionalidade, Pseudonimos),['Fernando'],[]). % DONE
procurar_autor(autor(IdAutor, Prim, Ultim, AnoNascimento, AnoMorte, Sexo, Nacionalidade, Pseudonimos)) -->
	[IdAutor], {autor(IdAutor, Prim, Ultim, AnoNascimento, AnoMorte, Sexo, Nacionalidade, Pseudonimos)}.
procurar_autor(autor(IdAutor, Prim, Ultim, AnoNascimento, AnoMorte, Sexo, Nacionalidade, Pseudonimos)) -->
	[Prim], [Ultim], {autor(IdAutor, Prim, Ultim, AnoNascimento, AnoMorte, Sexo, Nacionalidade, Pseudonimos)}.
procurar_autor(autor(IdAutor, Prim, UltimoNome, AnoNascimento, AnoMorte, Sexo, Nacionalidade, Pseudonimos)) -->
	[Prim], {autor(IdAutor, Prim, UltimoNome, AnoNascimento, AnoMorte, Sexo, Nacionalidade, Pseudonimos)}.
procurar_autor(autor(IdAutor, PrimeiroNome, Ultim, AnoNascimento, AnoMorte, Sexo, Nacionalidade, Pseudonimos)) -->
	[Ultim], {autor(IdAutor, PrimeiroNome, Ultim, AnoNascimento, AnoMorte, Sexo, Nacionalidade, Pseudonimos)}.

% frase_int_autor(autor(_, Prim, Ultim, _, _, _, _, _),[quem, escreveu, 'A Morgadinha dos Canaviais',?],[]). % NOT WORKING
% frase_int_autor(autor(_, Prim, Ultim, _, _, _, _, _),[que, escritor, portugues, escreveu, 'A Morgadinha dos Canaviais',?],[]).
frase_int_autor(autor(IdAutor, Prim, Ultim, Nasc, Morte, Genero, Nacionalidade, Pseudonimos)) -->
  sint_nom_int(_-_,_,autor,Nacionalidade,_,_),
  verbo(_,escrever,passado),
  procurar_livro(livro(_, Titulo, IdAutor, _, _, _)),
  procurar_autor(autor(IdAutor, Prim, Ultim, Nasc, Morte, Genero, Nacionalidade, Pseudonimos)),
  [?].

% frase_int_livro(livro(_, Titulo, _, _, _, _),[que, romances, foram, escritos, por, 'Camilo','Castelo Branco',?],[]). % NOT WORKING
% frase_int_livro(livro(_, Titulo, _, _, _, _),[que, romances, escreveu, 'Camilo','Castelo Branco',?],[]).
frase_int_livro(livro(IdLivro, Titulo, IdAutor, AnoPub, Genero, Colec)) -->
  sint_nom_int(N-_,_,_,_,_,Genero),
  ( verbo(s,escrever,passado) ; verbo(N,ser,passado), verbo_passiva(), [por]),
  procurar_autor(autor(IdAutor, Primeiro, Ultimo, _, _, _, _, _)),
  {livro(_, Titulo, IdAutor, _, Genero, _)},
  [?].

% frase_int_livro_ano(livro(_, _, _, AnoPub, _, _),[quando, foi, escrita, 'A Morgadinha dos Canaviais',?],[]). % DONE
frase_int_livro_ano(livro(IdLivro, Titulo, IdAutor, AnoPub, Genero, Colec)) -->
  sint_nom_int(_,_,_,_,_,_),
  verbo(_,ser,passado),
  verbo_passiva(_-_,escrever),
  procurar_livro(livro(IdLivro, Titulo, IdAutor, AnoPub, Genero, Colec)),
  [?].

% frase_int_livros_ling(livro(_, Titulo, _, _, _, _),[que, livros, foram, escritos, em, portugues, ?],[]). % NOT WORKING
frase_int_livros_ling(livro(IdLivro, Titulo, IdAutor, AnoPub, Genero, Colec)) -->
  sint_nom_int(N-G,_,_,_,_,Genero),
  verbo(N,ser,passado),
  verbo_passiva(N-G, escrever),
  [em],
  subst_nac(Lingua, s-m),
  {autor(IdAutor, _, _, _, _, _, Lingua, _)},
  procurar_livro(livro(IdLivro, Titulo, IdAutor, AnoPub, Genero, Colec)),
  [?].

  % frase_int_livro_ling(N-G,Adj,Nom,Nac,Cont,Gen,Act,Tem,Titulo,['A Morgadinha dos Canaviais', foi, escrita, em, portugues, ?],[]). % DONE
  frase_int_livro_ling(N-G,Adj,Nom,Nac,Cont,Gen,Act,Tem,Titulo) -->
  [Titulo],
  {livro(_,Titulo,IdAutor,_,_,_)},
  {autor(IdAutor,_, _, _, _, _, Cod, _)},
   verbo(_,ser,Temp),
   verbo_passiva(_-_,escrever),
   [em],
   subst_nac(Cod, s-m),
   [?].

                                                  %---------------------------------------------------------%
                                                  %                          VIVER                          %
                                                  %---------------------------------------------------------%

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

comparar_idade_autores(<) --> [antes], comparar_idade_autores1.
comparar_idade_autores(>) --> [depois], comparar_idade_autores1.
comparar_idade_autores(>) --> [apos].
comparar_idade_autores(=) --> [no], [mesmo], [ano].
comparar_idade_autores1 --> [de].

% frase_int_viver(Lista, [que, escritores, viveram, no, seculo, 'XX', ?], []).
% frase_int_viver(Lista, [quais, os, escritores, que, viveram, no, seculo, 'XX', ?], []).
% frase_int_viver(Lista, [quais, os, escritores, que, viveram, antes, do, seculo, 'XX', ?], []).
% frase_int_viver(Lista, [quais, os, escritores, que, viveram, depois, do, seculo, 'XX', ?], []).
% frase_int_viver(Lista, [que, escritores, estao, vivos, ?], []).
% frase_int_viver(Lista, [quais, os, escritores, que, estao, vivos, ?], []).

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

% frase_int_nascer(Lista, [quando, nasceu, 'Camilo', ?], []).
% frase_int_nascer(Lista, [quando, nasceu, 'Castelo Branco', ?], []).
% frase_int_nascer(Lista, [quando, nasceu, 'Camilo', 'Castelo Branco', ?], []).
% frase_int_nascer(Lista, [quem, nasceu, em, 1917, ?], []).
% frase_int_nascer(Lista, [que, escritores, nasceram, em, 1917, ?], []).
% frase_int_nascer(Lista, [quais, os, escritores, que, nasceram, no, seculo, 'XX', ?], []).
% frase_int_nascer(Lista, [quais, os, escritores, que, nasceram, antes, do, seculo, 'XX', ?], []).
% frase_int_nascer(Lista, [quais, os, escritores, que, nasceram, depois, do, seculo, 'XX', ?], []).

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
	procurar_autor(autor(_, _, _, AnoNascimento, _, _, _, _)), [?].


                                                  %---------------------------------------------------------%
                                                  %                          MORRER                         %
                                                  %---------------------------------------------------------%

% frase_int_morrer(Lista, [quando, morreu, 'Camilo', ?], []).
% frase_int_morrer(Lista, [quando, morreu, 'Castelo Branco', ?], []).
% frase_int_morrer(Lista, [quando, faleceu, 'Camilo', 'Castelo Branco', ?], []).
% frase_int_morrer(Lista, [quais, as, escritoras, que, estao, mortas, ?], []).
% frase_int_morrer(Lista, [quem, morreu, em, 1917, ?], []).
% frase_int_morrer(Lista, [que, escritores, morreram, em, 1917, ?], []).
% frase_int_morrer(Lista, [quais, os, escritores, que, morreram, no, seculo, 'XX', ?], []).
% frase_int_morrer(Lista, [quais, os, escritores, que, morreram, antes, do, seculo, 'XX', ?], []).
% frase_int_morrer(Lista, [quais, os, escritores, que, morreram, depois, do, seculo, 'XX', ?], []).

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

% declarativa_autor(['Camilo', escreveu, 'A Morgadinha dos Canaviais'], []).
% declarativa_autor(['Dinis', escreveu, 'A Morgadinha dos Canaviais'], []).
% declarativa_autor(['Julio', 'Castelo Branco', escreveu, 'A Morgadinha dos Canaviais'], []).

% ?- declarativa_autor(['Castelo Branco', escreveu, romances], []).
% yes
% ?- declarativa_autor(['Castelo Branco', escreveu, ficcoes-cientificas], []).
% no
% ?- declarativa_autor(['Camilo','Castelo Branco', e, portugues],[]).
% yes
% ?- declarativa_autor(['Camilo','Castelo Branco', e, ingles],[]).
% no
% ?- declarativa_autor(['Jane','Austen', e, europeia], []).
% yes
% ?- declarativa_autor(['Jane','Austen', e, africana], []).
% no
% ?- declarativa_autor(['Camilo','Castelo Branco', e, europeu], []).
% yes
% ?- declarativa_autor(['Camilo','Castelo Branco', e, africano], []).
% no

declarativa_autor -->
	procurar_autor(autor(IdAutor, _, _, _, _, Genero, Pais, _)), !,
	declarativa_autor1(IdAutor, Genero, Pais),
	interrogacao_opcional.

declarativa_autor1(_, Genero, Pais) -->
	verbo(s, ser, presente),
	declarativa_autor2(Genero, Pais).
declarativa_autor1(IdAutor, _, _) -->
	verbo(s, escrever, passado),
	declarativa_autor3(IdAutor).

declarativa_autor2(Genero, Pais) -->
	subst_nac(Pais, s-Genero),
	interrogacao_opcional.
declarativa_autor2(Genero, Pais) -->
	{nac_to_cont(Pais, Cont)},
	subst_cont(s-Genero, Cont),
	interrogacao_opcional.

declarativa_autor3(IdAutor) -->
	subst_gen(Genero, p-_),
	{livro(_, _, IdAutor, _, Genero, _)}.
declarativa_autor3(IdAutor)  -->
	[Titulo],
	{livro(_, Titulo, IdAutor, _, _, _)}.

% frase_dec_livro_lingua(['A Morgadinha dos Canaviais', foi, escrita, em, portugues],[]).
% frase_dec_livro_lingua(['A Morgadinha dos Canaviais', foi, publicada, em, russo],[]).
% frase_dec_livro_sec(['A Morgadinha dos Canaviais', foi, escrita, no, seculo, 'XX'],[]).
% frase_dec_livro_sec(['A Morgadinha dos Canaviais', foi, escrita, antes, do, seculo, 'XX'],[]).
% frase_dec_livro_sec(['A Morgadinha dos Canaviais', foi, publicada, do, seculo, 'XX'],[]).
% frase_dec_livro_ano(['A Morgadinha dos Canaviais', foi, escrita, em, 1868],[]).
% frase_dec_livro_ano(['A Morgadinha dos Canaviais', foi, escrita, antes, de, 1800],[]).
% frase_dec_livro_ano(['A Morgadinha dos Canaviais', foi, publicada, depois, de, 1800],[]).
% frase_dec_livro_gen(['A Morgadinha dos Canaviais', e, um, romance],[]).
% frase_dec_livro_gen(['A Morgadinha dos Canaviais', e, um, drama],[]).

frase_dec_livro_lingua --> [Titulo], {livro(_, Titulo, IdAutor, _, _, _)}, verbo(s,ser,passado), verbo_passiva(s-_, escrever) , [em], subst_nac(Codigo, s-m), {autor(IdAutor,_,_,_,_,_,Codigo,_)}.
frase_dec_livro_sec --> [Titulo], {livro(_, Titulo, _, Ano, _, _)}, verbo(s,ser,passado), verbo_passiva(s-_, escrever) , [depois], [do], [seculo], [Sec], {seculo_lim(Sec, _, Last)}, !, {Ano > Last}.
frase_dec_livro_sec --> [Titulo], {livro(_, Titulo, _, Ano, _, _)}, verbo(s,ser,passado), verbo_passiva(s-_, escrever) , [antes], [do], [seculo], [Sec], {seculo_lim(Sec, First, _)}, !, {Ano < First}.
frase_dec_livro_sec --> [Titulo], {livro(_, Titulo, _, Ano, _, _)}, verbo(s,ser,passado), verbo_passiva(s-_, escrever) , [no], [seculo], [Sec], {seculo_lim(Sec, First, Last)}, !, {Ano >= First}, {Ano =< Last}.
frase_dec_livro_ano --> [Titulo], {livro(_, Titulo, _, Ano, _, _)}, verbo(s,ser,passado), verbo_passiva(s-_, escrever) , [depois], [de], [Data], !, {Ano > Data}.
frase_dec_livro_ano --> [Titulo], {livro(_, Titulo, _, Ano, _, _)}, verbo(s,ser,passado), verbo_passiva(s-_, escrever) , [antes], [de], [Data], !, {Ano < Data}.
frase_dec_livro_ano --> [Titulo], {livro(_, Titulo, _, Ano, _, _)}, verbo(s,ser,passado), verbo_passiva(s-_, escrever) , [em], [Data], !, {Ano =:= Data}.
frase_dec_livro_gen --> [Titulo], verbo(s,ser,presente), [um], [Genero],  {livro(_, Titulo, _, _, Genero, _)}.


			%---------------------------------------------------------%
			%                          NASCER                         %
			%---------------------------------------------------------%

% ?- declarativa_nascer(['Camilo', nasceu, em, 1825],[]).
% yes
% ?- declarativa_nascer(['Camilo', nasceu, em, 1891],[]).
% no
% ?- declarativa_nascer(['Castelo Branco', nasceu, em, 1825],[]).
% yes
% ?- declarativa_nascer(['Castelo Branco', nasceu, em, 1891],[]).
% no
% ?- declarativa_nascer(['Camilo','Castelo Branco', nasceu, em, 1825],[]).
% yes
% ?- declarativa_nascer(['Camilo','Castelo Branco', nasceu, em, 1890],[]).
% no
% ?- declarativa_nascer(['Camilo', nasceu, depois, de, 1700], []).
% yes
% ?- declarativa_nascer(['Camilo', nasceu, depois, do, ano, de, 1825],[]).
% no
% ?- declarativa_nascer(['Camilo', nasceu, antes, de, 1825],[]).
% no
% ?- declarativa_nascer(['Camilo', nasceu, antes, de, 1826],[]).
% yes
% ?- declarativa_nascer(['Camilo', nasceu, no, seculo, 'XX'],[]).
% no
% ?- declarativa_nascer(['Castelo Branco', nasceu, no, seculo, 'XIX'],[]).
% yes
% ?- declarativa_nascer(['Camilo','Castelo Branco', nasceu, antes, do, seculo, 'XX'],[]).
% yes
% ?- declarativa_nascer(['Camilo','Castelo Branco', nasceu, depois, do, seculo, 'XX'],[]).
% no
% ?- declarativa_nascer(['Camilo','Castelo Branco', nasceu, antes, de, 'Jane', 'Austen'],[]).
% no
% ?- declarativa_nascer(['Camilo','Castelo Branco', nasceu, depois, de, 'Jane', 'Austen'],[]).
% yes

declarativa_nascer -->
	procurar_autor(autor(_, _, _, AnoNascimento, _, _, _, _)), !,
	verbo(s, nascer, passado),
	declarativa_nascer1(AnoNascimento),
	interrogacao_opcional.

declarativa_nascer1(AnoNascimento) -->
	locucao_ano(Selector, Ano),
	{call(Selector, AnoNascimento, Ano)}.
declarativa_nascer1(AnoNascimento) -->
	locucao_seculo(Selector, Seculo),
	{autor_verificar_seculo(Selector, AnoNascimento, Seculo)}.
declarativa_nascer1(AnoNascimento) -->
	comparar_idade_autores(Selector),
	procurar_autor(autor(_,_,_,AnoNascimento1,_,_,_,_)),
	{call(Selector, AnoNascimento, AnoNascimento1)}.


			%---------------------------------------------------------%
			%                          VIVER                          %
			%---------------------------------------------------------%

% frase_dec_vivos(['Camilo', 'Castelo Branco', esta, vivo],[]).
% frase_dec_vivos(['Isabel', 'Allende', esta, viva],[]).

frase_dec_vivos -->
	procurar_autor(autor(_, _, _, AnoNascimento, _, Genero, _, _)),
	verbo(s, estar, presente),
	verbo_passiva(s-Genero, morrer),
	interrogacao_opcional, !,
	{AnoNascimento < 0}.

% frase_dec_vivo_sec(['Camilo', 'Castelo Branco', viveu, antes, do, seculo, 'XX'],[]).
% frase_dec_vivo_sec(['Camilo', 'Castelo Branco', viveu, antes, do, seculo, 'XIII'],[]).
% frase_dec_vivo_sec(['Camilo', 'Castelo Branco', viveu, no, seculo, 'XX'],[]).
% frase_dec_vivo_sec(['Camilo', 'Castelo Branco', viveu, no, seculo, 'XIX'],[]).

frase_dec_vivo_sec -->
	[Primeiro],
	{autor(_,Primeiro,_,Nasc,Morte,_,_,_)},
	verbo(s,viver,passado),
	[no], [seculo], [Sec],
	{seculo_lim(Sec, First, Last)}, !,
	{Nasc >= First}, {Morte =< Last}.

frase_dec_vivo_sec --> [Ultimo], {autor(_,_,Ultimo,Nasc,Morte,_,_,_)}, verbo(s,viver,passado), [no], [seculo], [Sec], {seculo_lim(Sec, First, Last)}, !, {Nasc >= First}, {Morte =< Last}.
frase_dec_vivo_sec --> [Primeiro], [Ultimo], {autor(_,Primeiro,Ultimo,Nasc,Morte,_,_,_)}, verbo(s,viver,passado), [no], [seculo], [Sec], {seculo_lim(Sec, First, Last)}, !, {Nasc >= First}, {Morte =< Last}.
frase_dec_vivo_sec --> [Primeiro], {autor(_,Primeiro,_,_,Morte,_,_,_)}, verbo(s,viver,passado), [antes], [do], [seculo], [Sec], {seculo_lim(Sec, First, _)}, !, {Morte =< First}.
frase_dec_vivo_sec --> [Ultimo], {autor(_,_,Ultimo,_,Morte,_,_,_)}, verbo(s,viver,passado), [antes], [do], [seculo], [Sec], {seculo_lim(Sec, First, _)}, !, {Morte =< First}.
frase_dec_vivo_sec --> [Primeiro], [Ultimo], {autor(_,Primeiro,Ultimo,_,Morte,_,_,_)}, verbo(s,viver,passado), [antes], [do], [seculo], [Sec], {seculo_lim(Sec, First, _)}, !, {Morte =< First}.


			%---------------------------------------------------------%
			%                          MORRER                         %
			%---------------------------------------------------------%

% ?- declarativa_morrer(['Camilo', morreu, em, 1890], []).
% yes
% ?- declarativa_morrer(['Camilo', morreu, em, 1891], []).
% no
% ?- declarativa_morrer(['Castelo Branco', morreu, em, 1890], []).
% yes
% ?- declarativa_morrer(['Castelo Branco', morreu, em, 1891], []).
% no
% ?- declarativa_morrer(['Camilo','Castelo Branco', morreu, em, 1890], []).
% yes
% ?- declarativa_morrer(['Camilo','Castelo Branco', morreu, em, 1891], []).
% no
% ?- declarativa_morrer(['Castelo Branco', morreu, antes, de, 1890], []).
% no
% ?- declarativa_morrer(['Castelo Branco', morreu, antes, de, 1895], []).
% yes
% ?- declarativa_morrer(['Camilo', morreu, depois, de, 1891], []).
% no
% ?- declarativa_morrer(['Camilo', morreu, depois, de, 1791], []).
% yes
% ?- declarativa_morrer(['Camilo','Castelo Branco', esta, morto],[]).
% yes
% ?- declarativa_morrer(['Jane','Austen', esta, morta],[]).
% yes
% ?- declarativa_morrer(['Isabel','Allende', esta, morta],[]).
% no
% ?- declarativa_morrer(['Haruki','Murakami', esta, morto],[]).
% no
% ?- declarativa_morrer(['Camilo', morreu, no, seculo, 'XX'],[]).
% no
% ?- declarativa_morrer(['Castelo Branco', morreu, no, seculo, 'XIX'],[]).
% yes
% ?- declarativa_morrer(['Camilo','Castelo Branco', morreu, antes, do, seculo, 'XX'],[]).
% yes
% ?- declarativa_morrer(['Camilo','Castelo Branco', morreu, depois, do, seculo, 'XX'],[]).
% no
% ?- declarativa_morrer(['Camilo','Castelo Branco', morreu, antes, de, 'Jane', 'Austen'], []).
% no
% ?- declarativa_morrer(['Jane','Austen', morreu, antes, de, 'Camilo', 'Castelo Branco'], []).
% yes
% ?- declarativa_morrer(['Camilo','Castelo Branco', morreu, depois, de, 'Jane', 'Austen'], []).
% yes
% ?- declarativa_morrer(['Jane','Austen', morreu, depois, de, 'Camilo', 'Castelo Branco'], []).
% no

declarativa_morrer -->
	procurar_autor(autor(_, _, _, _, AnoMorte, Genero, _, _)), !,
	declarativa_morrer1(AnoMorte, Genero),
	interrogacao_opcional.

declarativa_morrer1(AnoMorte, Genero) -->
	verbo(s, estar, presente),
	verbo_passiva(s-Genero, morrer),
	{AnoMorte >= 0}.
declarativa_morrer1(AnoMorte, _) -->
	verbo(s, morrer, passado),
	declarativa_morrer2(AnoMorte).

declarativa_morrer2(AnoMorte) -->
	locucao_ano(Selector, Ano),
	interrogacao_opcional, !,
	{call(Selector, AnoMorte, Ano)}.
declarativa_morrer2(AnoMorte) -->
	locucao_seculo(Selector, Seculo),
	interrogacao_opcional, !,
	{autor_verificar_seculo(Selector, AnoMorte, Seculo)}.
declarativa_morrer2(AnoMorte) -->
	comparar_idade_autores(Selector),
	procurar_autor(autor(_ ,_ ,_ ,_ , AnoMorte1, _, _, _)),
	{call(Selector, AnoMorte, AnoMorte1)}.

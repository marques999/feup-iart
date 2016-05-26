% consult(['~/Desktop/feup-iart-master/proj1/server/gramatica.pl']).

nascer_autor([seculo=SecNum]) --> [no], [seculo], [Sec], {seculo(Sec, SecNum)}.
nascer_autor([ano=Ano]) --> [no], [ano], [Ano], {integer(Ano)}.


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

% frase_int_autor(N-G,Adj,Nom,Nac,Cont,Gen,Act,Tem,Titulo,[quem, escreveu, 'A Morgadinha dos Canaviais',?],[]).
% frase_int_livro(N-G,Adj,Nom,Nac,Cont,Gen,Act,Tem,Prim,Ultim,[que, escritor, escreveu, 'A Morgadinha dos Canaviais',?],[]).
% frase_int_livro(N-G,Adj,Nom,Nac,Cont,Gen,Act,Tem,Prim,Ultim,[que, comedias, e, dramas, escreveu, 'Camilo','Castelo Branco',?],[]).
% frase_int_livro(N-G,Adj,Nom,Nac,Cont,Gen,Act,Tem,Prim,Ultim,[que, comedias, e, dramas, foram, escritas, por,'Camilo',?],[]).
% frase_int_livro(N-G,Adj,Nom,Nac,Cont,Gen,Act,Tem,Prim,Ultim,[que, livros, foram, escritos, por, 'Camilo','Castelo Branco',?],[]).
% frase_int_livro_ano(N-G,Adj,Nom,Nac,Cont,Gen,Act,Tem,Titulo,Ano,[quando, foi, escrita, 'A Morgadinha dos Canaviais',?],[]).

% frase_int_livro_ling(N-G,Adj,Nom,Nac,Cont,Gen,Act,Tem,Titulo,['A Morgadinha dos Canaviais', foi, escrita, em, portugues, ?],[]).
frase_int_livro_ling(N-G,Adj,Nom,Nac,Cont,Gen,Act,Tem,Titulo) --> [Titulo], {livro(_,Titulo,IdAutor,_,_,_)}, {autor(IdAutor,_, _, _, _, _, Cod, _)}, verbo(_,ser,Temp), verbo_passiva(_-_,escrever), [em], subst_nac(Cod, s-m), [?].

% frase_int_livros_ling(N-G,Adj,Nom,Nac,Cont,Gen,Act,Tem,Lingua,[que, livros, foram, escritos, em, portugues, ?],[]).
frase_int_livros_ling(N-G,Adj,Nom,Nac,Cont,Gen,Act,Tem,Lingua) --> sint_nom_int(N-G,Adj,Nom,Nac,Cont,Gen), verbo(_,ser,Tem), verbo_passiva(_-_,escrever), [em], subst_nac(Lingua, s-m), [?].

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

% frase_int_viver_sec(N-G,Adj,Nom,Nac,Cont,Gen,Act,Temp,SecNum,Adv,[que, escritores, viveram, no, seculo, 'XX', ?],[]).
% frase_int_viver_sec(N-G,Adj,Nom,Nac,Cont,Gen,Act,Temp,SecNum,Adv,[quais, os, escritores, que, viveram, no, seculo, 'XX', ?],[]).
% frase_int_viver_sec(N-G,Adj,Nom,Nac,Cont,Gen,Act,Temp,SecNum,Adv,[quais, os, escritores, que, viveram, antes, do, seculo, 'XX', ?],[]).
% frase_int_viver_sec(N-G,Adj,Nom,Nac,Cont,Gen,Act,Temp,SecNum,Adv,[quais, os, escritores, que, viveram, depois, do, seculo, 'XX', ?],[]).
% frase_int_vivos(N-G,Adj,Nom,Nac,Cont,Gen,Act,Temp,SecNum,[que, escritores, estao, vivos, ?],[]).
% frase_int_vivos(N-G,Adj,Nom,Nac,Cont,Gen,Act,Temp,SecNum,[quais, os, escritores, que, estao, vivos,?],[]).

frase_int_vivos(N-G,Adj,Nom,Nac,Cont,Gen,viver,Temp,SecNum) --> sint_nom_int(N-G,Adj,Nom,Nac,Cont,Gen), verbo(N,estar,Temp), verbo_passiva(N-G, viver), [?].
frase_int_viver_sec(N-G,Adj,_,Nac,Cont,Gen,viver,Temp,SecNum,_) --> sint_nom_int(N-G,Adj,autor,Nac,Cont,Gen), verbo(N,viver,Temp), [no], [seculo], [Sec], {seculo(Sec,SecNum)}, [?].
frase_int_viver_sec(N-G,Adj,_,Nac,Cont,Gen,viver,Temp,SecNum,Adv) --> sint_nom_int(N-G,Adj,autor,Nac,Cont,Gen), verbo(N,viver,Temp), adverbio(Adv), [do], [seculo], [Sec], {seculo(Sec,SecNum)}, [?].
frase_int_viver_sec(N-G,Adj,_,Nac,Cont,Gen,viver,Temp,SecNum,Adv) --> sint_nom_int(N-G,Adj,autor,Nac,Cont,Gen), verbo(N,viver,Temp), adverbio(Adv), [do], [seculo], [Sec], {seculo(Sec,SecNum)}, [?].
frase_int_vivos(N-G,Adj,Nom,Nac,Cont,Gen,viver,Temp,_) --> sint_nom_int(N-G,Adj,Nom,Nac,Cont,Gen), verbo(N,estar,Temp), verbo_passiva(N-G, viver), [?].

                                                  %---------------------------------------------------------%
                                                  %                          NASCER                         %
                                                  %---------------------------------------------------------%


% frase_int_nascer_autor(N-G,Adj,Nom,Nac,Cont,Gen,Act,Tem,Prim,Ultim,[quando, nasceu, 'Camilo',?],[]).
% frase_int_nascer_autor(N-G,Adj,Nom,Nac,Cont,Gen,Act,Tem,Prim,Ultim,[quando, nasceu, 'Castelo Branco',?],[]).
% frase_int_nascer_autor(N-G,Adj,Nom,Nac,Cont,Gen,Act,Tem,Prim,Ultim,[quando, nasceu, 'Camilo', 'Castelo Branco',?],[]).
% frase_int_nascer_ano(N-G,Adj,Nom,Nac,Cont,Gen,Act,Tem,Prim,Ultim,Ano,[quem, nasceu, em, 1917,?],[]).
% frase_int_nascer_ano(N-G,Adj,Nom,Nac,Cont,Gen,Act,Tem,Prim,Ultim,Ano,[que, escritores, nasceram, em, 1917,?],[]).
% frase_int_nascer_sec(N-G,Adj,Nom,Nac,Cont,Gen,Act,Temp,SecNum,Adv,[quais, os, escritores, que, nasceram, no, seculo, 'XX', ?],[]).
% frase_int_nascer_sec(N-G,Adj,Nom,Nac,Cont,Gen,Act,Temp,SecNum,Adv,[quais, os, escritores, que, nasceram, antes, do, seculo, 'XX', ?],[]).
% frase_int_nascer_sec(N-G,Adj,Nom,Nac,Cont,Gen,Act,Temp,SecNum,Adv,[quais, os, escritores, que, nasceram, depois, do, seculo, 'XX', ?],[]).

frase_int_nascer_autor(N-G,Adj,Nom,Nac,Cont,Gen,nascer,Temp,Prim, _) --> sint_nom_int(N-G,Adj,Nom,Nac,Cont,Gen), verbo(s,nascer,Temp), [Prim], {autor(_, Prim, _, _, _, _, _, _)}, [?].
frase_int_nascer_autor(N-G,Adj,Nom,Nac,Cont,Gen,nascer,Temp,_, Ultim) --> sint_nom_int(N-G,Adj,Nom,Nac,Cont,Gen), verbo(s,nascer,Temp), [Ultim], {autor(_, _, Ultim, _, _, _, _, _)}, [?].
frase_int_nascer_autor(N-G,Adj,Nom,Nac,Cont,Gen,nascer,Temp,Prim, Ultim) --> sint_nom_int(N-G,Adj,Nom,Nac,Cont,Gen), verbo(s,nascer,Temp), [Prim], [Ultim], {autor(_, Prim, Ultim, _, _, _, _, _)}, [?].
frase_int_nascer_ano(N-G,Adj,Nom,Nac,Cont,Gen,nascer,Temp,_,_,Ano) --> sint_nom_int(N-G,Adj,Nom,Nac,Cont,Gen), verbo(N,nascer,Temp), [em], [Ano], {integer(Ano)},[?].
frase_int_nascer_sec(N-G,Adj,_,Nac,Cont,Gen,nascer,Temp,SecNum,_) --> sint_nom_int(N-G,Adj,autor,Nac,Cont,Gen), verbo(N,nascer,Temp), [no], [seculo], [Sec], {seculo(Sec,SecNum)}, [?].
frase_int_nascer_sec(N-G,Adj,_,Nac,Cont,Gen,nascer,Temp,SecNum,Adv) --> sint_nom_int(N-G,Adj,autor,Nac,Cont,Gen), verbo(N,nascer,Temp), adverbio(Adv), [do], [seculo], [Sec], {seculo(Sec,SecNum)}, [?].
frase_int_nascer_sec(N-G,Adj,_,Nac,Cont,Gen,nascer,Temp,SecNum,Adv) --> sint_nom_int(N-G,Adj,autor,Nac,Cont,Gen), verbo(N,nascer,Temp), adverbio(Adv), [do], [seculo], [Sec], {seculo(Sec,SecNum)}, [?].

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

frase_int_morrer_nesse_ano(N-G,Adj,Nom,Nac,Cont,Gen,morrer,Temp,_,_,Ano) --> sint_nom_int(N-G,Adj,Nom,Nac,Cont,Gen), verbo(N,morrer,Temp), [em], [Ano], {integer(Ano)},[?].
frase_int_morrer_ano(N-G,Adj,Nom,Nac,Cont,Gen,morrer,Temp,Prim, _) --> sint_nom_int(N-G,Adj,Nom,Nac,Cont,Gen), verbo(s,morrer,Temp), [Prim], {autor(_, Prim, _, _, _, _, _, _)}, [?].
frase_int_morrer_ano(N-G,Adj,Nom,Nac,Cont,Gen,morrer,Temp,_, Ultim) --> sint_nom_int(N-G,Adj,Nom,Nac,Cont,Gen), verbo(s,morrer,Temp), [Ultim], {autor(_, _, Ultim, _, _, _, _, _)}, [?].
frase_int_morrer_ano(N-G,Adj,Nom,Nac,Cont,Gen,morrer,Temp,Prim, Ultim) --> sint_nom_int(N-G,Adj,Nom,Nac,Cont,Gen), verbo(s,morrer,Temp), [Prim], [Ultim], {autor(_, Prim, Ultim, _, _, _, _, _)}, [?].
frase_int_mortos(N-G,Adj,Nom,Nac,Cont,Gen,morrer,Temp,_,_) --> sint_nom_int(N-G,Adj,Nom,Nac,Cont,Gen), verbo(N,estar,Temp), verbo_passiva(N-G, morrer), [?].
frase_int_morrer_sec(N-G,Adj,_,Nac,Cont,Gen,morrer,Temp,SecNum,_) --> sint_nom_int(N-G,Adj,autor,Nac,Cont,Gen), verbo(N,morrer,Temp), [no], [seculo], [Sec], {seculo(Sec,SecNum)}, [?].
frase_int_morrer_sec(N-G,Adj,_,Nac,Cont,Gen,morrer,Temp,SecNum,Adv) --> sint_nom_int(N-G,Adj,autor,Nac,Cont,Gen), verbo(N,morrer,Temp), [antes], [do], [seculo], [Sec], {seculo(Sec,SecNum)}, [?].
frase_int_morrer_sec(N-G,Adj,_,Nac,Cont,Gen,morrer,Temp,SecNum,Adv) --> sint_nom_int(N-G,Adj,autor,Nac,Cont,Gen), verbo(N,morrer,Temp), [depois], [do], [seculo], [Sec], {seculo(Sec,SecNum)}, [?].

                                                  %---------------------------------------------------------%
                                                  %  ***********       FRASES DECLARATIVAS      **********  %
                                                  %---------------------------------------------------------%

                                                  %---------------------------------------------------------%
                                                  %                          ESCREVER                       %
                                                  %---------------------------------------------------------%
/*
% frase_dec_autor(['Camilo', escreveu, 'A Morgadinha dos Canaviais'],[]).

% frase_dec_autor(['Castelo Branco', escreveu, 'A Morgadinha dos Canaviais'],[]).
% frase_dec_autor(['Camilo', 'Castelo Branco', escreveu, 'A Morgadinha dos Canaviais'],[]).
% frase_dec_autor_gen(['Castelo Branco', escreveu, romances],[]).
% frase_dec_autor_gen(['Castelo Branco', escreveu, ficcoes-cientificas],[]).
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
% frase_dec_autor_nac(['Camilo','Castelo Branco', e, portugues],[]).
% frase_dec_autor_nac(['Camilo','Castelo Branco', e, ingles],[]).
% frase_dec_autor_cont(['Jane','Austen', e, europeia],[]).
% frase_dec_autor_cont(['Jane','Austen', e, africana],[]).
% frase_dec_autor_cont(['Camilo','Castelo Branco', e, europeu],[]).
% frase_dec_autor_cont(['Camilo','Castelo Branco', e, africano],[]).

frase_dec_autor --> [Primeiro], {autor(IdAutor, Primeiro, _, _, _, _, _, _)}, verbo(s,escrever,_), [Titulo], {livro(_, Titulo, IdAutor, _, _, _)}.
frase_dec_autor --> [Ultimo], {autor(IdAutor, _, Ultimo, _, _, _, _, _)},  verbo(s,escrever,_), [Titulo], {livro(_, Titulo, IdAutor, _, _, _)}.
frase_dec_autor --> [Primeiro], [Ultimo], {autor(IdAutor, Primeiro, Ultimo, _, _, _, _, _)}, verbo(s,escrever,_), [Titulo], {livro(_, Titulo, IdAutor, _, _, _)}.*/

frase_dec_livro_lingua --> [Titulo], {livro(_, Titulo, IdAutor, _, _, _)}, verbo(s,ser,passado), verbo_passiva(s-_, escrever) , [em], subst_nac(Codigo, s-m), {autor(IdAutor,_,_,_,_,_,Codigo,_)}.
frase_dec_livro_sec --> [Titulo], {livro(_, Titulo, _, Ano, _, _)}, verbo(s,ser,passado), verbo_passiva(s-_, escrever) , [depois], [do], [seculo], [Sec], {seculo_lim(Sec, _, Last)}, !, {Ano > Last}.
frase_dec_livro_sec --> [Titulo], {livro(_, Titulo, _, Ano, _, _)}, verbo(s,ser,passado), verbo_passiva(s-_, escrever) , [antes], [do], [seculo], [Sec], {seculo_lim(Sec, First, _)}, !, {Ano < First}.
frase_dec_livro_sec --> [Titulo], {livro(_, Titulo, _, Ano, _, _)}, verbo(s,ser,passado), verbo_passiva(s-_, escrever) , [no], [seculo], [Sec], {seculo_lim(Sec, First, Last)}, !, {Ano >= First}, {Ano =< Last}.
frase_dec_livro_ano --> [Titulo], {livro(_, Titulo, _, Ano, _, _)}, verbo(s,ser,passado), verbo_passiva(s-_, escrever) , [depois], [de], [Data], !, {Ano > Data}.
frase_dec_livro_ano --> [Titulo], {livro(_, Titulo, _, Ano, _, _)}, verbo(s,ser,passado), verbo_passiva(s-_, escrever) , [antes], [de], [Data], !, {Ano < Data}.
frase_dec_livro_ano --> [Titulo], {livro(_, Titulo, _, Ano, _, _)}, verbo(s,ser,passado), verbo_passiva(s-_, escrever) , [em], [Data], !, {Ano =:= Data}.
frase_dec_livro_gen --> [Titulo], verbo(s,ser,presente), [um], [Genero],  {livro(_, Titulo, _, _, Genero, _)}.
frase_dec_autor_gen --> [Primeiro], verbo(s,escrever,passado), subst_gen(Genero, p-_), {autor(IdAutor,Primeiro,_,_,_,_,_,_)}, !, {livro(_, _, IdAutor, _, Genero, _)}.
frase_dec_autor_gen --> [Ultimo], verbo(s,escrever,passado), subst_gen(Genero, p-_), {autor(IdAutor,_,Ultimo,_,_,_,_,_)}, !, {livro(_, _, IdAutor, _, Genero, _)}.
frase_dec_autor_gen --> [Primeiro], [Ultimo], verbo(s,escrever,passado), subst_gen(Genero, p-_), {autor(IdAutor,Primeiro,Ultimo,_,_,_,_,_)}, !, {livro(_, _, IdAutor, _, Genero, _)}.
frase_dec_autor_nac --> [Ultimo], verbo(s,ser,presente), {autor(_, _, Ultimo, _, _, Genero, Pais, _)}, subst_nac(Pais, s-Genero).
frase_dec_autor_nac --> [Primeiro], verbo(s,ser,presente), {autor(_, Primeiro, _, _, _, Genero, Pais, _)}, subst_nac(Pais, s-Genero).
frase_dec_autor_nac --> [Primeiro], [Ultimo], verbo(s,ser,presente), {autor(_, Primeiro, Ultimo, _, _, Genero, Pais, _)}, subst_nac(Pais, s-Genero).
frase_dec_autor_cont --> [Primeiro], verbo(s,ser,presente), {autor(_, Primeiro, _, _, _, Genero, Pais, _)}, {nac_to_cont(Pais, Cont)}, subst_cont(s-Genero, Cont).
frase_dec_autor_cont --> [Ultimo], verbo(s,ser,presente), {autor(_, _, Ultimo, _, _, Genero, Pais, _)}, {nac_to_cont(Pais, Cont)}, subst_cont(s-Genero, Cont).
frase_dec_autor_cont --> [Primeiro], [Ultimo], verbo(s,ser,presente), {autor(_, Primeiro, Ultimo, _, _, Genero, Pais, _)}, {nac_to_cont(Pais, Cont)}, subst_cont(s-Genero, Cont).

                                                  %---------------------------------------------------------%
                                                  %                          NASCER                         %
                                                  %---------------------------------------------------------%

% frase_dec_nascer_ano(['Camilo', nasceu, em, 1825],[]).
% frase_dec_nascer_ano(['Camilo', nasceu, em, 1891],[]).
% frase_dec_nascer_ano(['Castelo Branco', nasceu, em, 1825],[]).
% frase_dec_nascer_ano(['Castelo Branco', nasceu, em, 1891],[]).
% frase_dec_nascer_ano(['Camilo','Castelo Branco', nasceu, em, 1825],[]).
% frase_dec_nascer_ano(['Camilo','Castelo Branco', nasceu, em, 1890],[]).
% frase_dec_nascer_sec(['Camilo', nasceu, no, seculo, 'XX'],[]).
% frase_dec_nascer_sec(['Castelo Branco', nasceu, no, seculo, 'XIX'],[]).
% frase_dec_nascer_sec(['Camilo','Castelo Branco', nasceu, antes, do, seculo, 'XX'],[]).
% frase_dec_nascer_sec(['Camilo','Castelo Branco', nasceu, depois, do, seculo, 'XX'],[]).
% frase_dec_nascer_ord(['Camilo','Castelo Branco', nasceu, antes, de, 'Jane', 'Austen'],[]).
% frase_dec_nascer_ord(['Camilo','Castelo Branco', nasceu, depois, de, 'Jane', 'Austen'],[]).

frase_dec_nascer_ano --> [Primeiro], verbo(s, nascer,passado), [em], [Ano], {integer(Ano)},  {autor(_,Primeiro,_,Ano,_,_,_,_)}.
frase_dec_nascer_ano --> [Ultimo], verbo(s, nascer,passado), [em], [Ano], {integer(Ano)},  {autor(_,_,Ultimo,Ano,_,_,_,_)}.
frase_dec_nascer_ano --> [Primeiro], [Ultimo], verbo(s, nascer,passado), [em], [Ano], {integer(Ano)},  {autor(_,Primeiro,Ultimo,Ano,_,_,_,_)}.
frase_dec_nascer_sec --> [Primeiro], {autor(_,Primeiro,_,Ano,_,_,_,_)}, verbo(s,nascer,passado), [depois], [do], [seculo], [Sec], {seculo_lim(Sec, _, Last)}, !, {Ano > Last}.
frase_dec_nascer_sec --> [Primeiro], {autor(_,Primeiro,_,Ano,_,_,_,_)}, verbo(s,nascer,passado), [antes], [do], [seculo], [Sec], {seculo_lim(Sec, First, _)}, !, {Ano < First}.
frase_dec_nascer_sec --> [Primeiro], {autor(_,Primeiro,_,Ano,_,_,_,_)}, verbo(s,nascer,passado), [no], [seculo], [Sec], {seculo_lim(Sec, First, Last)}, !, {Ano >= First}, {Ano =< Last}.
frase_dec_nascer_sec --> [Ultimo], {autor(_,_,Ultimo,Ano,_,_,_,_)}, verbo(s,nascer,passado), [depois], [do], [seculo], [Sec], {seculo_lim(Sec, _, Last)}, !, {Ano > Last}.
frase_dec_nascer_sec --> [Ultimo], {autor(_,_,Ultimo,Ano,_,_,_,_)}, verbo(s,nascer,passado), [antes], [do], [seculo], [Sec], {seculo_lim(Sec, First, _)}, !, {Ano < First}.
frase_dec_nascer_sec --> [Ultimo], {autor(_,_,Ultimo,Ano,_,_,_,_)}, verbo(s,nascer,passado), [no], [seculo], [Sec], {seculo_lim(Sec, First, Last)}, !, {Ano >= First}, {Ano =< Last}.
frase_dec_nascer_sec --> [Primeiro], [Ultimo], {autor(_,Primeiro,Ultimo,Ano,_,_,_,_)}, verbo(s,nascer,passado), [depois], [do], [seculo], [Sec], {seculo_lim(Sec, _, Last)}, !, {Ano > Last}.
frase_dec_nascer_sec --> [Primeiro], [Ultimo], {autor(_,Primeiro,Ultimo,Ano,_,_,_,_)}, verbo(s,nascer,passado), [antes], [do], [seculo], [Sec], {seculo_lim(Sec, First, _)}, !, {Ano < First}.
frase_dec_nascer_sec --> [Primeiro], [Ultimo], {autor(_,Primeiro,Ultimo,Ano,_,_,_,_)}, verbo(s,nascer,passado), [no], [seculo], [Sec], {seculo_lim(Sec, First, Last)}, !, {Ano >= First}, {Ano =< Last}.
frase_dec_nascer_ord --> [Primeiro1], [Ultimo1], {autor(_,Primeiro1,Ultimo1,Ano1,_,_,_,_)}, verbo(s,nascer,passado), [antes], [de], [Primeiro2], [Ultimo2], {autor(_,Primeiro2,Ultimo2,Ano2,_,_,_,_)}, {Ano1 < Ano2}.
frase_dec_nascer_ord --> [Primeiro1], [Ultimo1], {autor(_,Primeiro1,Ultimo1,Ano1,_,_,_,_)}, verbo(s,nascer,passado), [antes], [de], [Primeiro2], {autor(_,Primeiro2,_,Ano2,_,_,_,_)}, {Ano1 < Ano2}.
frase_dec_nascer_ord --> [Primeiro1], [Ultimo1], {autor(_,Primeiro1,Ultimo1,Ano1,_,_,_,_)}, verbo(s,nascer,passado), [antes], [de], [Ultimo2], {autor(_,_,Ultimo2,Ano2,_,_,_,_)}, {Ano1 < Ano2}.
frase_dec_nascer_ord --> [Primeiro1], {autor(_,Primeiro1,_,Ano1,_,_,_,_)}, verbo(s,nascer,passado), [antes], [de], [Primeiro2], [Ultimo2], {autor(_,Primeiro2,Ultimo2,Ano2,_,_,_,_)}, {Ano1 < Ano2}.
frase_dec_nascer_ord --> [Primeiro1], {autor(_,Primeiro1,_,Ano1,_,_,_,_)}, verbo(s,nascer,passado), [antes], [de], [Primeiro2], {autor(_,Primeiro2,_,Ano2,_,_,_,_)}, {Ano1 < Ano2}.
frase_dec_nascer_ord --> [Primeiro1], {autor(_,Primeiro1,_,Ano1,_,_,_,_)}, verbo(s,nascer,passado), [antes], [de], [Ultimo2], {autor(_,_,Ultimo2,Ano2,_,_,_,_)}, {Ano1 < Ano2}.
frase_dec_nascer_ord --> [Ultimo1], {autor(_,_,Ultimo1,Ano1,_,_,_,_)}, verbo(s,nascer,passado), [antes], [de], [Primeiro2], [Ultimo2], {autor(_,Primeiro2,Ultimo2,Ano2,_,_,_,_)}, {Ano1 < Ano2}.
frase_dec_nascer_ord --> [Ultimo1], {autor(_,_,Ultimo1,Ano1,_,_,_,_)}, verbo(s,nascer,passado), [antes], [de], [Primeiro2], {autor(_,Primeiro2,_,Ano2,_,_,_,_)}, {Ano1 < Ano2}.
frase_dec_nascer_ord --> [Ultimo1], {autor(_,_,Ultimo1,Ano1,_,_,_,_)}, verbo(s,nascer,passado), [antes], [de], [Ultimo2], {autor(_,_,Ultimo2,Ano2,_,_,_,_)}, {Ano1 < Ano2}.
frase_dec_nascer_ord --> [Primeiro1], [Ultimo1], {autor(_,Primeiro1,Ultimo1,Ano1,_,_,_,_)}, verbo(s,nascer,passado), [depois], [de], [Primeiro2], [Ultimo2], {autor(_,Primeiro2,Ultimo2,Ano2,_,_,_,_)}, {Ano1 > Ano2}.
frase_dec_nascer_ord --> [Primeiro1], [Ultimo1], {autor(_,Primeiro1,Ultimo1,Ano1,_,_,_,_)}, verbo(s,nascer,passado), [depois], [de], [Primeiro2], {autor(_,Primeiro2,_,Ano2,_,_,_,_)}, {Ano1 > Ano2}.
frase_dec_nascer_ord --> [Primeiro1], [Ultimo1], {autor(_,Primeiro1,Ultimo1,Ano1,_,_,_,_)}, verbo(s,nascer,passado), [depois], [de], [Ultimo2], {autor(_,_,Ultimo2,Ano2,_,_,_,_)}, {Ano1 > Ano2}.
frase_dec_nascer_ord --> [Primeiro1], {autor(_,Primeiro1,_,Ano1,_,_,_,_)}, verbo(s,nascer,passado), [depois], [de], [Primeiro2], [Ultimo2], {autor(_,Primeiro2,Ultimo2,Ano2,_,_,_,_)}, {Ano1 > Ano2}.
frase_dec_nascer_ord --> [Primeiro1], {autor(_,Primeiro1,_,Ano1,_,_,_,_)}, verbo(s,nascer,passado), [depois], [de], [Primeiro2], {autor(_,Primeiro2,_,Ano2,_,_,_,_)}, {Ano1 > Ano2}.
frase_dec_nascer_ord --> [Primeiro1], {autor(_,Primeiro1,_,Ano1,_,_,_,_)}, verbo(s,nascer,passado), [depois], [de], [Ultimo2], {autor(_,_,Ultimo2,Ano2,_,_,_,_)}, {Ano1 > Ano2}.
frase_dec_nascer_ord --> [Ultimo1], {autor(_,_,Ultimo1,Ano1,_,_,_,_)}, verbo(s,nascer,passado), [depois], [de], [Primeiro2], [Ultimo2], {autor(_,Primeiro2,Ultimo2,Ano2,_,_,_,_)}, {Ano1 > Ano2}.
frase_dec_nascer_ord --> [Ultimo1], {autor(_,_,Ultimo1,Ano1,_,_,_,_)}, verbo(s,nascer,passado), [depois], [de], [Primeiro2], {autor(_,Primeiro2,_,Ano2,_,_,_,_)}, {Ano1 > Ano2}.
frase_dec_nascer_ord --> [Ultimo1], {autor(_,_,Ultimo1,Ano1,_,_,_,_)}, verbo(s,nascer,passado), [depois], [de], [Ultimo2], {autor(_,_,Ultimo2,Ano2,_,_,_,_)}, {Ano1 > Ano2}.

                                                  %---------------------------------------------------------%
                                                  %                          VIVER                          %
                                                  %---------------------------------------------------------%

% frase_int_viver_sec(N-G,Adj,Nom,Nac,Cont,Gen,Act,Temp,SecNum,Adv,[quais, os, escritores, que, viveram, no, seculo, 'XX', ?],[]).
% frase_int_viver_sec(N-G,Adj,Nom,Nac,Cont,Gen,Act,Temp,SecNum,Adv,[quais, os, escritores, que, viveram, antes, do, seculo, 'XX', ?],[]).
% frase_int_viver_sec(N-G,Adj,Nom,Nac,Cont,Gen,Act,Temp,SecNum,Adv,[quais, os, escritores, que, viveram, depois, do, seculo, 'XX', ?],[]).
% frase_dec_vivo_sec(['Camilo', 'Castelo Branco', viveu, antes, do, seculo, 'XX'],[]).
% frase_dec_vivo_sec(['Camilo', 'Castelo Branco', viveu, antes, do, seculo, 'XIII'],[]).
% frase_dec_vivo_sec(['Camilo', 'Castelo Branco', viveu, no, seculo, 'XX'],[]).
% frase_dec_vivo_sec(['Camilo', 'Castelo Branco', viveu, no, seculo, 'XIX'],[]).
% frase_dec_vivos(['Camilo', 'Castelo Branco', esta, vivo],[]).
% frase_dec_vivos(['Isabel', 'Allende', esta, viva],[]).

frase_dec_vivos --> [Primeiro], {autor(_,Primeiro,_,_,Ano,Genero,_,_)}, verbo(s,estar,presente), verbo_passiva(s-Genero, viver), {Ano < 0}.
frase_dec_vivos --> [Ultimo], {autor(_,_,Ultimo,_,Ano,Genero,_,_)}, verbo(s,estar,presente), verbo_passiva(s-Genero, viver), {Ano < 0}.
frase_dec_vivos --> [Primeiro], [Ultimo], {autor(_,Primeiro,Ultimo,_,Ano,Genero,_,_)}, verbo(s,estar,presente), verbo_passiva(s-Genero, viver), {Ano < 0}.
frase_dec_vivo_sec --> [Primeiro], {autor(_,Primeiro,_,Nasc,Morte,_,_,_)}, verbo(s,viver,passado), [no], [seculo], [Sec], {seculo_lim(Sec, First, Last)}, !, {Nasc >= First}, {Morte =< Last}.
frase_dec_vivo_sec --> [Ultimo], {autor(_,_,Ultimo,Nasc,Morte,_,_,_)}, verbo(s,viver,passado), [no], [seculo], [Sec], {seculo_lim(Sec, First, Last)}, !, {Nasc >= First}, {Morte =< Last}.
frase_dec_vivo_sec --> [Primeiro], [Ultimo], {autor(_,Primeiro,Ultimo,Nasc,Morte,_,_,_)}, verbo(s,viver,passado), [no], [seculo], [Sec], {seculo_lim(Sec, First, Last)}, !, {Nasc >= First}, {Morte =< Last}.
frase_dec_vivo_sec --> [Primeiro], {autor(_,Primeiro,_,_,Morte,_,_,_)}, verbo(s,viver,passado), [antes], [do], [seculo], [Sec], {seculo_lim(Sec, First, _)}, !, {Morte =< First}.
frase_dec_vivo_sec --> [Ultimo], {autor(_,_,Ultimo,_,Morte,_,_,_)}, verbo(s,viver,passado), [antes], [do], [seculo], [Sec], {seculo_lim(Sec, First, _)}, !, {Morte =< First}.
frase_dec_vivo_sec --> [Primeiro], [Ultimo], {autor(_,Primeiro,Ultimo,_,Morte,_,_,_)}, verbo(s,viver,passado), [antes], [do], [seculo], [Sec], {seculo_lim(Sec, First, _)}, !, {Morte =< First}.

                                                  %---------------------------------------------------------%
                                                  %                          MORRER                         %
                                                  %---------------------------------------------------------%

% frase_dec_morrer_ano(['Camilo', morreu, em, 1890],[]).
% frase_dec_morrer_ano(['Camilo', morreu, em, 1891],[]).
% frase_dec_morrer_ano(['Castelo Branco', morreu, em, 1890],[]).
% frase_dec_morrer_ano(['Castelo Branco', morreu, em, 1891],[]).
% frase_dec_morrer_ano(['Camilo','Castelo Branco', morreu, em, 1890],[]).
% frase_dec_morrer_ano(['Camilo','Castelo Branco', morreu, em, 1891],[]).
% frase_dec_morto(['Camilo','Castelo Branco', esta, morto],[]).
% frase_dec_morto(['Jane','Austen', esta, morta],[]).
% frase_dec_morto(['Isabel','Allende', esta, morta],[]).
% frase_dec_morto(['Haruki','Murakami', esta, morto],[]).
% frase_dec_morrer_sec(['Camilo', morreu, no, seculo, 'XX'],[]).
% frase_dec_morrer_sec(['Castelo Branco', morreu, no, seculo, 'XIX'],[]).
% frase_dec_morrer_sec(['Camilo','Castelo Branco', morreu, antes, do, seculo, 'XX'],[]).
% frase_dec_morrer_sec(['Camilo','Castelo Branco', morreu, depois, do, seculo, 'XX'],[]).
% frase_dec_morrer_ord(['Camilo','Castelo Branco', morreu, antes, de, 'Jane', 'Austen'],[]).
% frase_dec_morrer_ord(['Jane','Austen', morreu, antes, de, 'Camilo', 'Castelo Branco'],[]).
% frase_dec_morrer_ord(['Camilo','Castelo Branco', morreu, depois, de, 'Jane', 'Austen'],[]).
% frase_dec_morrer_ord(['Jane','Austen', morreu, depois, de, 'Camilo', 'Castelo Branco'],[]).

frase_dec_morrer_ano --> [Primeiro], verbo(s, morrer,passado), [em], [Ano], {integer(Ano)},  {autor(_,Primeiro,_,_,Ano,_,_,_)}.
frase_dec_morrer_ano --> [Ultimo], verbo(s, morrer,passado), [em], [Ano], {integer(Ano)},  {autor(_,_,Ultimo,_,Ano,_,_,_)}.
frase_dec_morrer_ano --> [Primeiro], [Ultimo], verbo(s, morrer,passado), [em], [Ano], {integer(Ano)},  {autor(_,Primeiro,Ultimo,_,Ano,_,_,_)}.
frase_dec_morto --> [Primeiro], {autor(_,Primeiro,_,_,Ano,G,_,_)}, verbo(s, estar, presente), verbo_passiva(s-G, morrer), {Ano >= 0}.
frase_dec_morto --> [Ultimo], {autor(_,_,Ultimo,_,Ano,G,_,_)}, verbo(s, estar, presente), verbo_passiva(s-G, morrer), {Ano >= 0}.
frase_dec_morto --> [Primeiro], [Ultimo], {autor(_,Primeiro,Ultimo,_,Ano,G,_,_)}, verbo(s, estar, presente), verbo_passiva(s-G, morrer), {Ano >= 0}.
frase_dec_morrer_sec --> [Primeiro], {autor(_,Primeiro,_,_,Ano,_,_,_)}, verbo(s,morrer,passado), [depois], [do], [seculo], [Sec], {seculo_lim(Sec, _, Last)}, !, {Ano > Last}.
frase_dec_morrer_sec --> [Primeiro], {autor(_,Primeiro,_,_,Ano,_,_,_)}, verbo(s,morrer,passado), [antes], [do], [seculo], [Sec], {seculo_lim(Sec, First, _)}, !, {Ano < First}.
frase_dec_morrer_sec --> [Primeiro], {autor(_,Primeiro,_,_,Ano,_,_,_)}, verbo(s,morrer,passado), [no], [seculo], [Sec], {seculo_lim(Sec, First, Last)}, !, {Ano >= First}, {Ano =< Last}.
frase_dec_morrer_sec --> [Ultimo], {autor(_,_,Ultimo,_,Ano,_,_,_)}, verbo(s,morrer,passado), [depois], [do], [seculo], [Sec], {seculo_lim(Sec, _, Last)}, !, {Ano > Last}.
frase_dec_morrer_sec --> [Ultimo], {autor(_,_,Ultimo,_,Ano,_,_,_)}, verbo(s,morrer,passado), [antes], [do], [seculo], [Sec], {seculo_lim(Sec, First, _)}, !, {Ano < First}.
frase_dec_morrer_sec --> [Ultimo], {autor(_,_,Ultimo,_,Ano,_,_,_)}, verbo(s,morrer,passado), [no], [seculo], [Sec], {seculo_lim(Sec, First, Last)}, !, {Ano >= First}, {Ano =< Last}.
frase_dec_morrer_sec --> [Primeiro], [Ultimo], {autor(_,Primeiro,Ultimo,_,Ano,_,_,_)}, verbo(s,morrer,passado), [depois], [do], [seculo], [Sec], {seculo_lim(Sec, _, Last)}, !, {Ano > Last}.
frase_dec_morrer_sec --> [Primeiro], [Ultimo], {autor(_,Primeiro,Ultimo,_,Ano,_,_,_)}, verbo(s,morrer,passado), [antes], [do], [seculo], [Sec], {seculo_lim(Sec, First, _)}, !, {Ano < First}.
frase_dec_morrer_sec --> [Primeiro], [Ultimo], {autor(_,Primeiro,Ultimo,_,Ano,_,_,_)}, verbo(s,morrer,passado), [no], [seculo], [Sec], {seculo_lim(Sec, First, Last)}, !, {Ano >= First}, {Ano =< Last}.
frase_dec_morrer_ord --> [Primeiro1], [Ultimo1], {autor(_,Primeiro1,Ultimo1,_,Ano1,_,_,_)}, verbo(s,morrer,passado), [antes], [de], [Primeiro2], [Ultimo2], {autor(_,Primeiro2,Ultimo2,_,Ano2,_,_,_)}, !, {Ano1 < Ano2}, {Ano1 > 0}, {Ano2 > 0}.
frase_dec_morrer_ord --> [Primeiro1], [Ultimo1], {autor(_,Primeiro1,Ultimo1,_,Ano1,_,_,_)}, verbo(s,morrer,passado), [antes], [de], [Primeiro2], {autor(_,Primeiro2,_,_,Ano2,_,_,_)}, !, {Ano1 < Ano2}, {Ano1 > 0}, {Ano2 > 0}.
frase_dec_morrer_ord --> [Primeiro1], [Ultimo1], {autor(_,Primeiro1,Ultimo1,_,Ano1,_,_,_)}, verbo(s,morrer,passado), [antes], [de], [Ultimo2], {autor(_,_,Ultimo2,_,Ano2,_,_,_)}, !, {Ano1 < Ano2}, {Ano1 > 0}, {Ano2 > 0}.
frase_dec_morrer_ord --> [Primeiro1], {autor(_,Primeiro1,_,_,Ano1,_,_,_)}, verbo(s,morrer,passado), [antes], [de], [Primeiro2], [Ultimo2], {autor(_,Primeiro2,Ultimo2,_,Ano2,_,_,_)}, !, {Ano1 < Ano2}, {Ano1 > 0}, {Ano2 > 0}.
frase_dec_morrer_ord --> [Primeiro1], {autor(_,Primeiro1,_,_,Ano1,_,_,_)}, verbo(s,morrer,passado), [antes], [de], [Primeiro2], {autor(_,Primeiro2,_,_,Ano2,_,_,_)}, !, {Ano1 < Ano2}, {Ano1 > 0}, {Ano2 > 0}.
frase_dec_morrer_ord --> [Primeiro1], {autor(_,Primeiro1,_,_,Ano1,_,_,_)}, verbo(s,morrer,passado), [antes], [de], [Ultimo2], {autor(_,_,Ultimo2,_,Ano2,_,_,_)}, !, {Ano1 < Ano2}, {Ano1 > 0}, {Ano2 > 0}.
frase_dec_morrer_ord --> [Ultimo1], {autor(_,_,Ultimo1,_,Ano1,_,_,_)}, verbo(s,morrer,passado), [antes], [de], [Primeiro2], [Ultimo2], {autor(_,Primeiro2,Ultimo2,_,Ano2,_,_,_)}, !, {Ano1 < Ano2}, {Ano1 > 0}, {Ano2 > 0}.
frase_dec_morrer_ord --> [Ultimo1], {autor(_,_,Ultimo1,_,Ano1,_,_,_)}, verbo(s,morrer,passado), [antes], [de], [Primeiro2], {autor(_,Primeiro2,_,_,Ano2,_,_,_)}, !, {Ano1 < Ano2}, {Ano1 > 0}, {Ano2 > 0}.
frase_dec_morrer_ord --> [Ultimo1], {autor(_,_,Ultimo1,_,Ano1,_,_,_)}, verbo(s,morrer,passado), [antes], [de], [Ultimo2], {autor(_,_,Ultimo2,_,Ano2,_,_,_)}, !,{Ano1 < Ano2}, {Ano1 > 0}, {Ano2 > 0}.
frase_dec_morrer_ord --> [Primeiro1], [Ultimo1], {autor(_,Primeiro1,Ultimo1,_,Ano1,_,_,_)}, verbo(s,morrer,passado), [depois], [de], [Primeiro2], [Ultimo2], {autor(_,Primeiro2,Ultimo2,_,Ano2,_,_,_)}, !, {Ano1 > Ano2}, {Ano1 > 0}, {Ano2 > 0}.
frase_dec_morrer_ord --> [Primeiro1], [Ultimo1], {autor(_,Primeiro1,Ultimo1,_,Ano1,_,_,_)}, verbo(s,morrer,passado), [depois], [de], [Primeiro2], {autor(_,Primeiro2,_,_,Ano2,_,_,_)}, !, {Ano1 > Ano2}, {Ano1 > 0}, {Ano2 > 0}.
frase_dec_morrer_ord --> [Primeiro1], [Ultimo1], {autor(_,Primeiro1,Ultimo1,_,Ano1,_,_,_)}, verbo(s,morrer,passado), [depois], [de], [Ultimo2], {autor(_,_,Ultimo2,_,Ano2,_,_,_)}, !, {Ano1 > Ano2}, {Ano1 > 0}, {Ano2 > 0}.
frase_dec_morrer_ord --> [Primeiro1], {autor(_,Primeiro1,_,_,Ano1,_,_,_)}, verbo(s,morrer,passado), [depois], [de], [Primeiro2], [Ultimo2], {autor(_,Primeiro2,Ultimo2,_,Ano2,_,_,_)}, !, {Ano1 > Ano2}, {Ano1 > 0}, {Ano2 > 0}.
frase_dec_morrer_ord --> [Primeiro1], {autor(_,Primeiro1,_,_,Ano1,_,_,_)}, verbo(s,morrer,passado), [depois], [de], [Primeiro2], {autor(_,Primeiro2,_,_,Ano2,_,_,_)}, !, {Ano1 > Ano2}, {Ano1 > 0}, {Ano2 > 0}.
frase_dec_morrer_ord --> [Primeiro1], {autor(_,Primeiro1,_,_,Ano1,_,_,_)}, verbo(s,morrer,passado), [depois], [de], [Ultimo2], {autor(_,_,Ultimo2,_,Ano2,_,_,_)}, !, {Ano1 > Ano2}, {Ano1 > 0}, {Ano2 > 0}.
frase_dec_morrer_ord --> [Ultimo1], {autor(_,_,Ultimo1,_,Ano1,_,_,_)}, verbo(s,morrer,passado), [depois], [de], [Primeiro2], [Ultimo2], {autor(_,Primeiro2,Ultimo2,_,Ano2,_,_,_)}, !, {Ano1 > Ano2}, {Ano1 > 0}, {Ano2 > 0}.
frase_dec_morrer_ord --> [Ultimo1], {autor(_,_,Ultimo1,_,Ano1,_,_,_)}, verbo(s,morrer,passado), [depois], [de], [Primeiro2], {autor(_,Primeiro2,_,_,Ano2,_,_,_)}, !, {Ano1 > Ano2}, {Ano1 > 0}, {Ano2 > 0}.
frase_dec_morrer_ord --> [Ultimo1], {autor(_,_,Ultimo1,_,Ano1,_,_,_)}, verbo(s,morrer,passado), [depois], [de], [Ultimo2], {autor(_,_,Ultimo2,_,Ano2,_,_,_)}, !, {Ano1 > Ano2}, {Ano1 > 0}, {Ano2 > 0}.

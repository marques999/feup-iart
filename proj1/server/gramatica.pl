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

%?- ensure_loaded('bibliogenie.pl').
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

% sint_verb(N-G,Adj,Nom,Nac,Cont,Gen,Act,Temp,[escreveu, o, livro],[]).

sint_verb(N-G,Adj,Nom,Nac,Cont,Gen,Act,Tem) --> verbo(N,Act,Tem),(art_def(N-G);[]), nom(N-G,Adj,Nom,Nac,Cont,Gen).

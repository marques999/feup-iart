% consult(['~/Desktop/feup-iart-master/proj1/server/gramatica.pl']).

%---------------------------------------------------------%
%                      PILHA DE TESTES                    %
%---------------------------------------------------------%

% atributo(N-G, Adj, GrAdj, Nac, Cont, [mais,recente], []).
% atributo(N-G, Adj, GrAdj, Nac, Cont, [antigo], []).
% atributo(N-G, Adj, GrAdj, Nac, Cont, [portugueses], []).
% atributo(N-G, Adj, GrAdj, Nac, Cont, [sul-americano], []).
% --
% atributo(N-G, Adj, GrAdj, Nac, Cont, [mais, bonito], []).
% atributo(N-G, Adj, GrAdj, Nac, Cont, [o, mais, bonito], []).
% atributo(N-G, Adj, GrAdj, Nac, Cont, [marciano], []).

% nom(N-G,Adj,GrAdj,Nom, Nac, Cont, Gen, [livros],[]).
% nom(N-G,Adj,GrAdj,Nom, Nac, Cont, Gen, [escritores, europeus],[]).
% nom(N-G,Adj,GrAdj,Nom, Nac, Cont, Gen, [autor, portugues],[]).
% nom(N-G,Adj,GrAdj,Nom, Nac, Cont, Gen, [dramas, mais, recentes],[]).
% --
% nom(N-G,Adj,GrAdj,Nom, Nac, Cont, Gen, [as, comedias, mais, antigas],[]).

% com_deter(N-G,Adj,GrAdj,Nom,Nac,Cont,Gen,[de,autores,ingleses],[]).
% com_deter(N-G,Adj,GrAdj,Nom,Nac,Cont,Gen,[das,comedias,mais,antigas],[]).
% --
% com_deter(N-G,Adj,GrAdj,Nom,Nac,Cont,Gen,[da,comedias,mais,antigas],[]).

% sint_nom_int(N-G,Adj,GrAdj,Nom,Nac,Cont,Gen,[quais, as, escritoras, que],[]).
% sint_nom_int(N-G,Adj,GrAdj,Nom,Nac,Cont,Gen,[quais, os, escritores, portugueses, que],[]).
% sint_nom_int(N-G,Adj,GrAdj,Nom,Nac,Cont,Gen,[quais, as, comedias, mais, recentes, de, escritoras, inglesas, que],[]).
% --
% sint_nom_int(N-G,Adj,GrAdj,Nom,Nac,Cont,Gen,[quando, as, comedias, mais, recentes, de, escritoras, inglesas, que],[]).

clear :- write('\33\[2J').

%---------------------------------------------------------%
%                          INCLUDES                       %
%---------------------------------------------------------%

%?- ensure_loaded('bibliogenie.pl').
?- ensure_loaded('lexico.pl').
%?- ensure_loaded('query.pl').
%?- ensure_loaded('server.pl').

atributo(N-G, Adj, GrAdj, _, _) --> adjetivo_super(GrAdj), adjetivo(N-G, Adj).                    % ... mais recente ...
atributo(N-G, Adj, _, _, _) --> adjetivo(N-G, Adj).
                                                                                                  % ... antigo ...
atributo(N-G, _, _,Nac, _) --> subst_nac(Nac,N-G).                                                % ... portugueses ....
atributo(N-G, _, _, _, Cont) --> subst_cont(N-G,Cont).                                            % ... sul-americano ...

nom(N-G,Adj,GrAdj,Nom, Nac, Cont, _) --> subst(N-G,Nom), atributo(N-G, Adj, GrAdj, Nac, Cont).        % ... escritores europeus ...
nom(N-G,Adj,GrAdj,_, Nac, Cont, Gen) --> subst_gen(Gen,N-G), atributo(N-G, Adj, GrAdj, Nac, Cont).    % ... livros mais recentes ...
nom(N-G,_,_,Nom,_,_,_) --> subst(N-G,Nom).                                                            % ... escritores
nom(N-G,_,_,_,_,_,Gen) --> subst_gen(Gen,N-G).                                                        % ... livros ...

com_deter(N-G,Adj,GrAdj,Nom,Nac,Cont,Gen) --> preposicao(N-G),                                        % ... dos autores ingleses ...
                                            nom(N-G, Adj, GrAdj, Nom, Nac, Cont, Gen).

sint_nom_int(N-G,Adj,GrAdj,Nom,Nac,Cont,Gen) --> [quais],              % "Quais" os escritores [portugueses] que ...
                                                   art_def(N-G),
                                                   nom(N-G,Adj,GrAdj,Nom, Nac,Cont, Gen),
                                                   pron_rel(_-_).

sint_nom_int(N-G,Adj,GrAdj,Nom,Nac,Cont,Gen) --> [quais],              % "Quais" as comédias mais recentes de escritoras inglesas que ...
                                                  art_def(N-G),
                                                  nom(N-G,Adj,GrAdj,Nom, Nac,Cont,Gen),
                                                  com_deter(N-G,Adj,GrAdj,Nom,Nac,Cont,Gen),
                                                  pron_rel(_-_).

/*
% ESTA SECÇÃO AQUI NÃO ESTÁ COMPLETA FALTA ACRESCENTAR 'Nac' E 'Cont' NAS CHAMADAS NECESSÁRIAS!!!

% sint_nom_int(N-G,Adj1,Adj2,GrAdj1,GrAdj2,Nom1,Nom2) --> pron_int(N-_,ql),     % "Quais" os livros dos escritores portugueses que ...
                                              art_def(N-G),
                                              nom(N-G,Adj1,GrAdj1,Nom1),
                                              com_deter(N-G,Adj2,GrAdj2,Nom2),
                                              pronome_relativo(_-_).
% sint_nom_int(N-G,Adj,_,GrAdj,_,Nom,_) --> pron_int(_-_,ql),                        % "Que" escritores portugueses ...
                                       nom(N-G,Adj,GrAdj,Nom).
% sint_nom_int(_-_,_,_,_,_,_,_) --> pron_int(_-_,ql).                           % "Quem"\"Quando" ...
% sint_nom_int(N-G,Adj1,Adj2,GrAdj1,GrAdj2,Nom1,Nom2) --> pron_int(N-G,qn),     % "Quantos" livros de escritores portugueses ...
                                              subst(N-G,Nom1),
                                              com_deter(N-G,Adj2,GrAdj2,Nom2).
% sint_nom_int(N-G,Adj,_,GrAdj,_,Nom,_,_) --> pron_int(N-G,qn),                 % "Quantos" livros ...
                                               nom(N-G,Adj,GrAdj,Nom).
% sint_verb(N-G,Nom, Ver, Temp) --> verbo(N, Ver, Temp), nom(N-G,Nom).          % encontram


% query -->   % "Quais" .... ?
% query -->   % "O" ... .

% -----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

% Quem escreveu 'Os Maias'?
% Quem são os escritores africanos?
% Quais são os escritores africanos? [E portugueses?]
% Quais os livros de escritores portugueses escritos após 1823?
% Quais os escritores portugueses e espanhóis do século XV?
% Quais os livros publicados no século XV?
% Quantos livros de escritores europeus existem após o século XVI? [E qual é o mais recente?]
% Quantos livros escreveu Camilo Castelo Branco?
*/

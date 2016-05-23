% consult(['~/Desktop/feup-iart-master/proj1/server/gramatica.pl']).

%---------------------------------------------------------%
%                          INCLUDES                       %
%---------------------------------------------------------%

?- ensure_loaded('bibliogenie.pl').
%?- ensure_loaded('lexico.pl').
?- ensure_loaded('query.pl').
?- ensure_loaded('server.pl').

/*
% atributo(N-G, Adj, _) --> adjetivo(N-G, Adj).                                 % ... portugueses ...
% atributo(N-G, Adj, GrAdj) --> adjetivo_super(Gr), adjetivo(N-G, Adj).         % ... mais antigos ...
% nom(N-G,_,_,Nom) --> substantivo(N-G,Nom).                                    % ... livros ...
% nom(N-G,Adj,GrAdj,Nom) --> substantivo(N-G,Nom), atributo(N-G, Adj, GrAdj).   % ... livros mais antigos ...
% com_deter(N-G,Adj,GrAdj,Nom) --> preposicao(N-G), substantivo(N-G,Nom),       % ... dos escritores ingleses ...
                                   atributo(N-G, Adj, GrAdj).
% com_deter(N-G,Adj,GrAdj,Nom) --> preposicao(N-G), substantivo(N-G,Nom).       % ... do livro  ...
% sint_nom_int(N-G,Adj,_,GrAdj,_,Nom,_) --> pron_int(N-_,ql),                   % Quais os escritores [portugueses] que ...
                                             art_def(N-G),
                                             nom(N-G,Adj,GrAdj,Nom),
                                             pron_rel(_-_).
% sint_nom_int(N-G,Adj1,Adj2,GrAdj1,GrAdj2,Nom1,Nom2) --> pron_int(N-_,ql),     % Quais os livros dos escritores portugueses que ...
                                              art_def(N-G),
                                              nom(N-G,Adj1,GrAdj1,Nom1),
                                              com_deter(N-G,Adj2,GrAdj2,Nom2),
                                              pronome_relativo(_-_).
% sint_nom_int(N-G,Adj,_,GrAdj,_,Nom,_) --> pron_int(_-_,ql),                   % Que escritores portugueses ...
                                       nom(N-G,Adj,GrAdj,Nom).
% sint_nom_int(_-_,_,_,_,_,_,_) --> pron_int(_-_,ql).                           % Quem\Quando ...
% sint_nom_int(N-G,Adj1,Adj2,GrAdj1,GrAdj2,Nom1,Nom2) --> pron_int(N-G,qn),     % Quantos livros de escritores portugueses ...
                                              substantivo(N-G,Nom1),
                                              com_deter(N-G,Adj2,GrAdj2,Nom2).
% sint_nom_int(N-G,Adj,_,GrAdj,_,Nom,_,_) --> pron_int(N-G,qn),                 % Quantos livros ...
                                               nom(N-G,Adj,GrAdj,Nom).
% sint_verb(N-G,Nom, Ver, Temp) --> verbo(N, Ver, Temp), nom(N-G,Nom).          % encontram

% query -->   % "Quais\Que\Quem\Quantos\Quantas" .... ?
% query -->   % "O\..." ... .

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

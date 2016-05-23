%---------------------------------------------------------%
%                          INCLUDES                       %
%---------------------------------------------------------%

?- ensure_loaded('lexico.pl').

% |-------------------------------------------------------- SINTAGMA INTERROGATIVO --------------------------------------------------------|

%                          |------ SINTAGMA NOMINAL INTER -----|    |---------------------------- SINTAGMA VERBAL -------------------------|

%                                                                                                |----------- SINTAGMA  NOMINAL -----------|

% [Pronome Interrogativo + ([(Determinante) + Nome + (Pronome)])] + [Verbo + (Preposicao, Nome | [(Determinante) + Nome + ])]

% Quem escreveu 'Os Maias'?
% Quem são os escritores africanos?
% Quais são os escritores africanos? E portugueses?
% Quais os escritores portugueses e espanhóis do século XV?
% Quantos livros de escritores europeus existem após o século XVI? E qual é o mais recente?
% Quantos livros escreveu Camilo Castelo Branco?

frase_i(Q,A,At,O) --> sintagma_inter(N-_,At,Q), sintagma_verbal(N,A,_,O).
sintagma_interrogativo(N-_,At,Q) --> pronome_interrogativo(N-_, Q), sintagma_nominal_interrogativo(N-_, At).
sintagma_interrogativo(N-_,_,Q) --> pronome_interrogativo(N-_, Q).
sintagma_nominal_interrogativo(N-G, At) --> determinante(N-G), nome(N-G,At), pronome(_).
sintagma_nominal_interrogativo(N-G, At) --> nome(N-G,At).
sintagma_nominal(N,S) --> determinante(N-G), nome(N-G,S).
sintagma_nominal(N,S) --> nome(N-_,S).
sintagma_verbal(N,gostar,S,O) --> verbo(N, gostar,S,O), preposicao(N1-G1), nome(N1-G1,O).
sintagma_verbal(N,A,S,O) --> verbo(N,A,S,O), sintagma_nominal(_,O).
*/

:- op(400,xfx,\).
:- op(900,xfy,ou).

flatten(S,F) :-
  flatten_dl(S,F\[]).

flatten_dl([],X\X).
flatten_dl([X|Xs],Y\Z) :-
   flatten_dl(X,Y\T),
   flatten_dl(Xs,T\Z).
flatten_dl(X,[X|Z]\Z).

filtrar_livros(Selector, Lista):-
	findall(livro(IdLivro, Titulo, Autor, Ano, Genero, Coleccao),
	(
		livro(IdLivro, Titulo, Autor, Ano, Genero, Coleccao),
		filtrar_livros_aux(livro(IdLivro, Titulo, Autor, Ano, Genero, Coleccao), Selector)
	), Lista).

filtrar_livros_aux(_, []).

filtrar_livros_aux(livro(IdLivro, Titulo, Autor, Ano, Genero, Coleccao), [autor=Autor|Tail]):-
	filtrar_livros_aux(livro(IdLivro, Titulo, Autor, Ano, Genero, Coleccao), Tail).
filtrar_livros_aux(livro(IdLivro, Titulo, Autor, Ano, Genero, Coleccao), [autor=null|Tail]):-
	Autor = null,
	filtrar_livros_aux(livro(IdLivro, Titulo, Autor, Ano, Genero, Coleccao), Tail).

filtrar_livros_aux(livro(IdLivro, Titulo, Autor, Ano, Genero, Coleccao), [ano<AnoLimite|Tail]):-
	Ano < AnoLimite,
	filtrar_livros_aux(livro(IdLivro, Titulo, Autor, Ano, Genero, Coleccao), Tail).
filtrar_livros_aux(livro(IdLivro, Titulo, Autor, Ano, Genero, Coleccao), [ano>AnoLimite|Tail]):-
	Ano > AnoLimite,
	filtrar_livros_aux(livro(IdLivro, Titulo, Autor, Ano, Genero, Coleccao), Tail).
filtrar_livros_aux(livro(IdLivro, Titulo, Autor, Ano, Genero, Coleccao), [ano=AnoLimite|Tail]):-
	Ano = AnoLimite,
	filtrar_livros_aux(livro(IdLivro, Titulo, Autor, Ano, Genero, Coleccao), Tail).
filtrar_livros_aux(livro(IdLivro, Titulo, Autor, Ano, Genero, Coleccao), [ano=LimiteInferior-LimiteSuperior|Tail]):-
	Ano >= LimiteInferior,
	Ano =< LimiteSuperior,
	filtrar_livros_aux(livro(IdLivro, Titulo, Autor, Ano, Genero, Coleccao), Tail).

filtrar_livros_aux(livro(IdLivro, Titulo, Autor, Ano, Genero, Coleccao), [seculo<Seculo|Tail]):-
	LimiteInferior is (Seculo * 100) - 99,
	Ano < LimiteInferior,
	filtrar_livros_aux(livro(IdLivro, Titulo, Autor, Ano, Genero, Coleccao), Tail).
filtrar_livros_aux(livro(IdLivro, Titulo, Autor, Ano, Genero, Coleccao), [seculo>Seculo|Tail]):-
	LimiteSuperior is (Seculo * 100),
	Ano > LimiteSuperior,
	filtrar_livros_aux(livro(IdLivro, Titulo, Autor, Ano, Genero, Coleccao), Tail).
filtrar_livros_aux(livro(IdLivro, Titulo, Autor, Ano, Genero, Coleccao), [seculo=Seculo|Tail]):-
	LimiteSuperior is (Seculo * 100),
	LimiteInferior is LimiteSuperior - 99,
	Ano >= LimiteInferior,
	Ano =< LimiteSuperior,
	filtrar_livros_aux(livro(IdLivro, Titulo, Autor, Ano, Genero, Coleccao), Tail).

filtrar_livros_aux(livro(IdLivro, Titulo, Autor, Ano, Genero, Coleccao), [coleccao=null|Tail]):-
	Coleccao = null,
	filtrar_livros_aux(livro(IdLivro, Titulo, Autor, Ano, Genero, Coleccao), Tail).
filtrar_livros_aux(livro(IdLivro, Titulo, Autor, Ano, Genero, Coleccao), [coleccao\=null|Tail]):-
	Coleccao \= null,
	filtrar_livros_aux(livro(IdLivro, Titulo, Autor, Ano, Genero, Coleccao), Tail).

filtrar_livros_aux(livro(IdLivro, Titulo, Autor, Ano, Genero, Coleccao), [genero=Genero |Tail]):-
	filtrar_livros_aux(livro(IdLivro, Titulo, Autor, Ano, Genero, Coleccao), Tail).
filtrar_livros_aux(livro(IdLivro, Titulo, Autor, Ano, Genero, Coleccao), [genero=Genero ou Generos|Tail]):-
	verificar_genero(livro(IdLivro, Titulo, Autor, Ano, Genero, Coleccao), Genero ou Generos),
	filtrar_livros_aux(livro(IdLivro, Titulo, Autor, Ano, Genero, Coleccao), Tail).

filtrar_livros_aux(livro(IdLivro, Titulo, Autor, Ano, Genero, Coleccao), [postumo|Tail]):-
	autor(Autor, _, _, AnoNascimento, AnoMorte, _, _),
	AnoMorte > AnoNascimento, AnoMorte < Ano,
	filtrar_livros_aux(livro(IdLivro, Titulo, Autor, Ano, Genero, Coleccao), Tail).

%-----------------------------------------------------------------------------%
% -> Livros publicados                                                        %
%-----------------------------------------------------------------------------%
livros_publicados(Lista):-
	filtrar_livros([], Lista).

%-----------------------------------------------------------------------------%
% -> Livros publicados por determinado autor                                  %
%-----------------------------------------------------------------------------%
livros_publicados(Autor, Lista):-
	filtrar_livros([autor=Autor], Lista).

%-----------------------------------------------------------------------------%
% -> Livros publicados em colecções                                           %
%-----------------------------------------------------------------------------%
livros_publicados_coleccoes(Lista):-
	filtrar_livros([coleccao\=null], Lista).

%-----------------------------------------------------------------------------%
% -> Livros de determinado autor publicados em colecções                      %
%-----------------------------------------------------------------------------%
livros_publicados_coleccoes(Autor, Lista):-
	filtrar_livros([autor=Autor, coleccao\=null], Lista).

%-----------------------------------------------------------------------------%
% -> Livros póstumos                                                          %
%-----------------------------------------------------------------------------%
livros_postumos(Lista):-
	filtrar_livros([postumo], Lista).

%-----------------------------------------------------------------------------%
% -> Livros póstumos de determinado autor                                     %
%-----------------------------------------------------------------------------%
livros_postumos(Autor, Lista):-
	filtrar_livros([autor=Autor,postumo], Lista).

%-----------------------------------------------------------------------------%
% -> Livros publicados antes do ano AnoLimite                                 %
%-----------------------------------------------------------------------------%
livros_publicados_antes(AnoLimite, Lista):-
	filtrar_livros([ano<AnoLimite], Lista).

%-----------------------------------------------------------------------------%
% -> Livros de determinado autor publicados antes do ano AnoLimite            %
%-----------------------------------------------------------------------------%
livros_publicados_antes(Autor, AnoLimite, Lista):-
	filtrar_livros([autor=Autor,ano<AnoLimite], Lista).

%-----------------------------------------------------------------------------%
% -> Livros publicados no ano AnoLimite                                       %
%-----------------------------------------------------------------------------%
livros_publicados_ano(AnoLimite, Lista):-
	filtrar_livros([ano=AnoLimite], Lista).

%-----------------------------------------------------------------------------%
% -> Livros de determinado autor publicados no ano AnoLimite                  %
%-----------------------------------------------------------------------------%
livros_publicados_ano(Autor, AnoLimite, Lista):-
	filtrar_livros([autor=Autor,ano=AnoLimite], Lista).

%------------------------------------------------------------------------------------%
% -> Livros publicados entre [LimiteInferior, LimiteSuperior]                        %
%------------------------------------------------------------------------------------%
livros_publicados_entre(LimiteInferior, LimiteSuperior, Lista):-
	filtrar_livros([ano=LimiteInferior-LimiteSuperior], Lista).

%------------------------------------------------------------------------------------%
% -> Livros de determinado autor publicados entre [LimiteInferior, LimiteSuperior]   %
%------------------------------------------------------------------------------------%
livros_publicados_entre(Autor, LimiteInferior, LimiteSuperior, Lista):-
	filtrar_livros([autor=Autor,ano=LimiteInferior-LimiteSuperior], Lista).

%-----------------------------------------------------------------------------%
% -> Livros publicados depois do ano AnoLimite                                %
%-----------------------------------------------------------------------------%
livros_publicados_depois(AnoLimite, Lista):-
	filtrar_livros([ano>AnoLimite], Lista).

%-----------------------------------------------------------------------------%
% -> Livros de determinado autor publicados depois do ano AnoLimite           %
%-----------------------------------------------------------------------------%
livros_publicados_depois(Autor, AnoLimite, Lista):-
	filtrar_livros([autor=Autor,ano>AnoLimite], Lista).

%-----------------------------------------------------------------------------%
% -> Livros (de determinado autor) publicados em determinado(s) Século(s)     %
%-----------------------------------------------------------------------------%
livros_seculo(Autor, ListaSeculos, ListaResultado):-
	livros_seculo_aux(Autor, ListaSeculos, ResultadoTemporario),
	flatten(ResultadoTemporario, ListaResultado).

livros_seculo_aux(_, [], []).
livros_seculo_aux(Autor, [Seculo|TailSeculo], [Lista|TailLista]):-
	LimiteSuperior is (Seculo * 100),
	LimiteInferior is LimiteSuperior - 99,
	livros_seculo_aux(Autor, TailSeculo, TailLista),
	livros_publicados_entre(Autor, LimiteInferior, LimiteSuperior, Lista).

verificar_genero(livro(_, _, _, _, Genero, _), Genero ou _).
verificar_genero(livro(IdLivro, Titulo, Autor, Ano, Genero, Coleccao), _ ou Generos):-
	verificar_genero(livro(IdLivro, Titulo, Autor, Ano, Genero, Coleccao), Generos).
verificar_genero(livro(_, _, _, _, Genero, _), Genero).

%-----------------------------------------------------------------------------%
% -> Livros (de determinado autor) que são de determinado(s) Género(s)        %
%-----------------------------------------------------------------------------%
livros_genero(Autor, ListaGeneros, Lista):-
	findall(livro(IdLivro, Titulo, Autor1, Ano, Genero, Coleccao),
	(
		(Autor = null,
			Autor1^livro(IdLivro, Titulo, Autor1, Ano, Genero, Coleccao)
			;
			livro(IdLivro, Titulo, Autor, Ano, Genero, Coleccao),
			Autor1 = Autor
		),
		livro(IdLivro, Titulo, Autor, Ano, Genero, Coleccao),
		member(Genero, ListaGeneros)
	), Lista).

%-----------------------------------------------------------------------------%
% -> Livros (de determinado autor) que não são de determinado Género          %
%-----------------------------------------------------------------------------%
livros_nao_genero(Autor, ListaGeneros, Lista):-
	findall(livro(IdLivro, Titulo, Autor1, Ano, Genero, Coleccao),
	(
		(Autor = null,
			Autor1^livro(IdLivro, Titulo, Autor1, Ano, Genero, Coleccao)
			;
			livro(IdLivro, Titulo, Autor, Ano, Genero, Coleccao),
			Autor1 = Autor
		),
		Genero^livro(IdLivro, Titulo, Autor, Ano, Genero, Coleccao), 
		\+member(Genero, ListaGeneros)
	), Lista).

%-----------------------------------------------------------------------------%
% -> Livro mais antigo presente na base de dados                              %
%-----------------------------------------------------------------------------%
livro_mais_antigo(Livro):-
    livros_mais_antigos([_-Livro|_]).

%-----------------------------------------------------------------------------%
% -> Livros mais antigos presentes na base de dados                           %
%-----------------------------------------------------------------------------%
livros_mais_antigos(Numero, Resultado):-
	livros_mais_antigos(ListaLivros),
	livros_mais_antigos_aux(Numero, ListaLivros, Resultado).

livros_mais_antigos_aux(0, _, []).
livros_mais_antigos_aux(_, [], _).
livros_mais_antigos_aux(Numero, [_-Livro|Tail], [Livro|OutraTail]):-
	NovoNumero is Numero - 1,
	livros_mais_antigos_aux(NovoNumero, Tail, OutraTail).

livros_mais_antigos(Livros):-
	setof(Ano-livro(IdLivro, Titulo, Autor, Ano, Genero, Coleccao), 
    	Ano^livro(IdLivro, Titulo, Autor, Ano, Genero, Coleccao),
    	Livros).

%-----------------------------------------------------------------------------%
% -> Livro mais recente presente na base de dados                             %
%-----------------------------------------------------------------------------%
livro_mais_recente(Livro):-
    livros_mais_recentes([_-Livro|_]).

%-----------------------------------------------------------------------------%
% -> Livros mais recentes presentes na base de dados                          %
%-----------------------------------------------------------------------------%
livros_mais_recentes(Numero, Resultado):-
	livros_mais_recentes(ListaLivros),
	livros_mais_recentes_aux(Numero, ListaLivros, Resultado).

livros_mais_recentes_aux(0, _, []).
livros_mais_recentes_aux(_, [], _).
livros_mais_recentes_aux(Numero, [_-Livro|Tail], [Livro|OutraTail]):-
	NovoNumero is Numero - 1,
	livros_mais_antigos_aux(NovoNumero, Tail, OutraTail).

livros_mais_recentes(Livros):-
    setof(NovoAno-livro(IdLivro, Titulo, Autor, Ano, Genero, Coleccao), 
    	Ano^(livro(IdLivro, Titulo, Autor, Ano, Genero, Coleccao), NovoAno is -Ano),
    	Livros).

%-----------------------------------------------------------------------------%
% -> Autor mais velho presente na base de dados                               %
%-----------------------------------------------------------------------------%
autor_mais_velho(Autor):-
    autores_mais_velhos([_-Autor|_]).

%-----------------------------------------------------------------------------%
% -> Autores mais velhos presentes na base de dados                           %
%-----------------------------------------------------------------------------%
autores_mais_velhos(Numero, Resultado):-
	autores_mais_velhos(ListaAutores),
	autores_mais_velhos_aux(Numero, ListaAutores, Resultado).

autores_mais_velhos_aux(0, _, []).
autores_mais_velhos_aux(_, [], _).
autores_mais_velhos_aux(Numero, [_-Autor|Tail], [Autor|OutraTail]):-
	NovoNumero is Numero - 1,
	autores_mais_velhos_aux(NovoNumero, Tail, OutraTail).

autores_mais_velhos(Autores):-
  setof(AnoNascimento-autor(IdAutor, PrimeiroNome, UltimoNome, AnoNascimento, AnoMorte, Nacionalidade, Pseudonimos),
  	AnoNascimento^autor(IdAutor, PrimeiroNome, UltimoNome, AnoNascimento, AnoMorte, Nacionalidade, Pseudonimos),
 	Autores).

%-----------------------------------------------------------------------------%
% -> Autor mais novo presente na base de dados                                %
%-----------------------------------------------------------------------------%
autor_mais_novo(Autor):-
    autores_mais_novos([_-Autor|_]).

%-----------------------------------------------------------------------------%
% -> Autores mais novos presentes na base de dados                            %
%-----------------------------------------------------------------------------%
autores_mais_novos(Numero, Resultado):-
	autores_mais_novos(ListaAutores),
	autores_mais_novos_aux(Numero, ListaAutores, Resultado).

autores_mais_novos_aux(0, _, []).
autores_mais_novos_aux(_, [], _).
autores_mais_novos_aux(Numero, [_-Autor|Tail], [Autor|OutraTail]):-
	NovoNumero is Numero - 1,
	autores_mais_novos_aux(NovoNumero, Tail, OutraTail).

autores_mais_novos(Autores):-
  setof(NovoAno-autor(IdAutor, PrimeiroNome, UltimoNome, AnoNascimento, AnoMorte, Nacionalidade, Pseudonimos),
  	AnoNascimento^(autor(IdAutor, PrimeiroNome, UltimoNome, AnoNascimento, AnoMorte, Nacionalidade, Pseudonimos), NovoAno is -AnoNascimento),
 	Autores).

filtrar_autores(Selector, Lista):-
	findall(autor(IdAutor, PrimeiroNome, UltimoNome, AnoNascimento, AnoMorte, Nacionalidade, Pseudonimos),
	(
		autor(IdAutor, PrimeiroNome, UltimoNome, AnoNascimento, AnoMorte, Nacionalidade, Pseudonimos),
		filtrar_autores_aux(autor(IdAutor, PrimeiroNome, UltimoNome, AnoNascimento, AnoMorte, Nacionalidade, Pseudonimos), Selector)
	), Lista).

filtrar_autores_aux(_, []).

% selecciona autores com determinada nacionalidade
filtrar_autores_aux(autor(IdAutor, PrimeiroNome, UltimoNome, AnoNascimento, AnoMorte, Nacionalidade, Pseudonimos), [nacionalidade=Nacionalidade|Tail]):-
	filtrar_autores_aux(autor(IdAutor, PrimeiroNome, UltimoNome, AnoNascimento, AnoMorte, Nacionalidade, Pseudonimos), Tail).

% selecciona autores com uma das nacionalidades de várias
filtrar_autores_aux(autor(IdAutor, PrimeiroNome, UltimoNome, AnoNascimento, AnoMorte, Nacionalidade, Pseudonimos), [nacionalidade=Nacionalidade1 ou Nacionalidades|Tail]):-
	verificar_nacionalidade(Nacionalidade, Nacionalidade1 ou Nacionalidades),
	filtrar_autores_aux(autor(IdAutor, PrimeiroNome, UltimoNome, AnoNascimento, AnoMorte, Nacionalidade, Pseudonimos), Tail).

% selecciona autores que não são de determinada nacionalidade
filtrar_autores_aux(autor(IdAutor, PrimeiroNome, UltimoNome, AnoNascimento, AnoMorte, Nacionalidade, Pseudonimos), [nacionalidade\=Nacionalidade1|Tail]):-
	Nacionalidade \= Nacionalidade1,
	filtrar_autores_aux(autor(IdAutor, PrimeiroNome, UltimoNome, AnoNascimento, AnoMorte, Nacionalidade, Pseudonimos), Tail).

% selecciona autores que falam determinado idioma
filtrar_autores_aux(autor(IdAutor, PrimeiroNome, UltimoNome, AnoNascimento, AnoMorte, Nacionalidade, Pseudonimos), [idioma=Idioma|Tail]):-
	pais(Nacionalidade, _, Idioma, _, _),
	filtrar_autores_aux(autor(IdAutor, PrimeiroNome, UltimoNome, AnoNascimento, AnoMorte, Nacionalidade, Pseudonimos), Tail).

% selecciona autores que falam determinado idioma de vários
filtrar_autores_aux(autor(IdAutor, PrimeiroNome, UltimoNome, AnoNascimento, AnoMorte, Nacionalidade, Pseudonimos), [idioma=Idioma ou Idiomas|Tail]):-
	verificar_idioma(Nacionalidade, Idioma ou Idiomas),
	filtrar_autores_aux(autor(IdAutor, PrimeiroNome, UltimoNome, AnoNascimento, AnoMorte, Nacionalidade, Pseudonimos), Tail).

% selecciona autores que não falam determinado idioma
filtrar_autores_aux(autor(IdAutor, PrimeiroNome, UltimoNome, AnoNascimento, AnoMorte, Nacionalidade, Pseudonimos), [idioma\=Idioma|Tail]):-
	pais(Nacionalidade, _, Idioma1, _, _),
	Idioma1 \= Idioma,
	filtrar_autores_aux(autor(IdAutor, PrimeiroNome, UltimoNome, AnoNascimento, AnoMorte, Nacionalidade, Pseudonimos), Tail).

% selecciona autores com exatamente Count psuedónimos
filtrar_autores_aux(autor(IdAutor, PrimeiroNome, UltimoNome, AnoNascimento, AnoMorte, Nacionalidade, Pseudonimos), [pseudonimos=Count|Tail]):-
	length(Pseudonimos, Count),
	filtrar_autores_aux(autor(IdAutor, PrimeiroNome, UltimoNome, AnoNascimento, AnoMorte, Nacionalidade, Pseudonimos), Tail).

% selecciona autores com pelo menos Count psuedónimos
filtrar_autores_aux(autor(IdAutor, PrimeiroNome, UltimoNome, AnoNascimento, AnoMorte, Nacionalidade, Pseudonimos), [pseudonimos>Count|Tail]):-
	length(Pseudonimos, PseudonimosCount),
	PseudonimosCount >= Count,
	filtrar_autores_aux(autor(IdAutor, PrimeiroNome, UltimoNome, AnoNascimento, AnoMorte, Nacionalidade, Pseudonimos), Tail).

% selecciona autores que nasceram antes de AnoLimite
filtrar_autores_aux(autor(IdAutor, PrimeiroNome, UltimoNome, AnoNascimento, AnoMorte, Nacionalidade, Pseudonimos), [nasceu<AnoLimite|Tail]):-
	AnoNascimento < AnoLimite,
	filtrar_autores_aux(autor(IdAutor, PrimeiroNome, UltimoNome, AnoNascimento, AnoMorte, Nacionalidade, Pseudonimos), Tail).

% selecciona autores que nasceram depois de AnoLimite
filtrar_autores_aux(autor(IdAutor, PrimeiroNome, UltimoNome, AnoNascimento, AnoMorte, Nacionalidade, Pseudonimos), [nasceu>AnoLimite|Tail]):-
	AnoNascimento > AnoLimite,
	filtrar_autores_aux(autor(IdAutor, PrimeiroNome, UltimoNome, AnoNascimento, AnoMorte, Nacionalidade, Pseudonimos), Tail).

% selecciona autores que nasceram exatamente no ano AnoLimite
filtrar_autores_aux(autor(IdAutor, PrimeiroNome, UltimoNome, AnoNascimento, AnoMorte, Nacionalidade, Pseudonimos), [nasceu=AnoLimite|Tail]):-
	AnoNascimento = AnoLimite,
	filtrar_autores_aux(autor(IdAutor, PrimeiroNome, UltimoNome, AnoNascimento, AnoMorte, Nacionalidade, Pseudonimos), Tail).

% selecciona autores que nasceram entre [LimiteInferior, LimiteSuperior]
filtrar_autores_aux(autor(IdAutor, PrimeiroNome, UltimoNome, AnoNascimento, AnoMorte, Nacionalidade, Pseudonimos), [nasceu=LimiteInferior-LimiteSuperior|Tail]):-
	AnoNascimento >= LimiteInferior,
	AnoNascimento =< LimiteSuperior,
	filtrar_autores_aux(autor(IdAutor, PrimeiroNome, UltimoNome, AnoNascimento, AnoMorte, Nacionalidade, Pseudonimos), Tail).

% selecciona autores que estiveram vivos antes de AnoLimite
filtrar_autores_aux(autor(IdAutor, PrimeiroNome, UltimoNome, AnoNascimento, AnoMorte, Nacionalidade, Pseudonimos), [viveu<AnoLimite|Tail]):-
	AnoMorte < AnoLimite,
	filtrar_autores_aux(autor(IdAutor, PrimeiroNome, UltimoNome, AnoNascimento, AnoMorte, Nacionalidade, Pseudonimos), Tail).

% selecciona autores que estavam vivos depois de AnoLimite
filtrar_autores_aux(autor(IdAutor, PrimeiroNome, UltimoNome, AnoNascimento, AnoMorte, Nacionalidade, Pseudonimos), [viveu>AnoLimite|Tail]):-
	AnoMorte > AnoLimite,
	filtrar_autores_aux(autor(IdAutor, PrimeiroNome, UltimoNome, AnoNascimento, AnoMorte, Nacionalidade, Pseudonimos), Tail).

% selecciona autores que estavam vivos no ano AnoLimite
filtrar_autores_aux(autor(IdAutor, PrimeiroNome, UltimoNome, AnoNascimento, AnoMorte, Nacionalidade, Pseudonimos), [viveu=AnoLimite|Tail]):-
	AnoMorte >= AnoLimite,
	AnoNascimento =< AnoLimite,
	filtrar_autores_aux(autor(IdAutor, PrimeiroNome, UltimoNome, AnoNascimento, AnoMorte, Nacionalidade, Pseudonimos), Tail).

% selecciona autores que viveram no intervalo de tempo compreendido entre [LimiteInferior, LimiteSuperior]
filtrar_autores_aux(autor(IdAutor, PrimeiroNome, UltimoNome, AnoNascimento, AnoMorte, Nacionalidade, Pseudonimos), [viveu=LimiteInferior-LimiteSuperior|Tail]):-
	(AnoMorte < AnoNascimento ; LimiteInferior < AnoMorte),
	AnoNascimento < LimiteSuperior,
	filtrar_autores_aux(autor(IdAutor, PrimeiroNome, UltimoNome, AnoNascimento, AnoMorte, Nacionalidade, Pseudonimos), Tail).

%-----------------------------------------------------------------------------%
% -> Lista de autores com pelo menos N pseudónimos                            %
%-----------------------------------------------------------------------------%	
autores_minimo_pseudonimos(Number, Lista):-
	filtrar_autores([pseudonimos>Number], Lista).

%-----------------------------------------------------------------------------%
% -> Lista de autores com exatamente N pseudónimos                            %
%-----------------------------------------------------------------------------%	
autores_n_pseudonimos(Number, Lista):-
	filtrar_autores([pseudonimos=Number], Lista).

%-----------------------------------------------------------------------------%
% -> Lista de autores com pseudónimos                                         %
%-----------------------------------------------------------------------------%	
autores_com_pseudonimos(Lista):-
	filtrar_autores([pseudonimos>0], Lista).

%-----------------------------------------------------------------------------%
% -> Lista de autores sem qualquer pseudónimo                                 %
%-----------------------------------------------------------------------------%	
autores_sem_pseudonimos(Lista):-
	filtrar_autores([pseudonimos=0], Lista).

%-----------------------------------------------------------------------------%
% -> Lista de autores nascidos entre [LimiteInferior, LimiteSuperior]         %
%-----------------------------------------------------------------------------%
autores_nascidos_entre(LimiteInferior, LimiteSuperior, Lista):-
	filtrar_autores([nasceu=LimiteInferior-LimiteSuperior], Lista).

%-----------------------------------------------------------------------------%
% -> Lista de autores que nasceram no século Seculo                           %
%-----------------------------------------------------------------------------%
autores_nascidos_seculo(Seculo, Lista):-
	LimiteSuperior is (Seculo * 100),
	LimiteInferior is LimiteSuperior - 99,
	filtrar_autores([nasceu=LimiteInferior-LimiteSuperior], Lista).

%-----------------------------------------------------------------------------%
% -> Lista de autores que viveram entre [LimiteInferior, LimiteSuperior]      %
%-----------------------------------------------------------------------------%
autores_vivos_entre(LimiteInferior, LimiteSuperior, Lista):-
	filtrar_autores([viveu=LimiteInferior-LimiteSuperior], Lista).

%-----------------------------------------------------------------------------%
% -> Lista de autores que viveram no século Seculo                            %
%-----------------------------------------------------------------------------%
autores_vivos_seculo(Seculo, Lista):-
	LimiteSuperior is (Seculo * 100),
	LimiteInferior is LimiteSuperior - 99,
	filtrar_autores([viveu=LimiteInferior-LimiteSuperior], Lista).

verificar_nacionalidade(Nacionalidade, Nacionalidade ou _).
verificar_nacionalidade(Nacionalidade, _ ou Nacionalidades):-
	verificar_nacionalidade(Nacionalidade, Nacionalidades).
verificar_nacionalidade(Nacionalidade, Nacionalidade).

verificar_idioma(Nacionalidade, Idioma ou _):-
	pais(Nacionalidade, _, Idioma, _, _).
verificar_idioma(Nacionalidade, _ ou Idiomas):-
	verificar_idioma(Nacionalidade, Idiomas).
verificar_idioma(Nacionalidade, Idioma):-
	pais(Nacionalidade, _, Idioma, _, _).

%-----------------------------------------------------------------------------%
% -> Lista de autores de determinada(s) nacionalidade(s)                      %
%-----------------------------------------------------------------------------%
autores_nacionalidade(Nacionalidade ou Nacionalidades, Lista):-
	filtrar_autores([nacionalidade=Nacionalidade ou Nacionalidades], Lista).
autores_nacionalidade(Nacionalidade, Lista):-
	filtrar_autores([nacionalidade=Nacionalidade], Lista).

%-----------------------------------------------------------------------------%
% -> Lista de autores de determinado(s) continente(s)                         %
%-----------------------------------------------------------------------------%	
autores_continente(ListaContinentes, Filtros, Lista):-
	findall(autor(IdAutor, PrimeiroNome, UltimoNome, AnoNascimento, AnoMorte, Nacionalidade, Pseudonimos),
	(
		autor(IdAutor, PrimeiroNome, UltimoNome, AnoNascimento, AnoMorte, Nacionalidade, Pseudonimos), 
		pais_continente(Nacionalidade, Continente),
		member(Continente, ListaContinentes),
		filtrar_autores_aux(autor(IdAutor, PrimeiroNome, UltimoNome, AnoNascimento, AnoMorte, Nacionalidade, Pseudonimos), Filtros)
	), Lista).

%-----------------------------------------------------------------------------%
% -> Lista de autores que falam determinado(s) idioma(s)                      %
%-----------------------------------------------------------------------------%	
autores_idioma(Idioma ou Idiomas, Lista):-
	filtrar_autores([idioma=Idioma ou Idiomas], Lista).
autores_idioma(Idioma, Lista):-
	filtrar_autores([idioma=Idioma], Lista).

%-----------------------------------------------------------------------------%
% -> Verificar se Autor1 é mais velho que Autor2                              %
%-----------------------------------------------------------------------------%
comparar_autores_velho(Autor1, Autor2, Autor):-
	Autor1 \= Autor2, !,
	autor(Autor1, PrimeiroNome1, UltimoNome1, AnoNascimento1, AnoMorte1, Nacionalidade1, Pseudonimos1),
	autor(Autor2, PrimeiroNome2, UltimoNome2, AnoNascimento2, AnoMorte2, Nacionalidade2, Pseudonimos2),
	(
		AnoNascimento1 > AnoNascimento2, 
		Autor = autor(Autor1, PrimeiroNome1, UltimoNome1, AnoNascimento1, AnoMorte1, Nacionalidade1, Pseudonimos1)
		;
		(
			AnoNascimento1 < AnoNascimento2, 
			Autor = autor(Autor2, PrimeiroNome2, UltimoNome2, AnoNascimento2, AnoMorte2, Nacionalidade2, Pseudonimos2)
			;
			Autor = null
		)
	).

%-----------------------------------------------------------------------------%
% -> Verificar se Autor1 é mais novo que Autor2                               %
%-----------------------------------------------------------------------------%
comparar_autores_novo(Autor1, Autor2, Autor):-
	comparar_autores_velho(Autor2, Autor1, Autor).

%-----------------------------------------------------------------------------%
% -> Verificar se dois autores Autor1, Autor2 nasceram no mesmo ano           %
%-----------------------------------------------------------------------------%
autores_mesma_idade(Autor1, Autor2):-
	Autor1 \= Autor2, !,
	autor(Autor1, _, _, AnoNascimento, _, _, _),
	autor(Autor2, _, _, AnoNascimento, _, _, _).

%-----------------------------------------------------------------------------%
% -> Verificar se dois autores Autor1, Autor2 nasceram em anos diferentes     %
%-----------------------------------------------------------------------------%
autores_anos_diferentes(Autor1, Autor2):-
	\+autores_mesma_idade(Autor1, Autor2).

%-----------------------------------------------------------------------------%
% -> Verificar se dois autores Autor1, Autor2 nasceram no mesmo século        %
%-----------------------------------------------------------------------------%
autores_mesmo_seculo(Autor1, Autor2):-
	Autor1 \= Autor2, !,
	autor(Autor1, _, _, AnoNascimento1, _, _, _),
	Seculo1 is (AnoNascimento1 + 99) div 100,
	autor(Autor2, _, _, AnoNascimento2, _, _, _),
	Seculo2 is (AnoNascimento2 + 99) div 100,
	Seculo1 = Seculo2.

%-----------------------------------------------------------------------------%
% -> Verificar se dois autores Autor1, Autor2 nasceram em séculos diferentes  %
%-----------------------------------------------------------------------------%
autores_seculos_diferentes(Autor1, Autor2):-
	\+autores_mesmo_seculo(Autor1, Autor2).

%-----------------------------------------------------------------------------%
% -> Verificar se dois autores Autor1, Autor2 têm a mesma nacionalidade       %
%-----------------------------------------------------------------------------%
autores_mesma_nacionalidade(Autor1, Autor2):-
	Autor1 \= Autor2, !,
	autor(Autor1, _, _, _, _, Nacionalidade, _),
	autor(Autor2, _, _, _, _, Nacionalidade, _).

%-----------------------------------------------------------------------------%
% -> Verificar se dois autores Autor1, Autor2 têm nacionalidades diferentes   %
%-----------------------------------------------------------------------------%
autores_nacionalidades_diferentes(Autor1, Autor2):-
	\+autores_mesma_nacionalidade(Autor1, Autor2).

%-----------------------------------------------------------------------------%
% -> Verificar se dois autores Autor1, Autor2 são do mesmo continente         %
%-----------------------------------------------------------------------------%
autores_mesmo_continente(Autor1, Autor2):-
	Autor1 \= Autor2, !,
	autor(Autor1, _, _, _, _, Nacionalidade1, _),
	autor(Autor2, _, _, _, _, Nacionalidade2, _),
	pais_continente(Nacionalidade1, Continente),
	pais_continente(Nacionalidade2, Continente).

%-----------------------------------------------------------------------------%
% -> Verificar se dois autores Autor1, Autor2 são de continentes diferentes   %
%-----------------------------------------------------------------------------%
autores_continentes_diferentes(Autor1, Autor2):-
	\+autores_mesmo_continente(Autor1, Autor2).

%-----------------------------------------------------------------------------%
% -> Verificar se determinado Psuedónimo pertence a determinado Autor         %
%-----------------------------------------------------------------------------%
verificar_psuedonimo(Pseudonimo, Autor):-
	autor(Autor, _, _, _, _, _, Pseudonimos),
	member(Pseudonimo, Pseudonimos).

%-----------------------------------------------------------------------------%
% -> Verificar se dois livros Livro1, Livro2 foram publicados no mesmo ano    %
%-----------------------------------------------------------------------------%
livros_mesmo_ano(Livro1, Livro2):-
	Livro1 \= Livro2,
	livro(Livro1, _, _, Ano, _, _),
	livro(Livro2, _, _, Ano, _, _).

%--------------------------------------------------------------------------------%
% -> Verificar se dois livros Livro1, Livro2 foram publicados em anos diferentes %
%--------------------------------------------------------------------------------%
livros_anos_diferentes(Livro1, Livro2):-
	\+livros_mesmo_ano(Livro1, Livro2).

%-----------------------------------------------------------------------------%
% -> Verificar se dois livros Livro1, Livro2 foram publicados no mesmo século %
%-----------------------------------------------------------------------------%
livros_mesmo_seculo(Livro1, Livro2):-
	livro(Livro1, _, _, Ano1, _, _),
	Seculo1 is (Ano1 + 99) div 100,
	livro(Livro2, _, _, Ano2, _, _),
	Seculo2 is (Ano2 + 99) div 100,
	Seculo1 = Seculo2.

%-----------------------------------------------------------------------------------%
% -> Verificar se dois livros Livro1, Livro2 foram publicados em séculos diferentes %
%-----------------------------------------------------------------------------------%
livros_seculos_diferentes(Livro1, Livro2):-
	\+livros_mesmo_seculo(Livro1, Livro2).
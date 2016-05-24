% consult(['~/Desktop/feup-iart-master/proj1/server/lexico.pl']).

numero_ordinal(s-m, 1) --> [primeiro].
numero_ordinal(s-f, 1) --> [primeira].
numero_ordinal(p-m, 1) --> [primeiros].
numero_ordinal(p-f, 1) --> [primeiras].

numero_ordinal(s-m, 2) --> [segundo].
numero_ordinal(s-f, 2) --> [segunda].
numero_ordinal(p-m, 2) --> [segundos].
numero_ordinal(p-f, 2) --> [segundas].

numero_ordinal(s-m, 3) --> [terceiro].
numero_ordinal(s-f, 3) --> [terceira].
numero_ordinal(p-m, 3) --> [terceiros].
numero_ordinal(p-f, 3) --> [terceiras].

numero_ordinal(s-m, -1) --> [ultimo].
numero_ordinal(s-f, -1) --> [ultima].
numero_ordinal(p-m, -1) --> [ultimos].
numero_ordinal(p-f, -1) --> [ultimas].

numero_ordinal(s-m, -2) --> [penultimo].
numero_ordinal(s-f, -2) --> [penultima].
numero_ordinal(p-m, -2) --> [penultimos].
numero_ordinal(p-f, -2) --> [penultimas].

%---------------------------------------------------------%
% Determinantes Artigos                                   %
%---------------------------------------------------------%

art_def(s-m) --> [o].
art_def(s-f) --> [a].
art_def(p-m) --> [os].
art_def(p-f) --> [as].

art_indef(s-m) --> [um].
art_indef(s-f) --> [uma].
art_indef(p-m) --> [uns].
art_indef(p-f) --> [umas].

%---------------------------------------------------------%
% Preposições                                             %
%---------------------------------------------------------%

preposicao(s-m) --> [ao].
% preposicao(s-f) --> [à].
preposicao(p-m) --> [aos].
% preposicao(p-f) --> [às].
preposicao(_-_) --> [de].
preposicao(s-m) --> [do].
preposicao(s-f) --> [da].
preposicao(p-m) --> [dos].
preposicao(p-f) --> [das].

%---------------------------------------------------------%
% Pronomes Pessoais                                       %
%---------------------------------------------------------%

pronome_pessoal(s-m) --> [seu].
pronome_pessoal(s-f) --> [sua].
pronome_pessoal(p-m) --> [seus].
pronome_pessoal(p-f) --> [suas].

%---------------------------------------------------------%
% Pronomes Interrogativos                                 %
%---------------------------------------------------------%

pron_int(s-_, ql) --> [quais].
pron_int(p-_, ql) --> [quais].
pron_int(_-_, ql) --> [que].
pron_int(_-_, ql) --> [quem].
pron_int(_-_, ql) --> [quando].
pron_int(p-m, qn) --> [quantos].
pron_int(p-f, qn) --> [quantas].

pron_rel(_-_) --> [que].

adjetivo(s-_, recente) --> [recente].
adjetivo(p-_, recente) --> [recentes].

adjetivo(s-m, antigo) --> [antigo].
adjetivo(s-f, antigo) --> [antiga].
adjetivo(p-m, antigo) --> [antigos].
adjetivo(p-f, antigo) --> [antigas].

adjetivo_super(mais) --> [mais].
adjetivo_super(menos) --> [menos].

adj_comp(mais,antigo, maisantigo).
adj_comp(_,Adj,Adj).

adverbio(inclusao) --> [ainda].
adverbio(inclusao) --> [ate].
adverbio(inclusao) --> [tambem].

adverbio(s-m, algum) --> [algum].
adverbio(s-f, algum) --> [alguma].
adverbio(p-m, algum) --> [alguns].
adverbio(p-f, algum) --> [algumas].

adverbio(s-m, muito) --> [muito].
adverbio(s-f, muito) --> [muita].
adverbio(p-m, muito) --> [muitos].
adverbio(p-f, muito) --> [muitas].

adverbio(s-m, pouco) --> [pouco].
adverbio(s-f, pouco) --> [pouca].
adverbio(p-m, pouco) --> [poucos].
adverbio(p-f, pouco) --> [poucas].

%---------------------------------------------------------%
% Substantivos: Autores                                   %
%---------------------------------------------------------%

subst(s-m, autor) --> [autor].
subst(s-f, autor) --> [autora].
subst(p-m, autor) --> [autores].
subst(p-f, autor) --> [autoras].

subst(s-m, autor) --> [escritor].
subst(s-f, autor) --> [escritora].
subst(p-m, autor) --> [escritores].
subst(p-f, autor) --> [escritoras].

%---------------------------------------------------------%
% Substantivos: Colecções                                 %
%---------------------------------------------------------%

subst(s-m, colecao) --> [colecao].
subst(p-m, colecao) --> [colecoes].
subst(s-f, colecao) --> [saga].
subst(p-f, colecao) --> [sagas].
subst(s-f, colecao) --> [trilogia].
subst(p-f, colecao) --> [trilogias].
subst(s-m, colecao) --> [volume].
subst(p-m, colecao) --> [volumes].

%---------------------------------------------------------%
% Substantivos: Pseudónimos                               %
%---------------------------------------------------------%

% subst(s-_, pseudonimo) --> [criptónimos].
% subst(p-_, pseudonimo) --> [criptónimoss].
% subst(s-_, pseudonimo) --> [heterónimo].
% subst(p-_, pseudonimo) --> [heterónimos].
% subst(s-_, pseudonimo) --> [ortónimo].
% subst(p-_, pseudonimo) --> [ortónimos].
% subst(s-_, pseudonimo) --> [pseudónimo].
% subst(p-_, pseudonimo) --> [pseudónimos].

subst(s-_, morte) --> [morte].
subst(s-_, morte) --> [falecimento].
subst(s-_, nascimento) --> [nascimento].

adverbio(s, antes) --> [antes].
adverbio(s, depois) --> [depois].
adverbio(s, anterior) --> [anterior].
adverbio(p, anterior) --> [anteriores].
adverbio(s, posterior) --> [posterior].
adverbio(p, posterior) --> [posteriores].
% adverbio(s, posterior) --> [após].

subst(s-m, ano) --> [ano].
subst(p-m, ano) --> [anos].

subst(s-m, seculo) --> [seculo].
subst(p-m, seculo) --> [seculos].

subst(s-m, idioma) --> [idioma].
subst(p-m, idioma) --> [idiomas].
subst(s-f, idioma) --> [lingua].
subst(p-f, idioma) --> [linguas].

subst(s-f, nacionalidade) --> [nacionalidade].
subst(p-f, nacionalidade) --> [nacionalidades].

subst(s-f, idade) --> [idade].
substantivo(p-f, idade) --> [idades].

%---------------------------------------------------------%
% Substantivos: Géneros                                   %
%---------------------------------------------------------%

subst_gen(_,s-m) --> [livro].
subst_gen(_,p-m) --> [livros].

subst_gen(_,s-f) --> [obra].
subst_gen(_,p-f) --> [obras].

subst_gen(comedia, s-f) --> [comedia].
subst_gen(comedia, p-f) --> [comedias].

subst_gen(cronica, s-f) --> [cronica].
subst_gen(cronica, p-f) --> [cronicas].

subst_gen(conto, s-m) --> [conto].
subst_gen(conto, p-m) --> [contos].

subst_gen(drama, s-m) --> [drama].
subst_gen(drama, p-m) --> [dramas].

subst_gen(manga, s-m) --> [manga].
subst_gen(manga, p-m) --> [mangas].

subst_gen(poesia, s-f) --> [poesia].
subst_gen(poesia, p-f) --> [poesias].

subst_gen(prosa, s-f) --> [prosa].
subst_gen(prosa, p-f) --> [prosa].

subst_gen(romance, s-m) --> [romance].
subst_gen(romance, p-m) --> [romances].

subst_gen(teatro, s-m) --> [teatro].
subst_gen(teatro, p-m) --> [teatros].

subst_gen(tragedia, s-f) --> [tragedia].
subst_gen(tragedia, p-f) --> [tragedias].

%---------------------------------------------------------%
% Substantivos: Nacionalidades                            %
%---------------------------------------------------------%

subst_nac(ger, s-m) --> [alemao].
subst_nac(ger, s-f) --> [alema].
subst_nac(ger, p-m) --> [alemaes].
subst_nac(ger, p-f) --> [alemas].

subst_nac(chi, s-m) --> [chileno].
subst_nac(chi, s-f) --> [chilena].
subst_nac(chi, p-m) --> [chilenos].
subst_nac(chi, p-f) --> [chilenas].

subst_nac(col, s-m) --> [colombiano].
subst_nac(col, s-f) --> [colombiana].
subst_nac(col, p-m) --> [colombianos].
subst_nac(col, p-f) --> [colombianas].

subst_nac(esp, s-m) --> [espanhol].
subst_nac(esp, s-f) --> [espanhola].
subst_nac(esp, p-m) --> [espanhois].
subst_nac(esp, p-f) --> [espanholas].

subst_nac(fra, s-m) --> [frances].
subst_nac(fra, s-f) --> [francesa].
subst_nac(fra, p-m) --> [franceses].
subst_nac(fra, p-f) --> [francesas].

subst_nac(gbr, s-m) --> [ingles].
subst_nac(gbr, s-f) --> [inglesa].
subst_nac(gbr, p-m) --> [ingleses].
subst_nac(gbr, p-f) --> [inglesas].

subst_nac(ind, s-m) --> [indiano].
subst_nac(ind, s-f) --> [indiana].
subst_nac(ind, p-m) --> [indianos].
subst_nac(ind, p-f) --> [indianas].

subst_nac(ire, s-m) --> [irlandes].
subst_nac(ire, s-f) --> [irlandesa].
subst_nac(ire, p-m) --> [irlandeses].
subst_nac(ire, p-f) --> [irlandesas].

subst_nac(jpn, s-m) --> [japones].
subst_nac(jpn, s-f) --> [japonesa].
subst_nac(jpn, p-m) --> [japoneses].
subst_nac(jpn, p-f) --> [japonesas].

subst_nac(moz, s-m) --> [mocambicano].
subst_nac(moz, s-f) --> [mocambicana].
subst_nac(moz, p-m) --> [mocambicanos].
subst_nac(moz, p-f) --> [mocambicanas].

subst_nac(por, s-m) --> [portugues].
subst_nac(por, s-f) --> [portuguesa].
subst_nac(por, p-m) --> [portugueses].
subst_nac(por, p-f) --> [portuguesas].

subst_nac(rus, s-m) --> [russo].
subst_nac(rus, s-f) --> [russa].
subst_nac(rus, p-m) --> [russos].
subst_nac(rus, p-f) --> [russas].

subst_nac(usa, s-m) --> [americano].
subst_nac(usa, s-f) --> [americana].
subst_nac(usa, p-m) --> [americanos].
subst_nac(usa, p-f) --> [americanas].

%---------------------------------------------------------%
% Substantivos: Idiomas                                   %
%---------------------------------------------------------%

substantivo_idioma(alemao, s-m) --> [alemao].
substantivo_idioma(alemao, s-f) --> [alema].

substantivo_idioma(espanhol, s-m) --> [espahol].
substantivo_idioma(espanhol, s-f) --> [espanhola].

substantivo_idioma(frances, s-m) --> [frances].
substantivo_idioma(frances, s-f) --> [francesa].

substantivo_idioma(ingles, s-m) --> [ingles].
substantivo_idioma(ingles, s-f) --> [inglesa].

substantivo_idioma(japones, s-m) --> [japones].
substantivo_idioma(japones, s-f) --> [japonesa].

substantivo_idioma(russo, s-m) --> [russo].
substantivo_idioma(russo, s-f) --> [russa].

%---------------------------------------------------------%
% Substantivos: Continentes                               %
%---------------------------------------------------------%

subst_cont(s-m, africa) --> [africano].
subst_cont(s-f, africa) --> [africana].
subst_cont(p-m, africa) --> [africanos].
subst_cont(p-f, africa) --> [africanas].

subst_cont(s-m, asia) --> [asiatico].
subst_cont(s-f, asia) --> [asiatica].
subst_cont(p-m, asia) --> [asiaticos].
subst_cont(p-f, asia) --> [asiaticas].

subst_cont(s-m, europa) --> [europeu].
subst_cont(s-f, europa) --> [europeia].
subst_cont(p-m, europa) --> [europeus].
subst_cont(p-f, europa) --> [europeias].

subst_cont(s-m, america_norte) --> [norte-americano].
subst_cont(s-f, america_norte) --> [norte-americana].
subst_cont(p-m, america_norte) --> [norte-americanos].
subst_cont(p-f, america_norte) --> [norte-americanas].

subst_cont(s-m, america_sul) --> [sul-americano].
subst_cont(s-f, america_sul) --> [sul-americana].
subst_cont(p-m, america_sul) --> [sul-americanos].
subst_cont(p-f, america_sul) --> [sul-americanas].

%---------------------------------------------------------%
% Verbos: Presente                                        %
%---------------------------------------------------------%

% verbo(s, ser, presente) --> [é].
% verbo(p, ser, presente) --> [são].

verbo(s, encontrar, presente) --> [encontra].
verbo(p, encontrar, presente) --> [encontram].

verbo(s, estar, presente) --> [esta].
verbo(p, estar, presente) --> [estao].

verbo(s, existir, presente) --> [existe].
verbo(p, existir, presente) --> [existem].

%---------------------------------------------------------%
% Verbos: Pretérito Perfeito / Pretérito Imperfeito       %
%---------------------------------------------------------%

verbo(p, ser, passado) --> [era].
verbo(s, ser, passado) --> [eram].
verbo(p, ser, passado) --> [foi].
verbo(s, ser, passado) --> [foram].

verbo(s, estar, passado) --> [estava].
verbo(p, estar, passado) --> [estavam].
verbo(s, estar, passado) --> [esteve].
verbo(p, estar, passado) --> [estiveram].

verbo(s, encontrar, passado) --> [encontrava].
verbo(p, encontrar, passado) --> [encontravam].

verbo(s, existir, passado) --> [existia].
verbo(s, existir, passado) --> [existiu].
verbo(p, existir, passado) --> [existiam].
verbo(p, existir, passado) --> [existiram].

verbo(s, escrever, passado) --> [escreveu].
verbo(p, escrever, passado) --> [escreveram].
verbo(s, escrever, passado) --> [publicou].
verbo(p, escrever, passado) --> [publicaram].
verbo(s, escrever, passado) --> [redigiu].
verbo(p, escrever, passado) --> [redigiram].

verbo(s, morrer, passado) --> [morreu].
verbo(p, morrer, passado) --> [morreram].
verbo(s, morrer, passado) --> [faleceu].
verbo(p, morrer, passado) --> [faleceram].

verbo(s, nascer, passado) --> [nasceu].
verbo(s, nascer, passado) --> [nascia].
verbo(p, nascer, passado) --> [nasceram].
verbo(p, nascer, passado) --> [nasciam].

%---------------------------------------------------------%
% Verbos: Particípio Passado                              %
%---------------------------------------------------------%

verbo_passiva(s-m, escrever) --> [escrito].
verbo_passiva(s-f, escrever) --> [escrita].
verbo_passiva(p-m, escrever) --> [escritos].
verbo_passiva(p-f, escrever) --> [escritas].

verbo_passiva(s-m, escrever) --> [publicado].
verbo_passiva(s-f, escrever) --> [publicada].
verbo_passiva(p-m, escrever) --> [publicados].
verbo_passiva(s-f, escrever) --> [publicadas].

verbo_passiva(s-m, escrever) --> [redigido].
verbo_passiva(s-f, escrever) --> [redigida].
verbo_passiva(p-m, escrever) --> [redigidos].
verbo_passiva(p-f, escrever) --> [redigidas].

verbo_passiva(s-m, nascer) --> [nascido].
verbo_passiva(s-f, nascer) --> [nascida].
verbo_passiva(p-m, nascer) --> [nascidos].
verbo_passiva(p-f, nascer) --> [nascidas].

verbo_passiva(s-m, morrer) --> [falecido].
verbo_passiva(s-f, morrer) --> [falecida].
verbo_passiva(p-m, morrer) --> [falecidos].
verbo_passiva(p-f, morrer) --> [falecidas].

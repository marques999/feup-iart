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

artigo_definido(s-m) --> [o].
artigo_definido(s-f) --> [a].
artigo_definido(p-m) --> [os].
artigo_definido(p-f) --> [as].

artigo_indefinido(s-m) --> [um].
artigo_indefinido(s-f) --> [uma].
artigo_indefinido(p-m) --> [uns].
artigo_indefinido(p-f) --> [umas].

%---------------------------------------------------------%
% Preposições                                             %
%---------------------------------------------------------%

preposicao(s-m) --> [ao].
preposicao(s-f) --> [à].
preposicao(p-m) --> [aos].
preposicao(p-f) --> [às].

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

pronome_interrogativo(_-_, qualitativo) --> [que].
pronome_interrogativo(_-_, qualitativo) --> [quem].
pronome_interrogativo(_-_, qualitativo) --> [quando].
pronome_interrogativo(s-_, qualitativo) --> [quais].
pronome_interrogativo(p-_, qualitativo) --> [quais].
pronome_interrogativo(p-m, quantitativo) --> [quantos].
pronome_interrogativo(p-f, quantitativo) --> [quantas].

pronome_relativo(_-_) --> [que].

adjetivo(s-_, recente) --> [recente].
adjetivo(p-_, recente) --> [recentes].

adjetivo(s-m, antigo) --> [antigo].
adjetivo(s-f, antigo) --> [antiga].
adjetivo(p-m, antigo) --> [antigos].
adjetivo(p-f, antigo) --> [antigas].

adjetivo(_) -> [mais].
adjetivo(_) -> [menos].

adverbio(inclusao) -> [ainda];
adverbio(inclusao) -> [ate];
adverbio(inclusao) -> [tambem];

adverbio(s-m, algum) -> [algum];
adverbio(s-f, algum) -> [alguma];
adverbio(p-m, algum) -> [alguns];
adverbio(p-f, algum) -> [algumas];

adverbio(s-m, muito) -> [muito];
adverbio(s-f, muito) -> [muita];
adverbio(p-m, muito) -> [muitos];
adverbio(p-f, muito) -> [muitas];

adverbio(s-m, pouco) -> [pouco];
adverbio(s-f, pouco) -> [pouca];
adverbio(p-m, pouco) -> [poucos];
adverbio(p-f, pouco) -> [poucas];

%---------------------------------------------------------%
% Substantivos: Autores                                   %
%---------------------------------------------------------%

substantivo(s-m, autor) --> [autor].
substantivo(s-f, autor) --> [autora].
substantivo(p-m, autor) --> [autores].
substantivo(p-f, autor) --> [autoras].

substantivo(s-m, autor) --> [escritor].
substantivo(s-f, autor) --> [escritora].
substantivo(p-m, autor) --> [escritores].
substantivo(p-f, autor) --> [escritoras].

%---------------------------------------------------------%
% Substantivos: Colecções                                 %
%---------------------------------------------------------%

substantivo(s-m, colecao) --> [colecao].
substantivo(p-m, colecao) --> [colecoes].
substantivo(s-f, colecao) --> [saga].
substantivo(p-f, colecao) --> [sagas].
substantivo(s-f, colecao) --> [trilogia].
substantivo(p-f, colecao) --> [trilogias].
substantivo(s-m, colecao) --> [volume].
substantivo(p-m, colecao) --> [volumes].

%---------------------------------------------------------%
% Substantivos: Pseudónimos                               %
%---------------------------------------------------------%

substantivo(s-_, pseudonimo) --> [criptónimos].
substantivo(p-_, pseudonimo) --> [criptónimoss].
substantivo(s-_, pseudonimo) --> [heterónimo].
substantivo(p-_, pseudonimo) --> [heterónimos].
substantivo(s-_, pseudonimo) --> [ortónimo].
substantivo(p-_, pseudonimo) --> [ortónimos].
substantivo(s-_, pseudonimo) --> [pseudónimo].
substantivo(p-_, pseudonimo) --> [pseudónimos].

substantivo(s-_, morte) --> [morte].
substantivo(s-_, morte) --> [falecimento].
substantivo(s-_, nascimento) --> [nascimento].

adverbio(s, antes) -> [antes];
adverbio(s, depois) -> [depois];

adverbio(s, anterior) -> [anterior];
adverbio(p, anterior) -> [anteriores];

adverbio(s, posterior) -> [posterior];
adverbio(p, posterior) -> [posteriores];
adverbio(s, posterior) -> [após];

substantivo(s-m, ano) --> [ano];
substantivo(p-m, ano) --> [anos];

substantivo(s-m, seculo) --> [seculo];
substantivo(p-m, seculo) --> [seculos];

substantivo(s-m, idioma) --> [idioma];
substantivo(p-m, idioma) --> [idiomas];
substantivo(s-f, idioma) --> [lingua];
substantivo(p-f, idioma) --> [linguas];

substantivo(s-f, nacionalidade) --> [nacionalidade];
substantivo(p-f, nacionalidade) --> [nacionalidades];

substantivo(s-f, idade) --> [idade];
substantivo(p-f, idade) --> [idades];

%---------------------------------------------------------%
% Substantivos: Géneros                                   %
%---------------------------------------------------------%

substantivo_genero(s-m, _) --> [livro].
substantivo_genero(p-m, _) --> [livros].

substantivo_genero(s-f, _) --> [obra].
substantivo_genero(p-f, _) --> [obras].

substantivo_genero(comedia, s-f) --> [comedia].
substantivo_genero(comedia, p-f) --> [comedias].

substantivo_genero(cronica, s-f) --> [cronica].
substantivo_genero(cronica, p-f) --> [cronicas].

substantivo_genero(conto, s-m) --> [conto].
substantivo_genero(conto, p-m) --> [contos].

substantivo_genero(drama, s-m) --> [drama].
substantivo_genero(drama, p-m) --> [dramas].

substantivo_genero(manga, s-m) --> [manga].
substantivo_genero(manga, p-m) --> [mangas].

substantivo_genero(poesia, s-f) --> [poesia].
substantivo_genero(poesia, p-f) --> [poesias].

substantivo_genero(prosa, s-f) --> [prosa].
substantivo_genero(prosa, p-f) --> [prosa].

substantivo_genero(romance, s-m) --> [romance].
substantivo_genero(romance, p-m) --> [romances].

substantivo_genero(teatro, s-m) --> [teatro].
substantivo_genero(teatro, p-m) --> [teatros].

substantivo_genero(tragedia, s-f) --> [tragedia].
substantivo_genero(tragedia, p-f) --> [tragedias].

%---------------------------------------------------------%
% Substantivos: Nacionalidades                            %
%---------------------------------------------------------%

substantivo_nacionalidade(ger, s-m) --> [alemao].
substantivo_nacionalidade(ger, s-f) --> [alema].
substantivo_nacionalidade(ger, p-m) --> [alemaes].
substantivo_nacionalidade(ger, p-f) --> [alemas].

substantivo_nacionalidade(chi, s-m) --> [chileno].
substantivo_nacionalidade(chi, s-f) --> [chilena].
substantivo_nacionalidade(chi, p-m) --> [chilenos].
substantivo_nacionalidade(chi, p-f) --> [chilenas].

substantivo_nacionalidade(col, s-m) --> [colombiano].
substantivo_nacionalidade(col, s-f) --> [colombiana].
substantivo_nacionalidade(col, p-m) --> [colombianos].
substantivo_nacionalidade(col, p-f) --> [colombianas].

substantivo_nacionalidade(esp, s-m) --> [espanhol].
substantivo_nacionalidade(esp, s-f) --> [espanhola].
substantivo_nacionalidade(esp, p-m) --> [espanhois].
substantivo_nacionalidade(esp, p-f) --> [espanholas].

substantivo_nacionalidade(fra, s-m) --> [frances].
substantivo_nacionalidade(fra, s-f) --> [francesa].
substantivo_nacionalidade(fra, p-m) --> [franceses].
substantivo_nacionalidade(fra, p-f) --> [francesas].

substantivo_nacionalidade(gbr, s-m) --> [ingles].
substantivo_nacionalidade(gbr, s-f) --> [inglesa].
substantivo_nacionalidade(gbr, p-m) --> [ingleses].
substantivo_nacionalidade(gbr, p-f) --> [inglesas].

substantivo_nacionalidade(ind, s-m) --> [indiano].
substantivo_nacionalidade(ind, s-f) --> [indiana].
substantivo_nacionalidade(ind, p-m) --> [indianos].
substantivo_nacionalidade(ind, p-f) --> [indianas].

substantivo_nacionalidade(ire, s-m) --> [irlandes].
substantivo_nacionalidade(ire, s-f) --> [irlandesa].
substantivo_nacionalidade(ire, p-m) --> [irlandeses].
substantivo_nacionalidade(ire, p-f) --> [irlandesas].

substantivo_nacionalidade(jpn, s-m) --> [japones].
substantivo_nacionalidade(jpn, s-f) --> [japonesa].
substantivo_nacionalidade(jpn, p-m) --> [japoneses].
substantivo_nacionalidade(jpn, p-f) --> [japonesas].

substantivo_nacionalidade(moz, s-m) --> [mocambicano].
substantivo_nacionalidade(moz, s-f) --> [mocambicana].
substantivo_nacionalidade(moz, p-m) --> [mocambicanos].
substantivo_nacionalidade(moz, p-f) --> [mocambicanas].

substantivo_nacionalidade(por, s-m) --> [portugues].
substantivo_nacionalidade(por, s-f) --> [portuguesa].
substantivo_nacionalidade(por, p-m) --> [portugueses].
substantivo_nacionalidade(por, p-f) --> [portuguesas].

substantivo_nacionalidade(rus, s-m) --> [russo].
substantivo_nacionalidade(rus, s-f) --> [russa].
substantivo_nacionalidade(rus, p-m) --> [russos].
substantivo_nacionalidade(rus, p-f) --> [russas].

substantivo_nacionalidade(usa, s-m) --> [americano].
substantivo_nacionalidade(usa, s-f) --> [americana].
substantivo_nacionalidade(usa, p-m) --> [americanos].
substantivo_nacionalidade(usa, p-f) --> [americanas].

%---------------------------------------------------------%
% Substantivos: Idiomas                                   %
%---------------------------------------------------------%

substantivo_idioma(alemao, s-m) --> [alemao].
substantivo_idioma(alemao, s-f) --> [alema]

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

substantivo_continente(s-m, africa) --> [africano].
substantivo_continente(s-f, africa) --> [africana].
substantivo_continente(p-m, africa) --> [africanos].
substantivo_continente(p-f, africa) --> [africanas].

substantivo_continente(s-m, asia) --> [asiatico].
substantivo_continente(s-f, asia) --> [asiatica].
substantivo_continente(p-m, asia) --> [asiaticos].
substantivo_continente(p-f, asia) --> [asiaticas].

substantivo_continente(s-m, europa) --> [europeu].
substantivo_continente(s-f, europa) --> [europeia].
substantivo_continente(p-m, europa) --> [europeus].
substantivo_continente(p-f, europa) --> [europeias].

substantivo_continente(s-m, america_norte) --> [norte-americano].
substantivo_continente(s-f, america_norte) --> [norte-americana].
substantivo_continente(p-m, america_norte) --> [norte-americanos].
substantivo_continente(p-f, america_norte) --> [norte-americanas].

substantivo_continente(s-m, america_sul) --> [sul-americano].
substantivo_continente(s-f, america_sul) --> [sul-americana].
substantivo_continente(p-m, america_sul) --> [sul-americanos].
substantivo_continente(p-f, america_sul) --> [sul-americanas].

%---------------------------------------------------------%
% Verbos: Presente                                        %
%---------------------------------------------------------%

verbo(s, ser, presente) --> [é].
verbo(p, ser, presente) --> [são].

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
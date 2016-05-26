% consult(['~/Desktop/feup-iart-master/proj1/server/lexico.pl']).

seculo('I', 1).
seculo('II', 2).
seculo('III', 3).
seculo('IV', 4).
seculo('V', 5).
seculo('VI', 6).
seculo('VII', 7).
seculo('VIII', 8).
seculo('IX', 9).
seculo('X', 10).
seculo('XI', 11).
seculo('XII', 12).
seculo('XIII', 13).
seculo('XIV', 14).
seculo('XV', 15).
seculo('XVI', 16).
seculo('XVII', 17).
seculo('XVIII', 18).
seculo('XIX', 19).
seculo('XX', 20).
seculo('XXI', 21).

seculo_lim('XXI', 2001, 2100).
seculo_lim('XX', 1901,2000).
seculo_lim('XIX', 1801, 1900).
seculo_lim('XVIII', 1701, 1800).
seculo_lim('XVII', 1601, 1700).
seculo_lim('XVI', 1501, 1600).
seculo_lim('XV', 1401, 1500).
seculo_lim('XIV', 1301, 1400).
seculo_lim('XIII', 1201, 1300).
seculo_lim('XII', 1101, 1200).
seculo_lim('XI', 1001, 1100).
seculo_lim('XX', 901, 1000).
seculo_lim('IX', 801, 900).
seculo_lim('VIII', 701, 800).
seculo_lim('VII', 601, 700).
seculo_lim('VI', 501, 600).
seculo_lim('V', 401, 500).
seculo_lim('IV', 301, 400).
seculo_lim('III', 201, 300).
seculo_lim('II', 101, 200).
seculo_lim('I', 1, 100).

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

adj_comp(mais, recente, maisrecente).
adj_comp(menos, recente, menosrecente).
adj_comp(mais,antigo, maisantigo).
adj_comp(menos,atigo, menosantigo).
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
% antivos: Autores                                   %
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

subst(s-_, pseudonimo) --> [criptonimos].
subst(p-_, pseudonimo) --> [criptonimoss].
subst(s-_, pseudonimo) --> [heteronimo].
subst(p-_, pseudonimo) --> [heteronimos].
subst(s-_, pseudonimo) --> [ortonimo].
subst(p-_, pseudonimo) --> [ortonimos].
subst(s-_, pseudonimo) --> [pseudonimo].
subst(p-_, pseudonimo) --> [pseudonimos].

subst(s-_, morte) --> [morte].
subst(s-_, morte) --> [falecimento].
subst(s-_, nascimento) --> [nascimento].

adverbio(antes) --> [antes].
adverbio(depois) --> [depois].

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
subst(p-f, idade) --> [idades].

%---------------------------------------------------------%
% Substantivos: Géneros                                   %
%---------------------------------------------------------%

subst_gen(livro,s-m) --> [livro].
subst_gen(livro,p-m) --> [livros].

subst_gen(obra,s-f) --> [obra].
subst_gen(obra,p-f) --> [obras].

subst_gen(comedia, s-f) --> [comedia].
subst_gen(comedia, p-f) --> [comedias].

subst_gen(cronica, s-f) --> [cronica].
subst_gen(cronica, p-f) --> [cronicas].

subst_gen(conto, s-m) --> [conto].
subst_gen(conto, p-m) --> [contos].

subst_gen(drama, s-m) --> [drama].
subst_gen(drama, p-m) --> [dramas].

subst_gen(ficcao-cientifica, s-m) --> [ficcao-cientifica].
subst_gen(ficcao-cientifica, p-m) --> [ficcoes-cientificas].

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

nac_to_cont(ger, europa).
nac_to_cont(chi, america_sul).
nac_to_cont(col, america_sul).
nac_to_cont(esp, espanha).
nac_to_cont(fra, europa).
nac_to_cont(gbr, europa).
nac_to_cont(ind, asia).
nac_to_cont(ire, europa).
nac_to_cont(jpn, asia).
nac_to_cont(moz, africa).
nac_to_cont(por, europa).
nac_to_cont(rus, europa).
nac_to_cont(usa, america_norte).

%---------------------------------------------------------%
% Substantivos: Idiomas                                   %
%---------------------------------------------------------%

subst_idi(alemao, s-m) --> [alemao].
subst_idi(alemao, s-f) --> [alema].

subst_idi(espanhol, s-m) --> [espahol].
subst_idi(espanhol, s-f) --> [espanhola].

subst_idi(frances, s-m) --> [frances].
subst_idi(frances, s-f) --> [francesa].

subst_idi(ingles, s-m) --> [ingles].
subst_idi(ingles, s-f) --> [inglesa].

subst_idi(japones, s-m) --> [japones].
subst_idi(japones, s-f) --> [japonesa].

subst_idi(russo, s-m) --> [russo].
subst_idi(russo, s-f) --> [russa].

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

verbo(s, ser, presente) --> [e].
verbo(p, ser, presente) --> [sao].

verbo(s, viver, presente) --> [vive].
verbo(p, viver, presente) --> [vivem].

verbo(s, estar, presente) --> [esta].
verbo(p, estar, presente) --> [estao].

verbo(s, existir, presente) --> [existe].
verbo(p, existir, presente) --> [existem].

%---------------------------------------------------------%
% Verbos: Pretérito Perfeito / Pretérito Imperfeito       %
%---------------------------------------------------------%

verbo(p, ser, passado) --> [era].
verbo(s, ser, passado) --> [eram].
verbo(s, ser, passado) --> [foi].
verbo(p, ser, passado) --> [foram].

verbo(s, viver, passado) --> [viveu].
verbo(p, viver, passado) --> [viveram].
verbo(s, viver, passado) --> [vivia].
verbo(p, viver, passado) --> [viviam].

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

verbo_passiva(s-m, viver) --> [vivo].
verbo_passiva(p-m, viver) --> [vivos].
verbo_passiva(s-f, viver) --> [viva].
verbo_passiva(p-f, viver) --> [vivas].

verbo_passiva(s-f, morrer) --> [morta].
verbo_passiva(p-f, morrer) --> [mortas].
verbo_passiva(s-m, morrer) --> [morto].
verbo_passiva(p-m, morrer) --> [mortos].

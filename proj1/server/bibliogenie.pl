% consult('~/Desktop/feup-iart-master/proj1/server/bibliogenie.pl').

%                     LISTA DE AUTORES
autor(dumas, 'Alexandre', 'Dumas', 1802, 1870, m, fra, []).
autor(dumasjr, 'Alexandre', 'Dumas', 1824, 1895, m, fra, []).
autor(clarke, 'Arthur', 'Clarke', 1917, 2008, m, usa, []).
autor(cacb, 'Camilo', 'Castelo Branco', 1825, 1890, m, por, []).
autor(cbro, 'Charlotte', 'Brontë', 1816, 1855, f, gbr, []).
autor(qroz, 'Eça', 'de Queiróz', 1845, 1900, m, por, []).
autor(ebro, 'Emily', 'Brontë', 1818, 1848, f, gbr, []).
autor(ebla, 'Eric', 'Blair', 1903, 1950, m, ind-col, [gowr]).
autor(ehem, 'Ernest', 'Hemingway', 1899, 1961, m, usa, []).
autor(pess, 'Fernando', 'Pessoa', 1888, 1935, m, prt, [pess-soar]).
autor(dost, 'Fiódor', 'Dostoiévski', 1821, 1881, m, rus, []).
autor(nietz, 'Friedrich', 'Nietzsche', 1844, 1900, m, deu, []).
autor(gagm, 'Gabriel', 'Garcia Márquez', 1927, 2014, m, col, []).
autor(isal, 'Isabel', 'Allende', 1942, -1, f, chi, []).
autor(aust, 'Jane', 'Austen', 1775, 1817, f, gbr, []).
autor(juld, 'Júlio', 'Dinis', 1839, 1871, m, por, []).
autor(mtwn, 'Mark', 'Twain', 1835, 1910, m, usa, []).
autor(tolst, 'Leão', 'Tolstói', 1828, 1910, m, rus, []).
autor(lcam, 'Luís', 'de Camões', 1524, 1580, m, por, []).
autor(mcou, 'Mia', 'Couto', 1955, -1, m, moz, []).
autor(owld, 'Oscar', 'Wilde', 1864, 1900, m, ire, []).
autor(verf, 'Vergílo', 'Ferreira', 1916, 1996, m, por, []).
autor(shak, 'William', 'Shakespeare', 1564, 1616, m, gbr, []).

%                      LISTA DE LIVROS
livro(isal-cesp, 'A Casa dos Espíritos', isal, 1982, romance, null).
livro(clarke-cid, 'A Cidade e as Estrelas', clarke, 1956, ficcao-cientifica, null).
livro(dumasjr-cam, 'A Dama das Camélias', dumasjr, 1848, romance, null).
livro(ehem-fare, 'Adeus As Armas', ehem, 1929, romance, null).
livro(cacb-aceu, 'Agostinho de Ceuta', cacb, 1847, teatro, null).
livro(qroz-cram, 'A Ilustre Casa de Ramires', qroz, 1900, romance, null).
livro(pess-mens, 'A Mensagem', pess, 1934, poesia, null).
livro(cacb-aper, 'Amor de Perdição', cacb, 1862, romance, null).
livro(cacb-asal, 'Amor de Salvação', cacb, 1864, romance, null).
livro(juld-morg, 'A Morgadinha dos Canaviais', juld, 1868, romance, null).
livro(tolst-iva, 'A Morte de Ivan Ilitch', tolst, 1886, romance, null).
livro(lcam-anfi, 'Anfitriões', lcam, 1587, teatro, null).
livro(tolst-ann, 'Anna Karenina', tolst, 1877, romance, null).
livro(verf-apar, 'Aparição', verf, 1959, romance, null).
livro(qroz-reli, 'A Relíquia', qroz, 1887, romance, null).
livro(shak-temp, 'A Tempestade', shak, 1611, comedia, null).
livro(tolst-kre, 'A Sonata Kreutzer', tolst, 1889, romance, null).
livro(juld-pupr, 'As Pupilas do Senhor Reitor', juld, 1867, romance, null).
livro(lcam-afil, 'Auto de Filodemo', lcam, 1587, teatro, null).
livro(gagm-sole, 'Cem Anos de Solidão', gagm, 1967, romance, null).
livro(dost-cri, 'Crime e Castigo', dost, 1866, romance, null).
livro(mcou-cron, 'Cronicando', mcou, 1988, cronica, null).
livro(aust-emm, 'Emma', aust, 1815, romance, null).
livro(mcou-esto, 'Estórias Abensonhadas', mcou, 1994, conto, null).
livro(verf-epol, 'Estrela Polar', verf, 1960, conto, null).
livro(cacb-esfu, 'Estrelas Funestas', cacb, 1862, romance, null).
livro(cacb-espr, 'Estrelas Propícias', cacb, 1863, romance, null).
livro(shak-ham, 'Hamlet', shak, 1601, tragedia, null).
livro(shak-hen, 'Henrique VIII', shak, 1612, drama-historico, null).
livro(dost-hum, 'Humilhados e Ofendidos', dost, 1861, romance, null).
livro(cacb-insp, 'Inspirações', cacb, 1851, poesia, null).
livro(cbro-jeyr, 'Jane Eyre', cbro, 1847, romance, null).
livro(cacb-labe, 'Lágrimas Abençoadas', cacb, 1857, romance, null).
livro(cacb-lnp1, 'Livro Negro de Padre Dinis - I', cacb, 1855, romance, cacb-lnpd).
livro(cacb-lnp2, 'Livro Negro de Padre Dinis - II', cacb, 1855, romance, cacb-lnpd).
livro(shak-mac, 'Macbeth', shak, 1607, tragedia, null).
livro(verf-msub, 'Manhã Submersa', verf, 1953, romance, null).
livro(mcou-mamq, 'Mar Me Quer', mcou, 1998, romance, null).
livro(dost-mensu, 'Memórias do Subsolo', dost, 1864, romance, null).
livro(cacb-mis1, 'Mistérios de Lisboa - I', cacb, 1854, romance, cacb-misl).
livro(cacb-mis2, 'Mistérios de Lisboa - II', cacb, 1854, romance, cacb-misl).
livro(cacb-mis3, 'Mistérios de Lisboa - III', cacb, 1854, romance, cacb-misl).
livro(verf-muda, 'Mudança', verf, 1949, romance, null).
livro(ehem-icam, 'O Acampamento Indio', ehem, 1926, conto, null).
livro(dost-ado, 'O Adolescente', dost, 1875, romance, null).
livro(gagm-amor, 'O Amor nos Tempos de Cólera', gagm, 1985, romance, null).
livro(dumas-cri, 'O Conde de Monte Cristo', dumas, 1844, romance, null).
livro(qroz-pama, 'O Crime do Padro Amaro', qroz, 1875, romance, null).
livro(dost-dup, 'O Duplo', dost, 1846, romance, null).
livro(dost-ete, 'O Eterno Marido', dost, 1870, romance, null).
livro(dost-idi, 'O Idiota', dost, 1869, romance, null).
livro(dost-jog, 'O Jogador', dost, 1867, romance, null).
livro(soar-des, 'O Livro do Desassossego', pess-soar, _19xx, prosa, null).
livro(qroz-mand, 'O Mandarim', qroz, 1880, novela, null).
livro(shak-mer, 'O Mercador de Veneza', shak, 1598, comedia, null).
livro(ebro-wuth, 'O Morro dos Ventos Uivantes', ebro, 1847, romance, null).
livro(nietz-nas, 'O Nascimento da Tragédia', nietz, 1872, tratado, null).
livro(gagm-oton, 'O Outono do Patriarca', gagm, 1975, romance, null).
livro(qroz-pbas, 'O Primo Basílio', qroz, 1878, romance, null).
livro(aust-org, 'Orgulho e Preconceito', aust, 1813, romance, null).
livro(juld-casm, 'Os Fidalgos da Casa Mourisca', juld, 1871, romance, null).
livro(dost-kar, 'Os Irmãos Karamazov', dost, 1880, romance, null).
livro(lcam-lusi, 'Os Lusíadas', lcam, 1572, poesia, null).
livro(qroz-maia, 'Os Maias', qroz, 1888, romance, null).
livro(clarke-deu, 'Os Nove Biliões de Nomes de Deus', clarke, 1967, conto, null).
livro(cacb-pund, 'Os Pundonores Desagravados', cacb, 1845, poesia, null).
livro(dart-i, 'Os Três Mosqueteiros', dumas, 1844, romance, mosq).
livro(shak-ote, 'Otelo', shak, 1603, tragedia, null).
livro(dart-iii, 'O Visconde de Bragelonne', dumas, 1847, romance, dumas-mosq).
livro(mcou-freq, 'Pensageiro Frequente', mcou, 2010, romance, null).
livro(juld-poes, 'Poesias', juld, 1873, poesia, null).
livro(ehem-bell, 'Por Quem os Sinos Tocam', ehem, 1940, romance, null).
livro(aust-raz, 'Razão e Sensibilidade', aust, 1811, romance, null).
livro(shak-lea, 'Rei Lear', shak, 1605, tragedia, null).
livro(shak-rom, 'Romeu e Julieta', shak, 1595, tragedia, null).
livro(shak-son, 'Sonho de uma Noite de Verão', shak, 1596, comedia, null).
livro(mcou-tson, 'Terra Sonâmbula', mcou, 1992, romance, null).
livro(juld-fing, 'Uma Família Inglesa', juld, 1868, romance, null).
livro(dart-ii, 'Vinte Anos Depois', dumas, 1845, romance, mosq).
livro(mcou-vnoi, 'Vozes Anoitecidas', mcou, 1986, conto, null).

%                      LISTA DE COLECÇÕES/VOLUMES
colec(dumas-mosq, 'A Trilogia dos Mosqueteiros', dumas).
colec(cacb-lnpd, 'Livro Negro de Padre Dinis', cacb).
colec(cacb-misl, 'Mistérios de Lisboa', cacb).

%                      LISTA DE PSEUDÓNIMOS/HETERÓNIMOS
pseudo(pess-soar, 'Bernardo', 'Soares').
pseudo(gowr, 'George', 'Orwell').

%                        LISTA DE PAÍSES
pais(ger, 'Alemanha',  alemao, 'alemão', 'alemã').
pais(ang, 'Angola', lo-pt, 'angolano', 'angolana').
pais(aus, 'Austrália', lingua-en, 'australiano', 'australiana').
pais(aut, 'Austria', lingua-de, 'austríaco', 'austríaca').
pais(bel, 'Bélgica', frances, 'belga', 'belga').
pais(bra, 'Brasil', portugues, 'brasileiro', 'brasileira').
pais(chi, 'Chile', espanhol, 'chileno', 'chilena').
pais(col, 'Colômbia', espanhol, 'colombiano', 'colombiana').
pais(esp, 'Espanha', espanhol, 'espanhol', 'espanhola').
pais(usa, 'Estados Unidos', ingles, 'americano', 'americana').
pais(fin, 'Finlândia', finlandes, 'finlandês', 'finlandesa').
pais(fra, 'França', frances, 'francês', 'francesa').
pais(ind-col, 'India Britânica', ingles, 'inglês', 'inglesa').
pais(ind, 'India', hindu, 'indiano', 'indiana').
pais(ire, 'Irlanda', ingles, 'irlandês', 'irlandesa').
pais(moz, 'Moçambique', portugues, 'moçambicano', 'moçambicana').
pais(nor, 'Noruega', noruegues, 'norueguês', 'norueguesa').
pais(por, 'Portugal', portugues, 'português', 'portuguesa').
pais(gbr, 'Reíno Unido', ingles, 'inglês', 'inglesa').
pais(rus, 'Rússia', russo, 'russo', 'russa').
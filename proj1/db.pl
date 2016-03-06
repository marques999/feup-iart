/*
  USO:
  autor(ID, Primeiro Nome, Último Nome, Ano Nasc., Ano Mort., País).
  heteronimo(ID, ID autor "real", Primeiro Nome, Último Nome [Ano Nasc, Ano Morte, País]).
  livro(ID, Título, ID Autor/Heteronimo, Ano Conclusão, Tipo).
  saga(ID, ID Autor, Nome, Número de volumes).
  volume(ID, ID Saga, [Nome], Número, Ano Conclusão).
*/

# Jane Austen é uma mulher
autor("AUST", "Jane", "Austen", 1775, 1817, "UK").
livro("AUST-RAZ", "Razão e Sensibilidade", "AUST", 1811, "Romance").
livro("AUST-ORG", "Orgulho e Preconceito", "AUST", 1813, "Romance").
livro("AUST-EMM", "Emma", "AUST", 1815, "Romance").

# Clarke tem romances de ficção científica
autor("CLARKE", "Arthur", "Clarke", 1917, 2008).
livro("CLARKE-CID", "A Cidade e as Estrelas", "CLARKE", 1956, "Ficção Científica").
livro("CLARKE-DEU", "Os Nove Biliões de Nomes de Deus", "CLARKE", 1967, "Conto").

# Dostoiévksi é uma exemplo simples para testes
autor("DOST", "Fiódor", "Dostoiévski", 1821, 1881, "RUS").
livro("DOST-DUP", "O Duplo", "DOST", 1846, "Romance").
livro("DOST-HUM", "Humilhados e Ofendidos", "DOST", 1861, "Romance").
livro("DOST-MEMSU", "Memórias do Subsolo", "DOST", 1864, "Romance").
livro("DOST-CRI", "Crime e Castigo", "DOST", 1866, "Romance").
livro("DOST-JOG", "O Jogador", "DOST", 1867, "Romance").
livro("DOST-IDI", "O Idiota", "DOST", 1869, "Romance").
livro("DOST-ETE", "O Eterno Marido", "DOST", 1870, "Romance").
livro("DOST-ADO", "O Adolescente", "DOST", 1875, "Romance").
livro("DOST-KAR", "Os Irmãos Karamazov", "DOST", 1881, "Romance").

# Os 'Dumas'- pai e filho - têm o mesmo nome
autor("DUMAS", "Alexandre", "Dumas", 1802, 1870, "FRA").
livro("DUMAS-CRI", "O Conde de Monte Cristo", "DUMAS", 1844, "Romance").
saga("DUMAS-DART", "DUMAS", "Romances de D'Artagan", 3).
volume("DART-I", "DUMAS-DART", "Os Três Mosqueteiros", 1, 1844).
volume("DART-II", "DUMAS-DART", "Vinte Anos Depois", 2, 1845).
volume("DART-III", "DUMAS-DART", "O Visconde de Bragelonne", 3, 1847).

autor("DUMASJR", "Alexandre", "Dumas", 1824, 1895, "FRA").
livro("DUMASJR-CAM", "A Dama das Camélias", "DUMASJR", 1848).

# Nietzsche tem tradados filosóficos
autor("NIETZ", "Friedrich", "Nietzsche", 1844, 1900, "ALE").
livro("NIETZ-NAS", "O Nascimento da Tragédia", "NIETZ", 1872, Tratado).

# Pessoa tem vaŕios heterónimos
autor("PESS", "Fernando", "Pessoa", 1888, 1935, "POR").
livro("PESS-MENS", "A Mensagem", "PESS", 1934, "Poesia")

# Shakespeare tem dramas de diversos tipos
autor("SHAK", "William", "Shakespeare", 1564, 1616, "UK").
livro("SHAK-SON", "Sonho de uma Noite de Verão", "SHAK", 1596, "Comédia").
livro("SHAK-MER", "O Mercador de Veneza", "SHAK", 1598, "Comédia").
livro("SHAK-TEMP", "A Tempestade", "SHAK", 1611, "Comédia").
livro("SHAK-ROM", "Romeu e Julieta", "SHAK", 1595, "Tragédia").
livro("SHAK-MAC", "Macbeth", "SHAK", 1607, "Tragédia").
livro("SHAK-LEA", "Rei Lear", "SHAK", 1605, "Tragédia").
livro("SHAK-OTE", "Otelo", "SHAK", 1603, "Tragédia").
livro("SHAK-HAM", "Hamlet", "SHAK", 1601, "Tragédia").
livro("SHAK-HEN", "Henrique VIII", "SHAK", 1612, "Drama Histórico").

# Soares é um heterónimo de Fernando Pessoa
heteronimo("PESS-SOAR", "PESS", "Bernardo", "Soares").
livro("SOAR-DES", "O Livro do Desassossego", "PESS-SOAR", 19XX).

# Tolstói tem obras compostas de vários volumes com diferentes datas
autor("TOLST", "Leão", "Tolstói", 1828, 1910, "RUS").
saga("TOLST-GUERR", "TOLST", "A Guerra e a Paz", 4).
volume("GUERR-I", "TOLST-GUERR", 1, 18XX).
volume("GUERR-II", "TOLST-GUERR", 2, 18XX).
volume("GUERR-III", "TOLST-GUERR", 3, 18XX).
volume("GUERR-IV", "TOLST-GUERR", 4, 18XX).
livro("TOLST-ANN", "Anna Karenina", "TOLST", 1877, "Romance").
livro("TOLST-IVA", "A morte de Ivan Ilitch", "TOLST", 1886, "Romance").
livro("TOLST-KREU", "A Sonata Kreutzer", "TOLST", 1889, "Romance").

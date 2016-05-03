numero_ordinal(s-m) --> [primeiro].
numero_ordinal(s-f) --> [primeira].
numero_ordinal(s-m) --> [segundo].
numero_ordinal(s-f) --> [segunda].
numero_ordinal(s-m) --> [terceiro].
numero_ordinal(s-f) --> [terceira].
numero_ordinal(s-m) --> [ultimo]
numero_ordinal(s-f) --> [ultima]
numero_ordinal(p-m) --> [ultimos]
numero_ordinal(p-f) --> [ultimas]

artigo_definido(s-m) --> [o].
artigo_definido(s-f) --> [a].
artigo_definido(p-m) --> [os].
artigo_definido(p-f) --> [as].

artigo_indefinido(s-m) --> [um].
artigo_indefinido(s-f) --> [uma].
artigo_indefinido(p-m) --> [uns].
artigo_indefinido(p-f) --> [umas].

preposicao(s-m) --> [ao].
preposicao(s-f) --> [à].
preposicao(p-m) --> [aos].
preposicao(p-f) --> [às].

preposicao(_-_) --> [de].
preposicao(s-m) --> [do].
preposicao(s-f) --> [da].
preposicao(p-m) --> [dos].
preposicao(p-f) --> [das].

pronome_pessoal(s-m) --> [seu].
pronome_pessoal(s-f) --> [sua].
pronome_pessoal(p-m) --> [seus].
pronome_pessoal(p-f) --> [suas].

pronome_interrogativo(_-_) --> [quem].
pronome_interrogativo(_-_) --> [quando].
pronome_interrogativo(s-_) --> [quais].
pronome_interrogativo(p-_) --> [quais].
pronome_interrogativo(p-m) --> [quantos].
pronome_interrogativo(p-f) --> [quantas].
pronome_interrogativo(_-_) --> [que].

pronome_relativo(_-_) --> [que].

adjetivo_recente(s) --> [recente].
adjetivo_recente(p) --> [recentes].
adverbio_recente(_) --> [recentemente].

adjetivo_antigo(s-m) --> [antigo].
adjetivo_antigo(s-f) --> [antiga].
adjetivo_antigo(p-m) --> [antigos].
adjetivo_antigo(p-f) --> [antigas].
adverbio_antigo(_) --> [antigamente].

substantivo_livro(s-m) --> [livro].
substantivo_livro(p-m) --> [livros].
substantivo_livro(s-f) --> [obra].
substantivo_livro(p-f) --> [obras].

substantivo_autor(s-m) --> [autor].
substantivo_autor(p-m) --> [autores].
substantivo_autor(s-m) --> [escritor].
substantivo_autor(s-f) --> [escritora].
substantivo_autor(p-m) --> [escritores].
substantivo_autor(p-f) --> [escritoras].

substantivo_volume(s-m) --> [colecção].
substantivo_volume(p-m) --> [coleções].
substantivo_volume(s-f) --> [saga].
substantivo_volume(p-f) --> [sagas].
substantivo_volume(s-f) --> [trilogia].
substantivo_volume(p-f) --> [trilogias].
substantivo_volume(s-m) --> [volume].
substantivo_volume(p-m) --> [volumes].

nome(s-_) --> [morte].
nome(s-_) --> [nascimento].
nome(s-_) --> [falecimento].

nome(s-_) --> [heterónimo].
nome(p-_) --> [heterónimos].
nome(s-_) --> [pseudónimo].
nome(p-_) --> [pseudónimos].

adverbio_antes(s-_) -> [antes];
adverbio_antes(s-_) -> [anterior];

adverbio_depois(s-_) -> [posterior];
adverbio_depois(s-_) -> [depois];
adverbio_depois(s-_) -> [após];

substantivo(s-_) --> [seculo];
substantivo(p-_) --> [seculos];
substantivo(s-_) --> [idioma];
substantivo(p-_) --> [idiomas];
substantivo(s-_) --> [nacionalidade];
substantivo(p-_) --> [nacionalidades];
substantivo(s-_) --> [idade];
substantivo(p-_) --> [idades];

substantivo_nacionalidade(por, s-m) --> [portugues].
substantivo_nacionalidade(por, s-f) --> [portuguesa].
substantivo_nacionalidade(por, p-m) --> [portugueses].
substantivo_nacionalidade(por, p-f) --> [portuguesas].

substantivo_nacionalidade(esp, s-m) --> [espanhol].
substantivo_nacionalidade(esp, s-f) --> [espanhola].
substantivo_nacionalidade(esp, p-m) --> [espanhóis].
substantivo_nacionalidade(esp, p-f) --> [espanholas].

substantivo_nacionalidade(fra, s-m) --> [francês].
substantivo_nacionalidade(fra, s-f) --> [francesa].
substantivo_nacionalidade(fra, p-m) --> [franceses].
substantivo_nacionalidade(fra, p-f) --> [francesas].

substantivo_nacionalidade(ger, s-m) --> [alemão].
substantivo_nacionalidade(ger, s-f) --> [alemã].
substantivo_nacionalidade(ger, p-m) --> [alemães].
substantivo_nacionalidade(ger, p-f) --> [alemãs].

substantivo_nacionalidade(col, s-m) --> [colombiano].
substantivo_nacionalidade(col, s-f) --> [colombiana].
substantivo_nacionalidade(col, p-m) --> [colombianos].
substantivo_nacionalidade(col, p-f) --> [colombianas].

substantivo_nacionalidade(moz, s-m) --> [moçambicano].
substantivo_nacionalidade(moz, s-f) --> [moçambicana].
substantivo_nacionalidade(moz, p-m) --> [moçambicanos].
substantivo_nacionalidade(moz, p-f) --> [moçambicanas].

substantivo_idioma(ingles, s-m) --> [inglês];
substantivo_idioma(ingles, s-f) --> [inglesa];
substantivo_idioma(frances, s-m) --> [francês];
substantivo_idioma(frances, s-f) --> [francesa];
substantivo_idioma(japones, s-m) --> [japonês];
substantivo_idioma(japones, s-f) --> [japonesa];

continente(africa, s) --> [africano].
continente(africa, p) --> [africanos].
continente(europa, s) --> [europeu].
continente(europa, p) --> [europeus].
continente(america_norte, s) --> [norte-americano].
continente(america_norte, p) --> [norte-americanos].
continente(america_sul, s) --> [sul-americano].
continente(america_sul, p) --> [sul-americanos].
continente(asia, s) --> [asiatico].
continente(asia, p) --> [asiatica].

verbo(p) --> [escreveram].
verbo(s) --> [é].
verbo(p) --> [são].
verbo(p) --> [foi].
verbo(s) --> [foram].

verbo(s) --> [escreveu].
verbo(p) --> [escreveram].
verbo(s) --> [publicou].
verbo(p) --> [publicaram].

verbo(s) --> [morreu].
verbo(p) --> [morreram].
verbo(s) --> [nasceu].
verbo(p) --> [nasceram].

verbo(s) --> [gosta].
verbo(p) --> [gostam].
verbo(s) --> [come].
verbo(p) --> [comem].
verbo(p) --> [sao].

adjetivo(_) -> [mais].
adjetivo(_) -> [menos].
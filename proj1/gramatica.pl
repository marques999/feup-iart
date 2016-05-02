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

substantivo_volume(s-f) --> [trilogia].
substantivo_volume(p-f) --> [trilogias].
substantivo_volume(s-m) --> [volume].
substantivo_volume(p-m) --> [volumes].

nome(s-_) --> [morte].
nome(s-_) --> [nascimento].
nome(s-_) --> [heterónimo].
nome(p-_) --> [heterónimos].

nacionalidade(por, s-m) --> [portugues].
nacionalidade(por, s-f) --> [portuguesa].
nacionalidade(por, p-m) --> [portugueses].
nacionalidade(por, p-f) --> [portuguesas].

nacionalidade(esp, s-m) --> [espanhol].
nacionalidade(esp, s-f) --> [espanhola].
nacionalidade(esp, p-m) --> [espanhóis].
nacionalidade(esp, p-f) --> [espanholas].

nacionalidade(fra, s-m) --> [francês].
nacionalidade(fra, s-f) --> [francesa].
nacionalidade(fra, p-m) --> [franceses].
nacionalidade(fra, p-f) --> [francesas].

nacionalidade(ger, s-m) --> [alemão].
nacionalidade(ger, s-f) --> [alemã].
nacionalidade(ger, p-m) --> [alemães].
nacionalidade(ger, p-f) --> [alemãs].

nacionalidade(col, s-m) --> [colombiano].
nacionalidade(col, s-f) --> [colombiana].
nacionalidade(col, p-m) --> [colombianos].
nacionalidade(col, p-f) --> [colombianas].

nacionalidade(moz, s-m) --> [moçambicano].
nacionalidade(moz, s-f) --> [moçambicana].
nacionalidade(moz, p-m) --> [moçambicanos].
nacionalidade(moz, p-f) --> [moçambicanas].

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
verbo(s) --> [morreu].
verbo(s) --> [nasceu].

verbo(s) --> [gosta].
verbo(p) --> [gostam].
verbo(s) --> [come].
verbo(p) --> [comem].
verbo(p) --> [sao].

adjetivo(_) -> [mais].
adjetivo(_) -> [menos].
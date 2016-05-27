package iart.model;

class Autor
{
    private String mNome;
    private String mId;
    private String mNacionalidade;

    Autor(final String paramQuery) throws NumberFormatException
    {
	final String[] queryArgs = paramQuery.substring(6, paramQuery.length() - 1).split(("\\s*,\\s*"));

	mId = queryArgs[IndexIdAutor];
	mNome = (queryArgs[IndexPrimeiroNome] + " " + queryArgs[IndexUltimoNome]).replace("\'", "");
	mNacionalidade = queryArgs[IndexNacionalidade];
	mAnoNascimento = Integer.parseInt(queryArgs[IndexAnoNascimento]);
	mAnoMorte = Integer.parseInt(queryArgs[IndexAnoMorte]);
    }

    private int mAnoMorte;
    private int mAnoNascimento;
    private static final int IndexIdAutor = 0;
    private static final int IndexPrimeiroNome = 1;
    private static final int IndexUltimoNome = 2;
    private static final int IndexAnoNascimento = 3;
    private static final int IndexAnoMorte = 4;
    private static final int IndexNacionalidade = 6;

    final String getId()
    {
	return mId;
    }

    void setId(final String paramId)
    {
	mId = paramId;
    }

    final String getNome()
    {
	return mNome;
    }

    void setNome(final String paramNome)
    {
	mNome = paramNome;
    }

    final String getNacionalidade()
    {
	return mNacionalidade;
    }

    void setNacionalidade(final String paramNacionalidade)
    {
	mNacionalidade = paramNacionalidade;
    }

    final int getAnoNascimento()
    {
	return mAnoNascimento;
    }

    void setAnoNascimento(int paramAno)
    {
	mAnoNascimento = paramAno;
    }

    int getAnoMorte()
    {
	return mAnoMorte;
    }

    void setAnoMorte(int paramAno)
    {
	mAnoMorte = paramAno;
    }
}
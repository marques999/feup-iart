package iart.model;

class Livro
{
    private String mTitulo;
    private String mId;
    private String mGenero;
    private String mAutor;

    Livro(final String paramQuery) throws NumberFormatException
    {
	final String[] queryArgs = paramQuery.substring(6, paramQuery.length() - 1).split(("\\s*,\\s*"));

	mId = queryArgs[IndexIdLivro];
	mTitulo = queryArgs[IndexTitulo].replace("\'", "");
	mAutor = queryArgs[IndexAutor];
	mAno = Integer.parseInt(queryArgs[IndexAno]);
	mGenero = queryArgs[IndexGenero].substring(0, 1).toUpperCase() + queryArgs[IndexGenero].substring(1);
    }

    private int mAno;
    private static final int IndexIdLivro = 0;
    private static final int IndexTitulo = 1;
    private static final int IndexAutor = 2;
    private static final int IndexAno = 3;
    private static final int IndexGenero = 4;

    int getAno()
    {
	return mAno;
    }

    void setAno(int paramAno)
    {
	mAno = paramAno;
    }

    final String getId()
    {
	return mId;
    }

    void setId(final String paramId)
    {
	mId = paramId;
    }

    final String getTitulo()
    {
	return mTitulo;
    }

    void setTitulo(final String paramTitulo)
    {
	mTitulo = paramTitulo;
    }

    final String getAutor()
    {
	return mAutor;
    }

    void setAutor(final String paramAutor)
    {
	mAutor = paramAutor;
    }

    final String getGenero()
    {
	return mGenero;
    }

    void setGenero(final String paramGenero)
    {
	mGenero = paramGenero;
    }
}
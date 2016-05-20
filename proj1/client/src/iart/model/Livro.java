package iart.model;

class Livro {

    private String mTitulo;
    private String mId;
    private String mColeccao;
    private String mGenero;
    private String mAutor;

    Livro(final String paramQuery) throws NumberFormatException {

        final String[] queryArgs = paramQuery.substring(6, paramQuery.length() - 1).split(("\\s*,\\s*"));

        mId = queryArgs[IndexIdLivro];
        mTitulo = queryArgs[IndexTitulo].replace("\'", "");
        mAutor = queryArgs[IndexAutor];
        mAno = Integer.parseInt(queryArgs[IndexAno]);
        mGenero = queryArgs[IndexGenero].substring(0, 1).toUpperCase() + queryArgs[IndexGenero].substring(1);
        mColeccao = queryArgs[IndexColeccao];
    }

    private int mAno;
    private static final int IndexIdLivro = 0;
    private static final int IndexTitulo = 1;
    private static final int IndexAutor = 2;
    private static final int IndexAno = 3;
    private static final int IndexGenero = 4;
    private static final int IndexColeccao = 5;

    final int getAno() {
        return mAno;
    }

    final void setAno(int paramAno) {
        mAno = paramAno;
    }

    final String getId() {
        return mId;
    }

    final void setId(final String paramId) {
        mId = paramId;
    }

    final String getTitulo() {
        return mTitulo;
    }

    final void setTitulo(final String paramTitulo) {
        mTitulo = paramTitulo;
    }

    final String getAutor() {
        return mAutor;
    }

    final void setAutor(final String paramAutor) {
        mAutor = paramAutor;
    }

    final String getColeccao() {
        return mColeccao;
    }

    final void setColeccao(final String paramColeccao) {
        mColeccao = paramColeccao;
    }

    final String getGenero() {
        return mGenero;
    }

    final void setGenero(final String paramGenero) {
        mGenero = paramGenero;
    }
}
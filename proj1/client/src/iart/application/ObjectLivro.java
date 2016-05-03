package iart.application;

public class ObjectLivro {

    private static final int Index_IdLivro = 0;
    private static final int Index_Titulo = 1;
    private static final int Index_Autor = 2;
    private static final int Index_Ano = 3;
    private static final int Index_Genero = 4;
    private static final int Index_Coleccao = 5;

    public ObjectLivro(final String paramQuery) {

        final String[] queryArgs = paramQuery.substring(6, paramQuery.length() - 1).split(("\\s*,\\s*"));

        mId = queryArgs[Index_IdLivro];
        mTitulo = queryArgs[Index_Titulo].replace("\'", "");
        mAutor = queryArgs[Index_Autor];
        mAno = Integer.parseInt(queryArgs[Index_Ano]);
        mGenero = queryArgs[Index_Genero].substring(0, 1).toUpperCase() + queryArgs[Index_Genero].substring(1);
        mColeccao = queryArgs[Index_Coleccao];
    }

    private final String mTitulo;
    private final String mId;
    private final String mColeccao;
    private final String mGenero;
    private final String mAutor;

    private int mAno;

    public final String getId() {
        return mId;
    }

    public final String getTitulo() {
        return mTitulo;
    }

    public String getAutor() {
        return mAutor;
    }

    public final String getColeccao() {
        return mColeccao;
    }

    public final String getGenero() {
        return mGenero;
    }

    public final int getAno() {
        return mAno;
    }
}
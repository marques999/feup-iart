package iart.model;

class Autor {

    private String mNome;
    private String mId;
    private String mPseudonimos;
    private String mNacionalidade;

    Autor(final String paramQuery) throws NumberFormatException {

        final String[] queryArgs = paramQuery.substring(6, paramQuery.length() - 1).split(("\\s*,\\s*"));

        setId(queryArgs[IndexIdAutor]);
        mNome = (queryArgs[IndexPrimeiroNome] + " " + queryArgs[IndexUltimoNome]).replace("\'", "");
        setNacionalidade(queryArgs[IndexNacionalidade]);
        setAnoNascimento(Integer.parseInt(queryArgs[IndexAnoNascimento]));
        setAnoMorte(Integer.parseInt(queryArgs[IndexAnoMorte]));
        setPseudonimos(queryArgs[IndexPseudonimos].substring(1, queryArgs[IndexPseudonimos].length() - 1));
    }

    private int mAnoMorte;
    private int mAnoNascimento;
    private static final int IndexIdAutor = 0;
    private static final int IndexPrimeiroNome = 1;
    private static final int IndexUltimoNome = 2;
    private static final int IndexAnoNascimento = 3;
    private static final int IndexAnoMorte = 4;
    private static final int IndexNacionalidade = 6;
    private static final int IndexPseudonimos = 7;

    final String getId() {
        return mId;
    }

    final void setId(final String paramId) {
        mId = paramId;
    }

    final String getNome() {
        return mNome;
    }

    final void setNome(final String paramNome) {
        mNome = paramNome;
    }

    final String getPseudonimos() {
        return mPseudonimos;
    }

    final void setPseudonimos(final String paramPseudonimos) {
        mPseudonimos = paramPseudonimos;
    }

    final String getNacionalidade() {
        return mNacionalidade;
    }

    final void setNacionalidade(final String paramNacionalidade) {
        mNacionalidade = paramNacionalidade;
    }

    final int getAnoNascimento() {
        return mAnoNascimento;
    }

    final void setAnoNascimento(int paramAno) {
        mAnoNascimento = paramAno;
    }

    final int getAnoMorte() {
        return mAnoMorte;
    }

    final void setAnoMorte(int paramAno) {
        mAnoMorte = paramAno;
    }
}
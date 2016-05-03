package iart.application;

public class ObjectAutor {

    private static final int Index_IdAutor = 0;
    private static final int Index_PrimeiroNome = 1;
    private static final int Index_UltimoNome = 2;
    private static final int Index_AnoNascimento = 3;
    private static final int Index_AnoMorte = 4;
    private static final int Index_Nacionalidade = 6;
    private static final int Index_Pseudonimos = 7;

    public ObjectAutor(final String paramQuery) {

        final String[] queryArgs = paramQuery.substring(6, paramQuery.length() - 1).split(("\\s*,\\s*"));

        mId = queryArgs[Index_IdAutor];
        mNome = (queryArgs[Index_PrimeiroNome] + " " + queryArgs[Index_UltimoNome]).replace("\'", "");
        mNacionalidade = queryArgs[Index_Nacionalidade];
        mAnoNascimento = Integer.parseInt(queryArgs[Index_AnoNascimento]);
        mAnoMorte = Integer.parseInt(queryArgs[Index_AnoMorte]);
        mPseudonimos = queryArgs[Index_Pseudonimos].substring(1, queryArgs[Index_Pseudonimos].length() - 1);
    }

    private final String mNome;
    private final String mId;
    private final String mPseudonimos;
    private final String mNacionalidade;

    private final int mAnoNascimento;
    private final int mAnoMorte;

    public final String getId() {
        return mId;
    }

    public final String getNome() {
        return mNome;
    }

    public final String getColeccao() {
        return mPseudonimos;
    }

    public final String getNacionalidade() {
        return mNacionalidade;
    }

    public final int getAnoNascimento() {
        return mAnoNascimento;
    }

    public final int getAnoMorte() {
        return mAnoMorte;
    }
}
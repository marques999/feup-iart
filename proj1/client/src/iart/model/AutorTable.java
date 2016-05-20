package iart.model;

import javax.swing.table.AbstractTableModel;

import java.util.ArrayList;
import java.util.List;

public class AutorTable extends AbstractTableModel {

    private static final int IndexAutorId = 0;
    private static final int IndexNome = 1;
    private static final int IndexAnoNascimento = 2;
    private static final int IndexAnoMorte = 3;
    private static final int IndexNacionalidade = 4;
    private static final int IndexPseudonimos = 5;

    public AutorTable(final String serverResponse) {

        myAutores = new ArrayList<>();

        final List<String> processedQuery = StringUtils.split(serverResponse.trim());

        for (final String queryResult : processedQuery) {
            insertAutor(queryResult);
        }
    }

    private final String[] myColumns = {
        "ID", "Nome", "Nascimento", "Morte", "Nacionalidade", "Pseudónimos"
    };

    private final List<Autor> myAutores;

    private void insertAutor(final String queryResult) {

        final Autor testeAutor = new Autor(queryResult);

        System.out.println(testeAutor.getId());
        System.out.println(testeAutor.getNome());
        System.out.println(testeAutor.getAnoNascimento());
        System.out.println(testeAutor.getAnoMorte());
        System.out.println(testeAutor.getNacionalidade());
        System.out.println(testeAutor.getPseudonimos());
        System.out.println("-----------------------");
        fireTableRowsInserted(getRowCount() - 1, getRowCount() - 1);
    }

    @Override
    public boolean isCellEditable(int rowIndex, int columnIndex) {
        return false;
    }

    @Override
    public int getRowCount() {
        return myAutores.size();
    }

    @Override
    public String getColumnName(int columnIndex) {

        if (columnIndex >= 0 && columnIndex < myColumns.length) {
            return myColumns[columnIndex];
        }

        return null;
    }

    @Override
    public Class<?> getColumnClass(int columnIndex) {

        if (columnIndex == IndexAnoNascimento || columnIndex == IndexAnoMorte) {
            return Integer.class;
        }

        return String.class;
    }

    @Override
    public int getColumnCount() {
        return myColumns.length;
    }

    @Override
    public void setValueAt(final Object paramObject, int rowIndex, int columnIndex) {

        final Autor selectedAutor = myAutores.get(rowIndex);

        if (selectedAutor != null) {

            switch (columnIndex) {
            case IndexAutorId:
                selectedAutor.setId((String) paramObject);
            case IndexNome:
                selectedAutor.setNome((String) paramObject);
            case IndexAnoNascimento:
                selectedAutor.setAnoNascimento((Integer) paramObject);
            case IndexAnoMorte:
                selectedAutor.setAnoMorte((Integer) paramObject);
            case IndexNacionalidade:
                selectedAutor.setNacionalidade((String) paramObject);
            case IndexPseudonimos:
                selectedAutor.setPseudonimos((String) paramObject);
            }

            fireTableCellUpdated(rowIndex, columnIndex);
        }
    }

    @Override
    public Object getValueAt(int rowIndex, int columnIndex) {

        final Autor selectedAutor = myAutores.get(rowIndex);

        if (selectedAutor == null) {
            return null;
        }

        switch (columnIndex) {
        case IndexAutorId:
            return selectedAutor.getId();
        case IndexNome:
            return selectedAutor.getNome();
        case IndexAnoNascimento:
            return selectedAutor.getAnoNascimento();
        case IndexAnoMorte:
            return selectedAutor.getAnoMorte();
        case IndexNacionalidade:
            return selectedAutor.getNacionalidade();
        case IndexPseudonimos:
            return selectedAutor.getPseudonimos();
        }

        return null;
    }
}
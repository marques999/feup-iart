package iart.model;

import javax.swing.table.AbstractTableModel;

import java.util.ArrayList;
import java.util.List;

public class LivroTable extends AbstractTableModel {

    private static final int IndexIdLivro = 0;
    private static final int IndexTitulo = 1;
    private static final int IndexAutor = 2;
    private static final int IndexAno = 3;
    private static final int IndexGenero = 4;
    private static final int IndexColeccao = 5;

    public LivroTable(final String serverResponse) {

        myLivros = new ArrayList<>();

        final List<String> processedQuery = StringUtils.split(serverResponse.trim());

        for (final String queryResult : processedQuery) {
            insertLivro(queryResult);
        }
    }

    private static final String[] myColumns = {
        "ID", "Títutlo", "Autor", "Ano", "Género", "Colecção"
    };

    private final List<Livro> myLivros;

    private void insertLivro(final String queryResult) {

        final Livro testeLivro = new Livro(queryResult);

        System.out.println(testeLivro.getId());
        System.out.println(testeLivro.getTitulo());
        System.out.println(testeLivro.getAutor());
        System.out.println(testeLivro.getAno());
        System.out.println(testeLivro.getGenero());
        System.out.println("-----------------------");
        fireTableRowsInserted(getRowCount() - 1, getRowCount() - 1);
    }

    @Override
    public boolean isCellEditable(int rowIndex, int columnIndex) {
        return false;
    }

    @Override
    public int getRowCount() {
        return myLivros.size();
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

        if (columnIndex == IndexAno) {
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

        final Livro selectedLivro = myLivros.get(rowIndex);

        if (selectedLivro != null) {
            switch (columnIndex) {
            case IndexIdLivro:
                selectedLivro.setId((String) paramObject);
            case IndexTitulo:
                selectedLivro.setTitulo((String) paramObject);
            case IndexAutor:
                selectedLivro.setAutor((String) paramObject);
            case IndexAno:
                selectedLivro.setAno((Integer) paramObject);
            case IndexGenero:
                selectedLivro.setGenero((String) paramObject);
            case IndexColeccao:
                selectedLivro.setColeccao((String) paramObject);
            }

            fireTableCellUpdated(rowIndex, columnIndex);
        }
    }

    @Override
    public Object getValueAt(int rowIndex, int columnIndex) {

        final Livro selectedLivro = myLivros.get(rowIndex);

        if (selectedLivro == null) {
            return null;
        }

        switch (columnIndex) {
        case IndexIdLivro:
            return selectedLivro.getId();
        case IndexTitulo:
            return selectedLivro.getTitulo();
        case IndexAutor:
            return selectedLivro.getAutor();
        case IndexAno:
            return selectedLivro.getAno();
        case IndexGenero:
            return selectedLivro.getGenero();
        case IndexColeccao:
            return selectedLivro.getColeccao();
        }

        return null;
    }
}
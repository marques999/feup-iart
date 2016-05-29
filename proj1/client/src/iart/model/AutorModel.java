package iart.model;

import javax.swing.table.AbstractTableModel;

import java.util.ArrayList;
import java.util.List;

public final class AutorModel extends AbstractTableModel
{
    private static final int IndexAutorId = 0;
    private static final int IndexNome = 1;
    private static final int IndexAnoNascimento = 2;
    private static final int IndexAnoMorte = 3;
    private static final int IndexNacionalidade = 4;

    public AutorModel(final ArrayList<String> paramQuery)
    {
	myAutores = new ArrayList<>();

	for (final String queryResult : paramQuery)
	{
	    myAutores.add(new Autor(queryResult));
	}

	fireTableRowsInserted(0, getRowCount() - 1);
    }

    private final String[] myColumns =
    {
	"ID", "Nome", "Nascimento", "Morte", "Pais"
    };

    private final List<Autor> myAutores;

    @Override
    public boolean isCellEditable(int rowIndex, int columnIndex)
    {
	return false;
    }

    @Override
    public int getRowCount()
    {
	return myAutores.size();
    }

    @Override
    public String getColumnName(int columnIndex)
    {
	if (columnIndex >= 0 && columnIndex < myColumns.length)
	{
	    return myColumns[columnIndex];
	}

	return null;
    }

    @Override
    public Class<?> getColumnClass(int columnIndex)
    {
	if (columnIndex == IndexAnoNascimento || columnIndex == IndexAnoMorte)
	{
	    return Integer.class;
	}

	return String.class;
    }

    @Override
    public int getColumnCount()
    {
	return myColumns.length;
    }

    @Override
    public void setValueAt(final Object paramObject, int rowIndex, int columnIndex)
    {
	final Autor selectedAutor = myAutores.get(rowIndex);

	if (selectedAutor != null)
	{
	    switch (columnIndex)
	    {
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
	    }

	    fireTableCellUpdated(rowIndex, columnIndex);
	}
    }

    @Override
    public Object getValueAt(int rowIndex, int columnIndex)
    {
	final Autor selectedAutor = myAutores.get(rowIndex);

	if (selectedAutor == null)
	{
	    return null;
	}

	switch (columnIndex)
	{
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
	}

	return null;
    }
}
package iart.model;

import java.util.ArrayList;

import javax.swing.JTable;
import javax.swing.table.AbstractTableModel;
import javax.swing.table.DefaultTableCellRenderer;

public class LivroTable extends AbstractTable
{
    public LivroTable(final ArrayList<String> queryResponse)
    {
	super(queryResponse);
    }

    @Override
    protected DefaultTableCellRenderer getRenderer()
    {
	return new LivroRenderer();
    }

    @Override
    protected AbstractTableModel getModel()
    {
	return new LivroModel(getResponse());
    }

    @Override
    protected void setWidth(JTable jTable)
    {
	jTable.getColumnModel().getColumn(0).setPreferredWidth(32);
	jTable.getColumnModel().getColumn(2).setPreferredWidth(32);
	jTable.getColumnModel().getColumn(3).setPreferredWidth(16);
	jTable.getColumnModel().getColumn(4).setPreferredWidth(32);
    }

    @Override
    public String getName()
    {
	return "LIVROS";
    }
}
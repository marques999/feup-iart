package iart.model;

import javax.swing.JTable;
import javax.swing.table.AbstractTableModel;
import javax.swing.table.DefaultTableCellRenderer;

public abstract class AbstractTable
{
    private final String queryResponse;

    public AbstractTable(final String paramResponse)
    {
	queryResponse = paramResponse;
    }

    public void applyModel(final JTable jTable)
    {
	jTable.setModel(getModel());
	jTable.setDefaultRenderer(Object.class, getRenderer());
	setWidth(jTable);
    }

    protected final String getResponse()
    {
	return queryResponse;
    }

    public abstract String getName();

    protected abstract DefaultTableCellRenderer getRenderer();
    protected abstract AbstractTableModel getModel();
    protected abstract void setWidth(final JTable jTable);
}
package iart.model;

import java.util.ArrayList;

import javax.swing.JTable;
import javax.swing.table.AbstractTableModel;
import javax.swing.table.DefaultTableCellRenderer;

public abstract class AbstractTable
{
    private final ArrayList<String> queryResponse;

    public AbstractTable(final ArrayList<String> paramResponse)
    {
	queryResponse = paramResponse;
    }

    public void applyModel(final JTable jTable)
    {
	jTable.setModel(getModel());
	jTable.setDefaultRenderer(Object.class, getRenderer());
	setWidth(jTable);
    }
    
    protected ArrayList<String> getResponse()
    {
	return queryResponse;
    }

    public abstract String getName();
    protected abstract DefaultTableCellRenderer getRenderer();
    protected abstract AbstractTableModel getModel();
    protected abstract void setWidth(final JTable jTable);
}
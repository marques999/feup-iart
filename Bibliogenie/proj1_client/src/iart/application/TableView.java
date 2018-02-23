package iart.application;

import iart.model.AbstractTable;

import java.awt.BorderLayout;
import java.awt.Dimension;
import java.awt.Frame;

import javax.swing.JDialog;
import javax.swing.JScrollPane;
import javax.swing.JTable;
import javax.swing.WindowConstants;

public class TableView extends JDialog
{
    public TableView(final Frame parentFrame, final AbstractTable abstractTable)
    {
	super(parentFrame);
	final JScrollPane jScrollPane1 = new JScrollPane();
	final JTable jTable1 = new JTable();
	setDefaultCloseOperation(WindowConstants.DISPOSE_ON_CLOSE);
	setMinimumSize(new Dimension(400, 300));
	setTitle(abstractTable.getName() + " - Resultados");
	setModal(true);
	jTable1.setAutoCreateRowSorter(true);
	jTable1.setFillsViewportHeight(true);
	jTable1.setRowHeight(20);
	jTable1.setRowMargin(2);
	jTable1.setRowSelectionAllowed(false);
	jTable1.setShowHorizontalLines(false);
	jTable1.setShowVerticalLines(false);
	jTable1.getTableHeader().setResizingAllowed(false);
	jTable1.getTableHeader().setReorderingAllowed(false);
	abstractTable.applyModel(jTable1);
	jScrollPane1.setViewportView(jTable1);
	getContentPane().add(jScrollPane1, BorderLayout.CENTER);
	pack();
	setLocationRelativeTo(parentFrame);
    }
}
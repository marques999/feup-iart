package iart;

import iart.application.GUIMain;

import java.awt.Component;
import java.awt.EventQueue;

import javax.swing.JOptionPane;
import javax.swing.UIManager;
import javax.swing.UnsupportedLookAndFeelException;

public class Bibliogenie
{
    public static final String strProgramName = "Bibliogenie";

    public static void main(String args[])
    {
	try
	{
	    UIManager.setLookAndFeel(UIManager.getSystemLookAndFeelClassName());
	}
	catch (final ClassNotFoundException | InstantiationException | IllegalAccessException | UnsupportedLookAndFeelException ex)
	{
	    JOptionPane.showMessageDialog(null, ex.getLocalizedMessage(), strProgramName, JOptionPane.ERROR_MESSAGE);
	}

	EventQueue.invokeLater(() -> new GUIMain().setVisible(true));
    }

    public static void showError(final Component paramParent, final String paramMessage)
    {
	JOptionPane.showMessageDialog(paramParent, paramMessage, strProgramName, JOptionPane.ERROR_MESSAGE);
    }

    public static void showWarning(final Component paramParent, final String paramMessage)
    {
	JOptionPane.showMessageDialog(paramParent, paramMessage, strProgramName, JOptionPane.WARNING_MESSAGE);
    }
}
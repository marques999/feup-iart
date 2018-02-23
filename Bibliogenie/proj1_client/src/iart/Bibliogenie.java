package iart;

import iart.application.GUIMain;

import java.awt.Component;
import java.awt.EventQueue;

import javax.swing.JFrame;
import javax.swing.JOptionPane;
import javax.swing.UIManager;
import javax.swing.UnsupportedLookAndFeelException;

import se.sics.jasper.SICStus;
import se.sics.jasper.SPException;

public class Bibliogenie
{
    public static final String strProgramName = "Bibliogenie";

    public static void main(String argv[])
    {
	try
	{
	    UIManager.setLookAndFeel(UIManager.getSystemLookAndFeelClassName());
	}
	catch (final ClassNotFoundException | InstantiationException | IllegalAccessException | UnsupportedLookAndFeelException ex)
	{
	    JOptionPane.showMessageDialog(null, ex.getLocalizedMessage(), strProgramName, JOptionPane.ERROR_MESSAGE);
	}

	EventQueue.invokeLater(() -> 
	{
	    try
	    {
		SICStus sicstusInstance = new SICStus(null);
		sicstusInstance.restore("bibliogenie.sav");
	    }
	    catch (SPException ex)
	    {
		showCritical(null, ex);
	    }

	    new GUIMain().setVisible(true);
	});
    }
    
    private static void showCritical(final JFrame paramFrame, final Exception paramThrowable)
    {
	JOptionPane.showMessageDialog(paramFrame, paramThrowable, "Bibliogenie : ERROR", JOptionPane.ERROR_MESSAGE);
	System.exit(0);
    }
    
    public static void showError(final JFrame paramFrame, final Exception paramThrowable)
    {
	JOptionPane.showMessageDialog(paramFrame, paramThrowable, "Bibliogenie : ERROR", JOptionPane.ERROR_MESSAGE);
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
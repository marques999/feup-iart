package iart.application;

import java.awt.Frame;

import javax.swing.JTextArea;

public abstract class PrologResponse
{
    private final String msgFormat = "\nQ: %s\nA: %s\n";

    protected String getFormat()
    {
	return msgFormat;
    }

    public abstract void writeOutput(final JTextArea textArea);

    public void showDialog(final Frame paramParent)
    {
    }
}
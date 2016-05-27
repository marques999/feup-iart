package iart.server;

import java.awt.Component;

import javax.swing.JTextArea;

public class SimpleResponse extends PrologResponse
{
    public SimpleResponse(final String queryMessage, final String paramResponse)
    {
	super(queryMessage, paramResponse);
    }

    @Override
    public void writeOutput(JTextArea textArea)
    {
	textArea.append(String.format(getFormat(), getRequest(), getResponse()));
    }
}
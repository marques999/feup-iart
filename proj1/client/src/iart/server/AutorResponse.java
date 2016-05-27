package iart.server;

import iart.application.TableView;
import iart.model.AutorTable;

import java.awt.Frame;

import javax.swing.JTextArea;

public class AutorResponse extends PrologResponse
{
    public AutorResponse(final String queryMessage, final String paramResponse)
    {
	super(queryMessage, paramResponse);
    }

    @Override
    public void writeOutput(JTextArea textArea)
    {
	textArea.append(String.format(getFormat(), getRequest(), "Array"));
    }

    @Override
    public void showDialog(final Frame paramParent)
    {
	new TableView(paramParent, new AutorTable(getResponse())).setVisible(true);
    }
}
package iart.server;

import iart.application.TableView;
import iart.model.LivroTable;

import java.awt.Frame;

import javax.swing.JTextArea;

public class LivroResponse extends PrologResponse
{
    public LivroResponse(final String queryMessage, final String paramResponse)
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
	new TableView(paramParent, new LivroTable(getResponse())).setVisible(true);
    }
}
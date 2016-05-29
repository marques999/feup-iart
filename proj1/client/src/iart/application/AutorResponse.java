package iart.application;

import iart.model.AutorTable;

import java.awt.Frame;
import java.util.ArrayList;

import javax.swing.JTextArea;

public class AutorResponse extends PrologResponse
{
    private final String queryRequest;
    private final ArrayList<String> queryResponse;

    public AutorResponse(final String queryMessage, final ArrayList<String> paramResponse)
    {
	queryRequest = queryMessage;
	queryResponse = paramResponse;
    }

    @Override
    public void writeOutput(final JTextArea textArea)
    {
	textArea.append(String.format(getFormat(), queryRequest, "Array"));
    }

    @Override
    public void showDialog(final Frame paramParent)
    {
	new TableView(paramParent, new AutorTable(queryResponse)).setVisible(true);
    }
}
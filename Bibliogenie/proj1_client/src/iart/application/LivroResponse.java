package iart.application;

import iart.model.LivroTable;

import java.awt.Frame;
import java.util.ArrayList;

import javax.swing.JTextArea;

public class LivroResponse extends PrologResponse
{
    private final String queryRequest;
    private final ArrayList<String> queryResponse;

    public LivroResponse(final String queryMessage, final ArrayList<String> paramResponse)
    {
	queryRequest = queryMessage;
	queryResponse = paramResponse;
    }

    @Override
    public void writeOutput(JTextArea textArea)
    {
	textArea.append(String.format(getFormat(), queryRequest, "Array"));
    }

    @Override
    public void showDialog(final Frame paramParent)
    {
	new TableView(paramParent, new LivroTable(queryResponse)).setVisible(true);
    }
}
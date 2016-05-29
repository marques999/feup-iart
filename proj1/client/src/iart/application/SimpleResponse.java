package iart.application;

import javax.swing.JTextArea;

public class SimpleResponse extends PrologResponse
{
    private final String queryRequest;
    private final String queryResponse;

    public SimpleResponse(final String queryMessage, final String paramResponse)
    {
	queryRequest = queryMessage;
	queryResponse = paramResponse;
    }

    @Override
    public void writeOutput(final JTextArea textArea)
    {
	textArea.append(String.format(getFormat(), queryRequest, queryResponse));
    }
}
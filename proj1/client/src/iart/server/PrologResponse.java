package iart.server;

import java.awt.Frame;

import javax.swing.JTextArea;

public abstract class PrologResponse
{
    private final String mRequest;
    private final String mResponse;

    public PrologResponse(final String queryRequest, final String queryResponse)
    {
	mRequest = queryRequest;
	mResponse = queryResponse;
    }

    private final String msgFormat = "\nQ: %s\nA: %s\n";

    protected String getRequest()
    {
	return mRequest;
    }

    protected String getResponse()
    {
	return mResponse;
    }

    protected String getFormat()
    {
	return msgFormat;
    }

    public abstract void writeOutput(final JTextArea textArea);

    public void showDialog(final Frame paramParent)
    {
    }
}
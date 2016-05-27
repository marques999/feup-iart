package iart.server;

import iart.model.StringUtils;
import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;
import java.net.URLConnection;
import java.text.Normalizer;

public class HttpRequest
{
    private boolean m_connected;

    public HttpRequest()
    {
	m_connected = false;
	m_address = null;
	m_error = null;
    }

    public boolean isConnected()
    {
	return m_connected;
    }

    public boolean connect(final String paramAddress, int paramPort)
    {
	if (m_connected)
	{
	    return true;
	}

	m_connected = false;

	if (paramAddress.startsWith("http://"))
	{
	    m_address = String.format("%s:%d/", paramAddress, paramPort);
	}
	else
	{
	    m_address = String.format("http://%s:%d/", paramAddress, paramPort);
	}

	final String responseMessage = sendRequest("hello");

	if (responseMessage != null && responseMessage.equals("no"))
	{
	    m_connected = true;
	}

	return m_connected;
    }

    private String m_address;
    private String m_error;

    public String getError()
    {
	return m_error;
    }

    public void disconnect(final String lastError)
    {
	m_connected = false;
	m_error = lastError;
    }

    public String sendQuery(final String queryMessage)
    {
	return StringUtils.generateRequest(queryMessage);
    }

    private URLConnection urlConnection = null;

    private String sendRequest(final String myRequest)
    {
	boolean exceptionThrown = false;

	try
	{
	    urlConnection = new URL(m_address + myRequest).openConnection();
	    urlConnection.setDoOutput(true);
	    urlConnection.connect();
	}
	catch (final IOException ex)
	{
	    disconnect(ex.getLocalizedMessage());
	    exceptionThrown = true;
	}

	if (urlConnection == null || exceptionThrown)
	{
	    return null;
	}

	final StringBuffer myResponse = new StringBuffer();

	try (final BufferedReader br = new BufferedReader(new InputStreamReader(urlConnection.getInputStream())))
	{
	    for (String inputLine = br.readLine(); inputLine != null; inputLine = br.readLine())
	    {
		myResponse.append(inputLine);
	    }
	}
	catch (final IOException ex)
	{
	    disconnect(ex.getLocalizedMessage());
	    exceptionThrown = true;
	}

	if (exceptionThrown)
	{
	    return null;
	}

	return myResponse.toString();
    }
}
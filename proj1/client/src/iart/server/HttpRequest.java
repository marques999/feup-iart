package iart.server;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.net.URL;
import java.net.URLConnection;
import java.text.Normalizer;

public class HttpRequest{

	private boolean m_connected;

	public HttpRequest() {
		m_connected = false;
		m_address = null;
		m_error = null;
	}

	public boolean isConnected() {
		return m_connected;
	}

	public boolean connect(final String paramAddress, int paramPort) {

		if (m_connected) {
			return true;
		}

		m_connected = false;

		if (paramAddress.startsWith("http://")) {
			m_address = String.format("%s:%d/", paramAddress, paramPort);
		}
		else {
			m_address = String.format("http://%s:%d/", paramAddress, paramPort);
		}

		final String responseMessage = sendRequest("hello");

		if (responseMessage != null && responseMessage.equals("no")) {
			m_connected = true;
		}

		return m_connected;
	}

	private String m_address;
	private String m_error;

	public String getError() {
		return m_error;
	}

	public void disconnect(final String lastError) {
		m_connected = false;
		m_error = lastError;
	}

	public String sendQuery(final String queryMessage) {

		if (!m_connected) {
			return null;
		}

		String s = queryMessage;
		s = Normalizer.normalize(s, Normalizer.Form.NFD);
		s = s.replaceAll("[\\p{InCombiningDiacriticalMarks}]", "");

		return sendRequest("query('" + s.toLowerCase() + "')");
	}

	private String sendRequest(final String myRequest) {

		final URLConnection urlConnection;

		try {
			urlConnection = new URL(m_address + myRequest).openConnection();
			urlConnection.setDoOutput(true);
			urlConnection.connect();
		}
		catch (IOException ex) {
			disconnect(ex.getLocalizedMessage());
			return null;
		}

		final StringBuilder myResponse = new StringBuilder();

		try (BufferedReader in = new BufferedReader(new InputStreamReader(urlConnection.getInputStream()))) {

			String inputLine;

			while ((inputLine = in.readLine()) != null) {
				myResponse.append(inputLine);
			}
		}
		catch (IOException ex) {
			disconnect(ex.getLocalizedMessage());
			return null;
		}

		return myResponse.toString();
	}
}
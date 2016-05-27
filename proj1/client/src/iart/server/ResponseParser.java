package iart.server;

public class ResponseParser
{
    private static ResponseParser responseParser;

    private ResponseParser()
    {
    }

    public static ResponseParser getInstance()
    {
	if (responseParser == null)
	{
	    responseParser = new ResponseParser();
	}

	return responseParser;
    }

    private final String msgFormat = "\nQ: %s\nA: %s\n";

    public final PrologResponse parse(final String queryMessage, final String serverResponse)
    {
	if (serverResponse.charAt(0) == '[')
	{
	    final String responseType = serverResponse.substring(1, 6);

	    if (responseType.equals("autor"))
	    {
		return new AutorResponse(queryMessage, serverResponse);
	    }
	    else if (responseType.equals("livro"))
	    {
		return new LivroResponse(queryMessage, serverResponse);
	    }
	    else
	    {
		return null;
	    }
	}
	else
	{
	    return new SimpleResponse(queryMessage, serverResponse);
	}
    }
}
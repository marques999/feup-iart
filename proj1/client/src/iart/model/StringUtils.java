package iart.model;

import java.text.Normalizer;
import java.util.ArrayList;
import java.util.Collections;
import java.util.List;

public class StringUtils
{
    public static String generateRequest(String originalString)
    {
	boolean questionForm = originalString.endsWith("?");

	originalString = Normalizer.normalize(originalString, Normalizer.Form.NFD);
	originalString = originalString.replaceAll("[\\p{InCombiningDiacriticalMarks}]", "");

	final String[] words = originalString.split("\\s+");
	final StringBuilder sb = new StringBuilder();

	sb.append("query([");

	for (int i = 0; i < words.length; i++)
	{
	    sb.append("'").append(capitalCase(words[i].replaceAll("[^\\w]", ""))).append("'");

	    if (i < words.length - 1)
	    {
		sb.append(", ");
	    }
	}

	if (questionForm)
	{
	    sb.append(", '?'");
	}

	sb.append("],[])");

	return sb.toString();
    }

    private static String capitalCase(final String originalString)
    {
	char firstCharacter = originalString.charAt(0);

	if (Character.isUpperCase(firstCharacter))
	{
	    return originalString.charAt(0) + originalString.substring(1).toLowerCase();
	}

	return originalString.toLowerCase();
    }

    public static List<String> splitResponse(String serverResponse)
    {
	int numberParenthesis = 0;
	int inputLength = serverResponse.length();
	int currentPosition = 0;

	final List<String> result = new ArrayList<>();

	for (int i = 0; i < inputLength; i++)
	{
	    char currentChar = serverResponse.charAt(i);

	    if (i == 0)
	    {
		if (currentChar == '[')
		{
		    currentPosition = i + 1;
		}
		else
		{
		    return Collections.singletonList(serverResponse);
		}
	    }

	    if (i == inputLength - 1 && currentChar != ']')
	    {
		return null;
	    }

	    if (currentChar == ',')
	    {
		if (numberParenthesis == 0)
		{
		    result.add(serverResponse.substring(currentPosition, i));
		    currentPosition = i + 1;
		}
	    }
	    else if (currentChar == '(')
	    {
		numberParenthesis++;
	    }
	    else if (currentChar == ')')
	    {
		numberParenthesis--;

		if (numberParenthesis < 0)
		{
		    return null;
		}
	    }
	}

	if (numberParenthesis > 0)
	{
	    return null;
	}

	result.add(serverResponse.substring(currentPosition, inputLength - 1));

	return result;
    }
}
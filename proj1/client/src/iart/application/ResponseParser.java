package iart.application;

import java.util.ArrayList;
import java.util.Collections;
import java.util.List;

public class ResponseParser {

    private static ResponseParser responseParser;

    private ResponseParser() {}

    public static ResponseParser getInstance() {

        if (responseParser == null) {
            responseParser = new ResponseParser();
        }

        return responseParser;
    }

    public void parseLivroResponse(final String serverResponse) {

        final List<String> processedQuery = split(serverResponse.trim());

        for (final String queryResult : processedQuery) {

            final ObjectLivro testeLivro = new ObjectLivro(queryResult);

            System.out.println(testeLivro.getId());
            System.out.println(testeLivro.getTitulo());
            System.out.println(testeLivro.getAutor());
            System.out.println(testeLivro.getAno());
            System.out.println(testeLivro.getGenero());
            System.out.println("-----------------------");
        }
    }

    public void parseAutorResponse(final String serverResponse) {

        final List<String> processedQuery = split(serverResponse.trim());

        for (final String queryResult : processedQuery) {

            final ObjectAutor testeAutor = new ObjectAutor(queryResult);

            System.out.println(testeAutor.getId());
            System.out.println(testeAutor.getNome());
            System.out.println(testeAutor.getAnoNascimento());
            System.out.println(testeAutor.getAnoMorte());
            System.out.println(testeAutor.getNacionalidade());
            System.out.println(testeAutor.getColeccao());
            System.out.println("-----------------------");
        }
    }

    private static List<String> split(String serverResponse) {

        int numberParenthesis = 0;
        int inputLength = serverResponse.length();
        int currentPosition = 0;

        final List<String> result = new ArrayList<>();

        for (int i = 0; i < inputLength; i++) {

            char currentChar = serverResponse.charAt(i);

            if (i == 0) {

                if (currentChar == '[') {
                    currentPosition = i + 1;
                }
                else {
                    return Collections.singletonList(serverResponse);
                }
            }

            if (i == inputLength - 1 && currentChar != ']') {
                return null;
            }

            if (currentChar == ',') {

                if (numberParenthesis == 0) {
                    result.add(serverResponse.substring(currentPosition, i));
                    currentPosition = i + 1;
                }
            }
            else if (currentChar == '(') {
                numberParenthesis++;
            }
            else if (currentChar == ')') {

                numberParenthesis--;

                if (numberParenthesis < 0) {
                    return null;
                }
            }
        }

        if (numberParenthesis > 0) {
            return null;
        }

        result.add(serverResponse.substring(currentPosition, inputLength - 1));

        return result;
    }
}
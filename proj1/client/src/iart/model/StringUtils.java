package iart.model;

import java.util.ArrayList;
import java.util.Collections;
import java.util.List;

class StringUtils {

    static List<String> split(String serverResponse) {

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

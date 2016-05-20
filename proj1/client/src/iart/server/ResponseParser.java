package iart.server;

public class ResponseParser {

    private static ResponseParser responseParser;

    private ResponseParser() {}

    public static ResponseParser getInstance() {

        if (responseParser == null) {
            responseParser = new ResponseParser();
        }

        return responseParser;
    }
}
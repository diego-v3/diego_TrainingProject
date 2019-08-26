public with sharing class constants {
    private static FINAL String thisString = String.valueOf(constants.class);
    private static FINAL List<String> thisStrings = thisString.split('[.]', 2);
    public static FINAL String NAMESPACE = thisStrings.size() > 1 ? thisStrings[0] : 'c';
    public static FINAL String NAMESPACE_API = NAMESPACE == 'c' ? '' : NAMESPACE + '__';
}
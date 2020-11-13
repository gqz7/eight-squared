//package com.company;

import java.text.MessageFormat;
import java.util.Scanner;

public static class CLI {

    final static Scanner scanner = new Scanner(System.in);

    public static float numberFloatQuestion(String question, int min, int max) {
        float inputValue = 0;

        question += MessageFormat.format("\n\nChoices ({0} <--> {1})\nFloat: ", min, max);

        while (true) {
            try {
                System.out.print(question);
                inputValue = scanner.nextFloat();
                scanner.nextLine(); //this is to grab the left over new-line char
                if (inputValue < min || inputValue > max) {
                    System.out.print(MessageFormat.format("\nWARNING\nYou did not enter a number in the range of {0} to {1}\n\n", min, max));
                } else {
                    break;
                }
            } catch (Exception e) {
                scanner.next();
                printDataErrMsg();
            }
        }
        return inputValue;
    };

    public static float numberFloatQuestion(String question) {
        float inputValue = 0;

        question += "\nFloat: ";

        while (true) {
            try {
                System.out.print(question);
                inputValue = scanner.nextFloat();
                scanner.nextLine(); //this is to grab the left over new-line char
                break;
            } catch (Exception e) {
                scanner.next();
                printDataErrMsg();
            }
        }
        return inputValue;
    };

    public static long numberLongQuestion(String question) {
        long inputValue = 0;

        question += "\nLong: ";

        while (true) {
            try {
                System.out.print(question);
                inputValue = scanner.nextLong();
                scanner.nextLine(); //this is to grab the left over new-line char
                break;
            } catch (Exception e) {
                scanner.next();
                printDataErrMsg();
            }
        }
        return inputValue;
    };

    public static long numberLongQuestion(String question, int min, int max) {
        long inputValue = 0;

        question += MessageFormat.format("\n\nChoices ({0} <--> {1})\nLong: ", min, max);

        while (true) {
            try {
                System.out.print(question);
                inputValue = scanner.nextLong();
                scanner.nextLine(); //this is to grab the left over new-line char
                if (inputValue < min || inputValue > max) {
                    System.out.print(MessageFormat.format("\nWARNING\nYou did not enter a number in the range of {0} to {1}\n\n", min, max));
                } else {
                    break;
                }
            } catch (Exception e) {
                scanner.next();
                printDataErrMsg();
            }
        }
        return inputValue;
    };

    public static byte numberByteQuestion(String question, int min, int max) {
        byte inputValue = 0;

        question += MessageFormat.format("\n\nChoices ({0} <--> {1})\nByte: ", min, max);

        while (true) {
            try {
                System.out.print(question);
                inputValue = scanner.nextByte();
                scanner.nextLine(); //this is to grab the left over new-line char
                if (inputValue < min || inputValue > max) {
                    System.out.print(MessageFormat.format("\nWARNING\nYou did not enter a number in the range of {0} to {1}\n\n", min, max));
                } else {
                    break;
                }
            } catch (Exception e) {
                scanner.next();
                printDataErrMsg();
            }
        }
        return inputValue;
    };

    public static byte numberByteQuestion(String question) {

        question += "\nByte: ";

        byte inputValue = 0;
        while (true) {
            try {
                System.out.print(question);
                inputValue = scanner.nextByte();
                scanner.nextLine(); //this is to grab the left over new-line char
                break;
            } catch (Exception e) {
                scanner.next();
                printDataErrMsg();
            }
        }
        return inputValue;
    };

    public static int numberIntQuestion(String question, int min, int max) {
        int inputValue = 0;

        question += MessageFormat.format("\n\nChoices ({0} <--> {1})\nInt: ", min, max);

        while (true) {
            try {
                System.out.print(question);
                inputValue = scanner.nextInt();
                scanner.nextLine(); //this is to grab the left over new-line char
                if (inputValue < min || inputValue > max) {
                    System.out.print(MessageFormat.format("\nWARNING\nYou did not enter a number in the range of {0} to {1}\n\n", min, max));
                } else {
                    break;
                }
            } catch (Exception e) {
                scanner.next();
                printDataErrMsg();
            }
        }
        return inputValue;
    };

    public static int numberIntQuestion(String question) {
        int inputValue = 0;

        question += "\nInt: ";

        while (true) {
            try {
                System.out.print(question);
                inputValue = scanner.nextInt();
                scanner.nextLine(); //this is to grab the left over new-line char
                break;
            } catch (Exception e) {
                scanner.next();
                printDataErrMsg();
            }
        }
        return inputValue;
    };

    public static String stringQuestion(String question) {
        String inputValue = "";

        question += "\nString: ";

        while (true) {
            try {
                System.out.print(question);
                inputValue = scanner.nextLine();
                if (inputValue.trim() == "") {
                    System.out.print("\nWARNING\nYou Can Not Enter An Empty String");
                } else {

                    break;
                }
            } catch (Exception e) {
                scanner.next();
                printDataErrMsg();
            }
        }

        return inputValue;
    };

    public static boolean yesOrNo (String question) {
        question += "\n( YES / NO )\nInput: ";
        String inputValue = "";

        while (true) {
            try {
                System.out.print(question);
                inputValue = scanner.nextLine();
                if (inputValue.trim() == "") {
                    System.out.print("\nWARNING\nYou Can Not Enter An Empty String");
                } else if (inputValue.toLowerCase().charAt(0) == 'y'){
                    return true;
                } else if (inputValue.toLowerCase().charAt(0) == 'n') {
                    return false;
                } else {
                    System.out.println("\nWARNING\nYou must answer Yes OR No");
                }
            } catch (Exception e) {
                scanner.next();
                printDataErrMsg();
            }
        }
    }

    private static void printDataErrMsg() {
        System.out.println("\nWARNING\nYou must enter the correct data type, try again...\n");
    }
}

package com.company.ChessLogic;

import com.company.CLI;
import com.company.DesktopActions;

import java.awt.*;


public class GameConfigure {

    public static Game createGame () {

        boolean useAutoClearing = CLI.yesOrNo("Would you like to use auto-clearing for this game?");
        if (useAutoClearing) {
            int [] mouseCoOrds = configureAutoClick();
            if (mouseCoOrds[0] == 0) return new Game();
            else return new Game(mouseCoOrds[0], mouseCoOrds[1]);
        } else return new Game();
    }

    public static int[] configureAutoClick () {

        Dimension screenSize = Toolkit.getDefaultToolkit().getScreenSize();
        int width = (int) screenSize.getWidth();
        int height = (int) screenSize.getHeight();
        String widthQuestion = "Select An X Value On Your Screen To Test";
        String heightQuestion = "Select An Y Value On Your Screen To Test";

        while (true) {
            int testX = CLI.numberIntQuestion(widthQuestion,1, width );
            int testY = CLI.numberIntQuestion(heightQuestion, 1, height );

            boolean testNow = CLI.yesOrNo("Move the mouse to (" + testX + ", " + testY + ") for testing?");
            if (testNow) {
                try {
                    DesktopActions.move(testX, testY);
                    boolean testConfirm = CLI.yesOrNo("Was this in the correct position, if not enter 'No' and you can re-enter X & Y");
                    if (testConfirm) return new int[] {testX, testY};
                }
                catch (AWTException e) {
                    System.out.println("There was a problem while testing");
                }
            } else {
                boolean quitNow = CLI.yesOrNo("Would you like to cancel this configuration, you will then not have the auto clearing feature");
                if (quitNow) return new int[] {0,0};
            }

        }



    }

    public static void welcomeMessage () {
//        System.out.println(" ______  __  __  ______  ______  ______  ");
//        System.out.println("/\\  ___\\/\\ \\_\\ \\/\\  ___\\/\\  ___\\/\\  ___\\ ");
//        System.out.println("\\ \\ \\___\\ \\  __ \\ \\  __\\\\ \\___  \\ \\___  \\");
//        System.out.println(" \\ \\_____\\ \\_\\ \\_\\ \\_____\\/\\_____\\/\\_____\\ ");
//        System.out.println("  \\/_____/\\/_/\\/_/\\/_____/\\/_____/\\/_____/");
        System.out.println("___________________________________\n");
        System.out.println("   ____ _              ");
        System.out.println("  / ___| |__   ___  ___ ___");
        System.out.println(" | |   | '_ \\ / _ \\/ __/ __|");
        System.out.println(" | |___| | | |  __/\\__ \\__ \\");
        System.out.println("  \\____|_| |_|\\___||___/___/");
        System.out.println("\n___________________________________");
    }
}

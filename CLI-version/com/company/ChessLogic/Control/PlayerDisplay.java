package com.company.ChessLogic.Control;

import com.company.ChessLogic.Enviorment.Board;
import com.company.DesktopActions;

import java.awt.*;
import java.util.concurrent.TimeUnit;

public class PlayerDisplay {
    protected static void printCurrentGame (Board gameBoard, boolean isWhite, int turn) {
        System.out.println("\n________________________________________________\n");
        System.out.println("\t\tTURN: " + turn + "\t\tMOVING: " + (isWhite ? "WHITE" : "BLACK") +"\n");
        System.out.println(gameBoard.displayBoard(isWhite));
        System.out.println("________________________________________________\n");
    }

    protected static void clearScreen(int clearBtnX, int clearBtnY) {
        try {
            DesktopActions.click(clearBtnX, clearBtnY);
            TimeUnit.MILLISECONDS.sleep(200);
        } catch (AWTException | InterruptedException e) {
            System.out.println(e);
        }
    }
}

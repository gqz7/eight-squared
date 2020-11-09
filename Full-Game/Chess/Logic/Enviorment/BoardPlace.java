package com.company.Chess.Logic.Enviorment;

import com.company.Chess.Logic.Pieces.Piece;

public class BoardPlace {
    public int row;
    public int columnInt;
    public char columnChar;
    public String notation;
    public Piece holding;

    public BoardPlace( int row, int columnInt) {
        this.row = row;
        this.columnInt = columnInt;
        columnChar = mapNumToAlpha(columnInt);
        notation = Character.toString(columnChar) + row;
    }

    private static Character mapNumToAlpha (int num) {
        switch (num) {
            case 1:
                return 'A';
            case 2:
                return 'B';
            case 3:
                return 'C';
            case 4:
                return 'D';
            case 5:
                return 'E';
            case 6:
                return 'F';
            case 7:
                return 'G';
            case 8:
                return 'H';
            default:
                System.out.println("\n********\nAn invalid number was given to (mapNumToAlpha in Board)\n*****\n");
                return 'I';
        }
    }

    public BoardPlace getTranslatedSpace ( int x, int y ) {
        int translatedCol = columnInt+x;
        int translatedRow = row+y;
        if ( translatedCol < 8 && translatedCol > 1 || translatedRow < 8 && translatedRow > 1) {
            return new BoardPlace(translatedRow, translatedCol);
        }
        return null;
    }

    public boolean hasEnemy ( boolean isWhite ){
        if (holding == null) return false;
        boolean isEnemySpace = (isWhite && !holding.isWhite) || (!isWhite && holding.isWhite);
        return isEnemySpace;
    }

    public boolean isEmpty () {
        return holding == null;
    }

    @Override
    public String toString() {
        if (holding == null)
            return "[]";
        return holding.toString();
    }
}

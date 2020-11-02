package com.company;

public class BoardPlace {
    public int row;
    public int columnInt;
    public char columnChar;
    public String notation;

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

    @Override
    public String toString() {
        return notation;
    }
}

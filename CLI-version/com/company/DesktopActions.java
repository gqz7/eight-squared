package com.company;

import java.awt.*;
import java.awt.event.InputEvent;

public class DesktopActions {
    public static void click(int x, int y) throws AWTException{
        Robot bot = new Robot();
        bot.mouseMove(x, y);
        bot.mousePress(InputEvent.BUTTON1_MASK);
        bot.mouseRelease(InputEvent.BUTTON1_MASK);
    }

    public static void move(int x, int y) throws AWTException{
        Robot bot = new Robot();
        bot.mouseMove(x, y);
    }
}

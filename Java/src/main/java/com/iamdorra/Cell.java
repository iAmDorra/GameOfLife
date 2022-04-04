package com.iamdorra;

class Cell {
    private boolean isAlive;

    Cell(boolean isAlive) {

        this.isAlive = isAlive;
    }

    boolean isAlive() {
        return isAlive;
    }

    void setIsAlive(boolean b) {
        isAlive = b;
    }
}

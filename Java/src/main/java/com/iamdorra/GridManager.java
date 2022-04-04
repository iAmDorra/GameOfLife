package com.iamdorra;

class GridManager {
    Cell[][] getNewState(Cell[][] grid) {
        var newGrid = new Cell[grid.length][grid[0].length];
        for (int i = 0; i < grid.length; i++) {
            for (int j = 0; j < grid[0].length; j++) {
                newGrid[i][j] = new Cell(false);
            }
        }

        for (int i = 0; i < grid.length; i++) {
            for (int j = 0; j < grid[0].length; j++) {
                int nbNeighbours = countNeighbours(grid, i, j);
                if (nbNeighbours == 2) {
                    newGrid[i][j].setIsAlive(grid[i][j].isAlive());
                } else if (nbNeighbours == 3) {
                    newGrid[i][j].setIsAlive(true);
                }
            }
        }
        return newGrid;
    }

    int countNeighbours(Cell[][] grid, int i, int j) {
        int nbNeighbours = 0;
        if (isAliveNeighbour(grid, i - 1, j - 1)) {
            nbNeighbours++;
        }
        if (isAliveNeighbour(grid, i, j - 1)) {
            nbNeighbours++;
        }
        if (isAliveNeighbour(grid, i + 1, j - 1)) {
            nbNeighbours++;
        }
        if (isAliveNeighbour(grid, i - 1, j)) {
            nbNeighbours++;
        }
        if (isAliveNeighbour(grid, i + 1, j)) {
            nbNeighbours++;
        }
        if (isAliveNeighbour(grid, i - 1, j + 1)) {
            nbNeighbours++;
        }
        if (isAliveNeighbour(grid, i, j + 1)) {
            nbNeighbours++;
        }
        if (isAliveNeighbour(grid, i + 1, j + 1)) {
            nbNeighbours++;
        }

        return nbNeighbours;
    }

    private static boolean isAliveNeighbour(Cell[][] grid, int i, int j) {
        return j >= 0 && j < grid[0].length &&
                i >= 0 && i < grid.length &&
                grid[i][j].isAlive();
    }
}

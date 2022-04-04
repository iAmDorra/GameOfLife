package com.iamdorra;

import org.junit.jupiter.api.Test;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertFalse;
import static org.junit.jupiter.api.Assertions.assertTrue;

public class GridManagerShould {
    @Test
    void not_change_cells_if_all_cells_are_dead() {
        GridManager gridManager = new GridManager();
        var grid = new Cell[1][1];
        var newGrid = gridManager.getNewState(grid);

        assertFalse(newGrid[0][0].isAlive());
    }

    @Test
    void not_kill_cell_if_it_has_two_neighbours() {
        GridManager gridManager = new GridManager();
        Cell[][] grid = initializeGrid(3, 3);
        grid[0][2].setIsAlive(true);
        grid[1][1].setIsAlive(true);
        grid[2][0].setIsAlive(true);

        var newGrid = gridManager.getNewState(grid);

        assertTrue(newGrid[1][1].isAlive());
    }

    @Test
    void kill_cell_if_it_has_less_than_two_neighbours() {
        GridManager gridManager = new GridManager();
        Cell[][] grid = initializeGrid(2, 4);
        grid[1][0].setIsAlive(true);
        grid[1][1].setIsAlive(true);
        grid[1][2].setIsAlive(true);

        var newGrid = gridManager.getNewState(grid);

        assertFalse(newGrid[1][0].isAlive());
        assertFalse(newGrid[1][2].isAlive());
    }

    @Test
    void alive_cell_if_it_has_three_neighbours() {
        GridManager gridManager = new GridManager();
        Cell[][] grid = initializeGrid(2, 3);
        grid[0][1].setIsAlive(true);
        grid[1][0].setIsAlive(true);
        grid[1][1].setIsAlive(true);

        var newGrid = gridManager.getNewState(grid);

        assertTrue(newGrid[0][0].isAlive());
    }

    @Test
    void kill_cell_if_it_has_more_than_three_neighbours() {
        GridManager gridManager = new GridManager();
        Cell[][] grid = initializeGrid(4, 3);
        grid[0][2].setIsAlive(true);
        grid[1][1].setIsAlive(true);
        grid[2][0].setIsAlive(true);
        grid[2][1].setIsAlive(true);
        grid[2][2].setIsAlive(true);

        var newGrid = gridManager.getNewState(grid);

        assertFalse(newGrid[1][1].isAlive());
    }

    @Test
    void count_neighbours_of_cell() {
        GridManager gridManager = new GridManager();
        final int h = 2;
        final int w = 3;
        Cell[][] grid = initializeGrid(h, w);
        grid[0][1].setIsAlive(true);
        grid[1][0].setIsAlive(true);
        grid[1][1].setIsAlive(true);

        int nbNeighbours = gridManager.countNeighbours(grid, 0, 1);

        assertEquals(nbNeighbours, 2);
    }

    private static Cell[][] initializeGrid(int h, int w) {
        var grid = new Cell[h][w];
        for (int i = 0; i < grid.length; i++) {
            for (int j = 0; j < grid[0].length; j++) {
                grid[i][j] = new Cell(false);
            }
        }

        return grid;
    }
}

package com.iamdorra.gameoflife

import org.assertj.core.api.Assertions.assertThat
import org.junit.jupiter.api.Test

internal class GridManagerTest {
    @Test
    fun  `should not change cells if all cells are dead`()
    {
        val gridManager = GridManager()
        val grid = initializeGrid(3, 3);
        val newGrid = gridManager.getNewState(grid);

        assertThat(newGrid[0][0].alive).isFalse();
    }

    @Test
    fun  `should not kill cell if it has two neighbours`()
    {
        val gridManager = GridManager()

        val grid = initializeGrid(3, 3);
        grid[0][2].alive = true;
        grid[1][1].alive = true;
        grid[2][0].alive = true;

        val newGrid = gridManager.getNewState(grid);

        assertThat(newGrid[1][1].alive).isTrue();
    }

    @Test
    fun  `should kill cell if it has less than two neighbours`()
    {
        val gridManager = GridManager()

        val grid = initializeGrid(2, 4);
        grid[1][0].alive = true;
        grid[1][1].alive = true;
        grid[1][2].alive = true;

        val newGrid = gridManager.getNewState(grid);

        assertThat(newGrid[1][0].alive).isFalse();
        assertThat(newGrid[1][2].alive).isFalse();
    }

    @Test
    fun  `should alive cell if it has three neighbours`()
    {
        val gridManager = GridManager()

        val grid = initializeGrid(2, 3);
        grid[0][1].alive = true;
        grid[1][0].alive = true;
        grid[1][1].alive = true;

        val newGrid = gridManager.getNewState(grid);

        assertThat(newGrid[0][0].alive).isTrue();
    }

    @Test
    fun  `should kill cell if it has more than three neighbours`()
    {
        val gridManager = GridManager()

        val grid = initializeGrid(4, 3);
        grid[0][2].alive = true;
        grid[1][1].alive = true;
        grid[2][0].alive = true;
        grid[2][1].alive = true;
        grid[2][2].alive = true;

        val newGrid = gridManager.getNewState(grid);

        assertThat(newGrid[1][1].alive).isFalse();
    }

    @Test
    fun  `should count neighbours of cell`()
    {
        val gridManager = GridManager()

        val h = 2;
        val w = 3;
        val grid = initializeGrid(h, w);
        grid[0][1].alive = true;
        grid[1][0].alive = true;
        grid[1][1].alive = true;

        val nbNeighbours = gridManager.countNeighbours(grid, 0, 1);

        assertThat(nbNeighbours).isEqualTo(2);
    }

    fun initializeGrid(h: Int, w: Int): List<List<Cell>>
    {
        return (0..w).map { (0..h).map { Cell(false) } }
    }
}
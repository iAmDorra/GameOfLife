package com.iamdorra.gameoflife

internal class GridManager
{
    fun getNewState(grid: List<List<Cell>>): List<List<Cell>>
    {
        var newGrid = mutableListOf<List<Cell>>()
        (0..grid.size).forEach {
            val cells = mutableListOf<Cell>()
            (0..grid[0].size).forEach {
                cells.add(Cell(false))
            }
            newGrid.add(cells)
        }
        (0..grid.size).forEach { i ->
            (0..grid[0].size).forEach { j ->
                var nbNeighbours = countNeighbours(grid, i, j)
                if (nbNeighbours == 2)
                {
                    newGrid[i][j].alive = grid[i][j].alive
                }
                else if (nbNeighbours == 3)
                {
                    newGrid[i][j].alive = true
                }
            }
        }

        return newGrid
    }

    fun countNeighbours(grid: List<List<Cell>>, i: Int, j: Int): Int
    {
        var nbNeighbours = 0
        if (isAliveNeighbour(grid, i - 1, j - 1))
        {
            nbNeighbours++
        }
        if (isAliveNeighbour(grid, i, j - 1))
        {
            nbNeighbours++
        }
        if (isAliveNeighbour(grid, i + 1, j - 1))
        {
            nbNeighbours++
        }
        if (isAliveNeighbour(grid, i - 1, j))
        {
            nbNeighbours++
        }
        if (isAliveNeighbour(grid, i + 1, j))
        {
            nbNeighbours++
        }
        if (isAliveNeighbour(grid, i - 1, j + 1))
        {
            nbNeighbours++
        }
        if (isAliveNeighbour(grid, i, j + 1))
        {
            nbNeighbours++
        }
        if (isAliveNeighbour(grid, i + 1, j + 1))
        {
            nbNeighbours++
        }

        return nbNeighbours
    }

    fun isAliveNeighbour(grid: List<List<Cell>>, i: Int, j: Int): Boolean
    {
        return j >= 0 &&
                j < grid[0].size &&
                i >= 0 &&
                i < grid.size &&
                grid[i][j].alive
    }
}

class Cell(var alive: Boolean)
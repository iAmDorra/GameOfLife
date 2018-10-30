import Cell from './Cell';

function isAliveNeighbour(grid, i, j)
{
    return j >= 0 &&
        j < grid[0].length &&
        i >= 0 &&
        i < grid.length &&
        grid[i][j].isAlive;
}

export default class GridManager
{
    getNewState(grid)
    {
        let newGrid = [];
        
        for (let i = 0; i < grid.length; i++)
        {
            newGrid[i] = [];
            for (let j = 0; j < grid[0].length; j++)
            {
                newGrid[i][j] = new Cell(false);
            }
        }

        for (let i = 0; i < grid.length; i++)
        {
            for (let j = 0; j < grid[0].length; j++)
            {
                let nbNeighbours = this.countNeighbours(grid, i, j);
                if (nbNeighbours === 2)
                {
                    newGrid[i][j].isAlive = grid[i][j].isAlive;
                }
                else if (nbNeighbours === 3)
                {
                    newGrid[i][j].isAlive = true;
                }
            }
        }
        return newGrid;
    }

    countNeighbours(grid, i, j)
    {
        let nbNeighbours = 0;
        if (isAliveNeighbour(grid, i - 1, j - 1))
        {
            nbNeighbours++;
        }
        if (isAliveNeighbour(grid, i, j - 1))
        {
            nbNeighbours++;
        }
        if (isAliveNeighbour(grid, i + 1, j - 1))
        {
            nbNeighbours++;
        }
        if (isAliveNeighbour(grid, i - 1, j))
        {
            nbNeighbours++;
        }
        if (isAliveNeighbour(grid, i + 1, j))
        {
            nbNeighbours++;
        }
        if (isAliveNeighbour(grid, i - 1, j + 1))
        {
            nbNeighbours++;
        }
        if (isAliveNeighbour(grid, i, j + 1))
        {
            nbNeighbours++;
        }
        if (isAliveNeighbour(grid, i + 1, j + 1))
        {
            nbNeighbours++;
        }
        return nbNeighbours;
    }
}

namespace GameOfLife
{
    public class GridManager
    {
        public Cell[,] GetNewState(Cell[,] grid)
        {
            var newGrid = new Cell[grid.GetLength(0), grid.GetLength(1)];
            for (int i = 0; i < grid.GetLength(0); i++)
            {
                for (int j = 0; j < grid.GetLength(1); j++)
                {
                    newGrid[i, j] = new Cell(false);
                }
            }

            for (int i = 0; i < grid.GetLength(0); i++)
            {
                for (int j = 0; j < grid.GetLength(1); j++)
                {
                    int nbNeighbours = CountNeighbours(grid, i, j);
                    if (nbNeighbours == 2)
                    {
                        newGrid[i, j].IsAlive = grid[i, j].IsAlive;
                    }
                    else if (nbNeighbours == 3)
                    {
                        newGrid[i, j].IsAlive = true;
                    }
                }
            }
            return newGrid;
        }

        public int CountNeighbours(Cell[,] grid, int i, int j)
        {
            int nbNeighbours = 0;
            if (IsAliveNeighbour(grid, i - 1, j - 1))
            {
                nbNeighbours++;
            }
            if (IsAliveNeighbour(grid, i, j - 1))
            {
                nbNeighbours++;
            }
            if (IsAliveNeighbour(grid, i + 1, j - 1))
            {
                nbNeighbours++;
            }
            if (IsAliveNeighbour(grid, i - 1, j))
            {
                nbNeighbours++;
            }
            if (IsAliveNeighbour(grid, i + 1, j))
            {
                nbNeighbours++;
            }
            if (IsAliveNeighbour(grid, i - 1, j + 1))
            {
                nbNeighbours++;
            }
            if (IsAliveNeighbour(grid, i, j + 1))
            {
                nbNeighbours++;
            }
            if (IsAliveNeighbour(grid, i + 1, j + 1))
            {
                nbNeighbours++;
            }

            return nbNeighbours;
        }

        private static bool IsAliveNeighbour(Cell[,] grid, int i, int j)
        {
            return j >= 0 &&
                j < grid.GetLength(1) &&
                i >= 0 &&
                i < grid.GetLength(0) &&
                grid[i, j].IsAlive;
        }
    }
}
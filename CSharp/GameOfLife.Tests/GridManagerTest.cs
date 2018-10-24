using NFluent;
using Xunit;

namespace GameOfLife.Tests
{
    public class UnitTest1
    {
        [Fact]
        public void Should_not_change_cells_if_all_cells_are_dead()
        {
            GridManager gridManager = new GridManager();
            var grid = new Cell[1, 1];
            var newGrid = gridManager.GetNewState(grid);

            Check.That(newGrid[0, 0].IsAlive).IsFalse();
        }

        [Fact]
        public void Should_not_kill_cell_if_it_has_two_neighbours()
        {
            GridManager gridManager = new GridManager();

            Cell[,] grid = InitializeGrid(3, 3);
            grid[0, 2].IsAlive = true;
            grid[1, 1].IsAlive = true;
            grid[2, 0].IsAlive = true;

            var newGrid = gridManager.GetNewState(grid);

            Check.That(newGrid[1, 1].IsAlive).IsTrue();
        }

        [Fact]
        public void Should_kill_cell_if_it_has_less_than_two_neighbours()
        {
            GridManager gridManager = new GridManager();

            Cell[,] grid = InitializeGrid(2, 4);
            grid[1, 0].IsAlive = true;
            grid[1, 1].IsAlive = true;
            grid[1, 2].IsAlive = true;

            var newGrid = gridManager.GetNewState(grid);

            Check.That(newGrid[1, 0].IsAlive).IsFalse();
            Check.That(newGrid[1, 2].IsAlive).IsFalse();
        }

        [Fact]
        public void Should_alive_cell_if_it_has_three_neighbours()
        {
            GridManager gridManager = new GridManager();

            Cell[,] grid = InitializeGrid(2, 3);
            grid[0, 1].IsAlive = true;
            grid[1, 0].IsAlive = true;
            grid[1, 1].IsAlive = true;

            var newGrid = gridManager.GetNewState(grid);

            Check.That(newGrid[0, 0].IsAlive).IsTrue();
        }

        [Fact]
        public void Should_kill_cell_if_it_has_more_than_three_neighbours()
        {
            GridManager gridManager = new GridManager();

            Cell[,] grid = InitializeGrid(4, 3);
            grid[0, 2].IsAlive = true;
            grid[1, 1].IsAlive = true;
            grid[2, 0].IsAlive = true;
            grid[2, 1].IsAlive = true;
            grid[2, 2].IsAlive = true;

            var newGrid = gridManager.GetNewState(grid);

            Check.That(newGrid[1, 1].IsAlive).IsFalse();
        }

        [Fact]
        public void Should_count_neighbours_of_cell()
        {
            GridManager gridManager = new GridManager();

            const int h = 2;
            const int w = 3;
            Cell[,] grid = InitializeGrid(h, w);
            grid[0, 1].IsAlive = true;
            grid[1, 0].IsAlive = true;
            grid[1, 1].IsAlive = true;

            int nbNeighbours = gridManager.CountNeighbours(grid, 0, 1);

            Check.That(nbNeighbours).IsEqualTo(2);
        }

        private static Cell[,] InitializeGrid(int h, int w)
        {
            var grid = new Cell[h, w];
            for (int i = 0; i < grid.GetLength(0); i++)
            {
                for (int j = 0; j < grid.GetLength(1); j++)
                {
                    grid[i, j] = new Cell(false);
                }
            }

            return grid;
        }
    }
}

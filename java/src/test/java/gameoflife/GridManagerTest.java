package gameoflife;

import org.assertj.core.api.Assertions;
import org.junit.Test;

public class GridManagerTest {

    @Test
    public void should_not_change_cells_if_all_cells_are_dead() {
        GridManager gridManager = new GridManager();
        GridManager.Cell[][] grid = new GridManager.Cell[1][1];
        GridManager.Cell[][] newGrid = gridManager.___getNewState(grid);

        Assertions.assertThat(newGrid[0][0].isAlive).isFalse();
    }

    @Test
    public void should_not_kill_cell_if_it_has_two_neighbours() {
        GridManager gridManager = new GridManager();

        GridManager.Cell[][] grid = initializeGrid(3, 3);
        grid[0][2].isAlive = true;
        grid[1][1].isAlive = true;
        grid[2][0].isAlive = true;

        GridManager.Cell[][] newGrid = gridManager.___getNewState(grid);

        Assertions.assertThat(newGrid[1][1].isAlive).isTrue();
    }

    @Test
    public void should_kill_cell_if_it_has_less_than_two_neighbours() {
        GridManager gridManager = new GridManager();

        GridManager.Cell[][] grid = initializeGrid(2, 4);
        grid[1][0].isAlive = true;
        grid[1][1].isAlive = true;
        grid[1][2].isAlive = true;

        GridManager.Cell[][] newGrid = gridManager.___getNewState(grid);

        Assertions.assertThat(newGrid[1][0].isAlive).isFalse();
        Assertions.assertThat(newGrid[1][2].isAlive).isFalse();
    }

    @Test
    public void should_alive_cell_if_it_has_three_neighbours() {
        GridManager gridManager = new GridManager();

        GridManager.Cell[][] grid = initializeGrid(2, 3);
        grid[0][1].isAlive = true;
        grid[1][0].isAlive = true;
        grid[1][1].isAlive = true;

        GridManager.Cell[][] newGrid = gridManager.___getNewState(grid);

        Assertions.assertThat(newGrid[0][0].isAlive).isTrue();
    }

    @Test
    public void should_kill_cell_if_it_has_more_than_three_neighbours() {
        GridManager gridManager = new GridManager();

        GridManager.Cell[][] grid = initializeGrid(4, 3);
        grid[0][2].isAlive = true;
        grid[1][1].isAlive = true;
        grid[2][0].isAlive = true;
        grid[2][1].isAlive = true;
        grid[2][2].isAlive = true;

        GridManager.Cell[][] newGrid = gridManager.___getNewState(grid);

        Assertions.assertThat(newGrid[1][1].isAlive).isFalse();
    }

    @Test
    public void should_count_neighbours_of_cell() {
        GridManager gridManager = new GridManager();

        int h = 2;
        int w = 3;
        GridManager.Cell[][] grid = initializeGrid(h, w);
        grid[0][1].isAlive = true;
        grid[1][0].isAlive = true;
        grid[1][1].isAlive = true;

        int nbNeighbours = gridManager.countNeighbours(grid, null, 0, 1);

        Assertions.assertThat(nbNeighbours).isEqualTo(2);
    }


    private static GridManager.Cell[][] initializeGrid(int h, int w) {
        GridManager.Cell[][] grid = new GridManager.Cell[h][w];
        for (int i = 0; i < grid.length; i++) {
            for (int j = 0; j < grid[0].length; j++) {
                GridManager gridManager = new GridManager();
                grid[i][j] = gridManager.new Cell(false);
            }
        }

        return grid;
    }
}

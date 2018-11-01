package GameOfLife

import "testing"

func InitNewGrid(height int, width int) [][]Cell {
	newGrid := make([][]Cell, height)

	for i := 0; i < height; i++ {
		newGrid[i] = make([]Cell, width)
		for j := 0; j < width; j++ {
			newGrid[i][j] = Cell{isAlive: false}
		}
	}

	return newGrid
}

func Test_Should_not_change_cells_if_all_cells_are_dead(t *testing.T) {
	grid := InitNewGrid(1, 1)
	newGrid := GetNewState(grid)

	if newGrid[0][0].isAlive {
		t.Fail()
	}
}

func Test_Should_not_kill_cell_if_it_has_two_neighbours(t *testing.T) {
	grid := InitNewGrid(3, 3)
	grid[0][2].isAlive = true
	grid[1][1].isAlive = true
	grid[2][0].isAlive = true

	newGrid := GetNewState(grid)

	if !newGrid[1][1].isAlive {
		t.Fail()
	}

}

func Test_Should_kill_cell_if_it_has_more_than_three_neighbours(t *testing.T) {
	grid := InitNewGrid(4, 3)
	grid[0][2].isAlive = true
	grid[1][1].isAlive = true
	grid[2][0].isAlive = true
	grid[2][1].isAlive = true
	grid[2][2].isAlive = true

	newGrid := GetNewState(grid)

	if newGrid[1][1].isAlive {
		t.Fail()
	}
}

func Test_Should_count_neighbours_of_cell(t *testing.T) {
	grid := InitNewGrid(2, 3)
	grid[0][1].isAlive = true
	grid[1][0].isAlive = true
	grid[1][1].isAlive = true

	nbNeighbours := CountNeighbours(grid, 0, 1)

	if nbNeighbours != 2 {
		t.Fail()
	}
}

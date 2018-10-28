package GameOfLife

import "testing"

func Init_new_grid(height int, width int) [][]Cell {
	newGrid := make([][]Cell, height)

	for i := 0; i < height; i++ {
		newGrid[i] = make([]Cell, width)
		for j := 0; j < width; j++ {
			newGrid[i][j] = Cell{isAlive: false}
		}
	}

	return newGrid
}

func Should_not_change_cells_if_all_cells_are_dead(t *testing.T) {
	grid := Init_new_grid(1, 1)
	newGrid := GetNewState(grid)

	if newGrid[0][0].isAlive {
		t.Fail()
	}
}

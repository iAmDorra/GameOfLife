package GameOfLife

type Cell struct {
	isAlive bool
}

func GetNewState(grid [][]Cell) [][]Cell {
	gridWidth := len(grid[0])
	gridHeight := len(grid)

	newGrid := make([][]Cell, gridHeight)

	for i := 0; i < gridHeight; i++ {
		newGrid[i] = make([]Cell, gridWidth)
		for j := 0; j < gridWidth; j++ {
			newGrid[i][j] = Cell{isAlive: false}
		}
	}

	for i := 0; i < gridHeight; i++ {
		for j := 0; j < gridWidth; j++ {
			nbNeighbours := CountNeighbours(grid, i, j)
			if nbNeighbours == 2 {
				newGrid[i][j].isAlive = grid[i][j].isAlive
			} else if nbNeighbours == 3 {
				newGrid[i][j].isAlive = true
			}
		}
	}

	return newGrid
}

func CountNeighbours(grid [][]Cell, i, j int) int {
	nbNeighbours := 0

	if IsAliveNeighbour(grid, i - 1, j - 1) {
		nbNeighbours++
	}
	if IsAliveNeighbour(grid, i, j - 1) {
		nbNeighbours++
	}
	if IsAliveNeighbour(grid, i + 1, j - 1) {
		nbNeighbours++
	}
	if IsAliveNeighbour(grid, i - 1, j) {
		nbNeighbours++
	}
	if IsAliveNeighbour(grid, i + 1, j) {
		nbNeighbours++
	}
	if IsAliveNeighbour(grid, i - 1, j + 1) {
		nbNeighbours++
	}
	if IsAliveNeighbour(grid, i, j + 1) {
		nbNeighbours++
	}
	if IsAliveNeighbour(grid, i + 1, j + 1) {
		nbNeighbours++
	}

	return nbNeighbours
}

func IsAliveNeighbour(grid [][]Cell, i, j int) bool {
	return j >= 0 &&
		j < len(grid[0]) &&
		i >= 0 &&
		i < len(grid) &&
		grid[i][j].isAlive

}

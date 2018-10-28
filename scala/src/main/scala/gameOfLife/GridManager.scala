package gameOfLife

class GridManager {

  def GetNewState(grid: Array[Array[Cell]]): Array[Array[Cell]] = {
    var newGrid = Array.ofDim[Cell](grid.length, grid(0).length)
    for (i <- 0 until grid.length) {
      for (j <- 0 until grid(0).length) {
        newGrid(i)(j) = new Cell(false);
      }
    }

    for (i <- 0 until grid.length) {
      for (j <- 0 until grid(0).length) {
        var nbNeighbours: Int = CountNeighbours(grid, i, j);
        if (nbNeighbours == 2) {
          newGrid(i)(j).isAlive = grid(i)(j).isAlive;
        }
        else if (nbNeighbours == 3) {
          newGrid(i)(j).isAlive = true;
        }
      }
    }
    return newGrid;
  }

  def CountNeighbours(grid: Array[Array[Cell]], i: Int, j: Int): Int = {
    import GridManager._

    var nbNeighbours: Int = 0;
    if (isAliveNeighbour(grid, i - 1, j - 1)) {
      nbNeighbours += 1;
    }
    if (isAliveNeighbour(grid, i, j - 1)) {
      nbNeighbours += 1;
    }
    if (isAliveNeighbour(grid, i + 1, j - 1)) {
      nbNeighbours += 1;
    }
    if (isAliveNeighbour(grid, i - 1, j)) {
      nbNeighbours += 1;
    }
    if (isAliveNeighbour(grid, i + 1, j)) {
      nbNeighbours += 1;
    }
    if (isAliveNeighbour(grid, i - 1, j + 1)) {
      nbNeighbours += 1;
    }
    if (isAliveNeighbour(grid, i, j + 1)) {
      nbNeighbours += 1;
    }
    if (isAliveNeighbour(grid, i + 1, j + 1)) {
      nbNeighbours += 1;
    }

    return nbNeighbours;
  }

}

object GridManager {
  def isAliveNeighbour(grid: Array[Array[Cell]], i: Int, j: Int): Boolean = {
    return j >= 0 &&
      j < grid(0).length &&
      i >= 0 &&
      i < grid.length &&
      grid(i)(j).isAlive;
  }
}

package gameOfLife

import org.scalatest._

class GridManagerSpec extends FlatSpec with Matchers {
  "The GridManager" should "not change cells if all cells are dead" in {
    var gridManager: GridManager = new GridManager();
    var grid = Array.ofDim[Cell](1, 1);
    var newGrid = gridManager.GetNewState(grid);

    newGrid(0)(0).isAlive shouldEqual false;
  }

  it should "not kill cell if it has two neighbours" in {
    var gridManager = new GridManager();

    var grid = InitializeGrid(3, 3);
    grid(0)(2).isAlive = true;
    grid(1)(1).isAlive = true;
    grid(2)(0).isAlive = true;

    var newGrid = gridManager.GetNewState(grid);

    newGrid(1)(1).isAlive shouldEqual true;
  }

  it should "kill cell if it has less than two neighbours" in {
    var gridManager = new GridManager();

    var grid = InitializeGrid(2, 4);
    grid(1)(0).isAlive = true;
    grid(1)(1).isAlive = true;
    grid(1)(2).isAlive = true;

    var newGrid = gridManager.GetNewState(grid);

    newGrid(1)(0).isAlive shouldEqual false;
    newGrid(1)(2).isAlive shouldEqual false;
  }

  it should "alive cell if it has three neighbours" in {
    var gridManager = new GridManager();

    var grid = InitializeGrid(2, 3);
    grid(0)(1).isAlive = true;
    grid(1)(0).isAlive = true;
    grid(1)(1).isAlive = true;

    var newGrid = gridManager.GetNewState(grid);

    newGrid(0)(0).isAlive shouldEqual true;
  }

  it should "should kill cell if it has more than three neighbours" in {
    var gridManager = new GridManager();

    var grid = InitializeGrid(4, 3);
    grid(0)(2).isAlive = true;
    grid(1)(1).isAlive = true;
    grid(2)(0).isAlive = true;
    grid(2)(1).isAlive = true;
    grid(2)(2).isAlive = true;

    var newGrid = gridManager.GetNewState(grid);

    newGrid(1)(1).isAlive shouldEqual false;
  }

  it should "should count neighbours of cell" in {
    var gridManager = new GridManager();

    val h: Int = 2;
    val w: Int = 3;
    var grid = InitializeGrid(h, w);
    grid(0)(1).isAlive = true;
    grid(1)(0).isAlive = true;
    grid(1)(1).isAlive = true;

    var nbNeighbours = gridManager.CountNeighbours(grid, 0, 1);

    nbNeighbours shouldEqual 2;
  }

}

object InitializeGrid {
  def apply(h: Int, w: Int): Array[Array[Cell]] = {
    var grid = Array.ofDim[Cell](h, w);
    for (i <- 0 until grid.length) {
      for (j <- 0 until grid(0).length) {
        grid(i)(j) = new Cell(false);
      }
    }

    return grid;
  }
}


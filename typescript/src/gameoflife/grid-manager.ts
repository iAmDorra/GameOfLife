import Cell from "./cell";

export default class GridManager {

    public getNewState(grid: Cell[][]): Cell[][] {
        var newGrid: Cell[][] = new Array<Cell[]>(grid.length);
        for (let i = 0; i < grid.length; i++) {
            newGrid[i] = new Array<Cell>(grid[0].length);
            for (let j = 0; j < grid[0].length; j++) {
                newGrid[i][j] = new Cell(false);
            }
        }

        for (let i = 0; i < grid.length; i++) {
            for (let j = 0; j < grid[0].length; j++) {
                var nbNeighbours: number = this.countNeighbours(grid, i, j);
                if (nbNeighbours == 2) {
                    newGrid[i][j].alive = grid[i][j].isAlive();
                } else if (nbNeighbours == 3) {
                    newGrid[i][j].alive = true;
                }
            }
        }
        return newGrid;
    }

    public countNeighbours(grid: Cell[][], i: number, j: number): number {
        let nbNeighbours: number = 0;
        if (this.IsAliveNeighbour(grid, i - 1, j - 1)) {
            nbNeighbours++;
        }
        if (this.IsAliveNeighbour(grid, i, j - 1)) {
            nbNeighbours++;
        }
        if (this.IsAliveNeighbour(grid, i + 1, j - 1)) {
            nbNeighbours++;
        }
        if (this.IsAliveNeighbour(grid, i - 1, j)) {
            nbNeighbours++;
        }
        if (this.IsAliveNeighbour(grid, i + 1, j)) {
            nbNeighbours++;
        }
        if (this.IsAliveNeighbour(grid, i - 1, j + 1)) {
            nbNeighbours++;
        }
        if (this.IsAliveNeighbour(grid, i, j + 1)) {
            nbNeighbours++;
        }
        if (this.IsAliveNeighbour(grid, i + 1, j + 1)) {
            nbNeighbours++;
        }

        return nbNeighbours;
    }

    private IsAliveNeighbour(grid: Cell[][], i: number, j: number): boolean {
        return j >= 0 &&
            j < grid[0].length &&
            i >= 0 &&
            i < grid.length &&
            grid[i][j].isAlive();
    }
}

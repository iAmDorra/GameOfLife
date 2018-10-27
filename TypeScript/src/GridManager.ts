import { Cell } from "./Cell";

export class GridManager {
	getNewState(grid: Cell[][]): Cell[][] {
		const newGrid: Cell[][] = Array(grid.length);
		for (let i = 0; i < grid.length; i++) {
			newGrid[i] = Array(grid[i].length);
			for (let j = 0; j < grid[0].length; j++) {
				newGrid[i][j] = new Cell(false);
			}
		}

		for (let i = 0; i < grid.length; i++) {
			for (let j = 0; j < grid[0].length; j++) {
				const nbNeighbours = this.countNeighbours(grid, i, j);
				if (nbNeighbours == 2) {
					newGrid[i][j].isAlive = grid[i][j].isAlive;
				} else if (nbNeighbours == 3) {
					newGrid[i][j].isAlive = true;
				}
			}
		}
		return newGrid;
	}

	countNeighbours(grid: Cell[][], i: number, j: number): number {
		let nbNeighbours = 0;
		if (GridManager.isAliveNeighbour(grid, i - 1, j - 1)) {
			nbNeighbours++;
		}
		if (GridManager.isAliveNeighbour(grid, i, j - 1)) {
			nbNeighbours++;
		}
		if (GridManager.isAliveNeighbour(grid, i + 1, j - 1)) {
			nbNeighbours++;
		}
		if (GridManager.isAliveNeighbour(grid, i - 1, j)) {
			nbNeighbours++;
		}
		if (GridManager.isAliveNeighbour(grid, i + 1, j)) {
			nbNeighbours++;
		}
		if (GridManager.isAliveNeighbour(grid, i - 1, j + 1)) {
			nbNeighbours++;
		}
		if (GridManager.isAliveNeighbour(grid, i, j + 1)) {
			nbNeighbours++;
		}
		if (GridManager.isAliveNeighbour(grid, i + 1, j + 1)) {
			nbNeighbours++;
		}

		return nbNeighbours;
	}

	private static isAliveNeighbour(grid: Cell[][], i: number, j: number) {
		return (
			j >= 0 &&
			j < grid[0].length &&
			i >= 0 &&
			i < grid.length &&
			grid[i][j].isAlive
		);
	}
}

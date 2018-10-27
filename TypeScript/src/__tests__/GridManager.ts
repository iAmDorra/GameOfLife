import { Cell } from "../Cell";
import { GridManager } from "../GridManager";

describe("UnitTest1", () => {
	it("should not change cells if all cells are dead", () => {
		// @FIXME: for some reasons the tests fail with the message `GameOfLife.GridManager is not a constructor`
		const gridManager = new GridManager();
		const grid = [[new Cell(false)]];
		const newGrid = gridManager.getNewState(grid);

		expect(newGrid[0][0].isAlive).toBe(false);
	});

	it("should not kill cell if it has two neighbours", () => {
		const gridManager = new GridManager();

		const grid = initializeGrid(3, 3);
		grid[0][2].isAlive = true;
		grid[1][1].isAlive = true;
		grid[2][0].isAlive = true;

		const newGrid = gridManager.getNewState(grid);

		expect(newGrid[1][1].isAlive).toBe(true);
	});

	it("should kill cell if it has less than two neighbours", () => {
		const gridManager = new GridManager();

		const grid = initializeGrid(2, 4);
		grid[1][0].isAlive = true;
		grid[1][1].isAlive = true;
		grid[1][2].isAlive = true;

		const newGrid = gridManager.getNewState(grid);

		expect(newGrid[1][0].isAlive).toBe(false);
		expect(newGrid[1][2].isAlive).toBe(false);
	});

	it("should alive cell if it has three neighbours", () => {
		const gridManager = new GridManager();

		const grid = initializeGrid(2, 3);
		grid[0][1].isAlive = true;
		grid[1][0].isAlive = true;
		grid[1][1].isAlive = true;

		const newGrid = gridManager.getNewState(grid);

		expect(newGrid[0][0].isAlive).toBe(true);
	});

	it("should kill cell if it has more than three neighbours", () => {
		const gridManager = new GridManager();

		const grid = initializeGrid(4, 3);
		grid[0][2].isAlive = true;
		grid[1][1].isAlive = true;
		grid[2][0].isAlive = true;
		grid[2][1].isAlive = true;
		grid[2][2].isAlive = true;

		const newGrid = gridManager.getNewState(grid);

		expect(newGrid[1][1].isAlive).toBe(false);
	});

	it("should count neighbours of cell", () => {
		const gridManager = new GridManager();

		const h = 2;
		const w = 3;
		const grid = initializeGrid(h, w);
		grid[0][1].isAlive = true;
		grid[1][0].isAlive = true;
		grid[1][1].isAlive = true;

		const nbNeighbours = gridManager.countNeighbours(grid, 0, 1);

		expect(nbNeighbours).toBe(2);
	});

	function initializeGrid(h: number, w: number): Cell[][] {
		const grid = Array(h);
		for (let i = 0; i < grid.length; i++) {
			grid[i] = Array(w);
			for (let j = 0; j < grid[0].length; j++) {
				grid[i][j] = new Cell(false);
			}
		}

		return grid;
	}
});

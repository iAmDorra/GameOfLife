import GridManager from "../../src/gameoflife/grid-manager";
import Cell from "../../src/gameoflife/cell";

describe("GridManager", () => {

    it("should_not_change_cells_if_all_cells_are_dead", () => {
        const gridManager: GridManager = new GridManager();
        const grid: Cell[][] = [[new Cell(false)]];
        const newGrid: Cell[][] = gridManager.getNewState(grid);

        expect(newGrid[0][0].alive).toEqual(false);
    });


    it("should_not_kill_cell_if_it_has_two_neighbours", () => {
        const gridManager: GridManager = new GridManager();

        const grid = initializeGrid(3, 3);
        grid[0][2].alive = true;
        grid[1][1].alive = true;
        grid[2][0].alive = true;

        const newGrid: Cell[][] = gridManager.getNewState(grid);

        expect(newGrid[1][1].alive).toBe(true);
    });


    it("should_kill_cell_if_it_has_less_than_two_neighbours", () => {
        const gridManager: GridManager = new GridManager();

        const grid: any = initializeGrid(2, 4);
        grid[1][0].alive = true;
        grid[1][1].alive = true;
        grid[1][2].alive = true;

        const newGrid = gridManager.getNewState(grid);

        expect(newGrid[1][0].alive).toBe(false);
        expect(newGrid[1][2].alive).toBe(false);
    });


    it("should_alive_cell_if_it_has_three_neighbours", () => {
        const gridManager: GridManager = new GridManager();

        const grid: any = initializeGrid(2, 3);
        grid[0][1].alive = true;
        grid[1][0].alive = true;
        grid[1][1].alive = true;

        const newGrid: Cell[][] = gridManager.getNewState(grid);

        expect(newGrid[0][0].alive).toBe(true);
    });


    it("should_kill_cell_if_it_has_more_than_three_neighbours", () => {
        const gridManager: GridManager = new GridManager();

        const grid: Cell[][] = initializeGrid(4, 3);
        grid[0][2].alive = true;
        grid[1][1].alive = true;
        grid[2][0].alive = true;
        grid[2][1].alive = true;
        grid[2][2].alive = true;

        const newGrid: Cell[][] = gridManager.getNewState(grid);

        expect(newGrid[1][1].alive).toBe(false);
    });


    it("should_count_neighbours_of_cell", () => {
        const gridManager: GridManager = new GridManager();

        const h = 2;
        const w = 3;
        const grid = initializeGrid(h, w);
        grid[0][1].alive = true;
        grid[1][0].alive = true;
        grid[1][1].alive = true;

        const nbNeighbours = gridManager.countNeighbours(grid, 0, 1);

        expect(nbNeighbours).toEqual(2);
    });


});

function initializeGrid(h: number, w: number): Cell[][] {
    const grid: Cell[][] = new Array<Cell[]>(h);
    for (let i = 0; i < grid.length; i++) {
        grid[i] = new Array<Cell>(w);
        for (let j = 0; j < grid[0].length; j++) {
            grid[i][j] = new Cell(false);
        }
    }

    return grid;
}

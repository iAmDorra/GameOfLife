import Cell from '../src/Cell';
import GridManager from '../src/GridManager';

describe('GridManager', ()  =>
{
    it('Should not change cells if all cells are dead', () =>
    {
        let gridManager = new GridManager();
        let grid = new Array(new Array(1));
        let newGrid = gridManager.getNewState(grid);

        expect(newGrid[0][0].isAlive).toBe(false);
    });

    it('Should not kill cell if it has two neighbours', () =>
    {
        let gridManager = new GridManager();
        
        let grid = initializeGrid(3, 3);
        grid[0][2].isAlive = true;
        grid[1][1].isAlive = true;
        grid[2][0].isAlive = true;

        let newGrid = gridManager.getNewState(grid);

        expect(newGrid[1][1].isAlive).toBe(true);
    });

    it('Should kill cell if it has less than two neighbours', () =>
    {
        let gridManager = new GridManager();
        
        let grid = initializeGrid(2, 4);
        grid[1][0].isAlive = true;
        grid[1][1].isAlive = true;
        grid[1][2].isAlive = true;

        let newGrid = gridManager.getNewState(grid);

        expect(newGrid[1][0].isAlive).toBe(false);
        expect(newGrid[1][2].isAlive).toBe(false);
    });

    it('Should alive cell if it has three neighbours', () =>
    {
        let gridManager = new GridManager();

        let grid = initializeGrid(2, 3);
        grid[0][1].isAlive = true;
        grid[1][0].isAlive = true;
        grid[1][1].isAlive = true;

        let newGrid = gridManager.getNewState(grid);

        expect(newGrid[0][0].isAlive).toBe(true);
    });

    it('Should kill cell if it has more than three neighbours', () =>
    {
        let gridManager = new GridManager();

        let grid = initializeGrid(4, 3);
        grid[0][2].isAlive = true;
        grid[1][1].isAlive = true;
        grid[2][0].isAlive = true;
        grid[2][1].isAlive = true;
        grid[2][2].isAlive = true;

        let newGrid = gridManager.getNewState(grid);

        expect(newGrid[1][1].isAlive).toBe(false);
    });

    it('Should count neighbours of cell', () =>
    {
        let gridManager = new GridManager();

        const h = 2;
        const w = 3;
        let grid = initializeGrid(h, w);
        grid[0][1].isAlive = true;
        grid[1][0].isAlive = true;
        grid[1][1].isAlive = true;

        let nbNeighbours = gridManager.countNeighbours(grid, 0, 1);

        expect(nbNeighbours).toEqual(2);
    })

});

function initializeGrid(h, w)
{
	let grid = [];
	for (let i = 0; i < h; i++)
	{
        grid[i] = [];
		for (let j = 0; j < w; j++)
		{
			grid[i][j] = new Cell(false);
		}
	}

	return grid;
}

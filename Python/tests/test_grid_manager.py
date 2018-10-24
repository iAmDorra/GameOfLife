from game_of_life.cell import Cell
from game_of_life.grid_manager import GridManager


def test_should_not_change_cells_if_all_cells_are_dead():
    grid_manager = GridManager()
    grid = [[Cell(False) for _ in range(1)] for _ in range(1)]
    new_grid = grid_manager.get_new_state(grid)

    assert new_grid[0][0].is_alive is False


def test_should_not_kill_cell_if_it_has_two_neighbours():
    grid_manager = GridManager()
    grid = initialize_grid(3, 3)
    grid[0][2].is_alive = True
    grid[1][1].is_alive = True
    grid[2][0].is_alive = True

    new_grid = grid_manager.get_new_state(grid)

    assert new_grid[1][1].is_alive is True


def test_should_kill_cell_if_it_has_less_than_two_neighbours():
    grid_manager = GridManager()

    grid = initialize_grid(2, 4)
    grid[1][0].is_alive = True
    grid[1][1].is_alive = True
    grid[1][2].is_alive = True

    new_grid = grid_manager.get_new_state(grid)

    assert new_grid[1][0].is_alive is False
    assert new_grid[1][2].is_alive is False


def test_should_alive_cell_if_it_has_three_neighbours():
    grid_manager = GridManager()

    grid = initialize_grid(2, 2)
    grid[0][1].is_alive = True
    grid[1][0].is_alive = True
    grid[1][1].is_alive = True

    new_grid = grid_manager.get_new_state(grid)

    assert new_grid[0][0].is_alive is True


def test_should_kill_cell_if_it_has_more_than_three_neighbours():
    grid_manager = GridManager()

    grid = initialize_grid(4, 3)
    grid[0][2].is_alive = True
    grid[1][1].is_alive = True
    grid[2][0].is_alive = True
    grid[2][1].is_alive = True
    grid[2][2].is_alive = True

    new_grid = grid_manager.get_new_state(grid)

    assert new_grid[1][1].is_alive is False


def test_should_count_neighbours_of_cell():
    grid_manager = GridManager()
    h = 2
    w = 3
    grid = initialize_grid(h, w)
    grid[0][1].is_alive = True
    grid[1][0].is_alive = True
    grid[1][1].is_alive = True

    nb_neighbours = grid_manager.count_neighbours(grid, 0, 1)

    assert nb_neighbours == 2


def initialize_grid(h, w):
    return [[Cell(False) for _ in range(w)] for _ in range(h)]

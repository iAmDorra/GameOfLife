from game_of_life.cell import Cell


class GridManager(object):
    def get_new_state(self, grid):
        new_grid = [[Cell(False) for _ in range(len(grid[0]))] for _ in range(len(grid))]

        for i in range(len(grid)):
            for j in range(len(grid[0])):
                nb_neighbours = self.count_neighbours(grid, i, j)
                if nb_neighbours == 2:
                    new_grid[i][j].is_alive = grid[i][j].is_alive
                elif nb_neighbours == 3:
                    new_grid[i][j].is_alive = True

        return new_grid

    def count_neighbours(self, grid, i, j):
        nb_neighbours = 0
        if self._is_alive_neighbour(grid, i - 1, j - 1):
            nb_neighbours += 1
        if self._is_alive_neighbour(grid, i, j - 1):
            nb_neighbours += 1
        if self._is_alive_neighbour(grid, i + 1, j - 1):
            nb_neighbours += 1
        if self._is_alive_neighbour(grid, i - 1, j):
            nb_neighbours += 1
        if self._is_alive_neighbour(grid, i + 1, j):
            nb_neighbours += 1
        if self._is_alive_neighbour(grid, i - 1, j + 1):
            nb_neighbours += 1
        if self._is_alive_neighbour(grid, i, j + 1):
            nb_neighbours += 1
        if self._is_alive_neighbour(grid, i + 1, j + 1):
            nb_neighbours += 1
        return nb_neighbours

    @staticmethod
    def _is_alive_neighbour(grid, i, j):
        return 0 <= i < len(grid) and \
               0 <= j < len(grid[0]) and \
               grid[i][j].is_alive

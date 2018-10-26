-module(grid_manager_tests).

-include_lib("eunit/include/eunit.hrl").

should_not_change_cells_if_all_cells_are_dead__test() ->
  Grid0 = grid_manager:new_grid(1,1),
  Grid1 = grid_manager:get_new_state(Grid0),
  Alive = grid_manager:is_cell_alive(Grid1, 0, 0),
  ?assertEqual(Alive, false).

should_not_kill_cell_if_it_has_two_neighbours__test() ->
  Grid0 = grid_manager:new_grid(3,3),
  Grid1 = grid_manager:set_cell_alive(Grid0, 0, 2, true),
  Grid2 = grid_manager:set_cell_alive(Grid1, 1, 1, true),
  Grid3 = grid_manager:set_cell_alive(Grid2, 2, 0, true),

  Grid4 = grid_manager:get_new_state(Grid3),

  ?assertEqual(grid_manager:is_cell_alive(Grid4, 1, 1), true).

should_kill_cell_if_it_has_less_than_two_neighbours__test() ->
  Grid0 = grid_manager:new_grid(2,4),
  Grid1 = grid_manager:set_cell_alive(Grid0, 1, 0, true),
  Grid2 = grid_manager:set_cell_alive(Grid1, 1, 1, true),
  Grid3 = grid_manager:set_cell_alive(Grid2, 1, 2, true),

  Grid4 = grid_manager:get_new_state(Grid3),

  ?assertEqual(grid_manager:is_cell_alive(Grid4, 1, 0), false),
  ?assertEqual(grid_manager:is_cell_alive(Grid4, 1, 2), false).


should_alive_cell_if_it_has_three_neighbours__test() ->
  Grid0 = grid_manager:new_grid(2,3),
  Grid1 = grid_manager:set_cell_alive(Grid0, 0, 1, true),
  Grid2 = grid_manager:set_cell_alive(Grid1, 1, 0, true),
  Grid3 = grid_manager:set_cell_alive(Grid2, 1, 1, true),

  Grid4 = grid_manager:get_new_state(Grid3),

  ?assertEqual(grid_manager:is_cell_alive(Grid4, 0, 0), true).

should_kill_cell_if_it_has_more_than_three_neighbours__test() ->
  Grid0 = grid_manager:new_grid(4, 3),
  Grid1 = grid_manager:set_cell_alive(Grid0, 0, 2, true),
  Grid2 = grid_manager:set_cell_alive(Grid1, 1, 1, true),
  Grid3 = grid_manager:set_cell_alive(Grid2, 2, 0, true),
  Grid4 = grid_manager:set_cell_alive(Grid3, 2, 1, true),
  Grid5 = grid_manager:set_cell_alive(Grid4, 2, 2, true),

  Grid6 = grid_manager:get_new_state(Grid5),

  ?assertEqual(grid_manager:is_cell_alive(Grid6, 1, 1), false).

should_count_neighbours_of_cell__test() ->
  H = 2,
  W = 3,
  Grid0 = grid_manager:new_grid(H, W),
  Grid1 = grid_manager:set_cell_alive(Grid0, 0, 1, true),
  Grid2 = grid_manager:set_cell_alive(Grid1, 1, 0, true),
  Grid3 = grid_manager:set_cell_alive(Grid2, 1, 1, true),

  NbNeighbours = grid_manager:count_neighbours(Grid3, 0, 1),
  ?assertEqual(NbNeighbours, 2).

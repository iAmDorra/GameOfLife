-module(grid_manager).

%% API exports
-export([new_grid/2, is_cell_alive/3, set_cell_alive/4]).
-export([get_new_state/1, count_neighbours/3]).

-define(IF(Cond,E1,E2), (case (Cond) of true -> (E1); false -> (E2) end)).
-record(cell, {x,y,alive}).
-record(grid, {width,height,cells}).

%%====================================================================
%% API functions
%%====================================================================
new_grid(Width, Height) ->
  Cells = [#cell{x=X, y=Y, alive=false}
            || X <- lists:seq(0, Width  - 1),
               Y <- lists:seq(0, Height - 1)],
  #grid{width=Width, height=Height, cells=Cells}.

get_new_state(Grid) ->
  PreviousCells = Grid#grid.cells,
  IsAlive = fun(Cell) ->
    case count_alive_neighbours(Cell#cell.x, Cell#cell.y, PreviousCells) of
      2 -> Cell#cell.alive;
      3 -> true;
      _ -> false
    end
  end,
  Updated = [Cell#cell{alive = IsAlive(Cell)} || Cell <- Grid#grid.cells],
  Grid#grid{cells=Updated}.

count_neighbours(Grid, X, Y) ->
  count_alive_neighbours(X, Y, Grid#grid.cells).

is_cell_alive(#grid{cells=Cells}, X,Y) ->
  Cell = find_cell(X,Y,Cells),
  Cell#cell.alive.

set_cell_alive(Grid = #grid{cells=Cells}, X,Y, Alive) ->
  NewCells = update_cell_alive([], X, Y, Alive, Cells),
  Grid#grid{cells = NewCells}.

%%====================================================================
%% Internal functions
%%====================================================================
count_alive_neighbours(X, Y, Cells) ->
  Count = ?IF(is_alive_neighbour(X-1, Y-1, Cells), 1, 0)
  + ?IF(is_alive_neighbour(X, Y-1, Cells), 1, 0)
  + ?IF(is_alive_neighbour(X+1, Y-1, Cells), 1, 0)
  + ?IF(is_alive_neighbour(X-1, Y, Cells), 1, 0)
  + ?IF(is_alive_neighbour(X+1, Y, Cells), 1, 0)
  + ?IF(is_alive_neighbour(X-1, Y+1, Cells), 1, 0)
  + ?IF(is_alive_neighbour(X, Y+1, Cells), 1, 0)
  + ?IF(is_alive_neighbour(X+1, Y+1, Cells), 1, 0),
  %% io:format("Count alive neighbours [~w, ~w]: ~w~n", [X,Y,Count]),
  Count.

update_cell_alive(NewCells, _X, _Y, _Alive, []) ->
  NewCells;

update_cell_alive(NewCells, X, Y, Alive, [Cell=#cell{x=X, y=Y} | Others]) ->
  [Cell#cell{alive=Alive} | Others] ++ NewCells;

update_cell_alive(NewCells, X, Y, Alive, [Cell| Others]) ->
  update_cell_alive([Cell| NewCells], X, Y, Alive, Others).

find_cell(X, Y, [Cell=#cell{x=X, y=Y} | _Others]) ->
  Cell;

find_cell(X, Y, [_ | Others]) ->
  find_cell(X, Y, Others).

is_alive_neighbour(_X, _Y, []) ->
  false;

is_alive_neighbour(X, Y, [#cell{x=X, y=Y, alive=Alive} | _]) ->
  Alive;

is_alive_neighbour(X, Y, [_ | Others]) ->
  is_alive_neighbour(X, Y, Others).

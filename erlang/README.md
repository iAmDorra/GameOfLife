# game_of_life

## Build

    $ rebar3 compile

## Tests

    $ rebar3 eunit

## REPL

    $ erl

```erlang
Erlang/OTP 20 [erts-9.3] [source] [64-bit] [smp:4:4] [ds:4:4:10] [async-threads:10] [hipe] [kernel-poll:false]

Eshell V9.3  (abort with ^G)
1> c('src/grid_manager').
{ok,grid_manager}
2> grid_manager:
count_neighbours/3  get_new_state/1     is_cell_alive/3
module_info/0       module_info/1       new_grid/2
set_cell_alive/4
2> grid_manager:new_grid(3, 3).
{grid,3,3,
      [{cell,0,0,false},
       {cell,0,1,false},
       {cell,0,2,false},
       {cell,1,0,false},
       {cell,1,1,false},
       {cell,1,2,false},
       {cell,2,0,false},
       {cell,2,1,false},
       {cell,2,2,false}]}
4>
```

# Install

* [rebar3](https://www.rebar3.org/docs/getting-started)

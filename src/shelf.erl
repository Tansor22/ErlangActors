%%%-------------------------------------------------------------------
%%% @author Sergei
%%% @copyright (C) 2020, <COMPANY>
%%% @doc
%%%
%%% @end
%%% Created : 12. апр. 2020 18:54
%%%-------------------------------------------------------------------
-module(shelf).
-author("Sergei").

%% API
-export([main/0]).

-import(utils, [nop/1]).

name() -> shelf.
client() -> nop(name()).

main() -> Shelf_PID = spawn(fun() -> client() end),
  global:register_name(name(), Shelf_PID),
  % block current thread in order not to shutdown virtual machine
  receive
    _ -> exit(normal)
  end.

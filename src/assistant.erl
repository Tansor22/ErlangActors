%%%-------------------------------------------------------------------
%%% @author Sergei
%%% @copyright (C) 2020, <COMPANY>
%%% @doc
%%%
%%% @end
%%% Created : 12. апр. 2020 18:53
%%%-------------------------------------------------------------------
-module(assistant).
-author("Sergei").

%% API
-export([main/0]).

-import(utils, [nop/1]).

name() -> assistant.
client() -> nop(name()).

main() -> Assistant_PID = spawn(fun() -> client() end),
  global:register_name(name(), Assistant_PID),
  % block current thread in order not to shutdown virtual machine
  receive
    _ -> exit(normal)
  end.

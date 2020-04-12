%%%-------------------------------------------------------------------
%%% @author Sergei
%%% @copyright (C) 2020, <COMPANY>
%%% @doc
%%%
%%% @end
%%% Created : 12. апр. 2020 18:55
%%%-------------------------------------------------------------------
-module(issuing_point).
-author("Sergei").

%% API
-export([main/0]).

-import(utils, [nop/1, send/2, say/2]).

name() -> issuing_point.
issuing_point() -> nop(name()).

main() -> Issuing_point_PID = spawn(fun() -> issuing_point() end),
  global:register_name(name(), Issuing_point_PID),
  % block current thread in order not to shutdown virtual machine
  receive
    _ -> exit(normal)
  end.

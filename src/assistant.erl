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

-import(utils, [nop/1, send/2, say/2, say/1]).

name() -> assistant.
assistant() -> say("Waiting for a cashier's request..."),
  receive
    DesiredBook -> utils:send(shelf, DesiredBook),
      receive
        TheSameBook ->
          % check condition
          % looks like deadlock
          utils:send(issuing_point, TheSameBook)
      end
  end, assistant().

main() -> Assistant_PID = spawn(fun() -> utils:init(), assistant() end),
  global:register_name(name(), Assistant_PID).

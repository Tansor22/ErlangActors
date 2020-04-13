%%%-------------------------------------------------------------------
%%% @author Sergei
%%% @copyright (C) 2020, SIB IT
%%% @doc
%%%
%%% @end
%%% Created : 12. апр. 2020 18:53
%%%-------------------------------------------------------------------
-module(assistant).
-author("Sergei").

%% API
-export([main/0]).

-import(utils, [nop/1, send/2, say/2, say/1, sayEx/1, quoted/1, rand/2]).

name() -> assistant.
assistant() -> say("Waiting for a cashier's request..."),
  receive
    Book -> sayEx(["The cashier has requested a", quoted(Book), "!"]),
      utils:send(shelf, Book),
      receive
        Book ->
          % check condition
          utils:send(issuing_point, Book)
      end
  end, timer:sleep(rand(500, 1500)), assistant().

main() -> Assistant_PID = spawn(fun() -> utils:init(), assistant() end),
  global:register_name(name(), Assistant_PID), nop(self()).

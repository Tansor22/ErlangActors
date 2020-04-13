%%%-------------------------------------------------------------------
%%% @author Sergei
%%% @copyright (C) 2020, SIB IT
%%% @doc
%%%
%%% @end
%%% Created : 12. апр. 2020 18:54
%%%-------------------------------------------------------------------
-module(shelf).
-author("Sergei").

%% API
-export([main/0]).

-import(utils, [nop/1, send/2, say/2, say/1, sayEx/1, quoted/1, rand/2]).

name() -> shelf.
shelf() -> say("Waiting for an assistant's request..."),
  receive
    Book -> sayEx(["The assistant has requested a", quoted(Book), "!"]), utils:send(assistant, Book)
  end, timer:sleep(rand(500, 1500)), shelf().

main() -> Shelf_PID = spawn(fun() -> utils:init(), shelf() end),
  global:register_name(name(), Shelf_PID), nop(self()).

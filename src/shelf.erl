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

-import(utils, [nop/1, send/2, say/2, say/1]).

name() -> shelf.
shelf() -> say("Waiting for an assistant's request..."),
  receive
    Book -> utils:send(assistant, Book)
  end, shelf().

main() -> Shelf_PID = spawn(fun() -> utils:init(), shelf() end),
  global:register_name(name(), Shelf_PID).

%%%-------------------------------------------------------------------
%%% @author Sergei
%%% @copyright (C) 2020, SIB IT
%%% @doc
%%%
%%% @end
%%% Created : 12. апр. 2020 18:52
%%%-------------------------------------------------------------------
-module(cashier).
-author("Sergei").

%% API
-export([main/0]).

-import(utils, [nop/1, send/2, say/2, say/1, sayEx/1, quoted/1, rand/2]).

name() -> cashier.

cashier() -> say("Waiting for a customer's request..."),
  receive
    Book -> sayEx(["The customer has requqsted a", quoted(Book), "!"]),
      utils:send(assistant, Book),
      receive
        true -> sayEx(["The", Book,  "has been sold!"])
      end
  end, timer:sleep(rand(500, 1500)),cashier().


main() -> Cashier_PID = spawn(fun() -> utils:init(), cashier() end),
  global:register_name(name(), Cashier_PID), nop(self()).

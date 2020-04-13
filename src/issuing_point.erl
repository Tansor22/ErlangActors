%%%-------------------------------------------------------------------
%%% @author Sergei
%%% @copyright (C) 2020, SIB IT
%%% @doc
%%%
%%% @end
%%% Created : 12. апр. 2020 18:55
%%%-------------------------------------------------------------------
-module(issuing_point).
-author("Sergei").

%% API
-export([main/0]).

-import(utils, [nop/1, send/2, say/2, sayEx/1, say/1, rand/2]).

name() -> issuing_point.
issuing_point() -> say("Waiting for an assistant's request..."),
  receive
    Book -> sayEx(["An assistant gave us a", Book, "book."]),
      say("Packing the book..."),
      utils:send(customer, Book),
      receive
        Money -> sayEx(["We've earned", integer_to_list(Money), "$!" ]),
          utils:send(cashier, true)
      end,
      timer:sleep(rand(500, 1500)), issuing_point()
  end.

main() -> Issuing_point_PID = spawn(fun() -> utils:init(), issuing_point() end),
  global:register_name(name(), Issuing_point_PID), nop(self()).
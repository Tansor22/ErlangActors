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

-import(utils, [nop/1, send/2, say/2, say/1]).

name() -> issuing_point.
issuing_point() -> say("Waiting for an assistant's request..."),
  receive
    Book -> %say("An assistant gave us a ~s book.", [Book])
      say("Packing the book..."),
      utils:send(customer, Book),
      receive
        Money -> %say("We've earned ~d $!", [Money]),
          utils:send(cashier, true)
      end
  end.

main() -> Issuing_point_PID = spawn(fun() -> utils:init(), issuing_point() end),
  global:register_name(name(), Issuing_point_PID).
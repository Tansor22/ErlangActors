%%%-------------------------------------------------------------------
%%% @author Sergei
%%% @copyright (C) 2020, <COMPANY>
%%% @doc
%%%
%%% @end
%%% Created : 12. апр. 2020 18:52
%%%-------------------------------------------------------------------
-module(cashier).
-author("Sergei").

%% API
-export([main/0]).

-import(utils, [nop/1, send/2, say/2, say/1]).

name() -> cashier.

cashier() -> say("Waiting for a customer's request..."),
  receive
    DesiredBook -> utils:send(assistant, DesiredBook),
      receive
        true -> done%say("The ~s has been sold!", [DesiredBook])
      end
  end, cashier().


main() -> Cashier_PID = spawn(fun() -> utils:init(), cashier() end),
  global:register_name(name(), Cashier_PID).

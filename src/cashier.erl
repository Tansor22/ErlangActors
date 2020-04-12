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

-import(utils, [nop/1, send/2, say/2]).

name() -> cashier.

cashier() -> receive
               DesiredBook -> send(assistant, DesiredBook),
                 receive
                   true -> say("The ~w has been sold!", [DesiredBook])
                 end
             end,
  cashier().


main() -> Cashier_PID = spawn(fun() -> cashier() end),
  global:register_name(name(), Cashier_PID).
% TODO not needed in console launch mode
% block current thread in order not to shutdown virtual machine
%receive
%  _ -> exit(normal)
%end.

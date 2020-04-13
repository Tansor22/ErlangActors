%%%-------------------------------------------------------------------
%%% @author Sergei
%%% @copyright (C) 2020, <COMPANY>
%%% @doc
%%%
%%% @end
%%% Created : 12. апр. 2020 17:46
%%%-------------------------------------------------------------------
-module(customer).
-author("Sergei").

%% API
-export([main/0, node/0]).

-import(utils, [nop/1, send/2, say/2, cookie/0, init/0]).

name() -> customer.

% Books available.
books() -> ["Sweeney Todd. Demon barber of Flit Street", "Groovy in Action",
  "Java. Effective programming", "PHP. Cookbook", "The Strange Case Of Dr. Jekyll And Mr. Hyde"].

% Picks a random book.
wishForBook() -> lists:nth(rand:uniform(length(books())), books()).


customer() -> utils:init(), DesiredBook = wishForBook(),
  send(cashier, DesiredBook),
  say("I'd like a ~w book", [DesiredBook]),
  receive
    DesiredBook -> send(issuing_point, rand:uniform(10)),
      say("I've got a  ~w book now!", [DesiredBook])
  end,
  % infinite loop
  customer().

main() -> Customer_PID = spawn(fun() -> customer() end),
  global:register_name(name(), Customer_PID),
% block current thread in order not to shutdown virtual machine
receive
 _ -> exit(normal)
end.

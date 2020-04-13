%%%-------------------------------------------------------------------
%%% @author Sergei
%%% @copyright (C) 2020, SIB IT
%%% @doc
%%%
%%% @end
%%% Created : 12. апр. 2020 17:46
%%%-------------------------------------------------------------------
-module(customer).
-author("Sergei").

%% API
-export([main/0]).

-import(utils, [nop/1, send/2, say/2, sayEx/1, quoted/1, cookie/0, init/0, rand/1, rand/2]).

name() -> customer.

% Books available.
books() -> ["Sweeney Todd. Demon barber of Flit Street.", "Groovy in Action.",
  "Java. Effective programming.", "PHP. Cookbook.", "The Strange Case Of Dr. Jekyll And Mr. Hyde.",
  "Generating random numbers programmaticaly for Dummies.", "Introducing Erlang."].

% Picks a random book.
wishForBook() -> lists:nth(rand:uniform(length(books())), books()).


customer() -> Book = wishForBook(),
  send(cashier, Book),
  sayEx(["I'd like a", quoted(Book), "book"]),
  receive
    Book -> send(issuing_point, rand(20)),
      sayEx(["I've got a", quoted(Book), "book now!"])
  end, timer:sleep(rand(500, 1500)), customer().

main() -> Customer_PID = spawn(fun() -> utils:init(), customer() end),
  global:register_name(name(), Customer_PID), nop(self()).
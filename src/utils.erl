%%%-------------------------------------------------------------------
%%% @author Sergei
%%% @copyright (C) 2020, <COMPANY>
%%% @doc
%%%
%%% @end
%%% Created : 12. апр. 2020 17:49
%%%-------------------------------------------------------------------
-module(utils).
-author("Sergei").

%% API
-export([nop/0, nop/1, nameOf/1, send/2]).

nop(Name) -> io:format("~w waits for a wonder ... ~n", [Name]),
  receive
    Message -> io:format("Got msg=~p~n", [Message])
  end,
  nop(Name).

nop() ->
  io:format("~w waits for a wonder ... ~n", [self()]),
  receive
    Message -> io:format("Got msg=~p~n", [Message])
  end,
  nop().

nameOf(Atom) -> global:whereis_name(Atom).

send(To, Message) -> nameOf(To) ! Message, sent.

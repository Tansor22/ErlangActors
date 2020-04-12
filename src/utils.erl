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
-export([nop/0, nop/1, nameOf/1, send/2, say/2, pingNodes/2, nodes/0, injectPostfix/1]).

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

say(Message, [Params]) -> io:format(Message ++ "~n", Params).

% Returns all nodes available.
nodes() -> injectPostfix(["customerNode", "cashierNode",
  "assistantNode", "shelfNode", "issuingPointNode"]).

injectPostfix([Head | Tail]) -> [Head ++ "@127.0.1.0"] ++ injectPostfix(Tail);
injectPostfix([]) -> [].


% Ping all nodes (except 'Except' )to make sending by its names possible
% External
pingNodes(Except, [Head | Tail]) ->
  if
    Head == Except -> pingNodes(nothing, Tail);
    true ->
      case net_adm:ping(list_to_atom(Head))
      of
        pong -> pingNodes(Except, Tail, done);
        pang -> pingNodes(Except, Tail, fail)
      end
  end;
pingNodes(_, []) -> fail.

pingNodes(Except, [Head | Tail], Result) ->
  case Result
  of
    % do not continue pinging
    fail -> fail;
    % previous ping was successful
    done -> if
              Head == Except -> pingNodes(nothing, Tail);
              true ->
                case net_adm:ping(list_to_atom(Head))
                of
                  pong -> pingNodes(Except, Tail, done);
                  pang -> pingNodes(Except, Tail, fail)
                end
            end
  end;

pingNodes(_, [], Result) -> Result.



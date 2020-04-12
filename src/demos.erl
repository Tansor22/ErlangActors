%%%-------------------------------------------------------------------
%%% @author Sergei
%%% @copyright (C) 2020, <SIB IT>
%%% @doc
%%%
%%% @end
%%% Created : 12. апр. 2020 12:45
%%%-------------------------------------------------------------------
-module(demos).
-author("Sergei").


%% API
-export([hello/0, hello/1, spawnDemo/0,
  saySomething/2, pingPongDemo/0, ping/2,
  pong/0, errorHandlingDemo/0, monitorDemo/0]).

hello() -> "Hello world!".
hello(Value) -> "Hello " ++ Value ++ "!".

saySomething(_, 0) ->
  done;
saySomething(What, Times) ->
  io:format("~p~n", [What]),
  saySomething(What, Times - 1).

ping(0, Pong_PID) ->
  Pong_PID ! finished,
  io:format("ping finished~n", []);

ping(N, Pong_PID) ->
  Pong_PID ! {ping, self()},
  receive
    pong ->
      io:format("Ping received pong~n", [])
  end,
  ping(N - 1, Pong_PID).

pong() ->
  receive
    finished ->
      io:format("Pong finished~n", []);
    {ping, Ping_PID} ->
      io:format("Pong received ping~n", []),
      Ping_PID ! pong,
      pong()
  end.

% Error handling + link between processes
zeroDivision() -> 1 / 0.

errorHandlingDemo() ->
  process_flag(trap_exit, true), % register error receiving
  spawn_link(fun()-> zeroDivision() end), % spawn process linked with invoker
  receive
    {'EXIT', From, Reason} -> io:format("~w",[Reason])
  end.

% Monitor demo
worker() -> ok.
monitorDemo() -> spawn_monitor(fun()-> worker() end),
  receive
    Reason -> io:format("~w",[Reason])
  end.

spawnDemo() ->
  spawn(demos, saySomething, [hello, 3]),
  spawn(demos, saySomething, [goodbye, 3]).

pingPongDemo() ->
  Pong_PID = spawn(demos, pong, []),
  spawn(demos, ping, [3, Pong_PID]).

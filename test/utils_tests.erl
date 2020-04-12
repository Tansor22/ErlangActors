%%%-------------------------------------------------------------------
%%% @author Sergei
%%% @copyright (C) 2020, <COMPANY>
%%% @doc
%%%
%%% @end
%%% Created : 12. апр. 2020 23:00
%%%-------------------------------------------------------------------
-module(utils_tests).
-author("Sergei").

-include_lib("eunit/include/eunit.hrl").
-import(utils, [injectPostfix/1, pingNodes/2, nodes/0]).

inject_postfix_test() ->
  ?assertEqual(["test1@127.0.1.0", "test2@127.0.1.0"], injectPostfix(["test1", "test2"])).

ping_nodes_test() ->
  ?assertEqual(fail, pingNodes("toExcept", nodes())).

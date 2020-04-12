%%%-------------------------------------------------------------------
%%% @author Sergei
%%% @copyright (C) 2020, <COMPANY>
%%% @doc
%%%
%%% @end
%%% Created : 12. апр. 2020 23:53
%%%-------------------------------------------------------------------
-module(super).
-author("Sergei").


%% API node1@127.0.1.0
-export([main/0]).

% ** Can not start customer:main,[] on 'node1@127.0.1.0' **
% CONFIRMED need to cast spells on cookie (Staroletov)
main() -> spawn(fun() -> spawn(list_to_atom(customer:node()), customer, main, []) end).

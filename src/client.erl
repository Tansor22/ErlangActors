%%%-------------------------------------------------------------------
%%% @author Sergei
%%% @copyright (C) 2020, <COMPANY>
%%% @doc
%%%
%%% @end
%%% Created : 12. апр. 2020 17:46
%%%-------------------------------------------------------------------
-module(client).
-author("Sergei").

%% API
-export([main/0]).

-import(utils, [nop/1]).

name() -> client.
client() -> nop(name()).

main() -> Client_PID = spawn(fun() -> client() end),
          global:register_name(name(), Client_PID),
            % block current thread in order not to shutdown virtual machine
            receive
              _ -> exit(normal)
            end.

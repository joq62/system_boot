%%%-------------------------------------------------------------------
%% @doc control public API
%% @end
%%%-------------------------------------------------------------------

-module(system_boot_app).

-behaviour(application).

-export([start/2, stop/1]).

start(_StartType, _StartArgs) ->
    system_boot_sup:start_link().

stop(_State) ->
    ok.

%% internal functions

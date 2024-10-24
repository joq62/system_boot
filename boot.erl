%%%-------------------------------------------------------------------
%%% @author c50 <joq62@c50>
%%% @copyright (C) 2024, c50
%%% @doc
%%%
%%% @end
%%% Created : 21 Oct 2024 by c50 <joq62@c50>
%%%-------------------------------------------------------------------
-module(boot).

%% API
-export([
	 start/0
	]).

%%%===================================================================
%%% API
%%%===================================================================

%%--------------------------------------------------------------------
%% @doc
%% @spec
%% @end
%%--------------------------------------------------------------------
start()->
    os:cmd("rm -rf logs"),
    os:cmd("rm -rf application_specs"),
    os:cmd("rm -rf host_specs"),
    ok=application:start(ctrl),
    ok.
%%%===================================================================
%%% Internal functions
%%%===================================================================

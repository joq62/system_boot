%%%-------------------------------------------------------------------
%%% @author c50 <joq62@c50>
%%% @copyright (C) 2024, c50
%%% @doc
%%% 
%%% @end
%%% Created : 11 Jan 2024 by c50 <joq62@c50>
%%%-------------------------------------------------------------------
-module(lib_system_boot).
  

-include("controller.hrl").
-include("system_boot.hrl").
  
%% API
-export([
	 deploy_application/1	 
	]).

-export([

	]).

%%%===================================================================
%%% API
%%%===================================================================

%%--------------------------------------------------------------------
%% @doc
%% Creates a new workernode , load and start infra services (log and resource discovery)
%% and  the wanted application ApplicationId
%% @end
%%--------------------------------------------------------------------
deploy_application(ApplicationId)->

    io:format("ApplicationId ~p~n",[{?MODULE,?LINE,ApplicationId}]),
    {ok,WorkerNode}=create_worker(ApplicationId),
    io:format("WorkerNode ~p~n",[{?MODULE,?LINE,WorkerNode}]),
    
    PathApplicationEbin=filename:join([?ApplicationDir,ApplicationId,"ebin"]),
    io:format("PathApplicationEbin ~p~n",[{?MODULE,?LINE,PathApplicationEbin}]),

    PathRdEbin=filename:join([?ApplicationDir,"resource_discovery","ebin"]),
    io:format("PathRdEbin ~p~n",[{?MODULE,?LINE,PathRdEbin}]),

    PathLogEbin=filename:join([?ApplicationDir,"log","ebin"]),
    io:format("PathLogEbin ~p~n",[{?MODULE,?LINE,PathLogEbin}]),

    ApplicationApp=list_to_atom(ApplicationId),
    [rpc:call(WorkerNode,code,add_patha,[Path],5000)||Path<-[PathApplicationEbin,PathRdEbin,PathLogEbin]],
    
    ok=start_log_rd(WorkerNode,ApplicationId),   
    ok=rpc:call(WorkerNode,application,start,[ApplicationApp],5000),
    pong=rpc:call(WorkerNode,ApplicationApp,ping,[],3*5000),
    ok.

%%%===================================================================
%%% Internal functions
%%%===================================================================
%%--------------------------------------------------------------------
%% @doc
%% 
%% @end
%%--------------------------------------------------------------------
start_log_rd(WorkerNode,ApplicationId)->
    RdApp=rd,
    LogApp=log,
    %start log
    
    ok=rpc:call(WorkerNode,application,start,[LogApp],5000),
    pong=rpc:call(WorkerNode,LogApp,ping,[],5000),
    case filelib:is_dir(?MainLogDir) of
	false->
	    ok=file:make_dir(?MainLogDir);
	true->
	    ok
    end,
    [NodeName,_HostName]=string:tokens(atom_to_list(WorkerNode),"@"),
    NodeNodeLogDir=filename:join(?MainLogDir,NodeName),
    ok=rpc:call(WorkerNode,log,create_logger,[NodeNodeLogDir,?LocalLogDir,?LogFile,?MaxNumFiles,?MaxNumBytes],5000),
    
    %start rd
    ok=rpc:call(WorkerNode,application,start,[RdApp],5000),
    
    ok.
%%--------------------------------------------------------------------
%% @doc
%% Workers nodename convention Id_UniqueNum_cookie 
%% UniqueNum=integer_to_list(erlang:system_time(microsecond),36)
%% @end
%%--------------------------------------------------------------------
create_worker(Id)->
    {ok,HostName}=net:gethostname(),
    CookieStr=atom_to_list(erlang:get_cookie()),
    NodeName=Id++"_"++CookieStr,
    Args=" -setcookie "++CookieStr,
    {ok,Node}=slave:start(HostName,NodeName,Args),
    [rpc:call(Node,net_adm,ping,[N],5000)||N<-[node()|nodes()]],
    true=erlang:monitor_node(Node,true),
    {ok,Node}.

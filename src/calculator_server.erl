%%%-------------------------------------------------------------------
%%% @author cat
%%% @copyright (C) 2024, <COMPANY>
%%% @doc
%%%
%%% @end
%%% Created : 29. Jun 2024 10:55
%%%-------------------------------------------------------------------
-module(calculator_server).
-author("cat").
-behaviour(gen_server).

%% API
-export([start_link/0, connect/0, calculate/2]).

%% gen_server callbacks
-export([init/1, handle_call/3, handle_cast/2, handle_info/2, terminate/2, code_change/3]).

%% Types
-type operation() :: {add, [number()]} | {sub, [number()]} | {mul, [number()]} | {ddiv, [number()]}.

%% API functions
start_link() ->
  gen_server:start_link({local, ?MODULE}, ?MODULE, [], []).

connect() ->
  {ok, Pid} = gen_server:start_link(?MODULE, [], []),
  Pid.

calculate(Pid, Operation) ->
  gen_server:call(Pid, {calculate, Operation}).

%% gen_server callbacks
init([]) ->
  {ok, #{}}.

handle_call({calculate, {add, Numbers}}, _From, State) ->
  {reply, {ok, lists:sum(Numbers)}, State};
handle_call({calculate, {sub, [H | T]}}, _From, State) ->
  Result = lists:foldl(fun(X, Acc) -> Acc - X end, H, T),
  {reply, {ok, Result}, State};
handle_call({calculate, {mul, Numbers}}, _From, State) ->
  Result = lists:foldl(fun(X, Acc) -> Acc * X end, 1, Numbers),
  {reply, {ok, Result}, State};
handle_call({calculate, {ddiv, Numbers}}, _From, State) ->
  try
    Result = lists:foldl(fun(X, Acc) -> Acc / X end, hd(Numbers), tl(Numbers)),
    {reply, {ok, Result}, State}
  catch
    error:badarith -> {reply, {error, division_by_zero}, State}
  end;
handle_call({calculate, _}, _From, State) ->
  {reply, {error, invalid_operation}, State}.

handle_cast(_Msg, State) ->
  {noreply, State}.

handle_info(_Info, State) ->
  {noreply, State}.

terminate(_Reason, _State) ->
  ok.

code_change(_OldVsn, State, _Extra) ->
  {ok, State}.

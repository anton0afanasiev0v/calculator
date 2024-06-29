%%%-------------------------------------------------------------------
%%% @author cat
%%% @copyright (C) 2024, <COMPANY>
%%% @doc
%%%
%%% @end
%%% Created : 29. Jun 2024 11:02
%%%-------------------------------------------------------------------
-module(calculator_server_tests).
-author("cat").

-ifdef(TEST).
-include_lib("eunit/include/eunit.hrl").

%% Test functions
should_success_add_test() ->
  %%  given
  Pid = calculator_server:connect(),

  %%  when
  {ok, Result} = calculator_server:calculate(Pid, {add, [1, 2, 3.06, -1]}),

  %%then
  ?assertEqual(5.0600000000000005, Result).

should_success_sub_test() ->
  %%  given
  Pid = calculator_server:connect(),

  %%  when
  {ok, Result} = calculator_server:calculate(Pid, {sub, [10, 2, 3]}),

  %% then
  ?assertEqual(5, Result).

should_success_mul_test() ->
  %%  given
  Pid = calculator_server:connect(),

  %%  when
  {ok, Result} = calculator_server:calculate(Pid, {mul, [2, 3, 4]}),

  %% then
  ?assertEqual(24, Result).

should_success_div_test() ->
  %%  given
  Pid = calculator_server:connect(),

  %%  when
  {ok, Result} = calculator_server:calculate(Pid, {ddiv, [8, 2, 2]}),

  %% then
  ?assertEqual(2.0, Result).

should_error_reason_division_by_zero_test() ->
  %%  given
  Pid = calculator_server:connect(),

  %%  when
  {error, Reason} = calculator_server:calculate(Pid, {ddiv, [1, 0]}),

  %% then
  ?assertEqual(division_by_zero, Reason).

should_success_parallel_test() ->
  %%  given
  Pid1 = calculator_server:connect(),
  Pid2 = calculator_server:connect(),

  %%  when
  {ok, Result1} = calculator_server:calculate(Pid1, {add, [1, 2, 3.06, -1]}),
  {ok, Result2} = calculator_server:calculate(Pid2, {sub, [10, 5, 2]}),

  %% then
  ?assertEqual(5.0600000000000005, Result1),
  ?assertEqual(3, Result2).

should_invalid_operation_test() ->
  %%  given
  Pid = calculator_server:connect(),
  %%  when
  {error, Reason} = calculator_server:calculate(Pid, {unknown, [1, 2, 3]}),

  %% then
  ?assertEqual(invalid_operation, Reason).

-endif.

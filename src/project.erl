%%%-------------------------------------------------------------------
%%% @author Thomas Coll
%%% @contact thomas.coll3075@gmail.com
%%% @doc
%%%
%%% @end
%%% Created : 05. Mar 2019 18:30
%%%-------------------------------------------------------------------
-module(project).
-author("Thomas Coll").

%% API
-export([tokeniser/0]).

tokeniser() ->
  Input = io:fread('Please input your mathmatic equation: ', "~d"),
  parser(Input).

parser(Input) ->
  HandledInput = [],
  evaluator(HandledInput).

evaluator(ParsedInput) ->
  io:format('After careful and ingenius consideration I have concluded:\n'),
  io:fwrite("~w",[ParsedInput]).
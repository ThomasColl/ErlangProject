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
-export([start/0]).

start() ->
  Input = "((234+3)-1)",
%%  {ok, [Input]} = io:fread('Please input your mathmatic equation: ', "~s"),
  evaluator(parser(tokenise(Input), [], [])).
%%  evaluator(tokenise(Input)).

tokenise([$(|Tail]) ->
  [{s, lb}|tokenise(Tail)];
tokenise([$)|Tail]) ->
  [{s, rb}|tokenise(Tail)];
tokenise([$+|Tail]) ->
  [{o, plus}|tokenise(Tail)];
tokenise([$-|Tail]) ->
  [{o, minus}|tokenise(Tail)];
tokenise([$*|Tail]) ->
  [{o, multiply}|tokenise(Tail)];
tokenise([$/|Tail]) ->
  [{o, divide}|tokenise(Tail)];
tokenise([Head|Tail]) ->
  [String, Number] = get_number([Head|Tail],0),
  [{n, Number}|tokenise(String)];
tokenise([]) -> [].

get_number([], Num) -> Num;
get_number([Head|Tail], Num) when Head >= 48, Head < 58 -> get_number(Tail, (Num*10)+(Head-$0));
get_number([Head|Tail], Num) -> [[Head|Tail], Num].

parser([], _, RPN_String) ->
  RPN_String;
parser([{s, lb}|Tail], Stack, RPN_String) ->
  parser(Tail, [lb|Stack], RPN_String);
parser([{s, rb}|Tail], Stack, RPN_String) ->
  [Operators, New_Stack] = pop(Stack),
  parser(Tail, New_Stack, [Operators|RPN_String]);
parser([{o, Value}|Tail], Stack, RPN_String) ->
  parser(Tail, [Value|Stack], RPN_String);
parser([{n, Value}|Tail], Stack, RPN_String) ->
  parser(Tail, Stack, [Value|RPN_String]).

pop([Head|Tail]) when Head /= rb->
  [Head, pop(Tail)];
pop([_|Tail])->
  [Tail].

evaluator(ParsedInput) ->
  io:format('After careful and ingenius consideration I have concluded:\n'),
  io:fwrite("~w",[ParsedInput]).
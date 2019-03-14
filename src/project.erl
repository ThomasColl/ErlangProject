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
  Input = "((2+3)-1)",
%%  {ok, [Input]} = io:fread('Please input your mathmatic equation: ', "~s"),
  evaluator(parse(tokenise(Input), [], [])).

tokenise([$(|Tail]) ->
  [{s, "l"}|tokenise(Tail)];
tokenise([$)|Tail]) ->
  [{s, "r"}|tokenise(Tail)];
tokenise([$+|Tail]) ->
  [{o, plus}|tokenise(Tail)];
tokenise([$-|Tail]) ->
  [{o, minus}|tokenise(Tail)];
tokenise([$*|Tail]) ->
  [{o, multiply}|tokenise(Tail)];
tokenise([$/|Tail]) ->
  [{o, divide}|tokenise(Tail)];
tokenise([Head|Tail]) ->
  [{n, Head}|tokenise(Tail)];
tokenise([]) -> [].

parse([{$n, Value} | Remain], Stack, RPN) ->
  parse(Remain, Stack, [Value|RPN]);
parse([{$o, Value} | Remain], Stack, RPN) ->
  parse(Remain, [Value|Stack], RPN);
parse([{$s, Value} | Remain], Stack, RPN) ->
  parse(Remain, [Value|Stack], RPN);
parse([{$s, $r} | Remain], [Head|Tail], RPN) ->
  parse(Remain, pop(Tail), [Head|RPN]);
parse([], [Head|Tail], RPN) ->
  parse([], Tail, [Head|RPN]);
parse([], [], RPN) ->
  evaluator(RPN).

pop([_|Tail]) ->
  pop(Tail);
pop([$l|Tail]) ->
  [Tail].
%%parse([{$n, Char}|Stack], RPN)->
%%  parse(Stack, [Char|RPN]);
%%parse([{$o, Char}|Stack], RPN) ->
%%    Rhs = hd(RPN),
%%    Lhs = hd(tl(RPN)),
%%    Res = apply(op(Char), [Lhs, Rhs]),
%%    parse(Stack, [Res|tl(tl(RPN))]);
%%parse([], RPN) -> RPN.
%%%%  parser(TokenisedList, []).
%%
%%op("+") -> fun(L,R) -> L+R end;
%%op("*") -> fun(L,R) -> L*R end.
%%
%%is_op(X) -> X == "+" orelse X == "*".


%%parser([{Symbol, Value}|Tail], Evaluation) ->
%%  parser(Tail, Evaluation);
%%parser(Evaluation) ->
%%  evaluator(Evaluation).
%%
evaluator(ParsedInput) ->
  io:format('After careful and ingenius consideration I have concluded:\n'),
  io:fwrite("~w",[ParsedInput]).
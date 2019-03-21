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
  Input = "(~(2+3)-4)",
  output(evaluator(parser(tokenise(Input), [], []))).

tokenise([]) -> [];
tokenise([$(|Tail]) -> [{s, lb}|tokenise(Tail)];
tokenise([$)|Tail]) -> [{s, rb}|tokenise(Tail)];
tokenise([$+|Tail]) -> [{o, plus}|tokenise(Tail)];
tokenise([$-|Tail]) -> [{o, minus}|tokenise(Tail)];
tokenise([$*|Tail]) -> [{o, multiply}|tokenise(Tail)];
tokenise([$/|Tail]) -> [{o, divide}|tokenise(Tail)];
tokenise([$~|Tail]) -> [{o, um}|tokenise(Tail)];
tokenise([Head|Tail]) -> [String, Number] = get_number([Head|Tail],0), [{n, Number}|tokenise(String)].

get_number([], Num) -> Num;
get_number([Head|Tail], Num) when Head >= 48, Head < 58 -> get_number(Tail, (Num*10)+(Head-$0));
get_number([Head|Tail], Num) -> [[Head|Tail], Num].

parser([], _, RPN_String) -> reverse(RPN_String);
parser([{s, lb}|Tail], Stack, RPN_String) -> parser(Tail, [lb|Stack], RPN_String);
parser([{s, rb}|Tail], Stack, RPN_String) -> {Operators, New_Stack} = pop(Stack),
  parser(Tail, New_Stack, [Operators|RPN_String]);
%%parser([{o, um}|Tail], Stack, RPN_String) -> parser(Tail, Stack, [um|RPN_String); Unirary operator didnt get done
parser([{o, Value}|Tail], Stack, RPN_String) -> parser(Tail, [Value|Stack], RPN_String);
parser([{n, Value}|Tail], Stack, RPN_String) -> parser(Tail, Stack, [Value|RPN_String]).

pop([]) -> [];
pop([lb|Tail]) -> [Tail];
pop([Head|Tail])-> {Head, pop(Tail)}.

reverse(L) -> reverse(L,[]). % use an accumulator to create a tail recursive function
reverse([],R) -> R;
reverse([H|T],R) -> reverse(T,[H|R]).

evaluator([Final | []]) -> Final;
evaluator([First|[Second | [plus | Rest]]]) -> evaluator([First+Second | Rest]);
evaluator([First|[Second | [minus | Rest]]]) ->evaluator([First-Second | Rest]);
evaluator([First|[Second | [multiply | Rest]]]) ->evaluator([First*Second | Rest]);
evaluator([First|[Second | [divide | Rest]]])->evaluator([First/Second | Rest]);
evaluator([um, Second | Rest]) ->evaluator([-Second | Rest]).

output(Output) ->
  io:format('After careful and ingenius consideration I have concluded:\n'),
  io:fwrite("~w",[Output]).
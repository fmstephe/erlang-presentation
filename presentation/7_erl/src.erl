-module('src').
-export([go/0]).

go()->
	Numbers = 1000,
	fan_out(Numbers),
	Total = fan_in(Numbers),
	io:format("~w~n",[Total]),
	init:stop().

fan_out(0) -> ok;

fan_out(Count) ->
	Me = self(),
	spawn(fun() -> calc(Me, Count) end),
	fan_out(Count - 1).

fan_in(0) -> 0;

fan_in(Count) ->
	Total = receive
		{value, Value} -> Value
	end,
	Total + fan_in(Count-1).

calc(Pid, Number) ->
	Exp = Number * Number,
	Pid ! {value, Exp}.

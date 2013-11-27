-module('src').
-export([go/0]).

go()->
	Me = self(),
	spawn(fun() -> boring(Me) end),
	listen(5),
	init:stop().

listen(0) -> ok;

listen(Count) ->
	receive
		Msg -> io:format("~s~n",[Msg])
	end,
	listen(Count-1).

boring(Pid) ->
	Pid ! "Hello World",
	boring(Pid).

-module('src').
-export([go/0]).

go()->
	spawn(fun() -> boring(0) end),
	timer:sleep(1000),
	init:stop().

boring(Count) ->
	io:format("Hello World ~w~n",[Count]),
	boring(Count+1).

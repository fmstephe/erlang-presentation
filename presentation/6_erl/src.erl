-module('src').
-export([go/0]).

go()->
	Me = self(),
	spawn(fun() -> hello_world(Me) end),
	spawn(fun() -> goodbye_cruel_world(Me) end),
	spawn(fun() -> lonely_func(Me) end),
	listen(100),
	init:stop().

listen(0) -> ok;

listen(Count) ->
	receive
		{hello, Msg} -> io:format("~s~n",[Msg]);
		{goodbye, Msg} -> io:format("~s~n",[Msg]);
		{_, _} -> ok
	end,
	listen(Count-1).

hello_world(Pid) ->
	Pid ! {hello, "Hello World"},
	timer:sleep(5),
	hello_world(Pid).

goodbye_cruel_world(Pid) ->
	Pid ! {goodbye, "Goodbye Cruel World"},
	timer:sleep(5),
	goodbye_cruel_world(Pid).

lonely_func(Pid) ->
	Pid ! {lonely, "Nobody listens to me!"},
	timer:sleep(5),
	goodbye_cruel_world(Pid).

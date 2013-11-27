-module('src').
-export([go/0]).

go()->
	Me = self(),
	spawn(fun() -> hello_world(Me) end),
	spawn(fun() -> goodbye_cruel_world(Me) end),
	listen_hello(10),
	init:stop().

listen_hello(0) -> ok;

listen_hello(Count) ->
	receive
		{hello, Msg} -> io:format("~s~n",[Msg])
	end,
	listen_goodbye(Count-1).

listen_goodbye(0) -> ok;

listen_goodbye(Count) ->
	receive
		{goodbye, Msg} -> io:format("~s~n",[Msg])
	end,
	listen_hello(Count-1).

hello_world(Pid) ->
	Pid ! {hello, "Hello World"},
	timer:sleep(5),
	hello_world(Pid).


goodbye_cruel_world(Pid) ->
	Pid ! {goodbye, "Goodbye Cruel World"},
	timer:sleep(5),
	goodbye_cruel_world(Pid).

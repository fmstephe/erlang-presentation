-module('src').
-export([go/0]).

go()->
	boring(5),
	init:stop().

boring(0) -> ok;

boring(Count) ->
	io:format("Hello World~n"),
	boring(Count - 1).

-module('src').
-export([go/0]).

go()->
	io:format("Hello World~n"),
	init:stop().

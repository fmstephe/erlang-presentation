-module('src').
-export([go/0]).

go()->
	Web_Service = spawn(fun() -> start_slow_engine(web) end),
	Image_Service = spawn(fun() -> start_slow_engine(image) end),
	Video_Service = spawn(fun() -> start_slow_engine(video) end),
	Services = [Web_Service, Image_Service, Video_Service],
	test(5, Services),
	init:stop().

test(0, _Services) -> ok;

test(Count, Services) ->
	Results = search(Services, Count),
	io:format("~p~n~n", [Results]),
	test(Count-1, Services).

start_slow_engine(Kind) ->
	timer:sleep(1),
	{_A1, _A2, A3} = now(),
	random:seed(A3,A3,A3),
	slow_engine(Kind).

slow_engine(Kind) ->
	Time = random:uniform(5000),
	receive
		{Pid, Query} -> spawn(fun() -> Pid ! {result, Kind, slow_search(Query, Time) } end)
	end,
	slow_engine(Kind).

slow_search(Query, Time) ->
	timer:sleep(Time),
	{Query, Time}.

search([], _Query) -> [];

search([Service|Services], Query) ->
	Service ! {self(), Query},
	Results = search(Services, Query),
	receive
		{result, Kind, {Query, Time}} -> [{Kind, Query, Time} | Results]
	end.

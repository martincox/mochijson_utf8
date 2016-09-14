-module(tcp).

-export([init/1]).

init([]) ->
    {ok, Listen} = gen_tcp:listen(9999, [{active, once},
                                         {packet, raw}]),

    {ok, Accept} = gen_tcp:accept(Listen),
    loop(Accept).

loop(Accept) ->
    inet:setopts(Accept, [{active, once}]),
    receive
        {tcp, Socket, Data} ->
            Encoded = mochijson2:encode(unicode:characters_to_binary(Data, utf8, latin1)),
            send(Accept, Encoded),
            io:format("~p~n", [Encoded]),
            loop(Socket)
    end.

send(Socket, Data) ->
    gen_tcp:send(Socket, Data).

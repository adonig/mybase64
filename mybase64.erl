%% @author Andreas Donig <andreas@innwiese.de>
%% @doc Functions encoding and decoding binary data from and to Base64.
%% @copyright 2013 by Andreas Donig
%% @version 0.3

-module(mybase64).
-export([encode_base64/1, decode_base64/1]).

-define(INDEX_TABLE,
	"ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/").

%% @doc Encodes binary data to Base64.

-spec(encode_base64(binary()) -> binary()).

encode_base64(Input) ->
    {Padded, Pads} = pad(Input),
    encode_padded(Padded, Pads).

-spec(pad(binary()) -> {binary(),integer()}).

pad(Input) ->
    Pads = (3-(byte_size(Input) rem 3)) rem 3,
    Padded = <<Input/binary,0:(Pads*8)>>,
    {Padded, Pads}.

-spec(encode_padded(binary(), integer()) -> binary()).

encode_padded(<<>>, 0)                               ->
    <<>>;
encode_padded(<<A:6,B:6,0:6,0:6>>, 2)                ->
    <<(e(A)),(e(B)),"=","=">>;
encode_padded(<<A:6,B:6,C:6,0:6>>, 1)                ->
    <<(e(A)),(e(B)),(e(C)),"=">>;
encode_padded(<<A:6,B:6,C:6,D:6,Rest/binary>>, Pads) -> 
    <<(e(A)),(e(B)),(e(C)),(e(D)),(encode_padded(Rest, Pads))/binary>>.

-spec(e(byte()) -> byte()).

e(X) ->
    lists:nth(X+1, ?INDEX_TABLE).

%% @doc Decodes Base64-encoded binary data.

-spec(decode_base64(binary()) -> binary()).

decode_base64(<<>>)                            -> 
    <<>>;
decode_base64(<<U:8,V:8,"=","=">>)             ->
    <<(d(U)):6,(d(V) bsr 4):2>>;
decode_base64(<<U:8,V:8,W:8,"=">>)             ->
    <<(d(U)):6,(d(V)):6,(d(W) bsr 2):4>>;
decode_base64(<<U:8,V:8,W:8,X:8,Rest/binary>>) ->
    <<(d(U)):6,(d(V)):6,(d(W)):6,(d(X)):6,(decode_base64(Rest))/binary>>.

-spec(d(byte()) -> byte()).

d(X) ->
    Index = string:chr(?INDEX_TABLE, X)-1,
    <<0:2,D:6>> = binary:encode_unsigned(Index),
    D.

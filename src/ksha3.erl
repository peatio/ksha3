-module(ksha3).
-author('b@b3k.us').

-export([init/1,
         update/2,
         update/3,
         final/1,
         hash/2,
         hash/3,
         hexhash/2]).

-on_load(init/0).

init() ->
    case code:priv_dir(ksha3) of
        {error, bad_name} ->
            SoName = filename:join(["..", "priv", "ksha3_nifs"]);
        Dir ->
            SoName = filename:join(Dir, "ksha3_nifs")
    end,
    case erlang:load_nif(SoName, 0) of
        ok -> ok;
        {error, {load, _}} -> ok;
        {error, {reload, _}} -> ok;
        {error, {upgrade, _}} -> ok;
        Error -> Error
    end.

-spec init(non_neg_integer()) -> {ok, binary()} | {error, atom()}.
init(_Bits) ->
    erlang:nif_error({error, not_loaded}).

-spec update(binary(), binary()) -> {ok, binary()} | {error, atom()}.
update(State, Data) -> update(State, Data, bit_size(Data)).

-spec update(binary(), binary(), non_neg_integer()) -> {ok, binary()} | {error, atom()}.
update(_State, _Data, _BitLength) ->
    erlang:nif_error({error, not_loaded}).

-spec final(binary()) -> {ok, binary()} | {error, atom()}.
final(_State) ->
    erlang:nif_error({error, not_loaded}).

hexhash(Bits, Data) ->
  {ok, Hash} = hash(Bits, Data, bit_size(Data)),
  list_to_binary(hex2bin:bin_to_hexstr(Hash)).

-spec hash(non_neg_integer(), binary()) -> {ok, binary()} | {error, atom()}.
hash(Bits, Data) -> hash(Bits, Data, bit_size(Data)).

-spec hash(non_neg_integer(), binary(), non_neg_integer()) -> {ok, binary()} | {error, atom()}.
hash(_Bits, _Data, _BitLength) ->
    erlang:nif_error({error, not_loaded}).

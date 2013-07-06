-module(mybase64_tests).

-include_lib("eunit/include/eunit.hrl").

-import(mybase64, [encode_base64/1, decode_base64/1]).


encode_one_byte_zeros_test() ->
    ?assertEqual(<<"AA==">>, encode_base64(<<0:8>>)).

decode_one_byte_zeros_test() ->
    ?assertEqual(<<0:8>>, decode_base64(<<"AA==">>)).


encode_two_bytes_zeros_test() ->
    ?assertEqual(<<"AAA=">>, encode_base64(<<0:(2*8)>>)).

decode_two_bytes_zeros_test() ->
    ?assertEqual(<<0:(2*8)>>, decode_base64(<<"AAA=">>)).


encode_three_bytes_zeros_test() ->
    ?assertEqual(<<"AAAA">>, encode_base64(<<0:(3*8)>>)).

decode_three_bytes_zeros_test() ->
    ?assertEqual(<<0:(3*8)>>, decode_base64(<<"AAAA">>)).


encode_empty_string_test() ->
    ?assertEqual(<<"">>, encode_base64(<<"">>)).

decode_empty_string_test() ->
    ?assertEqual(<<"">>, decode_base64(<<"">>)).


encode_nonempty_string1_test() ->
    ?assertEqual(<<"cGxlYXN1cmUu">>, encode_base64(<<"pleasure.">>)).

decode_nonempty_string1_test() ->
    ?assertEqual(<<"pleasure.">>, decode_base64(<<"cGxlYXN1cmUu">>)).


encode_nonempty_string2_test() ->
    ?assertEqual(<<"bGVhc3VyZS4=">>, encode_base64(<<"leasure.">>)).

decode_nonempty_string2_test() ->
    ?assertEqual(<<"leasure.">>, decode_base64(<<"bGVhc3VyZS4=">>)).


encode_nonempty_string3_test() ->
    ?assertEqual(<<"ZWFzdXJlLg==">>, encode_base64(<<"easure.">>)).

decode_nonempty_string3_test() ->
    ?assertEqual(<<"easure.">>, decode_base64(<<"ZWFzdXJlLg==">>)).


encode_nonempty_string4_test() ->
    ?assertEqual(<<"YXN1cmUu">>, encode_base64(<<"asure.">>)).

decode_nonempty_string4_test() ->
    ?assertEqual(<<"asure.">>, decode_base64(<<"YXN1cmUu">>)).


encode_nonempty_string5_test() ->
    ?assertEqual(<<"c3VyZS4=">>, encode_base64(<<"sure.">>)).

decode_nonempty_string5_test() ->
    ?assertEqual(<<"sure.">>, decode_base64(<<"c3VyZS4=">>)).


encode_leviathan_test() ->
    ?assertEqual(<<"TWFuIGlzIGRpc3Rpbmd1aXNoZWQsIG5vdCBvbmx5IGJ5IGhpcyByZWFzb24sIGJ1dCBieSB0aGlzIHNpbmd1bGFyIHBhc3Npb24gZnJvbSBvdGhlciBhbmltYWxzLCB3aGljaCBpcyBhIGx1c3Qgb2YgdGhlIG1pbmQsIHRoYXQgYnkgYSBwZXJzZXZlcmFuY2Ugb2YgZGVsaWdodCBpbiB0aGUgY29udGludWVkIGFuZCBpbmRlZmF0aWdhYmxlIGdlbmVyYXRpb24gb2Yga25vd2xlZGdlLCBleGNlZWRzIHRoZSBzaG9ydCB2ZWhlbWVuY2Ugb2YgYW55IGNhcm5hbCBwbGVhc3VyZS4=">>, encode_base64(<<"Man is distinguished, not only by his reason, but by this singular passion from other animals, which is a lust of the mind, that by a perseverance of delight in the continued and indefatigable generation of knowledge, exceeds the short vehemence of any carnal pleasure.">>)).

decode_leviathan_test() ->
    ?assertEqual(<<"Man is distinguished, not only by his reason, but by this singular passion from other animals, which is a lust of the mind, that by a perseverance of delight in the continued and indefatigable generation of knowledge, exceeds the short vehemence of any carnal pleasure.">>, decode_base64(<<"TWFuIGlzIGRpc3Rpbmd1aXNoZWQsIG5vdCBvbmx5IGJ5IGhpcyByZWFzb24sIGJ1dCBieSB0aGlzIHNpbmd1bGFyIHBhc3Npb24gZnJvbSBvdGhlciBhbmltYWxzLCB3aGljaCBpcyBhIGx1c3Qgb2YgdGhlIG1pbmQsIHRoYXQgYnkgYSBwZXJzZXZlcmFuY2Ugb2YgZGVsaWdodCBpbiB0aGUgY29udGludWVkIGFuZCBpbmRlZmF0aWdhYmxlIGdlbmVyYXRpb24gb2Yga25vd2xlZGdlLCBleGNlZWRzIHRoZSBzaG9ydCB2ZWhlbWVuY2Ugb2YgYW55IGNhcm5hbCBwbGVhc3VyZS4=">>)).


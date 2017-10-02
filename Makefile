all:
	./rebar3 compile -v

clean:
	./rebar3 delete-deps -v
	./rebar3 clean -v

eunit:
	./rebar3 eunit -v

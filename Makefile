<<<<<<< HEAD
## usage:
## just "make" or "make NOTEST=true" for release build.

VERSION=1.0.0

ERL=$(shell which erl)
ERLC=$(shell which erlc)
BASE_PROG='io:format("~s~n", [code:lib_dir()])'
BASE=$(shell erl -eval $(BASE_PROG) -s init stop -noshell)

DEPS="[kernel, stdlib, crypto, compiler, syntax_tools, hipe]"
PROG='lists:foreach(fun(M) -> io:format("~s", [code:lib_dir(M)]) end)'
PATHS=`erl -eval '$(PROG)' -s init stop -noshell`

INSTALL_DEST=$(BASE)/sqlite-$(VERSION)

ifdef NOTEST
EMAKE_SRC = Emakefile.release
else
EMAKE_SRC = Emakefile.devel
endif
=======
REBAR=rebar
REBAR_COMPILE=$(REBAR) get-deps compile
PLT=dialyzer\sqlite3.plt
ERL_INTERFACE=$(ERL_ROOT)\lib\erl_interface-3.7.2
ERTS=$(ERL_ROOT)\erts-5.8.2
SQLITE_SRC=F:\MyProgramming\sqlite-amalgamation
>>>>>>> c3817095b2d2aa5ccb5bd2cd9ecc42e6f7822ed7

all: compile

<<<<<<< HEAD
compile:
	cp $(EMAKE_SRC) Emakefile
	$(ERL) -make
	cd priv && make

install: compile
	mkdir -p $(INSTALL_DEST)/ebin
	install ebin/sqlite.beam ebin/sqlite_lib.beam $(INSTALL_DEST)/ebin
	mkdir -p $(INSTALL_DEST)/priv
	install priv/sqlite_port $(INSTALL_DEST)/priv

static:
	dialyzer --build_plt --output_plt sqlite.plt -r ebin $(PATHS)

clean:
	- rm -rf ebin/*.beam doc/* sqlite.plt src/test/*.beam
	- rm -rf ct.db
	find . -name "*~" | xargs rm
	cd priv && make clean

docs:
	$(ERL) -noshell -run edoc_run application "'sqlite'" '"."' '[{title,"Welcome to sqlite"},{hidden,false},{private,false}]' -s erlang halt

test: compile
	- rm -rf ct.db
	$(ERL) -pa ./ebin -noshell -run test unit -s erlang halt
=======
compile: 
	$(REBAR_COMPILE)

debug:
	$(REBAR_COMPILE) -C rebar.debug.config

tests:
	$(REBAR) eunit

clean:
	del /Q deps ebin priv doc\* .eunit c_src\*.o

docs:
	$(REBAR_COMPILE) doc

static: compile
	@if not exist $(PLT) \
		(mkdir dialyzer & dialyzer --build_plt --apps kernel stdlib erts --output_plt $(PLT)); \
	else \
		(dialyzer --plt $(PLT) -r ebin)

cross_compile: clean
	$(REBAR_COMPILE) -C rebar.cross_compile.config
>>>>>>> c3817095b2d2aa5ccb5bd2cd9ecc42e6f7822ed7

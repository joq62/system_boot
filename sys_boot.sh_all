#!/bin/bash
rm -rf ctrl;
rm -rf *_container;
rm -rf Mnesia.*;
rm -rf *_specs;
rm -rf ebin;
rm -rf test_ebin;
rm -rf *~ */*~ */*/*~;
rm -rf apps/*/src/*.beam;
rm -rf test/*.beam test/*/*.beam;
rm -rf *.beam;
rm -rf _build;
rm -rf ebin;
rm -rf rebar.lock
git clone https://github.com/joq62/ctrl.git;
cd ./ctrl && rebar3 compile;
pwd
cd ..
pwd
erl -pa ctrl/application_specs -pa ctrl/host_spec -pa ctrl/_build/default/lib/log/ebin -pa ctrl/_build/default/lib/rd/ebin -pa ctrl/_build/default/lib/common/ebin -pa ctrl/_build/default/lib/application_server/ebin -pa ctrl/_build/default/lib/host_server/ebin -pa ctrl/_build/default/lib/ctrl/ebin -sname ctrl -s main_controller start -setcookie a -detached -noinput &

#!/bin/bash
erl -pa ctrl/application_specs -pa ctrl/host_spec -pa ctrl/_build/default/lib/log/ebin -pa ctrl/_build/default/lib/rd/ebin -pa ctrl/_build/default/lib/common/ebin -pa ctrl/_build/default/lib/application_server/ebin -pa ctrl/_build/default/lib/host_server/ebin -pa ctrl/_build/default/lib/ctrl/ebin -sname ctrl -s boot start -setcookie a -detached -noinput &

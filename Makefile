all:
	sudo rm -rf ctrl;
	git clone https://github.com/joq62/ctrl.git;
	cd ctrl;
	rm -rf rebar.lock;
	rm -rf _build;
	rebar3 compile;
	cd ../;
	echo pwd


load_system_boot:
	rm -rf system_boot;
	git clone https://github.com/joq62/system_boot.git;
	cp system_boot/sys_boot.sh .
	#INFO: with_ebin_commit ENDED SUCCESSFUL
start:
	erl -pa ebin\
	 -sname system_boot_a\
	 -run system_boot start\
	 -setcookie a

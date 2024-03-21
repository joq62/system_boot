all:
        rm -rf  *~ */*~ catalog system_boot;
        mkdir catalog;
        mkdir catalog/application_dir;
        mkdir catalog/application_dir/log;
        git clone https://github.com/joq62/log.git catalog/application_dir/log;
        mkdir catalog/application_dir/resource_discovery;
        git clone https://github.com/joq62/resource_discovery.git catalog/application_dir/resource_discovery;
	 mkdir catalog/application_dir/catalog;
        git clone https://github.com/joq62/catalog.git catalog/application_dir/catalog;
	mkdir catalog/application_dir/host;
        git clone https://github.com/joq62/host.git catalog/application_dir/host;
	mkdir catalog/application_dir/controller;
        git clone https://github.com/joq62/controller.git catalog/application_dir/controller;
	mkdir catalog/application_dir/deployment;
        git clone https://github.com/joq62/host.git catalog/application_dir/deployment;
	git clone https://github.com/joq62/system_boot.git;
        echo Done;
start:
        cd /home/ubuntu;
        erl -pa system_boot/ebin -sname system_boot_a -setcookie a -run system_boot start -noinput

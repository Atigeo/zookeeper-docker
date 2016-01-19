#!/bin/bash
# This is the base process of the container.

init()
{
	chown zookeeper:zookeeper /var/lib/zookeeper/
	service zookeeper-server init
}


# Initalize the container
init_container()
{
	init
	start_container
}

# Start zookeeper and tail logs to keep PID 1 going.
start_container() 
{
	chown zookeeper:zookeeper /var/lib/zookeeper/
	start_zookeeper
	sleep 5
	tail -f /var/log/zookeeper/*.out
}

# Start the tomcat service
start_zookeeper() 
{
	# Start the Zookeeper service
	echo -e "\n---- Luanching Zookeeper ----\n"
	service zookeeper-server start
}

# Stop the tomcat service
stop_zookeeper() 
{
	service zookeeper-server stop
}


# Startup the container
if [ -z $1 ] || [ "$1" == "run" ]; then
	start_container
fi

# Initalize the container
if [ "$1" == "init" ]; then 
	init_container
fi

# Start
if [ "$1" == "start" ]; then 
	start_zookeeper
fi

# Stop
if [ "$1" == "stop" ]; then 
	stop_zookeeper
fi

# Restart
if [ "$1" == "restart" ]; then 
	stop_zookeeper
	sleep 2
	start_zookeeper
fi

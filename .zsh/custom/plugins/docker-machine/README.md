# docker-machine plugin for oh my zsh

### Usage

#### docker-vm
Will create a docker-machine with the name "default" (required only once)
To create a second machine call "docker-vm foobar" or pass any other name

#### docker-up
This will start your "default" docker-machine (if necessary) and set it as the active one
To start a named machine use "docker-up foobar"

#### docker-switch
Use this to activate a running docker-machine (or to switch between multiple machines)
You need to call either this or docker-up when opening a new terminal
If no name is passed, it will unset all related variables

#### docker-stop
This will stop your "default" docker-machine
To stop a named machine use "docker-stop foobar"

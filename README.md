# A Dockerized ROS1 Workspace for Working with the Franka-Setup of TU Delft

Powered by [nachovizzo/ros1_devcontainer](https://github.com/nachovizzo/ros_in_docker)

In contrast to Nacho's base-setup, this repo

1. depends on relevant submodules that we use for the franka
1. also builds a compatible `libfranka`
1. Forward `ROS_MASTER_URI`, `ROS_IP` and `ROS_HOSTNAME` environment variables to the container

## Tested host-machines

- Ubuntu 22.04

## Host-machine dependencies

For now, you only need, I expect this repo to be used by "intermediate" developers, so I guess you
can figure out how to do that.

- docker
- docker-compose
- (VSCode) dev-containers extension

## How to use with your project (VSCode)

![vscode](https://user-images.githubusercontent.com/21349875/200361817-572292e3-3d73-4fb1-bd9d-562539fa2fb4.png)

1. Git clone the repo locally and `cd` into it. Make sure to clone _recursively_ to get all the submodules.
1. Clone inside the `src/` directory the ROS1 code you want to
   develop/test. I will be using the
   [ros_tutorials](https://github.com/ros/ros_tutorials) as an example, but it can be as complex as
   you wish, so, `git clone git@github.com:ros/ros_tutorials.git src/`
1. Launch `code .`, and then go to the "Remote Explorer" tab and hit "reopen the current folder in a
   container", this should launch a full dev environemnt with some extensions to develop your ROS
   application in the dockerize environment
1. Launch the `Build Task`, Ctrl+Shift+p and type "Tasks: Run Build Task"

## What about injecting rosbags inside the dev container?

Got you covered, just use the environment variable `export ROS_BAGS=/path/to/data/in/host` and
launch `make`. Your rosbag files will be mounted in the dev container in `~/ros_ws/bags` and are
read-only accessible to the ROS1 applications.

## How to extend the container

Could not be more simple, just add all your user-space command on the [Dockerfile](./Dockerfile).
`apt install <your-libs>` and enjoy the setup.

## GUI Supported?

Of course, you can run `rviz` and friends inside the dev container, it looks a bit ugly but at least
it works.

## Security concerns

The entire setup is NOT safe at all, so, use it at your own risk. I'm mounting directories from the
host machine to the docker container where the user has `sudo` access without a password. So you can
literally delete some stuff with `root` permissions without even typing a password. So, you are
warned!

# Goals

# Install docker

- https://docs.docker.com/engine/install/ubuntu/
- https://docs.docker.com/engine/install/linux-postinstall/


# Goals

1. Load the barrows hall map

2. Create the cartographer map and optimize trajectories
3. Try different variations of the algorithms
4. Evaluate if re-implementing RRT is a possible exercise, or showing some
   transformation questions.

# Fixes

1. `f1tenth_gym` module does not behave well with colcon build. Bypass colcon
   build and install it using `pip install -e ` and then ignore it using
   `touch COLCON_IGNORE`

# Commands

Check if the docker container exists

```
docker compose ps
```

For me it results in:

```
$ docker compose ps
NAME                                IMAGE                           COMMAND                  SERVICE   CREATED       STATUS              PORTS
forzaeth_devcontainer_x86_vdhiman   race_stack:humble_x86_vdhiman   "/ros_entrypoint.sh …"   x86       13 days ago   Up About a minute 
```

If the container `forzaeth_devcontainer_x86_$USER` exists

```
. setup.bash
docker compose exec x86 /bin/bash
```

If the container does not exists:

```
docker compose start x86
```

Inside docker container:

```
ros2 run rmw_zenoh_cpp rmw_zenohd &
ros2 launch stack_master base_system_launch.xml map_name:=barrows_floor2 racecar_version:=SIM sim:=true
```

mapping_launch.xml is not needed for the simulator

Generate trajectories

```
ros2 launch stack_master planner_launch.xml map_name:=barrows_floor2
```


A GUI will popup showing you the map and the extracted centerline. If you are satisfied you can close it to start the global raceline generation. If you have no monitor it starts automatically. Then two GUIs will be shown, and within them a slider can be used to select the velocity scaling and overtaking sectors. 
Be careful as once a sector is chosen it cannot be further subdivided. 

Run time trials in simulation using:

```
ros2 launch stack_master time_trials_launch.xml racecar_version:=SIM LU_table:=SIM_linear ctrl_algo:=PP
```

# Log

planner_launch.xml succeeded, generated some trajectories

# Notes

# Problems


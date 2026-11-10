#!/bin/bash

# Setup permissions
# USER="$(id -u -n)"
sudo chown -R $USER:$USER ~/ws/
if [[ "$CCACHE_DIR" && -d "$CCACHE_DIR" ]]; then
    sudo chown -R $USER:$USER "$CCACHE_DIR"
    sudo chmod o+x /root/
    sudo chown -R $USER:$USER /opt/venv
fi

# Install dependencies
rosdep update &&
    rosdep install --from-paths /home/$USERNAME/ws/src --ignore-src -y

# Setup race_stack
bash ~/ws/src/race_stack/.install_utils/f110_sim_setup.sh || echo "Failed to setup f110_sim"
bash ~/ws/src/race_stack/.install_utils/gb_opt_setup.sh || echo "Failed to setup gb_opt"

# Apply Joystick patch
sudo chmod 666 /dev/input/js0
sudo chmod 666 /dev/input/event*
sudo chmod 666 /dev/video*

# setup f1tenth_gym
cd ~/ws &&
    colcon build --packages-up-to f110_gym --base-paths ~/ws \
        --cmake-args "-DCMAKE_BUILD_TYPE=Release" "-DCMAKE_EXPORT_COMPILE_COMMANDS=On" \
        -Wall -Wextra -Wpedantic --cmake-clean-cache

cd ~/ws/src/race_stack &&
    ./.vscode/build.sh Release

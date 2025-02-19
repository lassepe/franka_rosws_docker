# MIT License
#
# Copyright (c) 2022 Ignacio Vizzo
#
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in all
# copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
# SOFTWARE.
FROM ignaciovizzo/ros_in_docker:noetic
LABEL maintainer="Ignacio Vizzo <ignaciovizzo@gmail.com>"

# Add any additional dependencies here:
RUN apt-get update && apt-get install --no-install-recommends -y \
    rsync \
    ros-noetic-realsense2-camera \
    build-essential \
    cmake \
    git \
    libpoco-dev \
    libeigen3-dev \
    libfmt-dev \
    ros-noetic-combined-robot-hw \
    ros-noetic-boost-sml \
    ros-noetic-pinocchio \
    && rm -rf /var/lib/apt/lists/*

# Also bake libfranka into the image
USER $USER_NAME
WORKDIR /home/$USER_NAME
RUN git clone --branch 0.9.2 --recursive https://github.com/frankaemika/libfranka/
RUN mkdir -p /home/$USER_NAME/libfranka/build
WORKDIR /home/$USER_NAME/libfranka/build
RUN cmake -DCMAKE_BUILD_TYPE=Release -DCMAKE_PREFIX_PATH=/opt/openrobots/lib/cmake -DBUILD_TESTS=OFF ..
RUN make -j$(nproc)
ENV Franka_DIR=/home/$USER_NAME/libfranka/build

# $USER_NAME Inherited from .base/Dockerfile
WORKDIR /home/$USER_NAME/ros_ws
CMD ["zsh"]

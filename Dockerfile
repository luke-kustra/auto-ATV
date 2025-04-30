# Use Ubuntu base image
FROM ubuntu:20.04

# Avoid interactive prompts during package installation
ENV DEBIAN_FRONTEND=noninteractive

# Update and install system dependencies
RUN apt-get update && apt-get install -y \
    python3 python3-pip \
    git curl wget \
    libssl-dev \
    libusb-1.0-0-dev pkg-config \
    libgtk-3-dev \
    libglfw3-dev \
    libgl1-mesa-dev \
    libglu1-mesa-dev \
    cmake \
    build-essential \
    && apt-get clean

# Install TensorFlow
RUN pip3 install --upgrade pip && pip3 install tensorflow

# Clone and build the RealSense SDK
RUN git clone https://github.com/IntelRealSense/librealsense.git && \
    cd librealsense && \
    mkdir build && cd build && \
    cmake ../ -DBUILD_EXAMPLES=false -DBUILD_GRAPHICAL_EXAMPLES=false && \
    make -j4 && \
    make install

# Set the working directory
WORKDIR /app

# Copy your app.py into the image
COPY app.py .

# Set the command to run your Python app
CMD ["python3", "app.py"]

# Use a full Debian-based image instead of slim for RealSense dependencies
FROM python:3.10

# Set working directory
WORKDIR /app

# Install system dependencies for RealSense
RUN apt-get update && \
    apt-get install -y \
        git \
        wget \
        cmake \
        build-essential \
        libusb-1.0-0-dev \
        pkg-config \
        libgtk-3-dev && \
    rm -rf /var/lib/apt/lists/*

# Install TensorFlow and pyrealsense2
RUN pip install --upgrade pip && \
    pip install tensorflow pyrealsense2

# Copy your app into the container
COPY app.py .

# Set the command to run your app
CMD ["python", "app.py"]

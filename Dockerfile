# Use a suitable Linux base image
FROM ubuntu:20.04

# Install necessary packages
RUN apt-get update && \
    apt-get install -y qemu-kvm sudo curl

# Install Docker
RUN curl -fsSL https://get.docker.com -o get-docker.sh && sh get-docker.sh

# Ensure Docker commands can be run without sudo
RUN usermod -aG docker root

# Start Docker service
RUN service docker start

# Expose the required port
EXPOSE 8006

# Command to run the desired Docker container with KVM, using sudo
CMD ["sudo", "docker", "run", "-it", "--rm", "-p", "8006:8006", "--device=/dev/kvm", "--cap-add", "NET_ADMIN", "--stop-timeout", "120", "dockurr/windows"]

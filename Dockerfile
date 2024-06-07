# Use the official CirrusLabs Flutter Docker image
FROM ghcr.io/cirruslabs/flutter:3.22.0-0.3.pre

RUN apt-get update && apt-get install -y \
    openjdk-11-jdk \
    wget \
    unzip \
    git \
    openssl \
    && rm -rf /var/lib/apt/lists/*

# Set the working directory in the container
WORKDIR /app

COPY . .

# Ensure flutter is in the PATH
#ENV PATH="/flutter/bin:/flutter/bin/cache/dart-sdk/bin:${PATH}"
RUN chown -R $(whoami) /sdks/flutter/bin/cache

# Get Flutter dependencies
RUN flutter pub get

# Ensure licenses are accepted (Android SDK)
RUN yes | flutter doctor --android-licenses

# Set the permissions for the Flutter SDK cache directory

# Clean the Flutter project
RUN flutter clean

# Specify the default command to run when starting the container
RUN flutter test

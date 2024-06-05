# Use the specified Flutter image as the base image
FROM ghcr.io/cirruslabs/flutter:3.22.0-0.3.pre

# Set the working directory inside the container
WORKDIR /build

# Copy the current directory contents into the container at /build
COPY . .

# Install required dependencies
RUN apt-get update && \
    apt-get install -y openjdk-11-jdk wget unzip && \
    apt-get clean

# Set JAVA_HOME environment variable
ENV JAVA_HOME=/usr/lib/jvm/java-11-openjdk-amd64
ENV PATH="$JAVA_HOME/bin:$PATH"

# Download and install Android command-line tools
RUN mkdir -p /usr/local/android-sdk && \
    cd /usr/local/android-sdk && \
    wget https://dl.google.com/android/repository/commandlinetools-linux-8092744_latest.zip -O commandlinetools.zip && \
    unzip commandlinetools.zip -d cmdline-tools && \
    rm commandlinetools.zip && \
    mv cmdline-tools/cmdline-tools /usr/local/android-sdk/cmdline-tools/latest

# Set ANDROID_HOME environment variable
ENV ANDROID_HOME=/usr/local/android-sdk
ENV PATH="$ANDROID_HOME/cmdline-tools/latest/bin:$ANDROID_HOME/platform-tools:$PATH"

# Install Android SDK components
RUN yes | sdkmanager --licenses && \
    sdkmanager "platforms;android-30" "build-tools;30.0.3" "platform-tools"

# Ensure Flutter and Android SDK are in the PATH
ENV PATH="/build/flutter/bin:/build/flutter/bin/cache/dart-sdk/bin:$PATH"

# Run flutter doctor to verify the environment setup
RUN flutter doctor -v

# Install project dependencies
RUN flutter pub get

# Ensure the Android licenses are accepted
RUN yes | flutter doctor --android-licenses

# Run flutter doctor again to verify everything is set up correctly
RUN flutter doctor -v

# Build the Flutter app (e.g., APK for Android)
RUN flutter build apk --verbose --release

# Specify the default command to run in the container
CMD ["flutter", "test"]

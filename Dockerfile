# Use the official CirrusLabs Flutter Docker image
FROM ghcr.io/cirruslabs/flutter:3.22.0-0.3.pre
# Set the working directory in the container
WORKDIR /app

COPY . .

# Ensure flutter is in the PATH
#ENV PATH="/flutter/bin:/flutter/bin/cache/dart-sdk/bin:${PATH}"

# Get Flutter dependencies
RUN flutter pub get

# Ensure licenses are accepted (Android SDK)
RUN yes | flutter doctor --android-licenses

# Build the APK

# Specify the default command to run when starting the container
CMD ["flutter", "test"]
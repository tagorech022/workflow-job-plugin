# Stage 1: Build the plugin
FROM maven:3.9.6-amazoncorretto-17 as builder

# Set working directory
WORKDIR /plugin

# Copy plugin source code
COPY . .

# Build plugin (skip tests for speed)
RUN mvn clean install -DskipTests

# Stage 2: Output plugin .hpi in clean image (optional)
FROM amazoncorretto:17-alpine

# Create plugin output directory
WORKDIR /plugin-output

# Copy built plugin from builder stage
COPY --from=builder /plugin/target/*.hpi .

# Default command (just list built plugins)
CMD ["ls", "-lh"]

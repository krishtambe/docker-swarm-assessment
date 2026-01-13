# Use the official Node.js 20 image as the build stage
FROM node:20 AS build

# Set the working directory inside the container
WORKDIR /app

# Copy all files from the current directory to the working directory
COPY . .

# Install npm packages and build the application
RUN npm install && npm run build

# Use the official Nginx image for serving the built application
FROM nginx:alpine

# Copy the built application from the build stage to the Nginx HTML directory
COPY --from=build /app/build /usr/share/nginx/html

# Expose port 80 for the Nginx server
EXPOSE 80

# Define a health check command to verify the Nginx server is running
HEALTHCHECK CMD wget -qO- http://localhost || exit 1

# Use the official Python 3.11 slim image as the base image
FROM python:3.11-slim

# Set the working directory inside the container
WORKDIR /app

# Copy all files from the current directory to the working directory
COPY . .

# Install the required Python packages from requirements.txt
RUN pip install -r requirements.txt

# Set the user to a non-root user with UID 1001
USER 1001

# Expose port 5000 for the application
EXPOSE 5000

# Define a health check command to verify the application is running
HEALTHCHECK CMD curl -f http://localhost:5000/health || exit 1

# Command to run the application
CMD ["python","app.py"]

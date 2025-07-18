# Use the official Python image from Docker Hub as the base image
FROM python:3.13-slim

# Set the working directory in the container
WORKDIR /app

# Environment variables to prevent Python from writing .pyc files and to buffer stdout/stderr
ENV PYTHONDONTWRITEBYTECODE=1
ENV PYTHONUNBUFFERED=1

# Copy the requirements.txt file into the container
COPY ./requirements.txt .

# Install the Python dependencies
RUN pip install --upgrade pip && pip install -r requirements.txt

# Copy the rest of the application code into the container
COPY demo .

# Collect static files for the Django application
RUN python manage.py collectstatic --noinput

# Expose port 8000 to allow traffic to the application
EXPOSE 8000

# Define the command to run the application
CMD ["gunicorn", "demo.wsgi:application", "--bind", "0.0.0.0:8000"]
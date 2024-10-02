# Use the official Python image from the Docker Hub
FROM python:3.12-slim

# Set environment variables
ENV PYTHONDONTWRITEBYTECODE=1
ENV PYTHONUNBUFFERED=1

# Set the working directory inside the container
WORKDIR /app

# Copy poetry.lock and pyproject.toml files first for better caching of dependencies
COPY pyproject.toml poetry.lock* ./

# Install Poetry and dependencies
RUN pip install --no-cache-dir poetry && poetry install --no-dev

# Copy the rest of the application code, including tests
COPY . .

# Run tests using pytest (optional)
RUN poetry run pytest -v

# Command to run your application using the entry point defined in pyproject.toml
CMD ["poetry", "run", "pack-cli"]  # This runs your CLI command defined in pyproject.toml

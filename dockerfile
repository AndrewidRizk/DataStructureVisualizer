FROM python:3.11-slim

# Install build tools
RUN apt-get update && apt-get install -y \
    build-essential \
    libpq-dev \
    && rm -rf /var/lib/apt/lists/*

# Set working directory
WORKDIR /app

# Copy requirements first (for caching)
COPY requirements.txt .

# Install Python dependencies
RUN pip install --no-cache-dir -r requirements.txt

# Now copy the rest of the app
COPY . .

# Expose port
EXPOSE 5000

# Run Flask (make sure host='0.0.0.0' in wsgi.py)
CMD ["python3", "wsgi.py"]

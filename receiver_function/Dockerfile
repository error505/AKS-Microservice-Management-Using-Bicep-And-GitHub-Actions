# Use the official Azure Functions Python base image
FROM mcr.microsoft.com/azure-functions/python:4-python3.9

# Set the working directory
WORKDIR /home/site/wwwroot

# Copy the requirements file and install dependencies
COPY requirements.txt .

# Install Python dependencies
RUN pip install --no-cache-dir -r requirements.txt

# Copy the function app code to the working directory
COPY . .

# Expose the port Azure Functions runtime is expected to run on
EXPOSE 80

# Entry point for the Azure Functions runtime
CMD ["python", "function_app.py"]

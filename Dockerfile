FROM python:3.9-slim

# Set the working directory in the container
WORKDIR /Tides

# Install system dependencies
RUN apt-get update && apt-get install -y \
    libgdal-dev \
    libspatialindex-dev \
    nodejs \
    npm \
 && apt-get clean \
 && rm -rf /var/lib/apt/lists/*

# Install npm global package
RUN npm install -g dbdocs 

# Upgrade pip and install Python dependencies
COPY requirements.txt .
RUN pip install --upgrade pip \
 && pip install pandas fiona shapely pyproj rtree \
 && pip install geopandas \
 && pip install -r requirements.txt

# Expose the port Jupyter Lab will run on
EXPOSE 8888

# Command to run Jupyter Lab
CMD ["jupyter", "lab", "--ip=0.0.0.0", "--allow-root"]

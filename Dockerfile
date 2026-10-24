FROM python:3.11-slim

# Install system dependencies
RUN apt-get update && apt-get install -y \
    build-essential \
    && apt-get clean && rm -rf /var/lib/apt/lists/*

WORKDIR /app

# Install Python dependencies
RUN pip install --no-cache-dir pandas numpy scikit-learn flask flask-cors

# Copy application files
COPY . .

# Create data dir
RUN mkdir -p /app/data

EXPOSE 5000

# Run a quick summary then keep container alive
CMD ["sh", "-c", "python -c \"import pandas as pd; df=pd.read_csv('creditcard.csv', nrows=1000); print('Credit fraud dataset rows(sample):', len(df)); print(df.head())\" && python -m http.server 5000"]

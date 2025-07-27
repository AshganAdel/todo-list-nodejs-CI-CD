# Use Node.js base image
FROM node:18

# Set working directory
WORKDIR /app

# Copy files
COPY . /app/

# Install dependencies
RUN npm install

# Expose port
EXPOSE 4000

# Run the app
CMD [ "npm", "start" ]

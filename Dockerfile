# Use the official Node.js LTS image
FROM node:22-alpine

# Set the working directory inside the container
WORKDIR /app

# Install tools required at runtime
RUN apk add --no-cache git

# Copy package.json and package-lock.json for dependency installation
COPY package*.json ./

# Install dependencies
RUN npm install

# Copy the rest of the application files
COPY . .

# Copy entrypoint that refreshes the repo when the container starts
COPY docker-entrypoint.sh /usr/local/bin/docker-entrypoint.sh
RUN chmod +x /usr/local/bin/docker-entrypoint.sh

# Expose the default Next.js port
EXPOSE 3000

# Command to run the development server
ENTRYPOINT ["/usr/local/bin/docker-entrypoint.sh"]
CMD ["npm", "run", "dev"]

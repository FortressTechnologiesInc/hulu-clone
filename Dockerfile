# Use the Alpine Linux base image
FROM alpine:3.14

# Update package repository and install necessary packages
RUN apk update && \
    apk add --no-cache nodejs npm curl git

# Install the 'serve' package globally
RUN npm install -g serve

# Clone the GitHub repository
RUN git clone https://github.com/somanath-goudar/hulu-clone.git /app
ARG TMDB_V3_API_KEY
ENV VITE_APP_TMDB_V3_API_KEY=${TMDB_V3_API_KEY}
ENV VITE_APP_API_ENDPOINT_URL="https://api.themoviedb.org/3"
# Set the working directory to the cloned repository
WORKDIR /app
COPY ./ /app/
# Install application dependencies (if you have a package.json file)
# Uncomment the following line if you have a package.json file:
RUN npm install --force
RUN npm install
RUN npm run build
RUN npm start &
RUN npm install -g serve

# Expose the port on which 'serve' will run (default is 5000)
EXPOSE 3000

# Command to start the application using 'serve'
ENTRYPOINT ["npm", "start"]
#CMD ["serve", "-s", "build", "-l", "3000", "/bin/bash"]


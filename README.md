# LocalLink

This repository is intended to serve as a starting point for new projects. It provides a basic structure and guidelines for organizing your code and documentation.

## Purpose

The purpose of this repository is to help developers quickly set up a new project with a well-organized structure. It includes templates for common files such as README, LICENSE, and .gitignore, as well as guidelines for writing documentation and organizing your code.

## Getting Started

To get started, simply clone this repository and customize it to fit your needs. You can replace the placeholder content with your own, and add any additional files or directories as needed.

## Running the Application

### Using Docker

1. Build the Docker image:
   ```sh
   docker build -t locallink .
   ```

2. Run the Docker container:
   ```sh
   docker run -p 3000:3000 locallink
   ```

### Using Makefile

1. Build the Docker image:
   ```sh
   make build
   ```

2. Run the Docker container:
   ```sh
   make run
   ```

## Setting up Postgres and pgAdmin

### Using Docker Compose

1. Start the services:
   ```sh
   docker-compose up
   ```

2. Access pgAdmin:
   Open your browser and go to `http://localhost:5051`
   - Login with the default email and password:
     - Email: `admin@locallink.com`
     - Password: `admin`

3. Add a new server in pgAdmin:
   - Host name/address: `postgres`
   - Port: `5433`
   - Maintenance database: `locallink`
   - Username: `locallink_user`
   - Password: `locallink_password`

## Contributing

If you would like to contribute to this repository, please fork it and submit a pull request with your changes. We welcome contributions from the community and appreciate your help in improving this project.

## License

This repository is licensed under the MIT License. See the LICENSE file for more information.

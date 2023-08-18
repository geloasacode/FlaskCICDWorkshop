# Dockerized Flask Web Application

This is a simple Flask web application that displays a colored background in which ou can specify the color in multiple ways. The application can be easily dockerized using Docker.

## Features

- Displays a colored background based on the provided color.
- Supports color specification through command-line arguments or environment variables.
- Provides routes to retrieve color, version, and application information.

## Getting Started

To run this Flask application, follow these steps:

1. Clone this repository:

   ```bash
   git clone https://github.com/gelodun/simple-flask.git
   cd your-repo

2. Assuming that you have docker installed in your local machine, you may run the command below:
   
   ```bash
   docker build -t <your-desired-web-name> .

3. Run a container using the created docker image by typing the command below:
   
   ```bash
   docker run -d -p 8080:8080 <your-desired-web-name>

4. To run, open a web browser and navigate to http://localhost:8080 to see the application in action.

## Routes

- `/`: Main route displaying the colored background and version.
- `/color`: Returns the currently displayed color.
- `/version`: Returns the application version.
- `/info`: Returns the combination of version and color information.

## Notes

This is a sample application for educational purposes.
The application supports both local and Dockerized execution.

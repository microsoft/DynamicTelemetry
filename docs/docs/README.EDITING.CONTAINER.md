# Using the Markdown editing container

MkDocs is our markdown rendering tool in Dynamic Telemetry, providing a pleasant
looking markdown-to-HTML converter that integrates well with GitHub.

Because MkDocs depends on Python, versioning issues can arise. To avoid these
complications, a single Docker or Podman container is used, bundling MkDocs,
Python, and all required tools.

Using the container is straightforward, involving two steps - one of which is a
one-time setup.

## Installation

1. Install Docker or Podman from [https://www.docker.com](https://www.docker.com)

1. From the tools directory in DynamicTelemetry, build the container using:

      ```
      docker build -f
            Dockerfile.mkdocs -t "dynamictelemetry/dynamictelemetry:mkdocs" .
      ```

1. Once the build process is complete, simply use the container. In a workflow
   that looks something like this.

   * In a standalone terminal window, use 'docker compose up' command
   which will monitor profile changes and update accordingly.

       ```
       docker compose up
       ```

       * Make changes to the documentation.
       * View the changes in your local web browser
            [http://localhost:8000](http://localhost:8000)

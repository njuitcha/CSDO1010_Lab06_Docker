
# Containerization and Image Management with Docker

Welcome to the **Containerization and Image Management** lab. In this exercise, you will package and deploy a one-page website using **Docker** and **Nginx**.

![alt divider](assets/gradient-fade-center-steps.svg)

|                                                                               Key take-away                                                                               |
| :-----------------------------------------------------------------------------------------------------------------------------------------------------------------------: |
| Containerization makes applications portable, consistent, and isolated from the host environment. Image management enables reproducible builds and automated deployments. |
|                                                                                                                                                                           |

![alt divider](assets/gradient-fade-center-steps.svg)

In this lab you will perform the following:

| Tool           | Function | Concept          | Description                                                      |
| :------------- | :------- | :--------------- | :--------------------------------------------------------------- |
| Docker         | Build    | Containerization | Packages your code and its dependencies into a portable image.   |
| Docker Hub     | Registry | Image Management | Stores, versions, and distributes container images.              |
| GitHub Actions | CI/CD    | Automation       | Builds and pushes your image automatically when `Docs/` changes. |
| Nginx          | Runtime  | Web Server       | Serves your static website content from the container.           |

This exercise is part of the **Build Automation Fundamentals** sequence. It extends prior labs by introducing **application packaging**, **image distribution**, and **automation workflows** that are standard in DevOps pipelines.

## Overview

This repository introduces the fundamentals of **Containerization** and **Image Management** using Docker and Nginx. You will learn to build a container from a local project, test it, publish it to Docker Hub, and automate builds with GitHub Actions.

In this lab, you will:

- Clone the working repository.
- Build a Docker image serving the website in `Docs/` through Nginx.
- Run and test the container locally.
- Push the image to Docker Hub.
- Configure a GitHub Actions workflow to automatically rebuild the image when website content changes.

Keep in mind that:

- Containers are stateless, lightweight, and portable across environments.
- Registries act as the distribution system for versioned images.
- CI/CD workflows automate repetitive build and deployment steps.

### Docker Image Tagging and Naming Conventions

| Image Tag     | Example                                    | Usage                         | Notes                                                        |
| :------------ | :----------------------------------------- | :---------------------------- | :----------------------------------------------------------- |
| `latest`      | `username/lab06-nginx:latest`              | Most recent stable release    | Automatically updated by CI when merging to `main`.          |
| Versioned Tag | `username/lab06-nginx:1.0`                 | Fixed release                 | Used for controlled deployments or teaching reproducibility. |
| Git SHA       | `username/lab06-nginx:sha-4f2b1a9`         | Automated build tag           | Created automatically by GitHub Actions for traceability.    |
| Feature Tag   | `username/lab06-nginx:feature-docs-update` | Temporary development version | Useful for previewing changes before merge.                  |

> Each image tag uniquely identifies a build. Use specific tags for production and reproducible testing.

## Instructions

All lab steps are detailed in the [INSTRUCTIONS.md](INSTRUCTIONS.md) file. Proceed to the tasks in order:

- Clone the Repository
- Create the Dockerfile
- Build the Image
- Run and Verify Locally
- Tag and Push to Docker Hub
- Automate with GitHub Actions

Each completed step should be documented in your [LAB_REPORT.md](LAB_REPORT.md).

## Lab Report

- Once you have prepared your lab report, make a final commit to your lab repository.
- Navigate to [Create Lab Report](../../actions/workflows/task-03-create-lab-report.yaml) and run the workflow.
- Upload your lab report in PDF format via Moodle.

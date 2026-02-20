# Build and Run an Container Locally

Serve a local one-page website from an Nginx container. Build, run, and push the image to Docker Hub.

## Prerequisites

Students must:

- Have Docker installed and running.
- Have a Docker Hub account.
- Possess a project directory named `Docs` containing the following structure:

Verify Docker is functional:

```bash
docker version
````

## Task 1.1 – Clone the Repository

Clone the working repository that contains the website and lab materials:

```bash
git clone https://github.com/yorku/CSDO1010-DevOps-ToolChain-Lab06.git
cd CSDO1010-DevOps-ToolChain-Lab06
```

Inspect the provided structure:

```bash
CSDO1010-DevOps-ToolChain-Lab06/
├── docker-compose.yml
├── Dockerfile
├── Docs
│   ├── css
│   ├── fav-icon
│   ├── img
│   ├── index.html
│   ├── js
│   └── README.md
└── workflows
    └── dockerhub-on-docs-change.yaml
```

The `Docs/` directory contains the static site you will serve through Nginx.

## Task 1.2 – Create the Dockerfile

In your working directory, create a file named `Dockerfile` with the following content:

```Dockerfile
FROM nginx:alpine
# Copy the entire Docs directory into Nginx's default web root
COPY Docs/ /usr/share/nginx/html/
EXPOSE 80
```

**Explanation:**

- The `nginx:alpine` image provides a minimal web server.
- The `COPY` instruction moves your `Docs/` site into the default Nginx directory.
- Port 80 is exposed for HTTP access.

## Task 1.3 – Build the Image

Build the container image and verify it was created successfully:

```bash
docker build -t lab06-nginx:1.0 .
docker images | grep lab06-nginx
```

Expected output:

```
REPOSITORY      TAG     IMAGE ID      CREATED         SIZE
lab06-nginx     1.0     abcd1234ef56  <seconds ago>   <size>
```

## Task 1.4 – Run and Verify Locally

Create a file named `docker-compose.yml`:

```bash
version: "3.9"

services:
  web:
    # Local-first: build from the Dockerfile in this directory
    build:
      context: .
      dockerfile: Dockerfile
    image: lab06-nginx:1.0
    container_name: lab06-nginx
    ports:
      - "8080:80"
    restart: unless-stopped

    # Optional: live-edit local content (uncomment to mount)
    # volumes:
    #   - ./Docs:/usr/share/nginx/html:ro
```

Build and start

```bash
docker compose up -d --build
```

Verify the website is served:

```bash
curl -I http://localhost:8080
```

Open your browser at:

```
http://localhost:8080
```

Stop and remove the container when finished:

```bash
docker compose down
```

## Task 1.5 – Tag and Push to Docker Hub

Authenticate with Docker Hub:

```bash
docker login
```

Tag the image:

```bash
docker tag lab06-nginx:1.0 <dockerhub-username>/lab06-nginx:1.0
```

Push the image to Docker Hub:

```bash
docker push <dockerhub-username>/lab06-nginx:1.0
```

Update the Docker Compose deployment using your Docker Hub image.

```yaml
version: "3.9"

services:
  web:
    image: <dockerhub-username>/lab06-nginx:1.0
    container_name: lab06-nginx
    ports:
      - "8080:80"
    restart: unless-stopped

    # Optional: override image content with local files (for quick edits)
    # volumes:
    #   - ./Docs:/usr/share/nginx/html:ro
```

Run it:

```bash
# from the repo root
docker compose up -d
```

Verify:

```bash
curl -I http://localhost:8080
```

Stop and clean up:

```bash
docker compose down
```

# Generate Docker Hub credentials and load them into GitHub

## Identify `DOCKERHUB_USERNAME`

* Use your Docker Hub account name.
* If you belong to an org and push to `org/image`, use the org name for the repo path but still store your personal username in `DOCKERHUB_USERNAME` unless you use a robot account.

Confirm locally:

```bash
docker login
# Username: <your Docker Hub username>
```

## Create `DOCKERHUB_TOKEN` (Docker Hub Access Token)

1. Sign in to Docker Hub.
2. Go to Account Settings → Security → Access Tokens.
3. Create a **New Access Token**:

   * Name: `github-actions-lab06` (or similar).
   * Access: **Read & Write**.
4. Copy the token **once**. You will not see it again.

Optional local test:

```bash
echo '<TOKEN>' | docker login --username '<USERNAME>' --password-stdin
```

## Add secrets to the GitHub repository (UI method)

1. Open your GitHub repo.
2. Settings → Secrets and variables → Actions → **New repository secret**.
3. Add:

   * **Name:** `DOCKERHUB_USERNAME`
     **Value:** `<your Docker Hub username>`
   * **Name:** `DOCKERHUB_TOKEN`
     **Value:** `<the access token you just created>`
4. Save each secret.

## Verify workflow picks them up

* Open the repo’s **Actions** tab.
* Trigger a commit that changes `Docs/**` or `Dockerfile` on `main`.
* Inspect the job logs:

  * Step “Log in to Docker Hub” should succeed.
  * Build-and-push step should tag and push.

## Good hygiene

* Rotate tokens periodically.
* Revoke the token in Docker Hub if compromised.
* Restrict push permissions to only what the workflow needs.
* Prefer a robot account for org-owned images when available.

# Create a Change Branch and Open a Pull Request

## Create a new branch

From the local repository root, check out a new branch for your update:

```bash
git checkout -b docs/update-homepage
```

Use a meaningful name — for example:

* `docs/update-homepage`
* `docs/fix-typo`
* `feature/add-css-animation`

## Make a change

Edit any file in the `Docs/` directory.
For example:

* Update `Docs/index.html` text
* Modify `Docs/css/styles.css`
* Add or change an image in `Docs/img/`

Save the file and confirm the modification:

```bash
git status
```

## Stage and commit the change

```bash
git add Docs/
git commit -m "docs: update site content"
```

## Push the branch to GitHub

```bash
git push -u origin docs/update-homepage
```

## Open a Pull Request

1. Go to your repository in GitHub.
2. You’ll see a banner suggesting to create a pull request for your new branch.
   Click **Compare & pull request**.
3. Confirm:

   * Base branch: `main`
   * Compare branch: your new branch
4. Enter a clear title and description of what changed.
5. Click **Create pull request**.

## Review and merge

* Wait for automated checks (like the Docker Hub build workflow) to finish.
* Review the diff and ensure the expected build occurs.
* When ready, click **Merge pull request** and select **Squash and merge** for a clean history.

## Clean up

After merging, delete your branch:

```bash
git branch -d docs/update-homepage
git push origin --delete docs/update-homepage
```

This completes the change workflow — the GitHub Actions pipeline will detect changes in `Docs/` and build a new Docker image on merge to `main`.


Run the latest Docker release from Docker Hub.

# Run the latest release

## Using Docker Compose

Update `docker-compose.yml` to use the Docker Hub image:

```yaml
version: "3.9"

services:
  web:
    image: <dockerhub-username>/lab06-nginx:latest
    container_name: lab06-nginx
    ports:
      - "8080:80"
    restart: unless-stopped

    # Optional: override with local files for quick edits
    # volumes:
    #   - ./Docs:/usr/share/nginx/html:ro
```

Start with the latest image:

```bash
docker compose pull
docker compose up -d
```

Verify:

```bash
curl -I http://localhost:8080
```

Stop and clean up:

```bash
docker compose down
```
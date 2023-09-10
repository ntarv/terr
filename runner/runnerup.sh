mkdir -p /data/docker/gitlab
touch docker-compose.yml
mkdir -p /data/docker/gitlab/var/opt/gitlab
mkdir -p /data/docker/gitlab/var/log/gitlab
mkdir -p /data/docker/gitlab/etc/gitlab-runner
mkdir -p /data/docker/gitlab/var/run/docker.sock
cat << EOF > docker-compose.yml
version: '3.5'
services:
  gitlab:
    image: gitlab/gitlab-ce:latest

    restart: unless-stopped
    environment:
      GITLAB_OMNIBUS_CONFIG: |
        gitlab_rails['gitlab_shell_ssh_port'] = 8822
    ports:
      - "8000:80"
      - "8822:22"
    volumes:
      - /data/docker/gitlab/etc/gitlab:/etc/gitlab
      - /data/docker/gitlab/var/opt/gitlab:/var/opt/gitlab
      - /data/docker/gitlab/var/log/gitlab:/var/log/gitlab
    networks:
      - gitlab_net

  gitlab-runner:
    image: gitlab/gitlab-runner:alpine
    restart: unless-stopped
    depends_on:
      - gitlab
    volumes:
      - /data/docker/gitlab/etc/gitlab-runner:/etc/gitlab-runner
      - /data/docker/gitlab/var/run/docker.sock:/var/run/docker.sock
    networks:
      - gitlab_net

networks:
  gitlab_net:
EOF

docker-compose up -d --force-recreate && docker-compose ps












## build

```bash
# Mount entire letsencrypt directory to preserve symlinks
docker run -d -p 80:8000 -p 443:8000 \
  -v /etc/letsencrypt:/etc/letsencrypt:ro \
  myapp
```

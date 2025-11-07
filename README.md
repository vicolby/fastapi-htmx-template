## build

```bash
docker run -d -p 80:8000 -p 443:8000 \
  -v /etc/letsencrypt/live/web.vicolby.space:/app/certs:ro \
  myapp
```

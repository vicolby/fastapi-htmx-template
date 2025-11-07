## build

```bash
docker run -d -p 80:8000 -p 443:8000 \
  -v /etc/letsencrypt/live/web.vicolby.space/cert.pem:/app/certs/cert.pm:ro \
  -v /etc/letsencrypt/live/web.vicolby.space/fullchain.pem:/app/certs/fullchain.pm:ro \
  myapp
```

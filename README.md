## build

```bash
docker run -d -p 80:8000 -p 443:8000 \
  --mount type=bind,source=$(readlink -f /etc/letsencrypt/live/web.vicolby.space/cert1.pem),target=/app/certs/cert.pem \
  --mount type=bind,source=$(readlink -f /etc/letsencrypt/live/web.vicolby.space/fullchain1.pem),target=/app/certs/fullchain.pem \
  webapp
```

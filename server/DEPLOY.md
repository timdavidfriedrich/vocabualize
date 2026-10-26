# Deploying the Vocabualize backend

The VPS holds a pull-only sparse checkout of `server/` and builds the image itself. Nothing in the stack publishes a host port. Caddy from the `global-gateway` project reaches `vocabualize-serverpod` and `vocabualize-garage` over the external `global-proxy` network.

```
Cloudflare ──▶ Caddy (global-gateway)
                 ├── vocabualize-api.timdavidfriedrich.de   ─▶ vocabualize-serverpod:8080
                 └── vocabualize-files.timdavidfriedrich.de ─▶ vocabualize-garage:3900

vocabualize project, internal network: postgres · garage · serverpod · migrate (one-shot)
```

## First-time setup

1. **DNS.** In Cloudflare, add proxied A records `vocabualize-api` and `vocabualize-files`, pointing at the VPS. Add both hostnames to the cache-bypass rule.

2. **Checkout:**
   ```bash
   cd ~/workspaces
   git clone --filter=blob:none --sparse https://github.com/timdavidfriedrich/vocabualize.git vocabualize
   cd vocabualize && git sparse-checkout set server
   ```

3. **`server/.env`.** Create it from `.env.prod.example` with fresh values and `chmod 600`. Use `openssl rand -hex 32` for `GARAGE_RPC_SECRET`, and `openssl rand -base64 32` for the other two.

4. **Garage.** Start it with `docker compose -f docker-compose.prod.yaml up -d garage`. Then run the steps from `AGENTS.md` (status, layout, bucket `vocabualize-images`, key, allow) through `docker compose -f docker-compose.prod.yaml exec -T garage /garage …`.

5. **`server/vocabualize_server/config/passwords.yaml`.** Write it on the VPS with a `production:` section only:
   - `database`: the same value as `POSTGRES_PASSWORD`.
   - Fresh `openssl rand` values for `serviceSecret`, `emailSecretHashPepper`, `jwtHmacSha512PrivateKey` and `jwtRefreshTokenHashPepper`.
   - `googleClientSecret`: the web client JSON, as a `|` block.
   - `garageAccessKey` and `garageSecretKey`, from step 4.

6. **Start:** `docker compose -f docker-compose.prod.yaml up -d --build`. `migrate` runs first and exits; the server starts only when migrate succeeds.

7. **Caddy.** Append `caddy-snippet.conf` to `~/workspaces/global-gateway/Caddyfile`. Merge `caddy-global-options.conf` into the Caddyfile's global options block (the first `{ … }` block; create it at the very top if there is none). Then run `docker compose -f ~/workspaces/global-gateway/docker-compose.yml restart caddy`.
   - The global options trust only Cloudflare's ranges (from https://www.cloudflare.com/ips/), so `{client_ip}` is the visitor's real IP behind Cloudflare and the connecting IP for anyone who bypasses it. The API block then overwrites `X-Client-IP` with it, which the report limits rely on.

8. **Verify.** This should answer with the `RemoteAppConfig`:
   ```bash
   curl -s -X POST https://vocabualize-api.timdavidfriedrich.de/config/fetch -H 'Content-Type: application/json' -d '{}'
   ```

## Routine deploy

```bash
cd ~/workspaces/vocabualize && git pull
docker compose -f server/docker-compose.prod.yaml up -d --build
```

Deploy the server before releasing an app build that needs it. A change to a synced table also needs the app release on the same day (see `AGENTS.md`).

## Rules

- `vocabualize_server/production/app_config.yaml` is read on every request, so edits apply immediately. Its folder is mounted, not the file, so editors and `sed -i` that replace the file work too. `images.*` is the exception: it is read at boot and needs a restart. Commit every edit back to the repository.
- Insights (8081) stays out of Caddy. Reach it over Tailscale.
- Never run `docker compose down -v`: it deletes the database and image volumes.

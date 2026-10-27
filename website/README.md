# Website

Static website for Vocabualize: landing page, privacy policy, account deletion and legal notice, each in English and German. Everything in `public/` is served as is; there is no build step.

## Preview

```bash
python3 -m http.server 8765 --directory website/public
```

Then open http://localhost:8765.

## Deploy

On mio, `~/workspaces/vocabualize_website` is a sparse checkout of this folder. Caddy in `global-gateway` serves `public/` as `vocabualize.timdavidfriedrich.de` (mounted at `/srv/vocabualize`).

```bash
cd ~/workspaces/vocabualize_website && git pull
```

Changes are live right after the pull; Caddy needs no restart.

## Placeholders

Personal details and points to verify are marked `[PLACEHOLDER: …]` and shown in orange. Find them with:

```bash
grep -rn "PLACEHOLDER" website/public
```

The privacy policy describes what the app does. Update it in both languages, with a new date, whenever data handling changes: new data, a new service provider, or different retention.

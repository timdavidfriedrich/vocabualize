# Website

Static website for Vocabualize: landing page, privacy policy, account deletion and legal notice, each in English and German.

## Structure

| Path | Content |
|---|---|
| `site.json` | Personal and legal details in one place: owner, address, email, business details, hosting provider, supervisory authority |
| `templates/` | The HTML pages. Edit text here |
| `build_site.dart` | Writes the finished pages from `templates/` and `site.json` into `public/` |
| `public/` | What Caddy serves: the generated pages plus the static assets (`public/assets/`) |

Never edit the HTML files in `public/` directly, not even on mio: the next build overwrites them, and edits on mio block the next `git pull`.

## Change details or text

1. Edit `site.json` (details) or a file in `templates/` (text).
2. Build from the repository root:
   ```bash
   fvm dart website/build_site.dart
   ```
3. Commit `site.json`, `templates/` and `public/` together, then push.
4. Deploy (below).

## Values

- A value is used in a template as `{{owner.email}}`.
- A value can be a plain string or one string per language (`{"en": "…", "de": "…"}`). Pages under `templates/de/` use `de`, all others `en`.
- A block wrapped in `{{#owner.vatId}}` … `{{/owner.vatId}}`, each tag on its own line, only appears when the value is filled. The legal notice uses this for the optional business details (VAT ID, company register, chamber, trade authority, trade regulations).
- The build stops with an error on an unknown value or leftover template syntax, so no page goes live half filled.

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

## Privacy policy

The privacy policy describes what the app does. Update it in both languages, with a new date, whenever data handling changes: new data, a new service provider, or different retention.

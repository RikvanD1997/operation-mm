# Prerequisites

- Rust toolchain, version 1.77.2 or later. As of writing, I'm personally using 1.78.0.

## For Cloudflare Pages deployment

You only need these if you want to deploy to Cloudflare Pages.

- NPM
- Cloudflare Wrangler

# Development

Simply running the Rust code, e.g. `cargo run`, will start up a local server on port 3000 using axum. The HTML templates are found in `templates/` and are rendered using minijinja. Static files such as CSS, JavaScript, and images are found in `public/` and also get served from matching `public/*` paths from the server.

If you add or change any page routes, you have to also change the `page_paths` array in the `build_static` function for the page to be rendered in static generation later.

# Static Site Generation and Deployment

Running the Rust code with a `--build` argument will render the entire static site to the `dist/` directory.

```
cargo run -- --build
```

The static site can then be browsed locally starting from `dist/index.html`.

## Deploying to Cloudflare Pages
If you want to deploy to Cloudflare Pages, change the `name` value in `wrangler.toml` to a name of a project on your Cloudflare account, then run `npx wrangler pages deploy`.

## Deploying to GitHub Pages

From GitHub ensure the repo is set to publish from the root dir of a branch named `publish`. See the instructions here for more info: https://docs.github.com/en/pages/getting-started-with-github-pages/configuring-a-publishing-source-for-your-github-pages-site#publishing-from-a-branch

Running the `deploy_ghpages.sh` script in the repo will push the contents of `dist/` to the `publish` branch which will be served at `https://<user>.github.io/operation-mm`.

### Example
```
~/operation-mm [main] » ./deploy_ghpages.sh
Created temporary directory /Users/<user>/operation-mm/tmp.Tyy1GmOG1u
Preparing worktree (checking out 'publish')
/Users/<user>/operation-mm                 e485234 [main]
/Users/<user>/operation-mm/tmp.Tyy1GmOG1u  a23ab95 [publish]
On branch publish
Your branch is based on 'origin/publish', but the upstream is gone.
  (use "git branch --unset-upstream" to fixup)

nothing to commit, working tree clean
Enumerating objects: 34, done.
Counting objects: 100% (34/34), done.
Delta compression using up to 8 threads
Compressing objects: 100% (33/33), done.
Writing objects: 100% (34/34), 982.55 KiB | 44.66 MiB/s, done.
Total 34 (delta 3), reused 15 (delta 0), pack-reused 0 (from 0)
remote: Resolving deltas: 100% (3/3), done.
remote:
remote: Create a pull request for 'publish' on GitHub by visiting:
remote:      https://github.com/<user>/operation-mm/pull/new/publish
remote:
To https://github.com/<user>/operation-mm.git
 * [new branch]      publish -> publish
Deleted temporary directory /Users/<user>/operation-mm/tmp.Tyy1GmOG1u
/Users/<user>/operation-mm  e485234 [main]
```

# GitHub Repository Helper

<img width="595" alt="Screen Shot 2023-01-19 at 22 05 16" src="https://user-images.githubusercontent.com/1977829/213615137-30fc6c36-6173-40a2-b52e-3eebe676de09.png">

An [Alfred workflow](https://www.alfredapp.com/workflows/) GitHub repository helper. Allows you to open the chosen repository in your browser, copy its URL to your clipboard, or navigate directly to the pull requests, issues, or projects page for that repo.

**[Get the latest download here](https://github.com/niclake/alfred-github-repo-helper/releases/latest/)**

## To set up, do the following:

1. Navigate to https://github.com/settings/tokens, and create a new Fine-Grain Token
2. Set the repo access to your desired level (recommended: All repositories)
	- If you set it to All repositories, under `Repository permissions`, find `Metadata` and set it to `Read only`
3. Save & generate the token, and copy the value
4. Set your GH_USERNAME and GH_TOKEN environment variables.
5. Make sure that `jq` installed at `/opt/homebrew/bin/jq` (you can use `which jq` to check). If not installed, you can do so with `brew`: `brew install jq`

## Usage:

- Use the `ugh` command to update your GitHub repo list. This will fetch all of the repos that you are a owner or contributor to, sanitize them, and generate your list
- If any part of the `ugh` command fails, right-click the workflow in the sidebar, Open in Terminal, run `chmod 777 *.sh`, and then try the `ugh` command again
- Once your list has been generated, `gh <repo_name>` will pull up the repository link, and you can then do the following:
	- `Enter`: go to repo
	- `⇧-Enter`: go to pull requests
	- `⌥-Enter`: go to issues
	- `⌃-Enter`: go to projects
	- `⌘-Enter`: copy the repo URL to your clipboard

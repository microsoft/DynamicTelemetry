# Contributing to Dynamic Telemetry

We welcome everyone to contribute to Dynamic Telemetry.

## Development Environment

You can contribute to this project from a Windows, macOS, or Linux machine.

On all platforms, the minimum requirements are:

* Git client and command line tools

## Pull Requests

### How to create pull requests

Everyone is welcome to contribute code to `DynamicTelemetry` via GitHub pull
requests (PRs).

To create a new PR, fork the project on GitHub and clone the upstream repo:

```sh
git clone https://github.com/DynamicTelemetry.git
```

Navigate to the repo root:

```sh
cd DynamicTelemetry
```

Add your fork as an origin:

```sh
git remote add fork https://github.com/YOUR_GITHUB_USERNAME/DynamicTelemetry.git
```

Check out a new branch, make modifications, and push the branch to your fork:

```sh
$ git checkout -b feature
# edit files
$ git commit
$ git push fork feature
```

Open a pull request against the main `DynamicTelemetry` repo.

#### Tips and best practices for pull requests

* If the PR is not ready for review, please mark it as
  [`draft`](https://github.blog/2019-02-14-introducing-draft-pull-requests/).
* Submit small, focused PRs addressing a single concern/issue.
* Make sure the PR title reflects the contribution.
* Write a summary that helps understand the change.
* Include usage examples in the summary, where applicable.

### How to get pull requests merged

A PR is considered to be **ready to merge** when:

* Major feedback/comments are resolved.
* It has been open for review for at least one working day. This gives people
  reasonable time to review.

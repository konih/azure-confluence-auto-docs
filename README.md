# Terraform Azure VM Details

This repository contains Terraform code to fetch and template the details of Azure VMs to confluence pages.


## Taskfile Documentation

The `Taskfile.yml` is a configuration file for the [Task](https://taskfile.dev/#/) task runner tool. It defines a set of
tasks that can be run in .this projects Each task is a series of commands that are run in sequence.


### Tasks

Here are some of the tasks defined in the `Taskfile.yml`:

- `terramate-init` (alias `tmi`): Initializes the Terramate stack. The `TAGS` variable can be used to specify which stacks to initialize.
- `terramate-generate` (alias `tmg`): Generates the Terramate stack configuration.
- `terramate-plan` (alias `tmp`): Plans the Terramate stack. The `TAGS` variable can be used to specify which stacks to plan.
- `terramate-apply-plan` (alias `tmap`): Applies the Terramate stack from the plan. The `TAGS` variable can be used to specify which stacks to apply.
- `terramate-apply` (alias `tma`): Applies the Terramate stack. The `TAGS` variable can be used to specify which stacks to apply.
- `terramate-apply-auto-approve` (alias `tmaa`): Applies the Terramate stack from the plan with auto-approval. The `TAGS` variable can be used to specify which stacks to apply.
- `terramate-validate` (alias `tmv`): Validates the Terramate stack. The `TAGS` variable can be used to specify which stacks to validate.
- `infracost`: Generates an Infracost report for the current path.
- `tflint`: Runs TFLint to lint Terraform files.
- `terraform-docs`: Generates documentation from Terraform files in Markdown format.
- `pre-commit`: Runs all configured pre-commit hooks.
- `bats-tests`: Runs all BATS tests for bash scripts.
- `run-gitlab-comment`: Runs a Python script to comment on GitLab.

Each task can be run from the command line using the `task` command followed by the task name. For example, to run
the `terramate-init` task, you would use the following command:

```bash
task terramate-init
```

Aliases are also provided for quick execution of tasks. For example, the `terramate-init` task can be run using its
alias `tmi`:

```bash
task tmi
```

### Environment Variables

Some tasks use environment variables, which can be set in the `env` section of the task. For example,
the `run-gitlab-comment` task uses the `CI_COMMIT_SHORT_SHA`, `CI_PROJECT_ID`, and `GITLAB_ACCESS_TOKEN` environment
variables. These variables should be set in your CI/CD settings.

## Local Setup

### Nix Shell

## Nix Shell Installation and Usage

Nix is a powerful package manager for Linux and other Unix systems that makes package management reliable and
reproducible. It provides atomic upgrades and rollbacks, side-by-side installation of multiple versions of a package,
multi-user package management and easy setup of build environments.

### Installation

To install Nix, open a terminal and run the following command:

```bash
sh <(curl -L https://nixos.org/nix/install)
```

This will download a script and run it. The script will ask you for your password to install the necessary components.

### Usage

Once Nix is installed, you can use the `nix-shell` command to create a new shell environment with specific packages
available.

In our project, we have a `shell.nix` file which describes the environment needed for your project. To enter this
environment, you can run:

```bash
nix-shell
```

This will start a new shell with all the packages specified in `shell.nix` available.

In your `shell.nix` file, you have specified packages
like `terraformd`, `terramated`, `git`, `pre-commit`, `terraform-docs`, `checkov`, `tflint`, `git-secrets`, `infracost`,
and `bash`. All these will be available in the shell environment started by `nix-shell`.

When you're done with your work, you can simply type `exit` to leave the nix shell environment.

Remember, any packages installed in the nix shell environment are local to that environment and will not affect your
global system packages. This helps to keep your system clean and your projects isolated.

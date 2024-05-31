terramate {
  config {
    git {
      default_branch    = "main"
      default_remote    = "origin"
      check_untracked   = false # check if there are untracked files
      check_uncommitted = false # check if there are uncommitted changes
      check_remote      = false # check if the remote branch is up-to-date
    }

    run {
      env {
        TF_PLUGIN_CACHE_DIR = "${terramate.root.path.fs.absolute}/.terraform-cache-dir"
      }
    }

    # Enable Terramate Scripts
    #    experiments = [
    #      "scripts",
    #    ]
  }
}

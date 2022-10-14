remote_file(
    name = "jq",
    binary = True,
    url = "https://github.com/stedolan/jq/releases/download/jq-1.6/jq-linux64",
    visibility = ["PUBLIC"],
)

SHELLCHECK_VERSION = "v0.8.0"

remote_file(
    name = "shellcheck",
    binary = True,
    exported_files = [f"shellcheck-{SHELLCHECK_VERSION}/shellcheck"],
    extract = True,
    url = f"https://github.com/koalaman/shellcheck/releases/download/{SHELLCHECK_VERSION}/shellcheck-{SHELLCHECK_VERSION}.linux.x86_64.tar.xz",
    visibility = ["PUBLIC"],
)

ACTIONLINT_VERSION = "1.6.21"

remote_file(
    name = "rhysd_actionlint",
    binary = True,
    exported_files = ["actionlint"],
    extract = True,
    url = f"https://github.com/rhysd/actionlint/releases/download/v{ACTIONLINT_VERSION}/actionlint_{ACTIONLINT_VERSION}_linux_amd64.tar.gz",
    visibility = ["PUBLIC"],
)

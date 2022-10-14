subinclude("//build/defs:sh")

sh_script(
    name = "util",
    main = "util.sh",
    visibility = ["PUBLIC"],
    deps = [
        "//third_party/sh:ansi",
    ],
)

sh_cmd(
    name = "_lint_all",
    cmd = "./pleasew query alltargets --include=lint | xargs ./pleasew run parallel --output=group_immediate",
)

sh_cmd(
    name = "_fmt_all",
    cmd = "./pleasew query alltargets --include=fmt | xargs ./pleasew run parallel --output=group_immediate",
)

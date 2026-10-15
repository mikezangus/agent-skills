#!/usr/bin/env bash
set -e

readonly ARCHIVE_URL='https://github.com/mikezangus/agent-skills/archive/refs/heads/master.tar.gz'

fail() {
    printf 'install: %s\n' "$*" >&2
    exit 1
}

download_skills() {
    local directory=$1 archive
    archive="$directory/archive.tar.gz"
    printf 'Downloading skills...\n'
    curl -fsSL "$ARCHIVE_URL" -o "$archive" || fail 'could not download skills'
    tar -xzf "$archive" --strip-components=1 -C "$directory" || fail 'could not extract skills'
}

validate_skills() {
    local root=$1 name
    shift
    for name in "$@"; do
        case $name in ''|.|..|*/*) fail "invalid skill name: $name" ;; esac
        [[ -f $root/$name/SKILL.md ]] || fail "unknown skill: $name"
    done
}

finish_installation() {
    local staging=$1 target=$2
    if [[ -d $staging/skill && ( -e $staging/previous || -L $staging/previous ) ]]; then
        if [[ -e $target || -L $target ]] || ! mv -- "$staging/previous" "$target"; then
            printf 'install: could not restore %s; previous installation kept at %s/previous\n' \
                "$target" "$staging" >&2
            return
        fi
        printf 'Restored: %s\n' "$target" >&2
    fi
    rm -rf -- "$staging" || fail "could not remove installation files: $staging"
}

install_skill() (
    local source=$1 target=$2 staging
    staging="${target%/*}/.install.${target##*/}"
    if ! mkdir -m 700 -- "$staging"; then
        if [[ -e $staging || -L $staging ]]; then
            fail "installation already running or unfinished at $staging; inspect it before retrying"
        fi
        fail "could not create installation directory: $staging"
    fi
    trap 'finish_installation "$staging" "$target"' EXIT
    trap 'exit 129' HUP
    trap 'exit 130' INT
    trap 'exit 143' TERM
    mkdir -- "$staging/skill" || fail "could not prepare installation: $target"
    cp -Rp -- "$source/." "$staging/skill/" || fail "could not copy skill: $target"
    if [[ -e $target || -L $target ]]; then
        mv -- "$target" "$staging/previous" || fail "could not back up existing installation: $target"
    fi
    mv -- "$staging/skill" "$target" || fail "could not install skill: $target"
    printf 'Installed: %s\n' "$target"
)

main() (
    local destination=${HOME:+$HOME/.agents/skills}
    local skills=()
    local root manifest name

    while (( $# )); do
        case $1 in
            --target-directory)
                (( $# >= 2 )) || fail "$1 requires a directory"
                [[ -n $2 && $2 != -* ]] || fail "$1 requires a directory"
                destination=$2
                shift 2
                ;;
            --target-directory=*)
                destination=${1#*=}
                [[ -n $destination ]] || fail '--target-directory requires a directory'
                shift
                ;;
            --)
                shift
                skills+=("$@")
                break
                ;;
            -*) fail "unknown option: $1" ;;
            *)
                skills+=("$1")
                shift
                ;;
        esac
    done
    [[ -n $destination ]] || fail 'no destination specified and HOME is unset or empty'

    root=$(mktemp -d -- "${TMPDIR:-/tmp}/skills.XXXXXXXX") || fail 'could not create download directory'
    trap 'rm -rf -- "$root"' EXIT
    trap 'exit 129' HUP
    trap 'exit 130' INT
    trap 'exit 143' TERM
    download_skills "$root"

    if (( ${#skills[@]} == 0 )); then
        for manifest in "$root"/*/SKILL.md; do
            [[ -f $manifest ]] || continue
            name=${manifest%/SKILL.md}
            skills+=("${name##*/}")
        done
    fi
    (( ${#skills[@]} )) || fail 'no skills found in the download'
    validate_skills "$root" "${skills[@]}"

    mkdir -p -- "$destination" || fail "could not create install directory: $destination"
    for name in "${skills[@]}"; do
        install_skill "$root/$name" "${destination%/}/$name"
    done
)

main "$@"

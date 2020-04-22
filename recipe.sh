#!/bin/sh

# Recipe executor.

log() {
    echo >&2 "$@"
}

usage() {
    log "Usage: recipe [-h] <recipe> [<argument> ...]"
}

exec_recipe() {
    recipe=$(find "$RECIPES_DIR" -name "$1" -not -name '.*' -perm +ugo+x | head -n 1)

    [ -z "$recipe" ] && {
        log "Error: recipe not found: $1"
        log "Available recipes:"
        list_recipes
        exit 2
    }

    shift
    exec "$recipe" "$@"
}

list_recipes() {
    find "$RECIPES_DIR" -type f -not -name '.*' -perm +ugo+x -exec basename {} \;
}


[ -n "$RECIPES_DIR" ] || {
    log "Error: variable RECIPES_DIR is not defined"
    exit 1
}
[ -d "$RECIPES_DIR" ] || {
    log "Error: recipes directory does not exist: $RECIPES_DIR"
    exit 1
}

getopts h _ && usage && exit 2
[ "$1" = -- ] && shift

[ $# = 0 ] && list_recipes && exit
exec_recipe "$@"

if status is-interactive
end

set -gx OPENER run-mailcap
set -gx EDITOR kak
set -gx SHELL  /bin/fish
set -gx LC_ALL en_US.UTF-8

set -gx GTK_IM_MODULE ibus
set -gx XMODIFIERS @im=ibus
#sqet -gx MOZC_IBUS_CANDIDATE_WINDOW ibus

# spacefish
set -gx SPACEFISH_GIT_BRANCH_COLOR magenta
set -gx SPACEFISH_RUST_SYMBOL 🦀

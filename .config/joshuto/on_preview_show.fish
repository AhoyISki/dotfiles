#!/usr/bin/env fish

function image
  command kitty +kitten icat --transfer-mode=file --clear 2>/dev/null
  command kitty +kitten icat --transfer-mode=file --place "$argv[4]x$argv[5]@$argv[2]x$argv[3]" "$argv[1]" 2>/dev/null
end

switch (file --mime-type -Lb "$argv[1]")
  case "image/*"
    image $argv[1..5]
  case "video/*"
    set -l thumbnail "$HOME/.cache/joshuto/thumbnail.png"
    command ffmpegthumbnailer -i "$argv[1]" -o "$thumbnail" -s 0 2>/dev/null
    image $thumbnail $argv[2..5]
  case "application/pdf"
    set -l thumbnail "$HOME/.cache/joshuto/thumbnail.png"
    command gs -o "$thumbnail" -sDEVICE=png256 -r100 -dLastPage=1 "$argv[1]" 2>/dev/null >/dev/null
    image $thumbnail $argv[2..5]
  case "*"
    command kitty +kitten icat --transfer-mode=file --clear 2>/dev/null
end

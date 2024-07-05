#!/usr/bin/env fish

## this script is a template script for creating textual file previews in joshuto.
##
## copy this script to your joshuto configuration directory and refer to this
## script in `joshuto.toml` in the `[preview]` section like
## ```
## preview_script = "~/.config/joshuto/preview_file.sh"
## ```
## make sure the file is marked as executable:
## ```sh
## chmod +x ~/.config/joshuto/preview_file.sh
## ```
## joshuto will call this script for each file when first hovered by the cursor.
## if this script returns with an exit code 0, the stdout of this script will be
## the file's preview text in joshuto's right panel.
## the preview text will be cached by joshuto and only renewed on reload.
## ansi color codes are supported if joshuto is build with the `syntax_highlight`
## feature.
##
## this script is considered a configuration file and must be updated manually.
## it will be left untouched if you upgrade joshuto.
##
## meanings of exit codes:
##
## code | meaning  | action of ranger
## -----+------------+-------------------------------------------
## 0  | success  | display stdout as preview
## 1  | no preview | display no preview at all
##
## this script is used only as a provider for textual previews.
## image previews are independent from this script.
##

set IFS '\n'
argparse 'path=' 'preview-width=' 'preview-height=' -- $argv

function handle_extension
  switch $argv[1]
      ## archive
    case "*.a" "*.ace" "*.alz" "*.arc" "*.arj" "*.bz" "*.bz2" "*.cab" "*.cpio" "*.deb" "*.gz" "*.jar" "*.lha" "*.lz" "*.lzh" "*.lzma" "*.lzo" "*.rpm" "*.rz" "*.t7z" "*.tar" "*.tbz" "*.tbz2" "*.tgz" "*.tlz" "*.txz" "*.tz" "*.tzo" "*.war" "*.xpi" "*.xz" "*.zip"
      command atool --list -- "$argv[1]" && exit 0
      command bsdtar --list --file "$argv[1]" && exit 0
      exit 1
    case "*.rar"
      ## avoid password prompt by providing empty password
      command unrar lt -p- -- "$argv[1]" && exit 0
      exit 1
    case "*.7z"
      ## avoid password prompt by providing empty password
      command 7z l -p -- "$argv[1]" && exit 0
      exit 1

      ## pdf
    case "*.pdf"
      exit 6

      ## torrent
    case "*.torrent"
      command transmission-show -- "$argv[1]" && exit 0
      exit 1

      ## opendocument
    case "*.odt" "*.ods" "*.odp" "*.sxw"
      ## preview as text conversion
      command odt2txt "$argv[1]" && exit 0
      ## preview as markdown conversion
      command pandoc -s -t markdown -- "$argv[1]" && exit 0
      exit 1

      ## xlsx
    case "*.xlsx"
      ## preview as csv conversion
      ## uses: https://github.com/dilshod/xlsx2csv
      command xlsx2csv -- "$argv[1]" && exit 0
      exit 1

      ## html
    case "*.htm" "*.html" "*.xhtml"
      ## preview as text conversion
      command w3m -dump "$argv[1]" && exit 0
      command lynx -dump -- "$argv[1]" && exit 0
      command elinks -dump "$argv[1]" && exit 0
      command pandoc -s -t markdown -- "$argv[1]" && exit 0

      ## json
    case "*.json" "*.ipynb"
      command jq --color-output . "$argv[1]" && exit 0
      command python -m json.tool -- "$argv[1]" && exit 0

      ## direct stream digital/transfer (dsdiff) and wavpack aren't detected
      ## by file(1).
    case "*.dff" "*.dsf" "*.wv" "*.wvc"
      command mediainfo "$argv[1]" && exit 0
      command exiftool "$argv[1]" && exit 0
  end
end

function handle_mime
  switch $argv[1]
      ## rtf and doc
    case "text/rtf" "*msword"
      ## preview as text conversion
      ## note: catdoc does not always work for .doc files
      ## catdoc: http://www.wagner.pp.ru/~vitus/software/catdoc/
      command catdoc -- $_flag_path && exit 0
      exit 1

      ## docx, epub, fb2 (using markdown)
      ## you might want to remove "|epub" and/or "|fb2" below if you have
      ## uncommented other methods to preview those formats
    case "*wordprocessingml.document" "*/epub+zip" "*/x-fictionbook+xml"
      ## preview as markdown conversion
      command pandoc -s -t markdown -- "$argv[2]" | bat -l markdown \
        --color=always --paging=never \
        --style=plain \
        --terminal-width=$argv[3] && exit 0
      exit 1

      ## e-mails
    case "message/rfc822"
      ## parsing performed by mu: https://github.com/djcb/mu
      command mu view -- "$argv[2]" && exit 0
      exit 1

      ## xls
    case "*ms-excel"
      ## preview as csv conversion
      ## xls2csv comes with catdoc:
      ##   http://www.wagner.pp.ru/~vitus/software/catdoc/
      command xls2csv -- "$argv[2]" && exit 0
      exit 1

    ## text
    case "text/*" "*/xml"
      command bat --color=always --paging=never --terminal-width=$argv[3] "$argv[2]" && exit 0
      command cat "$argv[2]" && exit 0
      exit 1

    ## djvu
    case "image/vnd.djvu"
      ## preview as text conversion (requires djvulibre)
      command djvutxt "$argv[2]" | fmt -w $argv[3] && exit 0
      command exiftool "$argv[2]" && exit 0
      exit 1

    ## image and video
    case "image/*" "video/*"
      exit 6

		## audio
    case "audio/*"
      command mediainfo "$argv[2]" && exit 0
      command exiftool "$argv[2]" && exit 0
      exit 1
  end
end

handle_extension $_flag_path $_flag_preview_width
set -l mimetype (file --dereference --brief --mime-type -- "$_flag_path")
handle_mime $mimetype $_flag_path $_flag_preview_width

exit 1

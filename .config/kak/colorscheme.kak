# Catppuccin theme for Kakoune
# Color palette
declare-option str rosewater     'rgb:f5e0dc'
declare-option str red           'rgb:f38ba8'
declare-option str mauve         'rgb:cba6f7'
declare-option str maroon        'rgb:eba0ac'
declare-option str pink          'rgb:f5c2e7'
declare-option str cyan          'rgb:74c7ec'
declare-option str yellow        'rgb:f9e2af'
declare-option str green         'rgb:a6e3a1'
declare-option str white         'rgb:cdd6f4'
declare-option str blue          'rgb:89b4fa'
declare-option str sky           'rgb:89dceb'
declare-option str lavender      'rgb:b4befe'
declare-option str black1        'rgb:181825'
declare-option str black2        'rgb:1e1e2e'
declare-option str black3        'rgb:313244'
declare-option str orange        'rgb:fab387'
declare-option str teal          'rgb:94e2d5'
declare-option str gray0         'rgb:585b70'
declare-option str gray1         'rgb:7f849c'
declare-option str bright_red    %opt{red}
declare-option str bright_green  %opt{green}
declare-option str bright_yellow %opt{yellow}
declare-option str bright_blue   %opt{blue}
declare-option str bright_cyan   %opt{cyan}
declare-option str bright_white  %opt{white}
declare-option str foreground    %opt{white}
declare-option str background    %opt{black2}

# Markup
set-face global	title		"%opt{rosewater}"
set-face global	header	"%opt{bright_red}"
set-face global	bold		"%opt{mauve}"
set-face global	italic	"%opt{lavender}"
set-face global	mono		"%opt{green}"
set-face global	block		"%opt{cyan}"
set-face global	link		"%opt{green}"
set-face global	bullet	"%opt{green}"
set-face global	list		"%opt{white}"

# Builtins
set-face global Default	            "%opt{white},%opt{background}"
set-face global PrimarySelection	  "%opt{gray0},%opt{lavender}"
set-face global SecondarySelection	"%opt{lavender},%opt{gray0}"
set-face global PrimaryCursor		    "%opt{background},%opt{rosewater}"
set-face global SecondaryCursor		  "%opt{black1},%opt{teal}"
set-face global PrimaryCursorEol	  "%opt{gray0},%opt{mauve}"
set-face global SecondaryCursorEol	"%opt{gray0},%opt{maroon}"
set-face global LineNumbers			    "%opt{gray1},%opt{background}"
set-face global LineNumberCursor	  "%opt{yellow},%opt{background}+b"
set-face global LineNumbersWrapped	"%opt{teal},%opt{background}+i"
set-face global MenuForeground 		  "%opt{white},%opt{gray0}+b"
set-face global MenuBackground		  "%opt{white},%opt{black3}"
set-face global MenuInfo			      "%opt{blue}+b"
set-face global Information			    "default"
set-face global Error				        "%opt{red},%opt{background}"
set-face global StatusLine			    "%opt{white},%opt{background}"
set-face global StatusLineMode		  "%opt{green},%opt{background}"
set-face global StatusLineInfo		  "%opt{blue},%opt{background}"
set-face global StatusLineValue		  "%opt{orange},%opt{background}"
set-face global StatusCursor		    "%opt{background},%opt{lavender}"
set-face global Prompt				      "%opt{green},%opt{background}"
set-face global MatchingChar		    "%opt{blue},%opt{background}+fua"
set-face global Whitespace			    "%opt{gray1},%opt{background}+f"
set-face global WrapMarker				  Whitespace
set-face global BufferPadding		    "%opt{background},%opt{background}"

# Code faces

## Comments
set-face global comment       "%opt{gray1}"
set-face global documentation "%opt{gray1}+b"

## Objects
set-face global parameter     "%opt{white}+i"
set-face global variable      "%opt{white}"
set-face global constant      "%opt{gray1}+b"
set-face global callable      "%opt{blue}+i"

# Values
set-face global value         "%opt{orange}"
set-face global string        "%opt{green}"

## Types
set-face global type          "%opt{yellow}"
set-face global struct        "%opt{yellow}+i"
set-face global variant       "%opt{orange}+i"
set-face global function      "%opt{blue}"

# Syntax
set-face global punctuation   "%opt{maroon}"
set-face global keyword       "%opt{mauve}"
set-face global operator      "%opt{sky}"
set-face global meta          "%opt{mauve}+i"

# Rust Specific
set-face global lifetime      "%opt{green}+i"
set-face global self          "%opt{orange}"
set-face global attribute     "%opt{mauve}"

# Other
set-face global macro         "%opt{mauve}+i"
set-face global module        "%opt{blue}+i"
set-face global builtin       "%opt{lavender}+b"
set-face global interface     "%opt{white}+b"
set-face global generic       "%opt{green}"

# Lsp
face global InfoDefault               "default"
face global InfoBlock                 "%opt{yellow}"
face global InfoBlockQuote            "%opt{yellow}"
face global InfoBullet                "%opt{mauve}"
face global InfoHeader                "%opt{mauve}"
face global InfoLink                  "%opt{blue}+i"
face global InfoLinkMono              "%opt{blue}+i"
face global InfoMono                  "%opt{lavender}"
face global InfoRule                  "%opt{gray0}"
face global InfoDiagnosticError       "%opt{red}+b"
face global InfoDiagnosticHint        "%opt{teal}+b"
face global InfoDiagnosticInformation "%opt{blue}+b"
face global InfoDiagnosticWarning     "%opt{yellow}+b"
face global Reference                 "default+u"
face global DiagnosticError           ",,%opt{red}+ua"
face global DiagnosticHit             ",,%opt{teal}+ua"
face global DiagnosticInfo            ",,%opt{blue}+ua"
face global DiagnosticWarning         ",,%opt{yellow}+ua"

# Status line custom
set-face global File "%opt{yellow},%opt{background}+i"
set-face global Git "%opt{mauve},%opt{background}"
set-face global Coords "%opt{orange},%opt{background}"
set-face global Separator "%opt{sky},%opt{background}"

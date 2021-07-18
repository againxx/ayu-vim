" Initialization:"{{{
" ----------------------------------------------------------------------------
hi clear
if exists("syntax_on")
  syntax reset
endif

let s:style = get(g:, 'ayucolor', 'dark')
let s:transparent = get(g:, 'ayutrans', v:false)
let g:colors_name = "ayu"
"}}}

" Palettes:"{{{
" ----------------------------------------------------------------------------

let s:palette = {}

let s:palette.bg        = {'dark': "#0A0E14",  'light': "#FAFAFA",  'mirage': "#1F2430"}

let s:palette.comment   = {'dark': "#5C6773",  'light': "#ABB0B6",  'mirage': "#5C6773"}
let s:palette.markup    = {'dark': "#F07178",  'light': "#F07171",  'mirage': "#F28779"}
let s:palette.constant  = {'dark': "#FFEE99",  'light': "#A37ACC",  'mirage': "#D4BFFF"}
let s:palette.operator  = {'dark': "#F29668",  'light': "#ED9366",  'mirage': "#F29E74"}
let s:palette.entity    = {'dark': "#59C2FF",  'light': "#399EE6",  'mirage': "#73D0FF"}
let s:palette.tag       = {'dark': "#39BAE6",  'light': "#55B4D4",  'mirage': "#5CCFE6"}
let s:palette.field     = {'dark': "#39BAE6",  'light': "#55B4D4",  'mirage': "#B695E0"}
let s:palette.regexp    = {'dark': "#95E6CB",  'light': "#4CBF99",  'mirage': "#95E6CB"}
let s:palette.string    = {'dark': "#C2D94C",  'light': "#86B300",  'mirage': "#BAE67E"}
let s:palette.namespace = {'dark': "#C2D94C",  'light': "#86B300",  'mirage': "#9ac732"}
let s:palette.function  = {'dark': "#FFB454",  'light': "#F29718",  'mirage': "#FFD580"}
let s:palette.special   = {'dark': "#E6B673",  'light': "#E6B673",  'mirage': "#FFE6B3"}
let s:palette.keyword   = {'dark': "#FF7733",  'light': "#FF7733",  'mirage': "#FFA759"}

let s:palette.error     = {'dark': "#FF3333",  'light': "#F51818",  'mirage': "#FF3333"}
let s:palette.accent    = {'dark': "#E6B450",  'light': "#FF9940",  'mirage': "#FFCC66"}
let s:palette.panel     = {'dark': "#14191F",  'light': "#FFFFFF",  'mirage': "#232834"}
let s:palette.guide     = {'dark': "#2D3640",  'light': "#D9D8D7",  'mirage': "#323A4C"}
let s:palette.line      = {'dark': "#151A1E",  'light': "#F3F3F3",  'mirage': "#191E2A"}
let s:palette.selection = {'dark': "#253340",  'light': "#F0EEE4",  'mirage': "#33415E"}
let s:palette.fg        = {'dark': "#E6E1CF",  'light': "#5C6773",  'mirage': "#CBCCC6"}
let s:palette.fg_idle   = {'dark': "#4D5566",  'light': "#8A9199",  'mirage': "#707A8C"}
let s:palette.added     = {'dark': "#91B362",  'light': "#99BF4D",  'mirage': "#A6CC70"}
let s:palette.modified  = {'dark': "#6994BF",  'light': "#709ECC",  'mirage': "#77A8D9"}
let s:palette.removed   = {'dark': "#D96C75",  'light': "#F27983",  'mirage': "#F27983"}
let s:palette.border    = {'dark': "#F0F0F0",  'light': "#000000",  'mirage': "#101521"}
let s:palette.shadow    = {'dark': "#00010A",  'light': "#424A50",  'mirage': "#141925"}

"}}}

" Highlighting Primitives:"{{{
" ----------------------------------------------------------------------------

function! s:build_prim(hi_elem, field)
  let l:vname = "s:" . a:hi_elem . "_" . a:field " s:bg_gray
  let l:gui_assign = "gui".a:hi_elem."=".s:palette[a:field][s:style] " guibg=...
  exe "let " . l:vname . " = ' " . l:gui_assign . "'"
endfunction

let s:bg_none = ' guibg=NONE ctermbg=NONE'
let s:fg_none = ' guifg=NONE ctermfg=NONE'
for [key_name, d_value] in items(s:palette)
  call s:build_prim('bg', key_name)
  call s:build_prim('fg', key_name)
endfor
" }}}

" Formatting Options:"{{{
" ----------------------------------------------------------------------------
let s:none   = "NONE"
let s:t_none = "NONE"
let s:n      = "NONE"
let s:c      = ",undercurl"
let s:r      = ",reverse"
let s:s      = ",standout"
let s:b      = ",bold"
let s:u      = ",underline"
let s:i      = ",italic"

exe "let s:fmt_none = ' gui=NONE".          " cterm=NONE".          " term=NONE"        ."'"
exe "let s:fmt_bold = ' gui=NONE".s:b.      " cterm=NONE".s:b.      " term=NONE".s:b    ."'"
exe "let s:fmt_bldi = ' gui=NONE".s:b.s:i.  " cterm=NONE".s:b.s:i.  " term=NONE".s:b.s:i."'"
exe "let s:fmt_undr = ' gui=NONE".s:u.      " cterm=NONE".s:u.      " term=NONE".s:u    ."'"
exe "let s:fmt_undb = ' gui=NONE".s:u.s:b.  " cterm=NONE".s:u.s:b.  " term=NONE".s:u.s:b."'"
exe "let s:fmt_undi = ' gui=NONE".s:u.      " cterm=NONE".s:u.      " term=NONE".s:u    ."'"
exe "let s:fmt_curl = ' gui=NONE".s:c.      " cterm=NONE".s:c.      " term=NONE".s:c    ."'"
exe "let s:fmt_ital = ' gui=NONE".s:i.      " cterm=NONE".s:i.      " term=NONE".s:i    ."'"
exe "let s:fmt_stnd = ' gui=NONE".s:s.      " cterm=NONE".s:s.      " term=NONE".s:s    ."'"
exe "let s:fmt_revr = ' gui=NONE".s:r.      " cterm=NONE".s:r.      " term=NONE".s:r    ."'"
exe "let s:fmt_revb = ' gui=NONE".s:r.s:b.  " cterm=NONE".s:r.s:b.  " term=NONE".s:r.s:b."'"
"}}}


" Vim Highlighting: (see :help highlight-groups)"{{{
" ----------------------------------------------------------------------------
if s:transparent
  exe "hi! Normal"        .s:fg_fg          .s:bg_none        .s:fmt_none
  exe "hi! SignColumn"    .s:fg_none        .s:bg_none        .s:fmt_none
  exe "hi! CursorLineNr"  .s:fg_accent      .s:bg_none        .s:fmt_none
else
  exe "hi! Normal"        .s:fg_fg          .s:bg_bg          .s:fmt_none
  exe "hi! SignColumn"    .s:fg_none        .s:bg_panel       .s:fmt_none
  exe "hi! CursorLineNr"  .s:fg_accent      .s:bg_line        .s:fmt_none
endif
exe "hi! ColorColumn"   .s:fg_none        .s:bg_line        .s:fmt_none
" Conceal, Cursor, CursorIM
exe "hi! CursorColumn"  .s:fg_none        .s:bg_line        .s:fmt_none
exe "hi! CursorLine"    .s:fg_none        .s:bg_line        .s:fmt_none
exe "hi! LineNr"        .s:fg_guide       .s:bg_none        .s:fmt_none

exe "hi! Directory"     .s:fg_fg_idle     .s:bg_none        .s:fmt_none
exe "hi! DiffAdd"       .s:fg_added       .s:bg_panel       .s:fmt_none
exe "hi! DiffChange"    .s:fg_modified    .s:bg_panel       .s:fmt_none
exe "hi! DiffText"      .s:fg_fg          .s:bg_panel       .s:fmt_none
exe "hi! ErrorMsg"      .s:fg_fg          .s:bg_error       .s:fmt_stnd
exe "hi! VertSplit"     .s:fg_bg          .s:bg_none        .s:fmt_none
exe "hi! Folded"        .s:fg_fg_idle     .s:bg_panel       .s:fmt_none
exe "hi! FoldColumn"    .s:fg_none        .s:bg_panel       .s:fmt_none
"   Incsearch"

exe "hi! MatchParen"    .s:fg_fg          .s:bg_bg          .s:fmt_undr
exe "hi! ModeMsg"       .s:fg_string      .s:bg_none        .s:fmt_none
exe "hi! MoreMsg"       .s:fg_string      .s:bg_none        .s:fmt_none
exe "hi! NonText"       .s:fg_guide       .s:bg_none        .s:fmt_none
exe "hi! Pmenu"         .s:fg_fg          .s:bg_selection   .s:fmt_none
exe "hi! PmenuSel"      .s:fg_fg          .s:bg_selection   .s:fmt_revr
"   PmenuSbar"
"   PmenuThumb"
exe "hi! Question"      .s:fg_string      .s:bg_none        .s:fmt_none
exe "hi! Search"        .s:fg_bg          .s:bg_constant    .s:fmt_none
exe "hi! SpecialKey"    .s:fg_selection   .s:bg_none        .s:fmt_none
exe "hi! SpellCap"      .s:fg_tag         .s:bg_none        .s:fmt_undr
exe "hi! SpellLocal"    .s:fg_keyword     .s:bg_none        .s:fmt_undr
exe "hi! SpellBad"      .s:fg_error       .s:bg_none        .s:fmt_undr
exe "hi! SpellRare"     .s:fg_regexp      .s:bg_none        .s:fmt_undr
exe "hi! StatusLine"    .s:fg_fg          .s:bg_panel       .s:fmt_none
exe "hi! StatusLineNC"  .s:fg_fg_idle     .s:bg_panel       .s:fmt_none
exe "hi! WildMenu"      .s:fg_selection   .s:bg_markup      .s:fmt_none
exe "hi! TabLine"       .s:fg_fg          .s:bg_panel       .s:fmt_revr
"   TabLineFill"
"   TabLineSel"
exe "hi! Title"         .s:fg_keyword     .s:bg_none        .s:fmt_none
exe "hi! Visual"        .s:fg_none        .s:bg_selection   .s:fmt_none
"   VisualNos"
exe "hi! WarningMsg"    .s:fg_error       .s:bg_none        .s:fmt_none

" TODO LongLineWarning to use variables instead of hardcoding
hi LongLineWarning  guifg=NONE        guibg=#371F1C     gui=underline ctermfg=NONE        ctermbg=NONE        cterm=underline
"   WildMenu"

"}}}

" Generic Syntax Highlighting: (see :help group-name)"{{{
" ----------------------------------------------------------------------------
exe "hi! Comment"         .s:fg_comment   .s:bg_none        .s:fmt_ital

exe "hi! Constant"        .s:fg_constant  .s:bg_none        .s:fmt_none
exe "hi! String"          .s:fg_string    .s:bg_none        .s:fmt_none
"   Character"
"   Number"
"   Boolean"
"   Float"

exe "hi! Identifier"      .s:fg_tag       .s:bg_none        .s:fmt_none
exe "hi! Function"        .s:fg_function  .s:bg_none        .s:fmt_none

exe "hi! Statement"       .s:fg_keyword   .s:bg_none        .s:fmt_bldi
"   Conditional"
"   Repeat"
"   Label"
exe "hi! Operator"        .s:fg_operator  .s:bg_none        .s:fmt_none
"   Keyword"
"   Exception"

exe "hi! PreProc"         .s:fg_special   .s:bg_none        .s:fmt_none
"   Include"
"   Define"
"   Macro"
"   PreCondit"

exe "hi! Type"            .s:fg_entity    .s:bg_none        .s:fmt_none
"   StorageClass"
exe "hi! Structure"       .s:fg_special   .s:bg_none        .s:fmt_none
"   Typedef"

exe "hi! Special"         .s:fg_special   .s:bg_none        .s:fmt_none
"   SpecialChar"
"   Tag"
"   Delimiter"
"   SpecialComment"
"   Debug"
"
exe "hi! Underlined"      .s:fg_tag       .s:bg_none        .s:fmt_undr

exe "hi! Ignore"          .s:fg_none      .s:bg_none        .s:fmt_none

exe "hi! Error"           .s:fg_fg        .s:bg_error       .s:fmt_none

exe "hi! Todo"            .s:fg_markup    .s:bg_none        .s:fmt_none

" Quickfix window highlighting
exe "hi! qfLineNr"        .s:fg_keyword   .s:bg_none        .s:fmt_none
exe "hi! qfError"         .s:fg_removed   .s:bg_none        .s:fmt_bold
exe "hi! qfWarning"       .s:fg_function  .s:bg_none        .s:fmt_bold
"   qfFileName"
"   qfLineNr"

exe "hi! Conceal"           .s:fg_guide   .s:bg_none        .s:fmt_none
exe "hi! CursorLineConceal" .s:fg_guide   .s:bg_line        .s:fmt_none
exe "hi! Whitespace"        .s:fg_shadow  .s:bg_none        .s:fmt_none


" Terminal
" ---------
if has("nvim")
  let g:terminal_color_0 =  s:palette.bg[s:style]
  let g:terminal_color_1 =  s:palette.markup[s:style]
  let g:terminal_color_2 =  s:palette.string[s:style]
  let g:terminal_color_3 =  s:palette.accent[s:style]
  let g:terminal_color_4 =  s:palette.tag[s:style]
  let g:terminal_color_5 =  s:palette.constant[s:style]
  let g:terminal_color_6 =  s:palette.regexp[s:style]
  let g:terminal_color_7 =  "#FFFFFF"
  let g:terminal_color_8 =  s:palette.fg_idle[s:style]
  let g:terminal_color_9 =  s:palette.error[s:style]
  let g:terminal_color_10 = s:palette.string[s:style]
  let g:terminal_color_11 = s:palette.accent[s:style]
  let g:terminal_color_12 = s:palette.tag[s:style]
  let g:terminal_color_13 = s:palette.constant[s:style]
  let g:terminal_color_14 = s:palette.regexp[s:style]
  let g:terminal_color_15 = s:palette.comment[s:style]
  let g:terminal_color_background = g:terminal_color_0
  let g:terminal_color_foreground = s:palette.fg[s:style]
else
  let g:terminal_ansi_colors =  [s:palette.bg[s:style],      s:palette.markup[s:style]]
  let g:terminal_ansi_colors += [s:palette.string[s:style],  s:palette.accent[s:style]]
  let g:terminal_ansi_colors += [s:palette.tag[s:style],     s:palette.constant[s:style]]
  let g:terminal_ansi_colors += [s:palette.regexp[s:style],  "#FFFFFF"]
  let g:terminal_ansi_colors += [s:palette.fg_idle[s:style], s:palette.error[s:style]]
  let g:terminal_ansi_colors += [s:palette.string[s:style],  s:palette.accent[s:style]]
  let g:terminal_ansi_colors += [s:palette.tag[s:style],     s:palette.constant[s:style]]
  let g:terminal_ansi_colors += [s:palette.regexp[s:style],  s:palette.comment[s:style]]
endif


" NerdTree
" ---------
exe "hi! NERDTreeOpenable"          .s:fg_fg_idle     .s:bg_none        .s:fmt_none
exe "hi! NERDTreeClosable"          .s:fg_accent      .s:bg_none        .s:fmt_none
" exe "hi! NERDTreeBookmarksHeader"   .s:fg_pink        .s:bg_none        .s:fmt_none
" exe "hi! NERDTreeBookmarksLeader"   .s:fg_bg          .s:bg_none        .s:fmt_none
" exe "hi! NERDTreeBookmarkName"      .s:fg_keyword     .s:bg_none        .s:fmt_none
" exe "hi! NERDTreeCWD"               .s:fg_pink        .s:bg_none        .s:fmt_none
exe "hi! NERDTreeUp"                .s:fg_fg_idle    .s:bg_none        .s:fmt_none
exe "hi! NERDTreeDir"               .s:fg_function   .s:bg_none        .s:fmt_none
exe "hi! NERDTreeFile"              .s:fg_none       .s:bg_none        .s:fmt_none
exe "hi! NERDTreeDirSlash"          .s:fg_accent     .s:bg_none        .s:fmt_none


" GitGutter
" ---------
exe "hi! GitGutterAdd"          .s:fg_added      .s:bg_none        .s:fmt_none
exe "hi! GitGutterChange"       .s:fg_modified   .s:bg_none        .s:fmt_none
exe "hi! GitGutterDelete"       .s:fg_removed    .s:bg_none        .s:fmt_none
exe "hi! GitGutterChangeDelete" .s:fg_function   .s:bg_none        .s:fmt_none

" Treesitter
exe "hi! TSParameter"       .s:fg_markup     .s:bg_none        .s:fmt_none
exe "hi! TSNamespace"       .s:fg_namespace  .s:bg_none        .s:fmt_none
exe "hi! TSField"           .s:fg_field      .s:bg_none        .s:fmt_none
exe "hi! TSConstructor"     .s:fg_regexp     .s:bg_none        .s:fmt_none

" Coc
exe "hi! CocErrorSign"      .s:fg_removed    .s:bg_none        .s:fmt_bold
exe "hi! CocWarningSign"    .s:fg_function   .s:bg_none        .s:fmt_none
exe "hi! CocInfoSign"       .s:fg_regexp     .s:bg_none        .s:fmt_none
exe "hi! CocHighlightText"  .s:fg_none       .s:bg_guide       .s:fmt_none

" Indent
exe "hi! IndentBlanklineChar" .s:fg_border   .s:bg_none        .s:fmt_none

" Vimspector
exe "hi! VimspectorBP"      .s:fg_markup     .s:bg_none        .s:fmt_none
exe "hi! VimspectorBPCond"  .s:fg_function   .s:bg_none        .s:fmt_none
exe "hi! VimspectorPC"      .s:fg_constant   .s:bg_none        .s:fmt_none
exe "hi! VimspectorPCBP"    .s:fg_constant   .s:bg_none        .s:fmt_none

" Sneak
exe "hi! Sneak"             .s:fg_bg         .s:bg_constant    .s:fmt_none

" Visual multi
exe "hi! VMExtend"          .s:fg_selection  .s:bg_regexp      .s:fmt_none
exe "hi! VMCursor"          .s:fg_selection  .s:bg_string      .s:fmt_none
hi! link VMMono WildMenu

" HTML & Vimwiki
exe "hi! htmlH1"            .s:fg_constant   .s:bg_none        .s:fmt_bold
exe "hi! htmlH2"            .s:fg_string     .s:bg_none        .s:fmt_bold
exe "hi! htmlH3"            .s:fg_entity     .s:bg_none        .s:fmt_bold
exe "hi! htmlH4"            .s:fg_function   .s:bg_none        .s:fmt_bold
exe "hi! htmlH5"            .s:fg_markup     .s:bg_none        .s:fmt_none
exe "hi! htmlH6"            .s:fg_regexp     .s:bg_none        .s:fmt_none

hi! link VimwikiHeader1 htmlH1
hi! link VimwikiHeader2 htmlH2
hi! link VimwikiHeader3 htmlH3
hi! link VimwikiHeader4 htmlH4
hi! link VimwikiHeader5 htmlH5
hi! link VimwikiHeader6 htmlH6

"}}}

" Diff Syntax Highlighting:"{{{
" ----------------------------------------------------------------------------
" Diff
"   diffOldFile
"   diffNewFile
"   diffFile
"   diffOnly
"   diffIdentical
"   diffDiffer
"   diffBDiffer
"   diffIsA
"   diffNoEOL
"   diffCommon
hi! link diffRemoved GitGutterDelete
"   diffChanged
hi! link diffAdded GitGutterAdd
"   diffLine
"   diffSubname
"   diffComment

"}}}

" This is needed for some reason: {{{

let &background = s:style

" }}}

type token =
  | Param of (
# 130 "src/octParser.mly"
        string
# 6 "src/octParser.mli"
)
  | AUTHOR
  | Version of (
# 132 "src/octParser.mly"
        string
# 12 "src/octParser.mli"
)
  | See of (
# 133 "src/octParser.mly"
        Types.see_ref
# 17 "src/octParser.mli"
)
  | Since of (
# 134 "src/octParser.mly"
        string
# 22 "src/octParser.mli"
)
  | Before of (
# 135 "src/octParser.mly"
        string
# 27 "src/octParser.mli"
)
  | DEPRECATED
  | Raise of (
# 137 "src/octParser.mly"
        string
# 33 "src/octParser.mli"
)
  | RETURN
  | INLINE
  | Custom of (
# 140 "src/octParser.mly"
        string
# 40 "src/octParser.mli"
)
  | Canonical of (
# 141 "src/octParser.mly"
        string
# 45 "src/octParser.mli"
)
  | BEGIN
  | END
  | Title of (
# 146 "src/octParser.mly"
        int * string option
# 52 "src/octParser.mli"
)
  | Style of (
# 147 "src/octParser.mly"
        Types.style_kind
# 57 "src/octParser.mli"
)
  | LIST
  | ENUM
  | Item of (
# 150 "src/octParser.mly"
        bool
# 64 "src/octParser.mli"
)
  | Ref of (
# 152 "src/octParser.mly"
        Types.ref_kind * string
# 69 "src/octParser.mli"
)
  | Special_Ref of (
# 153 "src/octParser.mly"
        Types.special_ref_kind
# 74 "src/octParser.mli"
)
  | Code of (
# 155 "src/octParser.mly"
        string
# 79 "src/octParser.mli"
)
  | Pre_Code of (
# 156 "src/octParser.mly"
        string
# 84 "src/octParser.mli"
)
  | Verb of (
# 157 "src/octParser.mly"
        string
# 89 "src/octParser.mli"
)
  | Target of (
# 158 "src/octParser.mly"
        string option * string
# 94 "src/octParser.mli"
)
  | HTML_Bold of (
# 160 "src/octParser.mly"
        string
# 99 "src/octParser.mli"
)
  | HTML_END_BOLD
  | HTML_Center of (
# 162 "src/octParser.mly"
        string
# 105 "src/octParser.mli"
)
  | HTML_END_CENTER
  | HTML_Left of (
# 164 "src/octParser.mly"
        string
# 111 "src/octParser.mli"
)
  | HTML_END_LEFT
  | HTML_Right of (
# 166 "src/octParser.mly"
        string
# 117 "src/octParser.mli"
)
  | HTML_END_RIGHT
  | HTML_Italic of (
# 168 "src/octParser.mly"
        string
# 123 "src/octParser.mli"
)
  | HTML_END_ITALIC
  | HTML_Title of (
# 170 "src/octParser.mly"
        string * int
# 129 "src/octParser.mli"
)
  | HTML_END_Title of (
# 171 "src/octParser.mly"
        int
# 134 "src/octParser.mli"
)
  | HTML_List of (
# 172 "src/octParser.mly"
        string
# 139 "src/octParser.mli"
)
  | HTML_END_LIST
  | HTML_Enum of (
# 174 "src/octParser.mly"
        string
# 145 "src/octParser.mli"
)
  | HTML_END_ENUM
  | HTML_Item of (
# 176 "src/octParser.mly"
        string
# 151 "src/octParser.mli"
)
  | HTML_END_ITEM
  | MINUS
  | PLUS
  | NEWLINE
  | EOF
  | BLANK
  | Char of (
# 185 "src/octParser.mly"
        string
# 162 "src/octParser.mli"
)
  | DOT
  | Ref_part of (
# 188 "src/octParser.mly"
        string
# 168 "src/octParser.mli"
)

val main :
  (Lexing.lexbuf  -> token) -> Lexing.lexbuf -> Types.t
val reference_parts :
  (Lexing.lexbuf  -> token) -> Lexing.lexbuf -> (string option * string) list

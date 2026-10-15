vim.cmd "highlight clear"
if vim.fn.exists "syntax_on" then vim.cmd "syntax reset" end
vim.g.colors_name = "cenote"
vim.o.termguicolors = true

local c = {
  -- fondos
  bg        = "#0C1A19",
  bg_dark   = "#081210",
  bg_light  = "#142624",
  bg_sel    = "#1A3330",
  bg_float  = "#0E2220",

  -- texto
  fg        = "#E6FFFC",
  fg_dim    = "#A8C5C2",
  fg_muted  = "#6A9490",
  comment   = "#3E6460",

  -- colores
  red       = "#FF6B6B",
  red_dim   = "#FF8787",
  green     = "#00C2AD",
  green_dim = "#68EADC",
  yellow    = "#E5C07B",
  yellow_br = "#FFD580",
  blue      = "#40E0CF",
  blue_dim  = "#98F4E4",
  purple    = "#C792EA",
  purple_br = "#E9B7F3",
  cyan      = "#1CD3C0",
  cursor    = "#9BF4EA",
  none      = "NONE",
}

-- Con un fondo distinto de background.png, ~/.local/bin/colores-fondo copia aquí
-- los colores del fondo (themes/noctalia.lua). Vacío = colores de siempre.
local ok, fondo = pcall(dofile, vim.fn.stdpath "config" .. "/colores-fondo.lua")
if ok and type(fondo) == "table" then c = vim.tbl_extend("force", c, fondo) end

local function hi(group, opts)
  vim.api.nvim_set_hl(0, group, opts)
end

-- ── Editor ────────────────────────────────────────────────────────────────────
hi("Normal",          { fg = c.fg,       bg = c.bg })
hi("NormalFloat",     { fg = c.fg,       bg = c.bg_float })
hi("NormalNC",        { fg = c.fg_dim,   bg = c.bg_dark })
hi("CursorLine",      { bg = c.bg_light })
hi("CursorLineNr",    { fg = c.cursor,   bold = true })
hi("LineNr",          { fg = c.comment })
hi("SignColumn",      { fg = c.comment,  bg = c.bg })
hi("ColorColumn",     { bg = c.bg_light })
hi("Folded",          { fg = c.fg_muted, bg = c.bg_light })
hi("FoldColumn",      { fg = c.comment,  bg = c.bg })
hi("Conceal",         { fg = c.comment })
hi("MatchParen",      { fg = c.cursor,   bold = true, underline = true })
hi("NonText",         { fg = c.comment })
hi("SpecialKey",      { fg = c.comment })
hi("Whitespace",      { fg = c.comment })
hi("EndOfBuffer",     { fg = c.bg })

-- ── Cursor & Selección ────────────────────────────────────────────────────────
hi("Cursor",          { fg = c.bg,       bg = c.cursor })
hi("CursorIM",        { fg = c.bg,       bg = c.cursor })
hi("Visual",          { bg = c.bg_sel })
hi("VisualNOS",       { bg = c.bg_sel })

-- ── Búsqueda ──────────────────────────────────────────────────────────────────
hi("Search",          { fg = c.bg,       bg = c.yellow })
hi("IncSearch",       { fg = c.bg,       bg = c.cursor })
hi("CurSearch",       { fg = c.bg,       bg = c.cursor })
hi("Substitute",      { fg = c.bg,       bg = c.red })

-- ── Mensajes ──────────────────────────────────────────────────────────────────
hi("ErrorMsg",        { fg = c.red })
hi("WarningMsg",      { fg = c.yellow })
hi("ModeMsg",         { fg = c.green_dim, bold = true })
hi("MoreMsg",         { fg = c.cyan })
hi("Question",        { fg = c.blue })

-- ── Splits & Bordes ───────────────────────────────────────────────────────────
hi("WinSeparator",    { fg = c.bg_sel })
hi("VertSplit",       { fg = c.bg_sel })

-- ── Status & Tabs ─────────────────────────────────────────────────────────────
hi("StatusLine",      { fg = c.fg_dim,   bg = c.bg_light })
hi("StatusLineNC",    { fg = c.comment,  bg = c.bg_dark })
hi("TabLine",         { fg = c.fg_muted, bg = c.bg_dark })
hi("TabLineSel",      { fg = c.fg,       bg = c.bg_light, bold = true })
hi("TabLineFill",     { bg = c.bg_dark })

-- ── Popup / Completion ────────────────────────────────────────────────────────
hi("Pmenu",           { fg = c.fg_dim,   bg = c.bg_float })
hi("PmenuSel",        { fg = c.fg,       bg = c.bg_sel })
hi("PmenuSbar",       { bg = c.bg_light })
hi("PmenuThumb",      { bg = c.fg_muted })
hi("FloatBorder",     { fg = c.blue,     bg = c.bg_float })
hi("FloatTitle",      { fg = c.cursor,   bold = true })

-- ── Diagnósticos ──────────────────────────────────────────────────────────────
hi("DiagnosticError",          { fg = c.red })
hi("DiagnosticWarn",           { fg = c.yellow })
hi("DiagnosticInfo",           { fg = c.blue })
hi("DiagnosticHint",           { fg = c.cyan })
hi("DiagnosticUnderlineError", { undercurl = true, sp = c.red })
hi("DiagnosticUnderlineWarn",  { undercurl = true, sp = c.yellow })
hi("DiagnosticUnderlineInfo",  { undercurl = true, sp = c.blue })
hi("DiagnosticUnderlineHint",  { undercurl = true, sp = c.cyan })
hi("DiagnosticVirtualTextError", { fg = c.red,    bg = c.bg_dark })
hi("DiagnosticVirtualTextWarn",  { fg = c.yellow, bg = c.bg_dark })
hi("DiagnosticVirtualTextInfo",  { fg = c.blue,   bg = c.bg_dark })
hi("DiagnosticVirtualTextHint",  { fg = c.cyan,   bg = c.bg_dark })

-- ── Diff ──────────────────────────────────────────────────────────────────────
hi("DiffAdd",         { fg = c.green,    bg = "#0A2420" })
hi("DiffChange",      { fg = c.yellow,   bg = "#221A0A" })
hi("DiffDelete",      { fg = c.red,      bg = "#200A0A" })
hi("DiffText",        { fg = c.yellow_br, bold = true })

-- ── Sintaxis base ─────────────────────────────────────────────────────────────
hi("Comment",         { fg = c.comment,  italic = true })
hi("Constant",        { fg = c.yellow })
hi("String",          { fg = c.green })
hi("Character",       { fg = c.green_dim })
hi("Number",          { fg = c.yellow_br })
hi("Boolean",         { fg = c.purple,   bold = true })
hi("Float",           { fg = c.yellow_br })
hi("Identifier",      { fg = c.fg })
hi("Function",        { fg = c.green_dim })
hi("Statement",       { fg = c.blue })
hi("Conditional",     { fg = c.blue })
hi("Repeat",          { fg = c.blue })
hi("Label",           { fg = c.blue })
hi("Operator",        { fg = c.cyan })
hi("Keyword",         { fg = c.blue,     bold = true })
hi("Exception",       { fg = c.red })
hi("PreProc",         { fg = c.purple })
hi("Include",         { fg = c.purple })
hi("Define",          { fg = c.purple })
hi("Macro",           { fg = c.purple_br })
hi("Type",            { fg = c.purple })
hi("StorageClass",    { fg = c.blue })
hi("Structure",       { fg = c.purple })
hi("Typedef",         { fg = c.purple })
hi("Special",         { fg = c.cyan })
hi("SpecialChar",     { fg = c.green_dim })
hi("Tag",             { fg = c.blue })
hi("Delimiter",       { fg = c.fg_dim })
hi("SpecialComment",  { fg = c.fg_muted, italic = true })
hi("Underlined",      { underline = true })
hi("Error",           { fg = c.red,      bold = true })
hi("Todo",            { fg = c.bg,       bg = c.yellow, bold = true })

-- ── Treesitter ────────────────────────────────────────────────────────────────
hi("@variable",              { fg = c.fg })
hi("@variable.builtin",      { fg = c.purple })
hi("@variable.parameter",    { fg = c.fg_dim })
hi("@variable.member",       { fg = c.blue_dim })
hi("@constant",              { fg = c.yellow })
hi("@constant.builtin",      { fg = c.yellow, bold = true })
hi("@string",                { fg = c.green })
hi("@string.escape",         { fg = c.cyan })
hi("@string.special",        { fg = c.cyan })
hi("@number",                { fg = c.yellow_br })
hi("@boolean",               { fg = c.purple, bold = true })
hi("@float",                 { fg = c.yellow_br })
hi("@function",              { fg = c.green_dim })
hi("@function.builtin",      { fg = c.cyan })
hi("@function.call",         { fg = c.green_dim })
hi("@function.method",       { fg = c.green_dim })
hi("@function.method.call",  { fg = c.green_dim })
hi("@constructor",           { fg = c.purple })
hi("@keyword",               { fg = c.blue, bold = true })
hi("@keyword.import",        { fg = c.purple })
hi("@keyword.return",        { fg = c.red_dim })
hi("@keyword.operator",      { fg = c.cyan })
hi("@operator",              { fg = c.cyan })
hi("@punctuation.bracket",   { fg = c.fg_dim })
hi("@punctuation.delimiter", { fg = c.fg_muted })
hi("@comment",               { fg = c.comment, italic = true })
hi("@type",                  { fg = c.purple })
hi("@type.builtin",          { fg = c.purple, bold = true })
hi("@attribute",             { fg = c.yellow })
hi("@namespace",             { fg = c.blue_dim })
hi("@tag",                   { fg = c.blue })
hi("@tag.attribute",         { fg = c.green_dim })
hi("@tag.delimiter",         { fg = c.fg_muted })

-- ── LSP ───────────────────────────────────────────────────────────────────────
hi("LspReferenceText",  { bg = c.bg_sel })
hi("LspReferenceRead",  { bg = c.bg_sel })
hi("LspReferenceWrite", { bg = c.bg_sel, underline = true })
hi("LspInlayHint",      { fg = c.comment, italic = true })

-- ── Gitsigns ──────────────────────────────────────────────────────────────────
hi("GitSignsAdd",    { fg = c.green })
hi("GitSignsChange", { fg = c.yellow })
hi("GitSignsDelete", { fg = c.red })

if vim.bo.ft ~= 'tex' then
	return
end

-- Local tab/space settings
vim.bo.tabstop = 8
vim.bo.softtabstop = 2
vim.bo.shiftwidth = 2
vim.bo.expandtab = true

-- LaTeX-specific Mappings
local mapopts = { buffer = true, silent = true, remap = false }
local map = vim.keymap.set

-- Bold and italic text mappings
map("i", "<C-b>", "\\textbf{}<Esc>i", mapopts)
map("i", "<C-t>", "\\textit{}<Esc>i", mapopts)

map("ia", "\\docu",  "\\documentclass[]{<++>}<Esc>6hi<C-R>",    mapopts)
map("ia", "\\useo",  "\\usepackage[]{<++>}<Esc>6hi<C-R>",       mapopts)
map("ia", "\\usep",  "\\usepackage{}<Left><C-R>",               mapopts)
map("ia", "\\part",  "\\part{}<Left><C-R>",                     mapopts)
map("ia", "\\chap",  "\\chapter{}<Left><C-R>",                  mapopts)
map("ia", "\\sect",  "\\section{}<Left><C-R>",                  mapopts)
map("ia", "\\subs",  "\\subsection{}<Left><C-R>",               mapopts)
map("ia", "\\sub2",  "\\subsubsection{}<Left><C-R>",            mapopts)
map("ia", "\\begin", "\\begin{}<Esc>o\\end{<++>}<Esc>khi<C-R>", mapopts)
map("ia", "\\frac",  "\\frac{}{<++>}<++><Esc>10hi<C-R>",        mapopts)

map("ia", "\\->", "\\textrightarrow{}", mapopts)

-- Greek letter mappings
map("i", '@A',  '\\mathrm{A}', mapopts)
map("i", '@a',  '\\alpha', mapopts)
map("i", '@B',  '\\mathrm{B}', mapopts)
map("i", '@b',  '\\beta', mapopts)
map("i", '@C',  '\\mathrm{X}', mapopts)
map("i", '@c',  '\\chi', mapopts)
map("i", '@D',  '\\Delta', mapopts)
map("i", '@d',  '\\delta', mapopts)
map("i", '@E',  '\\mathrm{E}', mapopts)
map("i", '@e',  '\\epsilon', mapopts)
map("i", '@F',  '\\Phi', mapopts)
map("i", '@f',  '\\phi', mapopts)
map("i", '@G',  '\\Gamma', mapopts)
map("i", '@g',  '\\gamma', mapopts)
map("i", '@H',  '\\mathrm{H}', mapopts)
map("i", '@h',  '\\eta', mapopts)
map("i", '@I',  '\\mathrm{I}', mapopts)
map("i", '@i',  '\\iota', mapopts)
map("i", '@K',  '\\mathrm{K}', mapopts)
map("i", '@k',  '\\kappa', mapopts)
map("i", '@L',  '\\Lambda', mapopts)
map("i", '@l',  '\\lambda', mapopts)
map("i", '@M',  '\\mathrm{M}', mapopts)
map("i", '@m',  '\\mu', mapopts)
map("i", '@N',  '\\mathrm{N}', mapopts)
map("i", '@n',  '\\nu', mapopts)
map("i", '@O',  '\\mathrm{O}', mapopts)
map("i", '@o',  '\\mathrm{o}', mapopts)
map("i", '@P',  '\\Pi', mapopts)
map("i", '@p',  '\\pi', mapopts)
map("i", '@Q',  '\\Theta', mapopts)
map("i", '@q',  '\\theta', mapopts)
map("i", '@R',  '\\mathrm{P}', mapopts)
map("i", '@r',  '\\rho', mapopts)
map("i", '@S',  '\\Sigma', mapopts)
map("i", '@s',  '\\sigma', mapopts)
map("i", '@T',  '\\mathrm{T}', mapopts)
map("i", '@t',  '\\tau', mapopts)
map("i", '@U',  '\\Upsilon', mapopts)
map("i", '@u',  '\\upsilon', mapopts)
map("i", '@W',  '\\Omega', mapopts)
map("i", '@w',  '\\omega', mapopts)
map("i", '@X',  '\\Xi', mapopts)
map("i", '@x',  '\\xi', mapopts)
map("i", '@Y',  '\\Psi', mapopts)
map("i", '@y',  '\\psi', mapopts)
map("i", '@Z',  '\\mathrm{Z}', mapopts)
map("i", '@z',  '\\zeta', mapopts)
map("i", '@Ve', '\\Varepsilon', mapopts)
map("i", '@Vr', '\\Varrho', mapopts)
map("i", '@Vk', '\\Varkappa', mapopts)
map("i", '@Vq', '\\Vartheta', mapopts)
map("i", '@Vs', '\\Varsigma', mapopts)
map("i", '@Vp', '\\Varpi', mapopts)
map("i", '@Vf', '\\Varphi', mapopts)
map("i", '@ve', '\\varepsilon', mapopts)
map("i", '@vr', '\\varrho', mapopts)
map("i", '@vk', '\\varkappa', mapopts)
map("i", '@vq', '\\vartheta', mapopts)
map("i", '@vs', '\\varsigma', mapopts)
map("i", '@vp', '\\varpi', mapopts)
map("i", '@vf', '\\varphi', mapopts)

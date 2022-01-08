imap("jk", "<esc>")
imap("kj", "<esc>")
nmap("Y", "y$")
nmap("<tab>", "<cmd>bn<CR>")
nmap("<S-tab>", "<cmd>bp<CR>")

nmap("<C-h>", "<C-w><C-h>")
nmap("<C-j>", "<C-w><C-j>")
nmap("<C-k>", "<C-w><C-k>")
nmap("<C-l>", "<C-w><C-l>")

cmap("<C-k>", "<up>")
cmap("<C-j>", "<down>")

nmap("<C-p>", "<cmd>Telescope find_files<CR>")

nmap("<C-w>+", "v:count1 * g:reSize . '<C-w>+'", { silent = false, expr = true })
nmap("<C-w>-", "v:count1 * g:reSize . '<C-w>-'", { silent = false, expr = true })
nmap("<C-w><", "v:count1 * g:reSize . '<C-w><'", { silent = false, expr = true })
nmap("<C-w>>", "v:count1 * g:reSize . '<C-w>>'", { silent = false, expr = true })

nmap("n", "nzzzv")
nmap("N", "Nzzzv")
nmap("<C-d>", "<C-d>zzzv")
nmap("<C-u>", "<C-u>zzzv")
nmap("<C-o>", "<C-o>zzzv")

nmap("s", "<cmd>HopChar1AC<CR>")
nmap("S", "<cmd>HopChar1BC<CR>")

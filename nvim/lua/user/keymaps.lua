-- lua/user/keymaps.lua

local keymap = vim.keymap.set
local opts = { noremap = true, silent = true } -- 기본 옵션: 재귀 금지, 메시지 출력 안 함

-- 모드 약자: 'n'(Normal), 'i'(Insert), 'v'(Visual), 'x'(Visual Block), 't'(Terminal), 'o'(Operator-pending)

-- Normal 모드 매핑 예시
-- 복사
keymap('v', '<C-c>', '"+y', opts)

-- Ctrl+Tab (앞으로 순환) 기능을 <leader><Tab> 에 매핑
keymap('n', '<Tab>', "<cmd>lua require('vscode').action('workbench.action.quickOpenPreviousRecentlyUsedEditorInGroup')<CR>", vim.tbl_extend('force', opts, { desc = "VSCode Prev Editor History" }))
-- Ctrl+Shift+Tab (뒤로 순환) 기능을 <leader><S-Tab> 에 매핑
keymap('n', '<S-Tab>', "<cmd>lua require('vscode').action('workbench.action.quickOpenLeastRecentlyUsedEditorInGroup')<CR>", vim.tbl_extend('force', opts, { desc = "VSCode Next Editor History" }))
-- 빠른 저장
keymap('n', '<leader>w', ':w<CR>', opts) -- Leader + w : 저장

-- 화면 분할
keymap('n', '<leader>sh', "<cmd>lua require('vscode').action('workbench.action.splitEditor')<CR>", opts) -- 세로 분할
keymap('n', '<leader>sv', "<cmd>lua require('vscode').action('workbench.action.splitEditorDown')<CR>", opts) -- 가로 분할

-- 새 폴더 열기
keymap('n', '<leader>of', "<cmd>lua require('vscode').action('workbench.action.files.openFolder')<CR>", opts) -- open folder

-- 코딩
keymap('n', '<leader>,', "<cmd>lua require('vscode').action('workbench.action.showAllEditors')<CR>", opts) -- 파일 열기
keymap('n', '<leader>ca', "<cmd>lua require('vscode').action('editor.action.codeAction')<CR>", opts) -- code action
keymap('n', '<leader>cr', "<cmd>lua require('vscode').action('editor.action.rename')<CR>", opts) -- rename
keymap('n', '<leader>cs', "<cmd>lua require('vscode').action('workbench.action.gotoSymbol')<CR>", opts) -- go to symbol
keymap('n', '<leader>qq', "<cmd>lua require('vscode').action('workbench.action.closeActiveEditor')<CR>", opts) -- close Active Editors
keymap('n', '<leader>qo', "<cmd>lua require('vscode').action('workbench.action.closeOtherEditors')<CR>", opts) -- close Other Editors
keymap('n', '<leader><leader>', "<cmd>lua require('vscode').action('workbench.action.quickOpen')<CR>", opts) -- quick open
keymap('n', '<leader>gd', "<cmd>lua require('vscode').action('editor.action.revealDefinition')<CR>", opts) -- revealDefinition
keymap('n', '<leader>gr', "<cmd>lua require('vscode').action('editor.action.goToReferences')<CR>", opts) -- goToReferences
keymap('n', '<leader>gi', "<cmd>lua require('vscode').action('editor.action.goToImplementation')<CR>", opts) -- goToImple
keymap('n', '<leader>ff', "<cmd>lua require('vscode').action('workbench.action.findInFiles')<CR>", opts) -- find in files
keymap('n', '<leader>gg', "<cmd>lua require('vscode').action('workbench.view.scm')<CR>", opts) -- 깃허브

-- Insert 모드 매핑 예시
-- jk로 Insert 모드 탈출 (선택 사항)
keymap('i', 'jk', '<ESC>', { noremap = true, silent = true, desc = "Exit insert mode with jk" })

-- Visual 모드 매핑 예시
-- 선택 영역 들여쓰기 유지하면서 이동
keymap('v', 'J', ":m '>+1<CR>gv=gv", opts)
keymap('v', 'K', ":m '<-2<CR>gv=gv", opts)

-- general keymaps
keymap({"n", "v"}, "<leader>t", "<cmd>lua require('vscode').action('workbench.action.terminal.toggleTerminal')<CR>")
keymap({"n", "v"}, "<leader>p", "<cmd>lua require('vscode').action('workbench.action.quickOpen')<CR>")

-- harpoon keymaps
keymap({"n", "v"}, "<leader>ha", "<cmd>lua require('vscode').action('vscode-harpoon.addEditor')<CR>")
keymap({"n", "v"}, "<leader>h1", "<cmd>lua require('vscode').action('vscode-harpoon.addEditor1')<CR>")
keymap({"n", "v"}, "<leader>h2", "<cmd>lua require('vscode').action('vscode-harpoon.addEditor2')<CR>")
keymap({"n", "v"}, "<leader>h3", "<cmd>lua require('vscode').action('vscode-harpoon.addEditor3')<CR>")
keymap({"n", "v"}, "<leader>h4", "<cmd>lua require('vscode').action('vscode-harpoon.addEditor4')<CR>")
keymap({"n", "v"}, "<leader>h5", "<cmd>lua require('vscode').action('vscode-harpoon.addEditor5')<CR>")
keymap({"n", "v"}, "<leader>h6", "<cmd>lua require('vscode').action('vscode-harpoon.addEditor6')<CR>")
keymap({"n", "v"}, "<leader>h7", "<cmd>lua require('vscode').action('vscode-harpoon.addEditor7')<CR>")
keymap({"n", "v"}, "<leader>h8", "<cmd>lua require('vscode').action('vscode-harpoon.addEditor8')<CR>")
keymap({"n", "v"}, "<leader>h9", "<cmd>lua require('vscode').action('vscode-harpoon.addEditor9')<CR>")
keymap({"n", "v"}, "<leader>hl", "<cmd>lua require('vscode').action('vscode-harpoon.editorQuickPick')<CR>")
keymap({"n", "v"}, "<leader>he", "<cmd>lua require('vscode').action('vscode-harpoon.editEditors')<CR>")
keymap({"n", "v"}, "<leader>1", "<cmd>lua require('vscode').action('vscode-harpoon.gotoEditor1')<CR>")
keymap({"n", "v"}, "<leader>2", "<cmd>lua require('vscode').action('vscode-harpoon.gotoEditor2')<CR>")
keymap({"n", "v"}, "<leader>3", "<cmd>lua require('vscode').action('vscode-harpoon.gotoEditor3')<CR>")
keymap({"n", "v"}, "<leader>4", "<cmd>lua require('vscode').action('vscode-harpoon.gotoEditor4')<CR>")
keymap({"n", "v"}, "<leader>5", "<cmd>lua require('vscode').action('vscode-harpoon.gotoEditor5')<CR>")
keymap({"n", "v"}, "<leader>6", "<cmd>lua require('vscode').action('vscode-harpoon.gotoEditor6')<CR>")
keymap({"n", "v"}, "<leader>7", "<cmd>lua require('vscode').action('vscode-harpoon.gotoEditor7')<CR>")
keymap({"n", "v"}, "<leader>8", "<cmd>lua require('vscode').action('vscode-harpoon.gotoEditor8')<CR>")
keymap({"n", "v"}, "<leader>9", "<cmd>lua require('vscode').action('vscode-harpoon.gotoEditor9')<CR>")

-- bookmarks keymaps
keymap({"n", "v"}, "<leader>ma", "<cmd>lua require('vscode').action('bookmarks.toggle')<CR>", vim.tbl_extend('force', opts, { desc = "Bookmark [T]oggle" }))
keymap("n", "<leader>mj", "<cmd>lua require('vscode').action('bookmarks.jumpToNext')<CR>", vim.tbl_extend('force', opts, { desc = "Bookmark [N]ext" }))
keymap("n", "<leader>mk", "<cmd>lua require('vscode').action('bookmarks.jumpToPrevious')<CR>", vim.tbl_extend('force', opts, { desc = "Bookmark [P]revious" }))
keymap("n", "<leader>ml", "<cmd>lua require('vscode').action('bookmarks.listFromAllFiles')<CR>", vim.tbl_extend('force', opts, { desc = "Bookmark [L]ist" }))
keymap("n", "<leader>mc", "<cmd>lua require('vscode').action('bookmarks.clear')<CR>", vim.tbl_extend('force', opts, { desc = "Bookmark [C]lear Current File" }))
keymap("n", "<leader>mC", "<cmd>lua require('vscode').action('bookmarks.clearFromAllFiles')<CR>", vim.tbl_extend('force', opts, { desc = "Bookmark clear [A]ll Files" }))

-- print("Keymaps loaded!") -- 로드 확인용 메시지 (선택 사항)

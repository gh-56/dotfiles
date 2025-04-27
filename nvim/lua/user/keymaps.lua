-- lua/user/keymaps.lua

local keymap = vim.keymap.set
local opts = { noremap = true, silent = true } -- 기본 옵션: 재귀 금지, 메시지 출력 안 함

-- 모드 약자: 'n'(Normal), 'i'(Insert), 'v'(Visual), 'x'(Visual Block), 't'(Terminal), 'o'(Operator-pending)

-- Insert 모드에서 Ctrl+Space를 눌렀을 때 VS Code의 'Trigger Suggest' 명령 호출
keymap('i', '<C-Space>', function()
  -- VSCodeCall: VS Code 명령을 호출하고 결과가 필요할 때 사용 (여기선 Notify도 가능)
  -- 'editor.action.triggerSuggest': VS Code의 빠른 제안 창 트리거 명령어 ID
  vim.fn.VSCodeCall('editor.action.triggerSuggest')
  -- 또는 vim.fn.VSCodeNotify('editor.action.triggerSuggest') -- 반환값이 필요 없으므로 Notify가 더 적합할 수 있음
end, { noremap = true, silent = true, desc = "Trigger VS Code Suggest" })

-- 필요하다면 Normal 모드에서도 설정할 수 있습니다.
-- map('n', '<C-Space>', function()
--   vim.fn.VSCodeCall('editor.action.triggerSuggest')
-- end, { noremap = true, silent = true, desc = "Trigger VS Code Suggest" })

-- Normal 모드 매핑 예시
-- 창 분할 이동 (Ctrl+hjkl)
keymap('n', '<C-h>', '<C-w>h', opts)
keymap('n', '<C-j>', '<C-w>j', opts)
keymap('n', '<C-k>', '<C-w>k', opts)
keymap('n', '<C-l>', '<C-w>l', opts)


-- Ctrl+Tab (앞으로 순환) 기능을 <leader><Tab> 에 매핑
keymap('n', '<leader><Tab>', "<cmd>lua require('vscode').action('workbench.action.quickOpenPreviousRecentlyUsedEditorInGroup')<CR>", vim.tbl_extend('force', opts, { desc = "VSCode Prev Editor History" }))
-- Ctrl+Shift+Tab (뒤로 순환) 기능을 <leader><S-Tab> 에 매핑
keymap('n', '<leader><S-Tab>', "<cmd>lua require('vscode').action('workbench.action.quickOpenLeastRecentlyUsedEditorInGroup')<CR>", vim.tbl_extend('force', opts, { desc = "VSCode Next Editor History" }))
-- 빠른 저장
keymap('n', '<leader>w', ':w<CR>', opts) -- Leader + w : 저장

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

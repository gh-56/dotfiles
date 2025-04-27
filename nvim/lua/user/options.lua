-- lua/user/options.lua

local opt = vim.opt -- 편의를 위해 opt 변수 사용

-- 줄 번호 표시
opt.number = true
opt.relativenumber = true -- 현재 줄 기준 상대 번호 표시

-- 탭 및 들여쓰기 설정
opt.tabstop = 4       -- 탭 문자를 4칸 공백으로 표시
opt.shiftwidth = 4    -- 자동 들여쓰기 시 4칸 사용
opt.expandtab = true  -- 탭 입력 시 공백으로 변환
opt.autoindent = true -- 자동 들여쓰기 활성화

-- 검색 설정
opt.ignorecase = true -- 검색 시 대소문자 무시
opt.smartcase = true  -- 검색어에 대문자가 포함되면 대소문자 구분

-- UI 관련 설정
opt.termguicolors = true -- 터미널에서 True Color 사용 (색상 테마에 중요)
opt.scrolloff = 0     -- 커서가 화면 가장자리에서 8줄 이상 떨어지도록 스크롤
opt.sidescrolloff = 0
opt.wrap = false      -- 긴 줄 자동 줄바꿈 비활성화

-- 백업 및 스왑 파일 설정 (선택 사항)
opt.swapfile = false
opt.backup = false
opt.undodir = os.getenv("HOME") .. "/.vim/undodir" -- 실행 취소 내역 저장 위치
opt.undofile = true                          -- 실행 취소 내역 파일로 저장

-- 기타 유용한 설정
opt.hlsearch = false     -- 검색 결과 하이라이트
opt.incsearch = true    -- 입력 중 실시간 검색 결과 보여주기
opt.mouse = 'a'         -- 모든 모드에서 마우스 사용 허용 (VS Code에서는 덜 중요할 수 있음)
-- opt.clipboard = "unnamedplus" -- 시스템 클립보드와 연동 ('+' 레지스터 사용)

-- Leader 키 설정 (여기서 해도 되고, init.lua나 keymaps.lua 시작 부분에서 해도 됨)
vim.g.mapleader = " " -- Leader 키를 Space로 설정
vim.g.maplocalleader = " " -- Local Leader 키도 Space로 설정


-- print("Auto save on InsertLeave configured!") -- 로드 확인 (선택 사항)

-- print("Base options loaded!") -- 로드 확인용 메시지 (선택 사항)

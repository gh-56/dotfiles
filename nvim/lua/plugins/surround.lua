-- lua/plugins/surround.lua

return {
  "tpope/vim-surround",
  -- 이 플러그인은 Vimscript 기반이므로 별도의 Lua 설정(config 함수)이 필요 없습니다.
  -- 로드되면 바로 사용할 수 있습니다.

  -- 선택 사항: 플러그인을 필요할 때 로드하여 시작 속도를 약간 향상시킵니다.
  event = "VeryLazy",
  -- print("vim-surround (tpope) configured!") -- 로드 확인 메시지 (선택 사항)
}


-- lua/user/init.lua

require('user.options') -- 1. 옵션 설정 로드
require('user.keymaps') -- 2. 키 매핑 로드
require('user.plugins') -- 3. 플러그인 매니저(Lazy) 설정 로드

-- print("User configuration initialized!")

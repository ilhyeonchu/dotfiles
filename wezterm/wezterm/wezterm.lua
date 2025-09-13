-- WezTerm 설정 파일 (Lua 스크립트)

-- wezterm API를 가져옵니다.
local wezterm = require("wezterm")

-- 반환할 설정 테이블을 생성합니다.
local config = {}

-- 일부 플랫폼에서는 config 객체를 생성하기 위해 이 줄이 필요할 수 있습니다.
if wezterm.config_builder then
	config = wezterm.config_builder()
end

-- 기본 셸을 zsh로 설정합니다.
-- 사용자의 zsh 경로를 확인하려면 'which zsh' 명령을 사용하세요.
config.default_prog = { "/bin/zsh" }

-- 폰트 설정 (필요 시 주석 해제 후 수정)
config.font = wezterm.font("JetBrains Mono")
font_size = 16.0

-- 색상 스킴 설정 (예: Dracula)
config.color_scheme = "Catppuccin Mocha"

-- 필요한 다른 설정들을 여기에 추가할 수 있습니다.
-- 예: 탭 바, 창 투명도 등

-- 최종 설정 객체를 반환합니다.
return config

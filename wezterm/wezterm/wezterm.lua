-- wezterm settings

local wezterm = require("wezterm")
local mycolors = require("color_preset")
local config = wezterm.config_builder and wezterm.config_builder() or {}
local act = wezterm.action
local mux = wezterm.mux
config.keys = {}
-- config.leader = { key = '`' }   -- 리더(prefix)키 설정

--------------------------------------------------------------------------------------------
-- ssh 설정
--------------------------------------------------------------------------------------------
config.ssh_domains = {
	{
		name = "myser",
		remote_address = "myser",
		multiplexing = "WezTerm",
	},
}

--------------------------------------------------------------------------------------------
-- 기본 셀 설정
--------------------------------------------------------------------------------------------
config.default_prog = { "/bin/zsh", "-l" }

config.font = wezterm.font_with_fallback({
	{ family = "JetBrains Mono", weight = "Bold" },
	{ family = "JetBrains Mono Nerd Font", weight = "Medium" },
	{ family = "Noto Color Emoji" },
})
-- config.font = wezterm.font(JetBrain Mono)

config.font_size = 13.0
config.line_height = 1.10
config.color_schemes = { MyPreset = mycolors }
-- config.color_scheme = "MyPreset"
config.color_scheme = "Catppuccin Mocha"

--------------------------------------------------------------------------------------------
-- util 함수
--------------------------------------------------------------------------------------------
-- 레이아웃에 맞춘 탭 생성 또는 포커싱

local function focus_or_create(tab_title, layout_fn)
	local wp = wezterm.mux.get_active_workspace()
	for _, win in ipairs(mux.get_workspace_windows(wp)) do
		for _, tab in ipairs(win:tabs()) do
			if tab:get_title() == tab_title then
				win:focus() -- 해당 윈도우로 이동
				win:activate_tab(tab) -- 해당 탭 포커스
				return
			end
		end
	end
	-- 없는 경우 새로운 탭 생성
	local tab, pane, win = mux.spawn_tab({
		workspace = wp,
		domain = mux.get_domain("myser"),
		cwd = pane and pane:get_current_working_dir() or nil,
	})
	tab:set_title(tab_title)
	if layout_fn then
		layout_fn(tab, pane, win)
	end
	win:focus()
end

-- ide layout
local function ide_layout(tab, root, win)
	local tree = root:split({ direction = "Left", size = 0.20 })
	local term = root:split({ direction = "Down", size = 0.25 })
	tree:send_text("lf\n") -- 좌측 파일 트리
	root:send_text("nvim\n") -- 중앙 nvim
	term:send_text("zsh\n") -- 하단 쉘
end

wezterm.on("activate-ide", function(window, pane)
	focus_or_create("ide", ide_layout)
end)
--------------------------------------------------------------------------------------------
-- 키 바인딩
--------------------------------------------------------------------------------------------
config.keys = {
	{ key = "`", mods = "LEADER", action = act.SendKey({ key = "`" }) }, -- '`' 백틱 문자 입력
	-- 워크스테이션 변경
	{
		key = "1",
		mods = "LEADER",
		action = act.SwitchToWorkspace({
			name = "myser",
			spawn = { domain = { DomainName = "myser" } },
		}),
	},
	{
		key = "2",
		mods = "LEADER",
		action = act.SwitchToWorkspace({
			name = "progc",
			spawn = { domain = { DomainName = "myser" } },
		}),
	},
	{
		key = "3",
		mods = "LEADER",
		action = act.SwitchToWorkspace({ name = "cg", spawn = {
			domain = { DomainName = "myser" },
		} }),
	},
	{ key = "9", mods = "LEADER", action = act.EmitEvent("activate-ide") },
}

config.scrollback_lines = 20000
return config

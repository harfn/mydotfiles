

-- slime-config.lua
return {
	"jpalardy/vim-slime",
	config = function()
		-- 1) Basis-Config für tmux
		vim.g.slime_target = "tmux"
		-- 1.2) Bracketed Paste: wichtig für IPython, R, Bash
		vim.g.slime_bracketed_paste = 1
		-- 1.3) Slime eigene Mappings brauchen wir nicht,
		--    du hast schon eigene in keybindings.lua
		vim.g.slime_no_mappings = 1
		-- 4) Frage nicht jedes Mal nach, wenn ein Default gesetzt ist
		--         --    (wir setzen den Default mit einem eigenen Command)
		vim.g.slime_dont_ask_default = 1
		-- 5) Helper-Command: tmux-Pane einfach aus Neovim setzen
		--    Beispiel: :SlimeSetTmuxPane  → Eingabe:  :.1  oder 0:1.0
		vim.api.nvim_create_user_command("SlimeSetTmuxPane", function()
			local pane = vim.fn.input("tmux pane (z.B. :.1 oder 0:1.0): ")
			if pane ~= "" then
				vim.g.slime_default_config = {
					socket_name = "default",
					target_pane = pane,
				}
				print("Slime target pane -> " .. pane)
			else
				print("Abgebrochen.")
			end
		end, {})

		-- 2) HILFSFUNKTION + REPL-Befehle (die du gefragt hast)
		local function slime_tmux_send_raw(cmd)
			local cfg = vim.g.slime_default_config or {}
			if not cfg.target_pane then
				print("Kein tmux target_pane gesetzt. Erst :SlimeSetTmuxPane ausführen.")
				return
			end
			local pane = cfg.target_pane
			local full_cmd = string.format("tmux send-keys -t %s %s C-m", pane, vim.fn.shellescape(cmd))
			os.execute(full_cmd)
		end

		vim.api.nvim_create_user_command("ReplPy", function()
			slime_tmux_send_raw("ipython")
		end, {})

		vim.api.nvim_create_user_command("ReplR", function()
			slime_tmux_send_raw("R")
		end, {})

		vim.api.nvim_create_user_command("ReplBash", function()
			slime_tmux_send_raw("bash")
		end, {})
	end,



}

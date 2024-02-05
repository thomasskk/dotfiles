local timeout = 1000

local function get_typescript_client(bufnr)
	local clients = vim.lsp.get_active_clients({
		name = "svelte",
		bufnr = bufnr,
	})

	if #clients == 0 then
		return
	end

	return clients[1]
end

local function get_file_uri(bufnr)
	local uri = vim.api.nvim_buf_get_name(bufnr)
	return vim.uri_from_fname(uri)
end

local function send_batch_code_action(fix_id, fix_name, bufnr)
	local typescript_client = get_typescript_client(bufnr)
	local uri = get_file_uri(bufnr)

	if typescript_client == nil then
		return
	end

	local params = {
		data = {
			fixId = fix_id,
			fixName = fix_name,
			uri = uri,
		},
	}

	local res = typescript_client.request_sync("codeAction/resolve", params, timeout, 0)

	if not res.err then
		vim.lsp.util.apply_workspace_edit(res.result.edit, "utf-8")
	end
end

vim.api.nvim_create_user_command("SvelteAddMissingImports", function()
	local FIX_ID = "fixMissingImport"
	local FIX_NAME = "import"

	send_batch_code_action(FIX_ID, FIX_NAME, 0)
end, { desc = "", nargs = "*" })

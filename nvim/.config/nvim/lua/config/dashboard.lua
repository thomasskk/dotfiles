local db = require("dashboard")

vim.g.indentLine_fileTypeExclude = { "dashboard" }
db.default_executive = "telescope"
db.preview_file_height = 12
db.preview_file_width = 80
db.custom_center = {
	{ desc = "  Find File        ", action = "Telescope find_files" },
	{ desc = "  Recents          ", action = "Telescope oldfiles" },
	{ desc = "  New File         ", action = "DashboardNewFile" },
	{ desc = "  Bookmarks        ", action = "Telescope marks" },
	{ desc = "  Load Last Session", action = "SessionLoad" },
	{ desc = "  Settings         ", action = "edit $MYVIMRC" },
}

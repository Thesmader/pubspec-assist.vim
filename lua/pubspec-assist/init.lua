-- package.path = package.path .. ';modules/share/lua/5.4/?.lua'
loadfile("./apiClient.lua")
api = vim.api
local function createFloatingWindow()
  local stats = api.nvim_list_uis()[1]
  local width = stats.width
  local height = stats.height
  local buf = api.nvim_create_buf(false, true)
  local winId = api.nvim_open_win(buf, true, {
    relative="editor",
    width = width - 4,
    height = height - 4,
    row = 2,
    col = 2,
  })
  -- if res.body then
    -- api.nvim_buf_set_text(buf, 0, 0)

  print("Window Size: ",width, height)
end

return {
  createFloatingWindow = createFloatingWindow
}

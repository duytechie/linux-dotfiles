local cmp_enabled = true -- Track completion state

vim.keymap.set("n", "<leader>p", function()
  cmp_enabled = true
  require("cmp").setup({ enabled = cmp_enabled })
  print("Completion Enabled")
end, { desc = "Enable completion" })

vim.keymap.set("n", "<leader>P", function()
  cmp_enabled = false
  require("cmp").setup({ enabled = cmp_enabled })
  print("Completion Disabled")
end, { desc = "Disable completion" })

-- vim.keymap.set("n", "<leader>cB", function()
--   vim.cmd("!g++ % -o a.out -std=c++17 `pkg-config --cflags --libs sdl2`")
--   print("SDL2 program built!")
-- end, { desc = "Build SDL2 Program" })
--
-- vim.keymap.set("n", "<leader>cb", function()
--   vim.cmd("!g++ % -o a.out -std=c++17")
--   print("C++ program built!")
-- end, { desc = "Build C++ Program" })

local map = LazyVim.safe_keymap_set

-- Group `<leader>cb` for compile/build commands
map("n", "<leader>cb", "<Nop>", { desc = "[C]ompile/[B]uild" }) -- Group keymap

-- Build and Run C++ with `<leader>cbc`
map("n", "<leader>cbc", function()
  vim.cmd("!g++ % -o a.out -std=c++17 && ./a.out")
  print("✅ C++ program compiled and executed!")
end, { desc = "Build & Run C++ Program" })

map("n", "<leader>cbC", function()
  -- Get the directory of the currently open .cpp file
  local file_dir = vim.fn.expand("%:p:h")
  local file_name = vim.fn.expand("%:t") -- Get the filename only (without path)

  vim.cmd(
    "belowright 10split | terminal cd "
      .. file_dir
      .. " && g++ "
      .. file_name
      .. " -o a.out -std=c++17 `pkg-config --cflags --libs sdl2` && ./a.out"
  )
  -- vim.cmd("!g++ % -o a.out -std=c++17 `pkg-config --cflags --libs sdl2`")
  print("✅ SDL2 program compiled")
end, { desc = "Build SDL2 Program" })

map("n", "<leader>cbp", function()
  vim.cmd("!python3 %")
  print("✅ Python program compiled and executed!")
end, { desc = "Build & Run Python Program" })

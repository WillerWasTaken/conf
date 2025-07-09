return {
  "echasnovski/mini.files",
  dependencies = {
    "nvim-tree/nvim-web-devicons",
    -- for git highlight group
    "echasnovski/mini.diff"
  },
  keys = {
    { "<leader>o", function()
      MiniFiles.open(vim.api.nvim_buf_get_name(0))
      MiniFiles.reveal_cwd()
    end, desc = "Open mini files on buffer" },
  },
  -- Do not lazy load to replace netrw as soon as possible
  -- https://github.com/echasnovski/mini.files/blob/main/doc/mini-files.txt#L678C1-L678C73
  lazy = false,
  config = function()
    require("mini.files").setup({
      options = {
        -- permanent_delete = false,
        use_as_default_explorer = true,
      },
      mappings = {
        go_in_plus  = '<CR>',
      },
      windows = {
        preview = true,
        width_preview = 100,
      },
    })

    -- Add split shortcut
    -- https://github.com/echasnovski/mini.nvim/blob/c78332b4c71ad3c2a09efe6acd0a51283627258f/doc/mini-files.txt#L473-L503
    local map_split = function(buf_id, lhs, direction)
    local rhs = function()
        -- Make new window and set it as target
        local cur_target = MiniFiles.get_explorer_state().target_window
        local new_target = vim.api.nvim_win_call(cur_target, function()
          vim.cmd(direction .. ' split')
          return vim.api.nvim_get_current_win()
        end)

        MiniFiles.set_target_window(new_target)
        MiniFiles.go_in({ close_on_file = true })
      end

      -- Adding `desc` will result into `show_help` entries
      local desc = 'Split ' .. direction
      vim.keymap.set('n', lhs, rhs, { buffer = buf_id, desc = desc })
    end

    vim.api.nvim_create_autocmd('User', {
      pattern = 'MiniFilesBufferCreate',
      callback = function(args)
        local buf_id = args.data.buf_id

        map_split(buf_id, '<C-x>', 'belowright horizontal')
        map_split(buf_id, '<C-v>', 'belowright vertical')
        map_split(buf_id, '<C-t>', 'tab')
      end,
    })

    -- config to toggle dotfiles
    -- https://github.com/echasnovski/mini.nvim/blob/c78332b4c71ad3c2a09efe6acd0a51283627258f/doc/mini-files.txt#L445-L472
    local show_dotfiles = true

    local filter_show = function(fs_entry) return true end

    local filter_hide = function(fs_entry)
      return not vim.startswith(fs_entry.name, '.')
    end

    local toggle_dotfiles = function()
      show_dotfiles = not show_dotfiles
      local new_filter = show_dotfiles and filter_show or filter_hide
      MiniFiles.refresh({ content = { filter = new_filter } })
    end

    vim.api.nvim_create_autocmd('User', {
      pattern = 'MiniFilesBufferCreate',
      callback = function(args)
        local buf_id = args.data.buf_id
        vim.keymap.set("n", "gH", toggle_dotfiles, { buffer = buf_id, desc = "Toggle dotfiles" })
      end,
    })

    -- Copy file path and change cwd
    -- https://github.com/echasnovski/mini.nvim/blob/c78332b4c71ad3c2a09efe6acd0a51283627258f/doc/mini-files.txt#L504-L530
    local set_cwd = function()
      local path = (MiniFiles.get_fs_entry() or {}).path
      if path == nil then return vim.notify('Cursor is not on valid entry') end
      vim.fn.chdir(vim.fs.dirname(path))
    end

    -- Yank in register full path of entry under cursor
    local yank_path = function()
      local path = (MiniFiles.get_fs_entry() or {}).path
      if path == nil then return vim.notify('Cursor is not on valid entry') end
      vim.fn.setreg(vim.v.register, path)
    end

    vim.api.nvim_create_autocmd('User', {
      pattern = 'MiniFilesBufferCreate',
      callback = function(args)
        local b = args.data.buf_id
        vim.keymap.set('n', 'gw', set_cwd,   { buffer = b, desc = 'Set cwd' })
        vim.keymap.set('n', 'gy', yank_path, { buffer = b, desc = 'Yank path debug' })
      end,
    })

    -- Automatic bookmarks
    -- https://github.com/echasnovski/mini.nvim/blob/c78332b4c71ad3c2a09efe6acd0a51283627258f/doc/mini-files.txt#L531-L546
    local set_mark = function(id, path, desc)
      MiniFiles.set_bookmark(id, path, { desc = desc })
    end
    vim.api.nvim_create_autocmd('User', {
      pattern = 'MiniFilesExplorerOpen',
      callback = function()
        set_mark('c', vim.fn.stdpath('config'), 'Config') -- path
        set_mark('w', vim.fn.getcwd, 'Working directory') -- callable
        set_mark('~', '~', 'Home directory')
      end,
    })

    -- Refresh the content
    vim.api.nvim_create_autocmd('User', {
      pattern = 'MiniFilesBufferCreate',
      callback = function(args)
        local b = args.data.buf_id
        vim.keymap.set('n', 'gR', function()
          local new_filter = show_dotfiles and filter_show or filter_hide
          MiniFiles.refresh({ content = { filter = new_filter } })
        end, { buffer = b, desc = 'Refresh' })
      end,
    })

    -- snippet to get git status
    -- https://gist.github.com/bassamsdata/eec0a3065152226581f8d4244cce9051
    local nsMiniFiles = vim.api.nvim_create_namespace("mini_files_git")
    local autocmd = vim.api.nvim_create_autocmd
    local _, MiniFiles = pcall(require, "mini.files")

    -- Cache for git status
    local gitStatusCache = {}
    local cacheTimeout = 2000 -- in milliseconds
    local uv = vim.uv or vim.loop

    local function isSymlink(path)
      local stat = uv.fs_lstat(path)
      return stat and stat.type == "link"
    end

    ---@type table<string, {symbol: string, hlGroup: string}>
    ---@param status string
    ---@return string symbol, string hlGroup
    local function mapSymbols(status, is_symlink)
      local statusMap = {
        -- stylua: ignore start
        [" M"] = { symbol = "•", hlGroup  = "MiniDiffSignChange"}, -- Modified in the working directory
        ["M "] = { symbol = "✹", hlGroup  = "MiniDiffSignChange"}, -- modified in index
        ["MM"] = { symbol = "≠", hlGroup  = "MiniDiffSignChange"}, -- modified in both working tree and index
        ["A "] = { symbol = "+", hlGroup  = "MiniDiffSignAdd"   }, -- Added to the staging area, new file
        ["AA"] = { symbol = "≈", hlGroup  = "MiniDiffSignAdd"   }, -- file is added in both working tree and index
        ["D "] = { symbol = "-", hlGroup  = "MiniDiffSignDelete"}, -- Deleted from the staging area
        ["AM"] = { symbol = "⊕", hlGroup  = "MiniDiffSignChange"}, -- added in working tree, modified in index
        ["AD"] = { symbol = "-•", hlGroup = "MiniDiffSignChange"}, -- Added in the index and deleted in the working directory
        ["R "] = { symbol = "→", hlGroup  = "MiniDiffSignChange"}, -- Renamed in the index
        ["U "] = { symbol = "‖", hlGroup  = "MiniDiffSignChange"}, -- Unmerged path
        ["UU"] = { symbol = "⇄", hlGroup  = "MiniDiffSignAdd"   }, -- file is unmerged
        ["UA"] = { symbol = "⊕", hlGroup  = "MiniDiffSignAdd"   }, -- file is unmerged and added in working tree
        ["??"] = { symbol = "?", hlGroup  = "MiniDiffSignDelete"}, -- Untracked files
        ["!!"] = { symbol = "!", hlGroup  = "MiniDiffSignChange"}, -- Ignored files
        -- stylua: ignore end
      }

      local result = statusMap[status] or { symbol = "?", hlGroup = "NonText" }
      local gitSymbol = result.symbol
      local gitHlGroup = result.hlGroup

      local symlinkSymbol = is_symlink and "↩" or ""

      -- Combine symlink symbol with Git status if both exist
      local combinedSymbol = (symlinkSymbol .. gitSymbol)
        :gsub("^%s+", "")
        :gsub("%s+$", "")
      -- Change the color of the symlink icon from "MiniDiffSignDelete" to something else
      local combinedHlGroup = is_symlink and "MiniDiffSignDelete" or gitHlGroup

      return combinedSymbol, combinedHlGroup
    end

    ---@param cwd string
    ---@param callback function
    ---@return nil
    local function fetchGitStatus(cwd, callback)
      local clean_cwd = cwd:gsub("^minifiles://%d+/", "")
      ---@param content table
      local function on_exit(content)
        if content.code == 0 then
          callback(content.stdout)
          -- vim.g.content = content.stdout
        end
      end
      ---@see vim.system
      vim.system(
        { "git", "status", "--ignored", "--porcelain" },
        { text = true, cwd = clean_cwd },
        on_exit
      )
    end

    ---@param buf_id integer
    ---@param gitStatusMap table
    ---@return nil
    local function updateMiniWithGit(buf_id, gitStatusMap)
      vim.schedule(function()
        local nlines = vim.api.nvim_buf_line_count(buf_id)
        local cwd = vim.fs.root(buf_id, ".git")
        local escapedcwd = cwd and vim.pesc(cwd)
        escapedcwd = vim.fs.normalize(escapedcwd)

        for i = 1, nlines do
          local entry = MiniFiles.get_fs_entry(buf_id, i)
          if not entry then
            break
          end
          local relativePath = entry.path:gsub("^" .. escapedcwd .. "/", "")
          local status = gitStatusMap[relativePath]

          if status then
            local symbol, hlGroup = mapSymbols(status, isSymlink(entry.path))
            vim.api.nvim_buf_set_extmark(buf_id, nsMiniFiles, i - 1, 0, {
              sign_text = symbol,
              sign_hl_group = hlGroup,
              priority = 2,
            })
            -- This below code is responsible for coloring the text of the items. comment it out if you don't want that
            local line = vim.api.nvim_buf_get_lines(buf_id, i - 1, i, false)[1]
            -- Find the name position accounting for potential icons
            local nameStartCol = line:find(vim.pesc(entry.name)) or 0

            if nameStartCol > 0 then
              vim.api.nvim_buf_set_extmark(
                buf_id,
                nsMiniFiles,
                i - 1,
                nameStartCol - 1,
                {
                  end_col = nameStartCol + #entry.name - 1,
                  hl_group = hlGroup,
                }
              )
            end

          else
          end
        end
      end)
    end

    -- Thanks for the idea of gettings https://github.com/refractalize/oil-git-status.nvim signs for dirs
    ---@param content string
    ---@return table
    local function parseGitStatus(content)
      local gitStatusMap = {}
      -- lua match is faster than vim.split (in my experience )
      for line in content:gmatch("[^\r\n]+") do
        local status, filePath = string.match(line, "^(..)%s+(.*)")
        -- Split the file path into parts
        local parts = {}
        for part in filePath:gmatch("[^/]+") do
          table.insert(parts, part)
        end
        -- Start with the root directory
        local currentKey = ""
        for i, part in ipairs(parts) do
          if i > 1 then
            -- Concatenate parts with a separator to create a unique key
            currentKey = currentKey .. "/" .. part
          else
            currentKey = part
          end
          -- If it's the last part, it's a file, so add it with its status
          if i == #parts then
            gitStatusMap[currentKey] = status
          else
            -- If it's not the last part, it's a directory. Check if it exists, if not, add it.
            if not gitStatusMap[currentKey] then
              gitStatusMap[currentKey] = status
            end
          end
        end
      end
      return gitStatusMap
    end

    ---@param buf_id integer
    ---@return nil
    local function updateGitStatus(buf_id)
      if not vim.fs.root(buf_id, ".git") then
        return
      end
      local cwd = vim.fs.root(buf_id, ".git")
      -- local cwd = vim.fn.expand("%:p:h")
      local currentTime = os.time()

      if
        gitStatusCache[cwd]
        and currentTime - gitStatusCache[cwd].time < cacheTimeout
      then
        updateMiniWithGit(buf_id, gitStatusCache[cwd].statusMap)
      else
        fetchGitStatus(cwd, function(content)
          local gitStatusMap = parseGitStatus(content)
          gitStatusCache[cwd] = {
            time = currentTime,
            statusMap = gitStatusMap,
          }
          updateMiniWithGit(buf_id, gitStatusMap)
        end)
      end
    end

    ---@return nil
    local function clearCache()
      gitStatusCache = {}
    end

    local function augroup(name)
      return vim.api.nvim_create_augroup("MiniFiles_" .. name, { clear = true })
    end

    autocmd("User", {
      group = augroup("start"),
      pattern = "MiniFilesExplorerOpen",
      callback = function()
        local bufnr = vim.api.nvim_get_current_buf()
        updateGitStatus(bufnr)
      end,
    })

    autocmd("User", {
      group = augroup("close"),
      pattern = "MiniFilesExplorerClose",
      callback = function()
        clearCache()
      end,
    })

    autocmd("User", {
      group = augroup("update"),
      pattern = "MiniFilesBufferUpdate",
      callback = function(args)
        local bufnr = args.data.buf_id
        local cwd = vim.fs.root(bufnr, ".git")
        if gitStatusCache[cwd] then
          updateMiniWithGit(bufnr, gitStatusCache[cwd].statusMap)
        end
      end,
    })
  end,
}

local M = {}

function M.get_top_level_directory()
  local git_common = vim.fn.trim(vim.fn.system("git rev-parse --git-common-dir"))
  if vim.v.shell_error ~= 0 then
    return nil
  end

  local is_bare = vim.fn.trim(vim.fn.system(
    "git -C " .. vim.fn.shellescape(git_common) .. " rev-parse --is-bare-repository"
  ))
  if is_bare == "true" then
    return git_common
  else
    return git_common .. "/.."
  end
end

return M

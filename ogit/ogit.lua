shell = require 'shell'
 
ogit = {}
ogit.__index = ogit
 
function ogit.new(o)
  o = o or
  {
    user = "",
    repo = "",
    branch = "master"
  }
 
  setmetatable(o, ogit)
  return o
end
 
function ogit:config(user, repo, branch)
  self.user = user or ""
  self.repo = repo or ""
  self.branch = branch or "master"
end
 
function ogit:geturl(path)
  path = path or ""
  return "https://raw.githubusercontent.com/" .. self.user .. "/" .. self.repo
          .. "/" .. self.branch .. "/" .. path
end
 
function ogit:download(wFile, lFile)
  print(wFile)
  if wFile then
    shell.execute('wget ' .. self:geturl(wFile) .. " " .. (lFile or ""))
  else
    io.stderr:write('ogit: Invalid web filename.')
    return
  end
end
 
local args = shell.parse(...)
print(#args)
 
if #args > 0 then
  if args[1] == "get" then
    local g = ogit.new()
    if #args < 3 then
      g:config(os.getenv("GIT-USER"), os.getenv("GIT-REPO"), os.getenv("GIT-BRH"))
      g:download(args[2])
    else
      g:config(args[2], args[3], args[4])
      g:download(args[5])
    end
  elseif args[1] == "config" then
    if #args > 1 then
      os.setenv("GIT-USER", args[2] or "")
      os.setenv("GIT-REPO", args[3] or "")
      os.setenv("GIT-BRH", args[4] or "master")
    else
      io.write("User: " .. os.getenv("GIT-USER") ..
               "\nRepository: " .. os.getenv("GIT-REPO") ..
               "\nBranch: " .. os.getenv("GIT-BRH"))
    end
  else
    io.stderr:write('ogit: Invalid argument!')
  end
else
  io.write("List of commands:")
  io.write("\n\tgit get <file>")
  io.write("\n\tgit get <user> <repo> <branch> <file>")
  io.write("\n\tgit config")
  io.write("\n\tgit config <user> <repo> <branch>")
  print("A")
end
 
return ogit
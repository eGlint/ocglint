shell = require 'shell'
fs = require 'filesystem'

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

if #args > 0 then
  if args[1] == "get" then
    local g = ogit.new()
    if #args < 3 then
      g:config(os.getenv('OGIT-USR'), os.getenv('OGIT-REP'), os.getenv('OGIT-BRH'))
      g:download(args[2])
    else
      g:config(args[2], args[3], args[4])
      g:download(args[5])
    end
  elseif args[1] == "config" then
    if #args > 1 then
      os.setenv('OGIT-USR', args[2] or "")
      os.setenv('OGIT-REP', args[3] or "")
      os.setenv('OGIT-BRH', args[4] or "master")
    else
      io.write("User: " .. os.getenv('OGIT-USR') or '(not set)' ..
               "\nRepository: " .. os.getenv('OGIT-REP') or '(not set)' ..
               "\nBranch: " .. os.getenv('OGIT-BRH') or '(not set)')
    end
  elseif args[1] == "run" then 
    local g = ogit.new()
    local tmp = '/tmp/' .. args[2]
    g:config(os.getenv('OGIT-USR'), os.getenv('OGIT-REP'), os.getenv('OGIT-BRH'))
    g:download(args[2], tmp)
    if (fs.exists(tmp)) then
      shell.execute(tmp .. ' ' .. args[3] )
    end
  elseif args[1] == "update" then 
    io.write("To be added in the later version")
  elseif args[1] == "disk" then 
    io.write("To be added in the later version")
  else
    io.stderr:write('ogit: Invalid argument!')
  end
else
  if (fs.exists(os.getenv('MANPATH') .. 'ogit')) then
    shell.execute("man ogit")
  else 
    io.write('Manual not available, downloading a copy...')
    local g = ogit.new()
    g:config("eGlint", "ocglint", "master")
    g:download('ogit/man/ogit', os.getenv('MANPATH') .. "/ogit")
    if (fs.exists(os.getenv('MANPATH') .. 'ogit')) then 
      shell.execute("man ogit")
    else 
      io.stderr:write("Downloading manual failed!")
    end
  end
end
 
return ogit
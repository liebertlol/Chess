-- creds by autumnv3
local base = "https://github.com/liebertlol/Chess/refs/heads/main/"

local function getDownload(file)
    file = file:gsub('ChessCheat/', '')

    local suc, ret = pcall(function()
        return game:HttpGet(base .. file)
    end)

    return suc and ret or 'print("Failed to get ' .. file..'")'
end

local function downloadFile(file)
    file = 'ChessCheat/' .. file

    if not isfile(file) then
        writefile(file, getDownload(file))
    end

    repeat task.wait() until isfile(file)

    return readfile(file)
end

local function debugDownloadSuccess(file)
    local File = downloadFile(file)

    if isfile('ChessCheat/' .. file) then
        print('[ChessCheat]: Successfully downloaded', file)
    else
        print('[ChsssCheat]: Failed to download', file)
    end

    return File
end

for i,v in {'ChessCheat', 'ChessCheat/Library'} do
    if not isfolder(v) then
        makefolder(v)
    end
end

debugDownloadSuccess('Library/getFen.lua')
debugDownloadSuccess('Library/Utils.lua')

return loadstring(debugDownloadSuccess('Main.lua'))()

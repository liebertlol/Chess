-- creds by autumnv3
local base = "https://raw.githubusercontent.com/liebertlol/Chess/refs/heads/main/"

local function getDownload(file)
    file = file:gsub('ChessCheat/', '')

    local suc, ret = pcall(function()
        return game:HttpGet(base .. file)
    end)

    if suc and ret then
        return ret
    else
        return '-- Failed to get ' .. file
    end
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
        print('[ChessCheat]: Failed to download', file)
    end

    return File
end

for _, v in ipairs({'ChessCheat', 'ChessCheat/Library'}) do
    if not isfolder(v) then
        makefolder(v)
    end
end

debugDownloadSuccess('Library/getFEN.lua')

return loadstring(debugDownloadSuccess('Main.lua'))()

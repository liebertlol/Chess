local SE = setmetatable({}, {
    __index = function(self, key)
        local ok, s = pcall(game.GetService, game, key)
        if ok and s then
            rawset(self, key, s)
            return s
        end
    end
})

if not isfolder("ChessCheat") then
    loadstring(game:HttpGet("https://raw.githubusercontent.com/liebertlol/Chess/refs/heads/main/Installer.lua"))()
end

local Players = SE.Players
local lplr = Players.LocalPlayer
local Workspace = SE.Workspace
local RS = SE.ReplicatedStorage
local HttpService = SE.HttpService
local fetch = (syn and syn.request) or (http and http.request) or http_request or (fluxus and fluxus.request) or request
local parser = loadfile("ChessCheat/Library/parser.lua")()
local depth = 12 -- max 18

function move(move)
    if move and #move >= 4 then
        RS.Chess.SubmitMove:InvokeServer(move)
    end
end

function getMove(fen)
    local Res
    local suc, ret = pcall(function()
        Res = fetch({
            Url = "https://chess-api.com/v1",
            Method = "POST",
            Headers = {["Content-Type"] = "application/json"},
            Body = HttpService:JSONEncode({
            fen = fen,
            depth = depth or 12
            })
        })
    end)
    if suc and Res and Res.Success then
        local Data = HttpService:JSONDecode(Res.Body)
        return Data.from .. Data.to
    end
end

while task.wait() do
    local fen = parser.FEN()
    if fen then
        local moved = getMove(fen)
        move(moves)
    end
end

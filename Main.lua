local SE = setmetatable({}, {
    __index = function(self, key)
        local ok, s = pcall(function()
            return game:GetService(key)
        end)
        if ok and s then
            rawset(self, key, s)
            return s
        end
        return nil
    end
})

if not isfolder("ChessCheat") then
    loadstring(game:HttpGet("https://raw.githubusercontent.com/liebertlol/Chess/refs/heads/main/Installer.lua",true))()
end

local Players = SE.Players
local Workspace = SE.Workspace
local RS = SE.ReplicatedStorage
local RunService = SE.RunService
local HttpService = SE.HttpService
local fetch = (syn and syn.request) or (http and http.request) or http_request or (fluxus and fluxus.request) or request

local fenParser = loadfile("ChessCheat/Library/getFen.lua")()
local utils = loadfile("ChessCheat/Library/Utils.lua")()
local FEN = fenParser.getFEN()

function Move(...)
  RS.Chess.SumbitMove(...)
  return true
end -- useless 

function GetMove(FEN, Engine)
    if Engine == "Stockfish" then
        local Res;
        local suc, ret = pcall(function()
            Res = fetch({
                Url = "https://chess-api.com/v1",
                Method = "POST",
                Headers = { ["Content-Type"] = "application/json" },
                Body = HttpService:JSONEncode({
                    fen = FEN
                })
            })
        end)
    if suc and Res and Res.Success then
      local Data = HttpService:JSONDecode(Res.Body)
      return Data.from .. Data.to
    else
      warn("[Engine] Stockfish request failed:", ret or (Res and Res.StatusCode))
    end
  end
end

while task.wait() do
  local Moves = GetMove(FEN, "Stockfish")
  Move(Moves)
end

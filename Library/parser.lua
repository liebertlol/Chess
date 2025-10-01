local lplr = game.Players.LocalPlayer

local parser = {}
function parser.FEN()
	for _, v in ipairs(workspace:GetChildren()) do
		if v.Name == "ChessTableset" then
			if v.WhitePlayer.Value == lplr.Name or v.BlackPlayer.Value == lplr.Name then
				return v.FEN.Value
			end
		end
	end
	print("[DEBUG] not in a match")
	return nil
end

return parser

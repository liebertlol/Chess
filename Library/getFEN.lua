function getFEN()
	for _, v in ipairs(workspace:GetChildren()) do
		if v.Name == "ChessTableset" then
			if v.WhitePlayer.Value == lplr or v.BlackPlayer.Value == lplr then
				return v.FEN.Value
      else
        print("[LIBS] getFEN doesnt work!")
      end
    end
  end
end

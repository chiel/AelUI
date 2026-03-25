local _, ns = ...

local m = ns.media

ns.storage.search.create = function(parent)
	local box = CreateFrame('EditBox', nil, parent, 'BackdropTemplate')
	box:SetHeight(20)
	box:SetFont(m.fonts.default.file, 18, '')
	box:SetTextInsets(4, 4, 0, 0)
	box:SetAutoFocus(false)

	box:SetBackdrop({ edgeFile = m.borders.default.file, edgeSize = 1 })
	box:SetBackdropBorderColor(0, 0, 0, 0)

	box.placeholder = box:CreateFontString(nil, 'ARTWORK')
	box.placeholder:SetFont(m.fonts.default.file, 18, '')
	box.placeholder:SetPoint('LEFT', 4, 0)
	box.placeholder:SetText('Search...')
	box.placeholder:SetTextColor(0.4, 0.4, 0.4)

	box:SetScript('OnTextChanged', function(self)
		local text = self:GetText()
		box.placeholder:SetShown(text == '')
		ns.storage.search.notify(text)
	end)

	box:SetScript('OnEnterPressed', function(self)
		self:ClearFocus()
	end)

	box:SetScript('OnEscapePressed', function(self)
		self:SetText('')
		self:ClearFocus()
	end)

	box:RegisterEvent('GLOBAL_MOUSE_DOWN')
	box:SetScript('OnEvent', function(self)
		if not self:IsMouseOver() then
			self:ClearFocus()
		end
	end)

	return box
end

-- ******************************************************************************
-- * SorryGuys v0.4																*
-- * 26. Dezember 2010															*
-- * -------------------------------------------------------------------------- *
-- * 																			*
-- * Use the source, Luke!														*
-- * 																			*
-- * Nein, Chräcker, keine Schweinereien im Quellcode ;-)						*
-- * ich war übrigens so frei und habe mapcoords als Vorlage geklaut. 			*
-- * Nicht, dass viel übrig geblieben wäre. Aber gepasst hat's schon.			*
-- ******************************************************************************


SorryGuys_VERSION 	= "0.4"

function SorryGuys_OnEvent(self,event, ...)

	if (event=="ADDON_LOADED") then
		SorryGuys_AddonLoaded(self)
		return
	end


	if (event=="CHAT_MSG_CHANNEL_NOTICE") then
		local action=...
		if (action=="YOU_JOINED") then
			SendChatMessage(SorryGuysConfig["dndmessage"],"DND");
			BNSetCustomMessage(SorryGuysConfig["dndmessage"]);
			BNSetDND(true);
			self:UnregisterEvent("CHAT_MSG_CHANNEL_NOTICE")
		end
		return
	end

	local action, who, a1, chatname, a2, a3, a4, channum, a5, a6, a7, a8, a9 = ...;
	if (event=="CHAT_MSG_BN_CONVERSATION_NOTICE") then
		if (action=="YOU_JOINED_CONVERSATION") then
			if (SorryGuysConfig["state"]==true) then
				BNSendConversationMessage(channum,SorryGuysConfig["message"])
				BNLeaveConversation(channum);
				if (SorryGuysConfig["dnd"]==true) then
					BNSetDND(true);
					-- Ob BNSetDND irgendwelche Auswirkungen hat, weiß ich nicht. Ich schätze, das ist für Konversationen über die Systeme hinaus interessant.
					-- Innerhalb von WoW vermutlich nicht wichtig. Denn das übernimmt dort:
					SendChatMessage(SorryGuysConfig["dndmessage"],"DND");
					BNSetCustomMessage(SorryGuysConfig["dndmessage"]);
				end
			end
		end
		
	end	
end

function SorryGuys_AddonLoaded (self) 

	if (not SorryGuysConfig) then
		SorryGuysConfig = {}
		SorryGuysConfig["state"]=false
		SorryGuysConfig["dnd"]=false
		SorryGuysConfig["dndstart"]=false
		SorryGuysConfig["message"]="Sorry Guys, no time for chitchat! Bye!"
		SorryGuysConfig["dndmessage"]=""
		

	end

	
	if (SorryGuysConfig["dndstart"]==true) then
		self:RegisterEvent("CHAT_MSG_CHANNEL_NOTICE");
	end
	SorryGuysBlizzardOptions()
	self:UnregisterEvent("ADDON_LOADED")
end


function SorryGuys_OnLoad(self)

	-- Das Eventbinding. Etwas generisch, das lässt sich dann ohne große Arbeit erweitern
	if (not SorryGuysConfig) then
	
		SorryGuysConfig = {}
		SorryGuysConfig["state"]=false
		SorryGuysConfig["dnd"]=false
		SorryGuysConfig["dndstart"]=false
		SorryGuysConfig["message"]="Sorry Guys, no time for chitchat! Bye!"
	end
	
	

	for _, event in pairs(ChatTypeGroup["BN_CONVERSATION"]) do
		self:RegisterEvent(event);
	end
	
	self:RegisterEvent("ADDON_LOADED")	

	SlashCmdList["SORRYGUYS"] = SorryGuys_SlashCommand
	SLASH_SORRYGUYS1 = "/sorryguys"
	SLASH_SORRYGUYS2 = "/sg"

end

function SorryGuys_Echo(msg)
	DEFAULT_CHAT_FRAME:AddMessage(msg)
end

function SorryGuys_SlashCommand(message)
	
	local msg,rest=strsplit(" ",message);
	local findarg = strfind(message, " ")
	if (findarg ~= nil) then
		arg = strsub(message,findarg + 1)
	end
	
	msg = string.lower(msg)

	-- vll sollte ich mal nach einem select..case in lua gucken. gibt's sowas? ;)
	
	if (msg=="dndtoggle") then
		SorryGuysConfig["dnd"] = not SorryGuysConfig["dnd"]
		if (SorryGuysConfig["dnd"]==true) then
			SorryGuys_Echo(SG_STRING_MSG_DNDON)
		else 
			SorryGuys_Echo(SG_STRING_MSG_DNDOFF)
		end
	elseif (msg == "dndoff") then
		SorryGuysConfig["dnd"] = false
		SorryGuys_Echo(SG_STRING_MSG_DNDOFF)
	elseif (msg == "dndon") then
		SorryGuysConfig["dnd"] = true
		SorryGuys_Echo(SG_STRING_MSG_DNDON)
	elseif (msg == "toggle") then
		SorryGuysConfig["state"] = not SorryGuysConfig["state"]
		if (SorryGuysConfig["state"]==true) then
			SorryGuys_Echo(SG_STRING_MSG_ON)
		else 
			SorryGuys_Echo(SG_STRING_MSG_OFF)
		end
	elseif (msg == "off") then
		SorryGuysConfig["state"] = false
		SorryGuys_Echo(SG_STRING_MSG_OFF)
	elseif (msg == "on") then
		SorryGuysConfig["state"] = true
		SorryGuys_Echo(SG_STRING_MSG_ON)
	elseif (msg == "msg") then
		SorryGuysConfig["message"] = strsub(message,5)
		SorryGuysMessageEdit:SetText(SorryGuysConfig["message"])
		SorryGuys_Echo(SG_STRING_MSG_MSGSET..SorryGuysConfig["message"])
	elseif (msg == "dndmsg") then
		SorryGuysConfig["dndmessage"] = strsub(message,8)
		SorryGuysMessageEdit:SetText(SorryGuysConfig["dndmessage"])
		SorryGuys_Echo(SG_STRING_MSG_DNDMSGSET..SorryGuysConfig["dndmessage"])
	elseif (msg == "dndstarton") then
		SorryGuysConfig["dndstart"] = true
		SorryGuys_Echo(SG_STRING_MSG_DNDSTARTON)
	elseif (msg == "dndstartoff") then
		SorryGuysConfig["dndstart"] = false
		SorryGuys_Echo(SG_STRING_MSG_DNDSTARTOFF)
	elseif (msg == "dndstarttoggle") then
		SorryGuysConfig["dndstart"] = not SorryGuysConfig["dndstart"]
		if (SorryGuysConfig["dndstart"]==true) then
			SorryGuys_Echo(SG_STRING_MSG_DNDSTARTON)
		else 
			SorryGuys_Echo(SG_STRING_MSG_DNDSTARTOFF)
		end
	else
		SorryGuys_Echo(SG_STRING_SLASH_HELP);
	end
	
	if SorryGuysOptions:IsVisible() then
		SorryGuysSetCheckButtonState()
	end
end

function SorryGuysSetCheckButtonState()
	SorryGuysCheckButton1:SetChecked(SorryGuysConfig["state"])
	SorryGuysCheckButton2:SetChecked(SorryGuysConfig["dnd"])
	SorryGuysCheckButton3:SetChecked(SorryGuysConfig["dndstart"])
	SorryGuysMessageEdit:SetText(SorryGuysConfig["message"])
	SorryGuysDNDMessageEdit:SetText(SorryGuysConfig["dndmessage"])
end 

function SorryGuysBlizzardOptions()

	-- Hier kommt nun der ganze Rotz für die Settings.
	-- das ginge mit einem XML schöner
	-- erwähnte ich, dass ich XML für die Pest am Arsch der Informatik halte?

	local SorryGuysOptions = CreateFrame("FRAME", "SorryGuysOptions")
	SorryGuysOptions:SetScript("OnShow", function(self) SorryGuysSetCheckButtonState() end)
	SorryGuysOptions.name = "SorryGuys"
	InterfaceOptions_AddCategory(SorryGuysOptions)

	local SorryGuysOptionsHeader = SorryGuysOptions:CreateFontString(nil, "ARTWORK")
	SorryGuysOptionsHeader:SetFontObject(GameFontNormalLarge)
	SorryGuysOptionsHeader:SetJustifyH("LEFT") 
	SorryGuysOptionsHeader:SetJustifyV("TOP")
	SorryGuysOptionsHeader:ClearAllPoints()
	SorryGuysOptionsHeader:SetPoint("TOPLEFT", 16, -16)
	SorryGuysOptionsHeader:SetText("SorryGuys "..SorryGuys_VERSION)

	local SorryGuysCheckButton1 = CreateFrame("CheckButton", "SorryGuysCheckButton1", SorryGuysOptions, "OptionsCheckButtonTemplate")
	SorryGuysCheckButton1:SetPoint("TOPLEFT", SorryGuysOptionsHeader, "BOTTOMLEFT", 2, -8)
	SorryGuysCheckButton1:SetScript("OnClick", function(self) SorryGuys_SlashCommand("toggle") end)
	SorryGuysCheckButton1Text:SetText(SG_STRING_OPTIONS_CHECKBUTTON_ONOFF)


	local SorryGuysCheckButton2 = CreateFrame("CheckButton", "SorryGuysCheckButton2", SorryGuysOptions, "OptionsCheckButtonTemplate")
	SorryGuysCheckButton2:SetPoint("TOPLEFT", SorryGuysCheckButton1, "BOTTOMLEFT", 0, -2)
	SorryGuysCheckButton2:SetScript("OnClick", function(self) SorryGuys_SlashCommand("dndtoggle") end)
	SorryGuysCheckButton2Text:SetText(SG_STRING_OPTIONS_CHECKBUTTON_DNDONOFF)

	local SorryGuysCheckButton3 = CreateFrame("CheckButton", "SorryGuysCheckButton3", SorryGuysOptions, "OptionsCheckButtonTemplate")
	SorryGuysCheckButton3:SetPoint("TOPLEFT", SorryGuysCheckButton2, "BOTTOMLEFT", 0, -2)
	SorryGuysCheckButton3:SetScript("OnClick", function(self) SorryGuys_SlashCommand("dndstarttoggle") end)
	SorryGuysCheckButton3Text:SetText(SG_STRING_OPTIONS_CHECKBUTTON_DNDSTARTONOFF)
	
	local SorryGuysOptionsMessageHead = SorryGuysOptions:CreateFontString(nil, "ARTWORK")
	SorryGuysOptionsMessageHead:SetFontObject(GameFontWhite)
	SorryGuysOptionsMessageHead:SetJustifyH("LEFT") 
	SorryGuysOptionsMessageHead:SetJustifyV("TOP")
	SorryGuysOptionsMessageHead:ClearAllPoints()
	SorryGuysOptionsMessageHead:SetPoint("TOPLEFT", SorryGuysCheckButton3, "BOTTOMLEFT", -2, -8)
	SorryGuysOptionsMessageHead:SetText(SG_STRING_OPTIONS_EDITBOX)

	local SorryGuysMessageEdit = CreateFrame("EditBox", "SorryGuysMessageEdit", SorryGuysOptions, "InputBoxTemplate")
	SorryGuysMessageEdit:SetPoint("TOPLEFT", SorryGuysOptionsMessageHead, "BOTTOMLEFT", 0, -4)
	SorryGuysMessageEdit:SetAutoFocus(false)
	SorryGuysMessageEdit:SetMaxLetters(100)
	SorryGuysMessageEdit:SetHeight(20)
	SorryGuysMessageEdit:SetWidth(300)
	SorryGuysMessageEdit:SetScript("OnEscapePressed",function() SorryGuysMessageEdit:ClearFocus() end)

	local SorryGuysSetMessage = CreateFrame("Button", "SorryGuysSetMessage", SorryGuysOptions, "UIPanelButtonTemplate")
	SorryGuysSetMessage:SetPoint("TOPLEFT", SorryGuysMessageEdit, "TOPRIGHT", 10, 0)
	SorryGuysSetMessage:SetScript("OnClick", function(self) SorryGuys_SlashCommand("msg "..SorryGuysMessageEdit:GetText()) end)
	SorryGuysSetMessage:SetHeight(20)
	SorryGuysSetMessage:SetWidth(40)
	SorryGuysSetMessage:SetText("Ok")
	
	local SorryGuysOptionsDNDMessageHead = SorryGuysOptions:CreateFontString(nil, "ARTWORK")
	SorryGuysOptionsDNDMessageHead:SetFontObject(GameFontWhite)
	SorryGuysOptionsDNDMessageHead:SetJustifyH("LEFT") 
	SorryGuysOptionsDNDMessageHead:SetJustifyV("TOP")
	SorryGuysOptionsDNDMessageHead:ClearAllPoints()
	SorryGuysOptionsDNDMessageHead:SetPoint("TOPLEFT", SorryGuysMessageEdit, "BOTTOMLEFT", 2, -8)
	SorryGuysOptionsDNDMessageHead:SetText(SG_STRING_OPTIONS_DNDEDITBOX)

	local SorryGuysDNDMessageEdit = CreateFrame("EditBox", "SorryGuysDNDMessageEdit", SorryGuysOptions, "InputBoxTemplate")
	SorryGuysDNDMessageEdit:SetPoint("TOPLEFT", SorryGuysOptionsDNDMessageHead, "BOTTOMLEFT", -2, -4)
	SorryGuysDNDMessageEdit:SetAutoFocus(false)
	SorryGuysDNDMessageEdit:SetMaxLetters(100)
	SorryGuysDNDMessageEdit:SetHeight(20)
	SorryGuysDNDMessageEdit:SetWidth(300)
	SorryGuysDNDMessageEdit:SetScript("OnEscapePressed",function() SorryGuysDNDMessageEdit:ClearFocus() end)

	local SorryGuysSetMessage = CreateFrame("Button", "SorryGuysSetMessage", SorryGuysOptions, "UIPanelButtonTemplate")
	SorryGuysSetMessage:SetPoint("TOPLEFT", SorryGuysDNDMessageEdit, "TOPRIGHT", 10, 0)
	SorryGuysSetMessage:SetScript("OnClick", function(self) SorryGuys_SlashCommand("dndmsg "..SorryGuysDNDMessageEdit:GetText()) end)
	SorryGuysSetMessage:SetHeight(20)
	SorryGuysSetMessage:SetWidth(40)
	SorryGuysSetMessage:SetText("Ok")

	
	
	-- this is the...
	
end
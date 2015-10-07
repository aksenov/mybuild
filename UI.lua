-- The MIT License (MIT)
-- Copyright (c) 2015 Eugene Aksenov
--
-- Permission is hereby granted, free of charge, to any person obtaining a copy
-- of this software and associated documentation files (the "Software"), to deal
-- in the Software without restriction, including without limitation the rights
-- to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
-- copies of the Software, and to permit persons to whom the Software is
-- furnished to do so, subject to the following conditions:
--
-- The above copyright notice and this permission notice shall be included in
-- all copies or substantial portions of the Software.
--
-- THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
-- IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
-- FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
-- AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
-- LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
-- OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
-- THE SOFTWARE.

-------------------------------------------------------------------------------
-- Main user interface
-------------------------------------------------------------------------------

MyBuild.UI = {}

local WM = GetWindowManager()

WM:CreateControl()

-- update all character information in window
function MyBuild.UI.UpdateUI()
    MyBuild.CharacterView:UpdateCharacterInfo(MyBuild.Char)
    MyBuild.AttributeView:UpdateCharacterInfo(MyBuild.Char)
    MyBuild.EquipmentView:UpdateCharacterInfo(MyBuild.Char)
    MyBuild.ChampionView:UpdateCharacterInfo(MyBuild.Char)
end

function MyBuild.UI.CreateUI()
    local ui = {}
    ui.mainWindow = MyBuild.UI.MainWindow(760, 800)

    MyBuild.AttributeView:Create(ui.mainWindow)
    MyBuild.EquipmentView:Create(ui.mainWindow)
    MyBuild.ChampionView:Create(ui.mainWindow)
    MyBuild.CharacterView:Create(ui.mainWindow)
    
    MyBuild.UI.ToggleHidden = function ()
        ui.mainWindow:ToggleHidden()
    end
    return ui
end


function MyBuild.UI.MainWindow(width, height)
  local mainWindow = WM:CreateTopLevelWindow("MyBuild_MainWindow")
  mainWindow:SetDimensions(width, height)
  mainWindow:SetAnchor(CENTER, GuiRoot, CENTER, 0, 0)
  mainWindow:SetHidden(false)
  mainWindow:SetMovable(true)
  mainWindow:SetMouseEnabled(true)
  mainWindow:SetClampedToScreen(true)

  WM:CreateControlFromVirtual("MainWindowbackdrop", mainWindow, "ZO_DefaultBackdrop")

  local closeButton = WM:CreateControl("MyBuild_closeButton", mainWindow, CT_BUTTON)
  closeButton:SetAnchor(TOPRIGHT, mainWindow, TOPRIGHT, -5, 5)
  closeButton:SetDimensions(24, 24)
  closeButton:SetNormalTexture("/esoui/art/buttons/closebutton_up.dds")
  closeButton:SetHidden(false)
  closeButton:SetHandler("OnClicked", function() mainWindow:SetHidden(true) end)

  return mainWindow
end


-- TODO MyBuild.UI - don't pollute global namespace

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

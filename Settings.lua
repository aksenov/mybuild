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
-- Create settings menu
-------------------------------------------------------------------------------
local LAM2 = LibStub:GetLibrary("LibAddonMenu-2.0")

function MyBuild.CreateSettingsWindow()
    local name = "MyBuild"
    local panelData = {
        type = "panel",
        name = "My Build",
        displayName = "My Build..",
        author = "Eugene Aksenov, @aksenov (EU)",
        version = 1,
        slashCommand = "/mybuild",
        registerForRefresh = true,
        registerForDefaults = true,
    }
    LAM2:RegisterAddonPanel(name, panelData)

    local optionsData = {
        [1] = {
            type = "header",
            name = "My Build Settings"
        },
        [2] = {
            type = "checkbox",
            name = "Display character's name",
            default = true,
            getFunc = function() return MyBuild.db.displayName end,
            setFunc = function(val)
                MyBuild.db.displayName = val
                MyBuild.UI.UpdateUI()
            end

        }
    }
    LAM2:RegisterOptionControls(name, optionsData)
end
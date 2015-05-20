--
-- Created by IntelliJ IDEA.
-- User: axis
-- Date: 02.05.2015
-- Time: 10:58
-- To change this template use File | Settings | File Templates.
--

UI2 = {}

local WM = GetWindowManager()
WM:CreateControl()

function UI2.Label(text, font, parent, width, height)
    local label = WM:CreateControl("", parent, CT_LABEL)
    label:SetText(text)
    label:SetFont(font)
    if width and height then
        label:SetDimensions(width, height)
    end
    label:SetWrapMode(TEXT_WRAP_MODE_ELLIPSIS)
    return label
end

function UI2.Box(parent, width, height)
    local box = WM:CreateControl("", parent, CT_CONTROL)
    box:SetDimensions(width, height)
    d("BOX")
    d(box)
    return box
end

function UI2.Offset(elem, x, y)
    d("ELEM")
    d(elem)
    d("LEM")
    local parent = elem:GetParent()
    elem:SetAnchor(TOPLEFT, parent, TOPLEFT, x, y)
    return elem
end


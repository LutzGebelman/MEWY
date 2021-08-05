TOOL.Category = "Lutz's Tools"
TOOL.Name = "MEWY"
TOOL.Commnad = nil
TOOL.ConfigName = ""
TOOL.ents_list = {}
TOOL.BackgroundColor = Color(0, 0, 0, 0)
if CLIENT then
    language.Add("Tool.mewy.name", "MEWY")
    language.Add("Tool.mewy.desc", "Make any entity watch after you")
    language.Add("Tool.mewy.0", "LMB to make object follow you; RMB to make it stop.")
    language.Add("Undone.mewy", "undone!")
end

if SERVER then end

local function my_rad_to_deg(rad)
    deg = rad * 180/math.pi
    if rad >= 0 then
        return deg
    else 
        return deg + 180
    end
end

local function calcucate_angle(ply, ent)
    ply_pos = ply:GetPos()
    ent_pos = ent:GetPos()

    rel_x = ent_pos["x"] - ply_pos["x"] // Reletive position of entity to player in X dimetion
    rel_y = ent_pos["y"] - ply_pos["y"] // Reletive position of entity to player in Y dimetion
    rel_z = ent_pos["z"] - ply_pos["z"] // Reletive position of entity to player in Z dimetion

    O = math.atan(math.sqrt(rel_x^2 + rel_y^2) / rel_z)
    fin_O = my_rad_to_deg(O) * -1 + 90 // Rotating entity to make it watch on player
    atan2_yx = math.atan2(rel_y, rel_x) // Using ATAN2 to calculate angle of the entity reletive to the player in the world
    ent:SetAngles(Angle(fin_O, math.deg(atan2_yx) + 180, 0)) // Setting the angle to what we need
end

function TOOL:LeftClick(trace)
    local ent = trace["Entity"]
    local ply = self:GetOwner()

    table.insert(self.ents_list, ent:EntIndex(), ent)
    function ent:Think()
        calcucate_angle(ply, ent)
        return true
    end
    return true
end

function TOOL:RightClick(trace)
    local ent = trace["Entity"]
    local ply = self:GetOwner()
    function ent:Think()
        return false
    end

    return true
end

function TOOL:Reload(trace)
    self.BackgroundColor = ColorRand(false)
    return false
end

function TOOL:DrawToolScreen(width, hight)
    surface.SetDrawColor(self.BackgroundColor)
    surface.DrawRect(0, 0, width, hight)
    str_ents_list = table.ToString(self.ents_list, nil, true)
    draw.SimpleText("Lutz's Tools MEWY", "DermaLarge", width / 2, hight / 2, Color(200, 200, 200), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
end

hook.Add("PreUndo", "Delete item from ent's list", function(undo)
    ent = undo.Entities[1]
    ply = undo.Owner
    if ply:GetTool() != nil and ply:GetTool()["Name"] == "MEWY" and ply:GetTool()["ents_list"][ent:EntIndex()] != nil then
        table.remove(ply:GetTool()["ents_list"], ent:EntIndex())
    end
end)
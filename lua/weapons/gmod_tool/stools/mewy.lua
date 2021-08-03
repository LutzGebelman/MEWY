TOOL.Category = "Fuck My Ass"
TOOL.Name = "Watch this tool"
TOOL.Commnad = nil

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
    ent = trace["Entity"]
    ply = self:GetOwner()
    function ent:Think()
        calcucate_angle(ply, ent)
        return true
    end
    return true
end

function TOOL:RightClick(trace)
    return false
end

function TOOL:Reload(trace)
    return false
end
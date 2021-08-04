if SERVER == CLIENT then
    hook.Add("Think", "Make_Everythink_Think", function()
        for _, ent in pairs(LocalPlayer():GetTool("tool.mewy").ents_list) do
            if LocalPlayer():GetTool("tool.mewy").ents_list[ent:EntIndex()] != nil then 
                if ent.Think != nil then
                    ent:Think()
                end
            end
        end
    end)
end 
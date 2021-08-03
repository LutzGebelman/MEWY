hook.Add("Think", "Make_Everythink_Think", function()
    for _, ent in pairs(ents.GetAll()) do
        if ent.Think != nil then
            ent:Think()
        end
    end
end)

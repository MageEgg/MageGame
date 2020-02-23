library PetSystem uses AbilityUI,OtherDamageTimer

    function PetTimer(int pid)
        for num = 0,5
            if  Pu[200+num] != null
                if  Udis(Pu[1],Pu[200+num]) > 800
                    SetUnitXY(Pu[200+num],GetUnitX(Pu[1])+GetRandomReal(-200,200),GetUnitY(Pu[1])+GetRandomReal(-200,200))
                    UnitAddEffect(Pu[200+num],"effect_az_pafeathermoon_b.mdl")
                    IssuePointOrderById(Pu[200+num],851983,(GetUnitX(Pu[1])+GetRandomReal(-500,500)),(GetUnitY(Pu[1])+GetRandomReal(-500,500)))
                endif
                if  GetUnitCurrentOrder(Pu[200+num]) == 0
                    IssuePointOrderById(Pu[200+num],851983,(GetUnitX(Pu[1])+GetRandomReal(-500,500)),(GetUnitY(Pu[1])+GetRandomReal(-500,500)))
                endif
            endif
        end
    endfunction
    
    function PetDeathPosition(int pid)
        real x = AttackRoomPostion[pid][1] 
        real y = AttackRoomPostion[pid][2]
        for num = 0,5
            if  Pu[200+num] != null
                SetUnitXY(Pu[200+num],x,y)
                UnitAddEffect(Pu[200+num],"effect_az_pafeathermoon_b.mdl")
            endif
        end
    endfunction
    
    function PlayerGetPetClear(int pid)
        for k = 0,5
            if  Pu[200+k] != null
                FlushChildHashtable(ht,GetHandleId(Pu[200+k]))
                RemoveUnit(Pu[200+k])
                Pu[200+k] = null
            endif
        end
    endfunction

    function CreatePet(int pid)
        if  Pu[200] != null
            FlushChildHashtable(ht,GetHandleId(Pu[200]))
            RemoveUnit(Pu[200])
            Pu[200] = null
        endif
        Pu[200] = CreateUnit(Player(pid),'hC01',GetUnitX(Pu[1]),GetUnitY(Pu[1]),0)
        IssuePointOrderById(Pu[200],851983,(GetUnitX(Pu[1])+GetRandomReal(-500,500)),(GetUnitY(Pu[1])+GetRandomReal(-500,500)))
    endfunction

endlibrary

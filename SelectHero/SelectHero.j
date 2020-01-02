scope SelectHero
    
    function IsPlayerHasHero(player p,int uid)->boolean
        int id = uid + 0x3000000
        if  IsPlayerHasTech(p,id) == true
            return true
        else
            DisplayTimedTextToPlayer(p,0,0,5,"|cffffcc00[系统]:|r无法选择"+GetObjectName(uid)+","+GetObjectName(id))
            return false
        endif
        
    endfunction

    
   
    function SelectHeroPrePareFunc(int pid)
        if  IsPlaying(pid) == true
            
            PlayerReviveX = -5024
            PlayerReviveY = -3392
            Pu[1] = PlaceRandomUnit( HeroPool, Player(pid),PlayerReviveX,PlayerReviveY,0 )
            //Pu[2] = CreateUnit(Player(pid),'zs00',1038,-5667,0)
            
            DisplayTimedTextToPlayer(GetLocalPlayer(),0,0,10,"|cffffcc00[系统]:|r"+GetPlayerColorEx(pid)+GetPN(pid)+"|r选择了|cffffcc00"+GetUnitName(Pu[1])+"|r！")
            if  Player(pid)==GetLocalPlayer()
                SetPlayerCameraBoundsToRect(bj_mapInitialPlayableArea)
                PanCameraToTimed(PlayerReviveX,PlayerReviveY, 0 )
                SetCameraField( CAMERA_FIELD_TARGET_DISTANCE, 2200.00, 2.0)
                SetCameraField( CAMERA_FIELD_FARZ, 10000.00, 2.0 )
                ClearSelection()
                SelectUnit(Pu[1],true)
            endif
            
            
            SetUnitRealState(Pu[1],5,1000)
            
            UnitAddAbility(Pu[1],'AG01')
            UnitAddAbility(Pu[1],'AG02')
            UnitAddAbility(Pu[1],'AG03')
            UnitAddAbility(Pu[1],'AG04')
            UnitAddAbility(Pu[1],'AG05')
            UnitAddAbility(Pu[1],'AG06')
            
            UnitAddAbility(Pu[1],'AG08')

            UnitAddAbility(Pu[1],'A002')

            HeroAddAbilityByIndex(Pu[1],1,'S0Q1')
            HeroAddAbilityByIndex(Pu[1],2,'S0W0')
            HeroAddAbilityByIndex(Pu[1],3,'S0E0')
            HeroAddAbilityByIndex(Pu[1],4,'S0R0')
            
            HeroAddAbilityByIndex(Pu[1],5,'S500'+(GetUnitTypeId(Pu[1])-'H000'))
            
            AddPlayerTechResearched(Player(pid),'Rhrt',1)
            
            LoadPlayerTechState(pid)
            
    
            GameChallenge_0Start(pid)
            
            if  SubString(GetPlayerName(Player(pid)),0,9) == "星耀丶"
                DisplayTimedTextToPlayer(GetLocalPlayer(),0,0,10,"|cffffcc00[系统]:|r欢迎星耀成员"+GetPlayerColorEx(pid)+GetPN(pid)+"，奖励木材1000！")
                AdjustPlayerStateBJ(1000, Player(pid), PLAYER_STATE_RESOURCE_LUMBER )
            endif
            
        endif
    endfunction
    
    /*
    function SelectHeroActions()
        int pid = GetPlayerId(GetTriggerPlayer())
        int uid = GetUnitTypeId(GetTriggerUnit())
        if  Pu[1] == null
            SelectHeroPrePareFunc(pid,'Hpal')
            
            if  IsPlayerHasHero(Player(pid),uid) == true
                if  IsUnitOwnedByPlayer(GetTriggerUnit(), Player(PLAYER_NEUTRAL_PASSIVE)) == true //and RectContainsCoords(gg_rct_SelectHero, GetUnitX(GetTriggerUnit()), GetUnitY(GetTriggerUnit())) 
                    if  Pu[0] == GetTriggerUnit()
                        SelectHeroPrePareFunc(pid,uid)
                    endif
                    Pu[0] = GetTriggerUnit()
                else
                    Pu[0] = null
                endif
            else
                
                Pu[0] = null
            endif
            
        endif
        flush locals
    endfunction
    
    function InitSelectHero()
        trigger trg = CreateTrigger()
    
        for pid = 0,7
            TriggerRegisterPlayerSelectionEventBJ(trg, Player(pid), true )
            Pu[0] = null
            Pu[1] = null
        end
        
        TriggerAddAction(trg, function SelectHeroActions)
        trg = null
    endfunction
    */
    
    function InitSelectHero()
        for pid = 0,3
            if  IsPlaying(pid) == true
                
                SelectHeroPrePareFunc(pid)
            endif
        end
    endfunction
endscope

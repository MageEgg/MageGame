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

    
   
    function SelectHeroPrePareFunc(int pid,unit hero)
        if  IsPlaying(pid) == true
            
            
            Pu[1] = hero
            
            Pu[2] = CreateUnit(Player(pid),'hZ00',AttackRoomPostion[pid][1],AttackRoomPostion[pid][2],0)
            
            DisplayTimedTextToPlayer(GetLocalPlayer(),0,0,10,"|cffffcc00[系统]:|r"+GetPlayerColorEx(pid)+GetPN(pid)+"|r选择了|cffffcc00"+GetUnitName(Pu[1])+"|r！")
            ShowPlayerSignInLastTime(pid) //登陆刷新
            if  Player(pid)==GetLocalPlayer()
                SetPlayerCameraBoundsToRect(bj_mapInitialPlayableArea)
                PanCameraToTimed(PlayerReviveX,PlayerReviveY, 0 )
                SetCameraField( CAMERA_FIELD_TARGET_DISTANCE, 2200.00, 2.0)
                SetCameraField( CAMERA_FIELD_FARZ, 10000.00, 2.0 )
                ClearSelection()
                SelectUnit(Pu[1],true)

                DzFrameShow(BUTTON_Back[702][0], true)
                
            endif
            
            
            SetUnitRealState(Pu[1],5,1000)
            

            UnitAddAbility(Pu[1],'MF01')//魔法书

            UnitAddAbility(Pu[1],'AG01')
            UnitAddAbility(Pu[1],'AG02')
            UnitAddAbility(Pu[1],'AG03')
            UnitAddAbility(Pu[1],'AG04')
            UnitAddAbility(Pu[1],'AG05')

            UnitAddAbility(Pu[1],'AG06')
            
            
            UnitAddAbility(Pu[1],'AG08')

            UnitAddAbility(Pu[1],'A002')

            HeroAddAbilityByIndex(Pu[1],1,'S0Q1')
            HeroAddAbilityByIndex(Pu[1],2,'S0W1')
            HeroAddAbilityByIndex(Pu[1],3,'S0E1')
            HeroAddAbilityByIndex(Pu[1],4,'S0R0')
            
            
            HeroAddAbilityByIndex(Pu[1],5,'S500'+(GetUnitTypeId(Pu[1])-'H000'))
            
            AddPlayerTechResearched(Player(pid),'Rhrt',1)
            
            
            
            InitPlayerGameGift(pid)//加载礼包
            GameChallenge_0Start(pid)//加载新手任务
            
            /*if  SubString(GetPlayerName(Player(pid)),0,9) == "星耀丶"
                DisplayTimedTextToPlayer(GetLocalPlayer(),0,0,10,"|cffffcc00[系统]:|r欢迎星耀成员"+GetPlayerColorEx(pid)+GetPN(pid)+"，奖励木材1000！")
                AdjustPlayerStateBJ(1000, Player(pid), PLAYER_STATE_RESOURCE_LUMBER )
            endif*/

            LoadPlayerTechState.execute(pid)
            InitHeroAddStateAbility.execute(Pu[1])
            
        endif
    endfunction

    function ReHeroPrePareFunc(int pid,int id)
        if  IsPlaying(pid) == true
            
            

            Pu[7] = Pu[1]

            Pu[1] = CreateUnit(Player(pid),id,PlayerReviveX,PlayerReviveY,0)
            for i = 0,5
                UnitAddItem(Pu[1],UnitItemInSlot(Pu[7],i))
            end
            RemoveUnit(Pu[7])
            //Pu[2] = CreateUnit(Player(pid),'zs00',1038,-5667,0)
            
            DisplayTimedTextToPlayer(GetLocalPlayer(),0,0,10,"|cffffcc00[系统]:|r"+GetPlayerColorEx(pid)+GetPN(pid)+"|r重新选择了|cffffcc00"+GetUnitName(Pu[1])+"|r！")
            
            if  Player(pid)==GetLocalPlayer()
                SetPlayerCameraBoundsToRect(bj_mapInitialPlayableArea)
                PanCameraToTimed(PlayerReviveX,PlayerReviveY, 0 )
                SetCameraField( CAMERA_FIELD_TARGET_DISTANCE, 2200.00, 2.0)
                SetCameraField( CAMERA_FIELD_FARZ, 10000.00, 2.0 )
                ClearSelection()
                SelectUnit(Pu[1],true)

                DzFrameShow(BUTTON_Back[702][0], true)
                DzFrameShow(BUTTON_Back[703][0], true) 
            endif

            
            
            SetUnitRealState(Pu[1],5,1000)
            

            UnitAddAbility(Pu[1],'MF01')//魔法书

            UnitAddAbility(Pu[1],'AG01')
            UnitAddAbility(Pu[1],'AG02')
            UnitAddAbility(Pu[1],'AG03')
            UnitAddAbility(Pu[1],'AG04')
            UnitAddAbility(Pu[1],'AG05')

            UnitAddAbility(Pu[1],'AG06')
            
            
            UnitAddAbility(Pu[1],'AG08')

            UnitAddAbility(Pu[1],'A002')

            HeroAddAbilityByIndex(Pu[1],1,'S0Q1')
            HeroAddAbilityByIndex(Pu[1],2,'S0W1')
            HeroAddAbilityByIndex(Pu[1],3,'S0E1')
            HeroAddAbilityByIndex(Pu[1],4,'S0R0')
            
            
            HeroAddAbilityByIndex(Pu[1],5,'S500'+(GetUnitTypeId(Pu[1])-'H000'))
            
            AddPlayerTechResearched(Player(pid),'Rhrt',1)
            
            LoadPlayerTechState.execute(pid)
            
            InitHeroAddStateAbility.execute(Pu[1])
            
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
                PlayerReviveX = -5120
                PlayerReviveY = -2976
                if  "a"+GetPlayerName(Player(pid)) == "aarDee"
                    SelectHeroPrePareFunc(pid,CreateUnit(Player(pid),'H011',PlayerReviveX,PlayerReviveY,0))
                else
                    SelectHeroPrePareFunc(pid,PlaceRandomUnit( HeroPool, Player(pid),PlayerReviveX,PlayerReviveY,0 ))
                endif
            endif
        end
    endfunction
endscope

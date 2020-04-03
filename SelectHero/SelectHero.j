scope SelectHero
    
    function IsPlayerHasHero(player p,int uid)->boolean
        int id = uid + 0x3000000
        if  IsPlayerHasTech(p,id) == true
            return true
        else
            DisplayTimedTextToPlayer(p,0,0,5,"|cffffcc00[系统]：|r无法选择"+GetObjectName(uid)+","+GetObjectName(id))
            return false
        endif
        
    endfunction


    //存档读属性的都放这里  找完姜子牙加载
    function SelectHeroAddSaveState(int pid)

        real x = AttackRoomPostion[pid][1]
        real y = AttackRoomPostion[pid][2]
        CreateUnit(Player(PLAYER_NEUTRAL_PASSIVE),'nc02',x-512,y+128,270)//技能商店
        Pu[22]=CreateUnit(Player(PLAYER_NEUTRAL_PASSIVE),'np02',x-512,y+128,270)//技能商店

        SetPlayerTechResearched(Player(pid),'R000',1)
        UnitAddAbility(Pu[1],'AG0A')//F5 F6
        UnitAddAbility(Pu[1],'AG0B')

        InitPlayerDzShopState.execute(pid)//商城属性

        InitPlayerMeridiansState.execute(pid)//经脉

        LoadPlayerTechState.execute(pid)//读取存档属性

        PlayerLoadPassCheck.execute(pid)//读取通行证

        if  SubString(GetPlayerName(Player(pid)),0,6) == "星耀"
            DisplayTimedTextToPlayer(GetLocalPlayer(),0,0,10,"|cffffcc00[系统]:|r检测到"+GetPlayerNameOfColor(pid)+"名称中带有星耀，奖励每秒金币+1、每秒攻击+1、每秒生命+5！")
            AddUnitRealState(Pu[1],47,1)
            AddUnitRealState(Pu[1],49,5)
            AddUnitRealState(Pu[1],50,1)
        endif 

        int dzlv = GetDzHeroExpLevel(pid,GetUnitTypeId(Pu[1]))
        
        if  dzlv >= 1
            AddUnitRealState(Pu[1],17,5)
        endif
        
        if  dzlv >= 2
            AddUnitRealState(Pu[1],18,3)
        endif
        /*
        if  dzlv >= 3
            AddUnitRealState(Pu[1],18,4)
        endif
        
        if  dzlv >= 4
            AddUnitRealState(Pu[1],17,10)
        endif
        if  dzlv >= 5
            AddUnitRealState(Pu[1],19,5)
        endif
        */
        

        if  Player(pid)==GetLocalPlayer()
            ReHeroButton.show = false
        endif
                

    endfunction


    //通用的都放这里
    function SelectHeroInitSkill(int pid)
        if  Player(pid)==GetLocalPlayer()
            SetPlayerCameraBoundsToRect(bj_mapInitialPlayableArea)
            PanCameraToTimed(PlayerReviveX,PlayerReviveY, 0 )
            SetCameraField( CAMERA_FIELD_TARGET_DISTANCE, 2200.00, 2.0)
            SetCameraField( CAMERA_FIELD_FARZ, 10000.00, 2.0 )
            ClearSelection()
            SelectUnit(Pu[1],true)
            ReHeroButton.show = true
            DzFrameShow(BUTTON_Back[702][0], true)
        endif


        SetUnitRealState(Pu[1],5,1000)

        UnitAddAbility(Pu[1],'MF01')//魔法书

        UnitAddAbility(Pu[1],'AG01')
        UnitAddAbility(Pu[1],'AG02')
        //UnitAddAbility(Pu[1],'AG03')
        UnitAddAbility(Pu[1],'AG04')
        UnitAddAbility(Pu[1],'AG05')

        UnitAddAbility(Pu[1],'AG06')
        
        UnitAddAbility(Pu[1],'AG08')
        
        

        HeroAddAbilityByIndex(Pu[1],1,'S0Q1')
        HeroAddAbilityByIndex(Pu[1],2,'S0W1')
        //HeroAddAbilityByIndex(Pu[1],3,'S0E1')
        HeroAddAbilityByIndex(Pu[1],4,'S0R0')
        
        HeroAddAbilityByIndex(Pu[1],5,'S500'+(GetUnitTypeId(Pu[1])-'H000'))
        
        InitHeroAddStateAbility.execute(Pu[1])//读取百分比属性技能
        
        InitPlayerMonsterSoulSkill(pid)

        

        
    endfunction

   
    //正常选英雄
    function SelectHeroPrePareFunc(int pid)
        if  IsPlaying(pid) == true
            
            
            Pu[1] = CreateUnit(Player(pid),GetHeroPoolType(),PlayerReviveX,PlayerReviveY,0)
            
            Pu[2] = CreateUnit(Player(pid),'hZ00',AttackRoomPostion[pid][1],AttackRoomPostion[pid][2],0)
            
            DisplayTimedTextToPlayer(GetLocalPlayer(),0,0,10,"|cffffcc00[系统]：|r"+GetPlayerNameOfColor(pid)+"选择了|cffffcc00"+GetUnitName(Pu[1])+"|r！")
            
            SelectHeroInitSkill(pid)//加载必要技能

            GameChallenge_0Start(pid)//加载新手任务

            ReTechFuncItemTips.execute(pid)//刷新道具兑换说明

            ShowPlayerSignInLastTime(pid) //登陆刷新

            for i = 1,GameLevel
                SetPlayerTechResearched(Player(pid),'KNDA'+i-1,1)
            end

            //重随次数
            if  DzBool == true
                HeroReNumber = 100
            else
                HeroReNumber = 1
            endif
            if  GetPlayerTechCount(Player(pid),'RY1D',true) > 0
                HeroReNumber = HeroReNumber + 1
            endif
            if  GetPlayerTechCount(Player(pid),'RG0B',true) > 0
                HeroReNumber = HeroReNumber + 1
            endif

            

            ReHeroFrameUI(pid)

            
        endif
    endfunction

    //重新选英雄
    function ReHeroPrePareFunc(int pid,int id)
        real showvalue = 0
        if  IsPlaying(pid) == true

            Pu[7] = Pu[1]
            Pu[1] = CreateUnit(Player(pid),id,PlayerReviveX,PlayerReviveY,0)
            
            for StateId = 10,41
                if  GetLocalPlayer() == Player(pid)
                    showvalue = GetUnitRealState(Pu[1],StateId)
                    if  StateId == 32
                        DzFrameSetText(BUTTON_Text[161],"|cffffcc00攻击加成：|r"+I2S(R2I(showvalue))+"%")
                    elseif  StateId == 33
                        DzFrameSetText(BUTTON_Text[162],"|cffffcc00业力加成：|r"+I2S(R2I(showvalue))+"%")
                    elseif  StateId == 15
                        DzFrameSetText(BUTTON_Text[163],"|cffffcc00攻击伤害：|r"+I2S(R2I(showvalue))+"%")
                    elseif  StateId == 16
                        DzFrameSetText(BUTTON_Text[164],"|cffffcc00技能伤害：|r"+I2S(R2I(showvalue))+"%")
                    elseif  StateId == 19
                        DzFrameSetText(BUTTON_Text[165],"|cffffcc00暴击：|r"+I2S(R2I(showvalue))+"%")
                    elseif  StateId == 20
                        DzFrameSetText(BUTTON_Text[166],"|cffffcc00暴击伤害：|r"+I2S(R2I(showvalue))+"%")
                    elseif  StateId == 41
                        DzFrameSetText(BUTTON_Text[167],"|cffffcc00金币加成：|r"+I2S(R2I(showvalue))+"%")
                    elseif  StateId == 10
                        DzFrameSetText(BUTTON_Text[168],"|cffffcc00闪避：|r"+I2S(R2I(showvalue))+"%")
                    elseif  StateId == 18
                        DzFrameSetText(BUTTON_Text[169],"|cffffcc00伤害减免：|r"+I2S(R2I(showvalue))+"%")
                    elseif  StateId == 22
                        DzFrameSetText(BUTTON_Text[170],"|cffffcc00分裂：|r"+I2S(R2I(showvalue))+"%")
                    elseif  StateId == 21
                        DzFrameSetText(BUTTON_Text[171],"|cffffcc00吸血：|r"+I2S(R2I(showvalue))+"%")
                    elseif  StateId == 17
                        DzFrameSetText(BUTTON_Text[172],"|cffffcc00伤害加成：|r"+I2S(R2I(showvalue))+"%")
                    elseif  StateId == 13
                        DzFrameSetText(BUTTON_Text[173],"|cffffcc00护甲穿透：|r"+I2S(R2I(showvalue)))
                    elseif  StateId == 27
                        DzFrameSetText(BUTTON_Text[174],"|cffffcc00触发概率：|r"+I2S(R2I(showvalue))+"%")  
                    elseif  StateId == 31
                        DzFrameSetText(BUTTON_Text[175],"|cffffcc00生命加成：|r"+I2S(R2I(showvalue))+"%")
                    elseif  StateId == 47
                        DzFrameSetText(BUTTON_Text[176],"|cffffcc00每秒攻击：|r"+I2S(R2I(showvalue)))
                    elseif  StateId == 48
                        DzFrameSetText(BUTTON_Text[177],"|cffffcc00每秒业力：|r"+I2S(R2I(showvalue)))
                    elseif  StateId == 49
                        DzFrameSetText(BUTTON_Text[178],"|cffffcc00每秒生命：|r"+I2S(R2I(showvalue)))
                    endif
                endif
            end
            for i = 0,5
                UnitAddItem(Pu[1],UnitItemInSlot(Pu[7],i))
            end
            RemoveUnit(Pu[7])
            DisplayTimedTextToPlayer(GetLocalPlayer(),0,0,10,"|cffffcc00[系统]：|r"+GetPlayerColorEx(pid)+GetPN(pid)+"|r重新选择了|cffffcc00"+GetUnitName(Pu[1])+"|r！")

            SelectHeroInitSkill(pid)//加载必要技能
            
        endif
    endfunction

    //重随
    function ReHeroPrePareByPool(int pid,int index)
        int id = ReHeroPool[pid][index]
        int uid = GetUnitTypeId(Pu[1])
        if  id > 0
            ReHeroPrePareFunc(pid,id)
            PoolRemHeroId(pid,id)
            PoolAddHeroId(pid,uid)
        endif
    endfunction

    function ReHeroPrePare(int pid)
        int id = GetUnitTypeId(Pu[1])
        if  id > 0
            if  PlayerDeathBool == false
                if  GameChallengBool[0] == false
                    if  HeroReNumber > 0
                        PoolAddHeroId(pid,id)
                        ReHeroPrePareFunc(pid,GetHeroPoolTypeNew(id))
                        HeroReNumber = HeroReNumber - 1
                        ReHeroFrameUI(pid)
                    else
                        DisplayTimedTextToPlayer(Player(pid),0,0,10,"|cffff0000[系统]：剩余次数不足！无法重随英雄！")
                    endif
                else
                    DisplayTimedTextToPlayer(Player(pid),0,0,10,"|cffff0000[系统]：当前无法重随英雄！")
                endif
            else
                DisplayTimedTextToPlayer(Player(pid),0,0,10,"|cffff0000[系统]：死亡状态无法重随英雄！")
            endif
        endif
    endfunction
    
    
    function InitSelectHero()
        for pid = 0,3
            if  IsPlaying(pid) == true
                PlayerReviveX = -4896
                PlayerReviveY = -3168
                SelectHeroPrePareFunc(pid)
                BuryingPointData(pid,0,GameLevel,1)//选难度埋点
            endif
        end

        //活动大使
        if  DzConA[4] == 1
            CreateUnit(Player(PLAYER_NEUTRAL_PASSIVE),'np39',-5110,-2862,270)
            CreateUnit(Player(PLAYER_NEUTRAL_PASSIVE),'nc39',-5110,-3090,270)
        endif

    endfunction
endscope

library PassCheckMission initializer InitPassCheckMission uses DzSave,DamageCode
    int MissionDay = 0
    int MaxMissionNum = 4//任务数量
    int MaxPassCheckPrizeNum = 20 //奖励数量
    int MaxPassCheckDayExp = 6
    
    scope RegisterMission
        int array PassCheckMissionData[1000][8]
        string array PassCheckMissionString[1000][8]

        function GetMissionExp(int missionid)->int//获取任务经验
            return PassCheckMissionData[missionid][1]
        endfunction
        function GetMissionUse(int missionid)->int//获取任务需求数量
            return PassCheckMissionData[missionid][2]
        endfunction
        function GetMissionName(int missionid)->string//获取任务名称
            return PassCheckMissionString[missionid][1]
        endfunction
        function GetMissionTips(int missionid)->string//获取任务说明
            return PassCheckMissionString[missionid][2]
        endfunction
        
        function RegisterPassCheckMission(int missionid,int exp,int use,string name,string tips)
            PassCheckMissionData[missionid][1] = exp
            PassCheckMissionData[missionid][2] = use
            PassCheckMissionString[missionid][1] = name
            PassCheckMissionString[missionid][2] = tips
        endfunction

        
    endscope

    scope RegisterDay

        int array PassCheckMissionId[800][10]

        function GetDayMissionId(int index)->int
            return PassCheckMissionId[MissionDay][index]
        endfunction
        
        function RegisterPassCheckDay(int day,int id1,int id2,int id3,int id4,int id5,int id6)
            PassCheckMissionId[day][1]=id1
            PassCheckMissionId[day][2]=id2
            PassCheckMissionId[day][3]=id3
            PassCheckMissionId[day][4]=id4
            PassCheckMissionId[day][5]=id5
            PassCheckMissionId[day][6]=id6
        endfunction
        
    endscope


    scope RegisterPrize
        int array PassCheckPrize[2][1000]

        function GetPassCheckPrize(int index,int num)->int
            return PassCheckPrize[num][index]
        endfunction

        function RegisterPassCheckPrize(int index,int id1,int id2)
            PassCheckPrize[1][index] = id1
            PassCheckPrize[2][index] = id2
        endfunction
    endscope


    function InitRegisterPrize()//注册奖励
        RegisterPassCheckPrize(1,'RS01',1000)
        RegisterPassCheckPrize(2,'RY2A','RY2B')
        RegisterPassCheckPrize(3,800,'IP01')
        RegisterPassCheckPrize(4,2,5)
        RegisterPassCheckPrize(5,'RS05','RT05')
        RegisterPassCheckPrize(6,'CS23','RT06')
        RegisterPassCheckPrize(7,'RS07','RT07')
        RegisterPassCheckPrize(8,'RY4A','RY4B')
        RegisterPassCheckPrize(9,'RS09','IP04')
        RegisterPassCheckPrize(10,'RS10','RT10')
        RegisterPassCheckPrize(11,0,'RT11')
        RegisterPassCheckPrize(12,'RS12','RT12')
        RegisterPassCheckPrize(13,0,'RT13')
        RegisterPassCheckPrize(14,'RY1A','RY1B')
        RegisterPassCheckPrize(15,'IP01','RT15')
        RegisterPassCheckPrize(16,'RS16','RT16')
        RegisterPassCheckPrize(17,0,'RT17')
        RegisterPassCheckPrize(18,5,'CS22')
        RegisterPassCheckPrize(19,0,'RT19')
        RegisterPassCheckPrize(20,'RY3A','RY3B')

        RegisterPassCheckPrize(21,'RS21','IN30')
        RegisterPassCheckPrize(22,'RJ2A','RJ2E')
        RegisterPassCheckPrize(23,'IP06','IP07')
        RegisterPassCheckPrize(24,2,5)
        RegisterPassCheckPrize(25,'RS25','RT25')
        RegisterPassCheckPrize(26,'IP02','RT26')
        RegisterPassCheckPrize(27,'RS27','RT27')
        RegisterPassCheckPrize(28,'RJ2B','RY2H')
        RegisterPassCheckPrize(29,'CS51','CS52')
        RegisterPassCheckPrize(30,'RS30','RT30')
        RegisterPassCheckPrize(31,0,'RT31')
        RegisterPassCheckPrize(32,'RS32','RT32')
        RegisterPassCheckPrize(33,0,'RT33')
        RegisterPassCheckPrize(34,'RJ2C','RJ2F')
        RegisterPassCheckPrize(35,'IP02','RT35')
        RegisterPassCheckPrize(36,'RS36','RT36')
        RegisterPassCheckPrize(37,0,'RT37')
        RegisterPassCheckPrize(38,5,'CS02')
        RegisterPassCheckPrize(39,0,'RT39')
        RegisterPassCheckPrize(40,'RJ2D','RY3G')



        RegisterPassCheckPrize(41,'RS41','IN30')
        RegisterPassCheckPrize(42,'RJ2H','RJ2L')
        RegisterPassCheckPrize(43,-2,-2)
        RegisterPassCheckPrize(44,1000,1500)
        RegisterPassCheckPrize(45,'RS45','RT45')
        RegisterPassCheckPrize(46,-3,'RT46')
        RegisterPassCheckPrize(47,'RS47','RT47')
        RegisterPassCheckPrize(48,'RJ2I','RY2J')
        RegisterPassCheckPrize(49,'CS51','CS52')
        RegisterPassCheckPrize(50,'RS50','RT50')
        RegisterPassCheckPrize(51,0,'RT51')
        RegisterPassCheckPrize(52,'RS52','RT52')
        RegisterPassCheckPrize(53,0,'RT53')
        RegisterPassCheckPrize(54,'RJ2J','RJ2M')
        RegisterPassCheckPrize(55,-3,'RT55')
        RegisterPassCheckPrize(56,0,'RT56')
        RegisterPassCheckPrize(57,0,'RT57')
        RegisterPassCheckPrize(58,'IP08','IP08')
        RegisterPassCheckPrize(59,0,'RT59')
        RegisterPassCheckPrize(60,'RJ2K','RY1F')




        
    endfunction

    function InitRegisterMission()//注册任务
        //代码输出
        RegisterPassCheckMission(1,2,1,"","点击右上角【签到】按钮完成签到")
        RegisterPassCheckMission(2,1,1,"","通关难1或以上")
        RegisterPassCheckMission(3,1,2500,"","击杀2500个进攻怪")
        RegisterPassCheckMission(4,1,9,"","通关9个任意副本")
        RegisterPassCheckMission(5,1,12,"","抽取12次技能")
        RegisterPassCheckMission(6,1,2,"","通关2次任意难度")
        RegisterPassCheckMission(7,1,50,"","击杀50个进攻精英怪")
        RegisterPassCheckMission(8,1,12,"","击杀12个进攻Boss")
        RegisterPassCheckMission(9,1,2,"","获得2次|CffBF00FF先天神器|r品质的法宝")
        RegisterPassCheckMission(10,1,2,"","获得2次|CffFFC926造化至宝|r品质的法宝")
        RegisterPassCheckMission(11,1,1,"","组队通关任意难度")
        RegisterPassCheckMission(12,1,8,"","获得8次|Cff00BFFF后天仙器|r品质的法宝")
        RegisterPassCheckMission(13,1,8,"","获得8次|Cff00FF7F通天灵宝|r品质的法宝")
        RegisterPassCheckMission(14,1,12,"","完成12次武灵挑战")
        RegisterPassCheckMission(15,1,16,"","通关16次任意副本")
        RegisterPassCheckMission(16,1,6,"","击杀6次送宝金蟾")
        RegisterPassCheckMission(17,1,16,"","完成16次山灵挑战")
        RegisterPassCheckMission(18,1,1,"","17:00-24:00登陆游戏")


        RegisterPassCheckMission(21,2,1,"","击杀1次闻太师")
        RegisterPassCheckMission(22,2,1,"","通关难2或以上")
        RegisterPassCheckMission(23,2,1,"","通关难3或以上")
        RegisterPassCheckMission(24,2,1,"","获得1个|CffFF0000混沌圣器|r品质的法宝")
        RegisterPassCheckMission(25,2,1,"","完成1次团队副本-万仙阵")
        RegisterPassCheckMission(26,2,2,"","获得两颗|CffFF0000混沌道果|r。")
        RegisterPassCheckMission(27,2,6,"","获得6个|CffFFC926造化至宝|r品质的法宝")


        RegisterPassCheckMission(30,2,16,"","通关16个任意副本")
        RegisterPassCheckMission(31,2,100,"","击杀100个【新手任务-妖魅】")
        RegisterPassCheckMission(32,2,20,"","击杀20个进攻Boss")
        RegisterPassCheckMission(33,2,20,"","抽取20次技能")
        RegisterPassCheckMission(34,2,8,"","获得8次|CffBF00FF先天神器|r的法宝")

    endfunction

    function InitRegisterDay()//注册每日任务
    
        //代码输出
        RegisterPassCheckDay(1,1,4,5,32,0,0)
        RegisterPassCheckDay(2,1,6,18,30,0,0)
        RegisterPassCheckDay(3,1,8,9,21,0,0)
        RegisterPassCheckDay(4,1,10,18,34,0,0)
        RegisterPassCheckDay(5,1,12,7,33,0,0)
        RegisterPassCheckDay(6,1,14,18,21,0,0)
        RegisterPassCheckDay(7,1,16,17,22,0,0)
        RegisterPassCheckDay(8,1,18,2,23,0,0)
        RegisterPassCheckDay(9,1,3,13,24,0,0)
        RegisterPassCheckDay(10,1,18,11,25,0,0)
        RegisterPassCheckDay(11,1,10,15,26,0,0)
        RegisterPassCheckDay(12,1,4,5,27,0,0)
        RegisterPassCheckDay(13,1,6,18,22,0,0)
        RegisterPassCheckDay(14,1,8,9,25,0,0)
        RegisterPassCheckDay(15,1,10,18,23,0,0)
        RegisterPassCheckDay(16,1,12,7,24,0,0)
        RegisterPassCheckDay(17,1,14,18,26,0,0)
        RegisterPassCheckDay(18,1,16,17,32,0,0)
        RegisterPassCheckDay(19,1,18,2,30,0,0)
        RegisterPassCheckDay(20,1,3,13,32,0,0)
        RegisterPassCheckDay(21,1,18,11,34,0,0)
        RegisterPassCheckDay(22,1,10,15,33,0,0)
        RegisterPassCheckDay(23,1,4,5,21,0,0)
        RegisterPassCheckDay(24,1,6,18,22,0,0)
        RegisterPassCheckDay(25,1,8,9,23,0,0)
        RegisterPassCheckDay(26,1,10,18,24,0,0)
        RegisterPassCheckDay(27,1,12,7,25,0,0)
        RegisterPassCheckDay(28,1,14,18,26,0,0)
        RegisterPassCheckDay(29,1,16,17,27,0,0)
        RegisterPassCheckDay(30,1,18,2,22,0,0)
        RegisterPassCheckDay(32,1,3,13,25,0,0)
        RegisterPassCheckDay(32,1,18,11,23,0,0)
        RegisterPassCheckDay(33,1,10,15,24,0,0)
        RegisterPassCheckDay(34,1,4,5,26,0,0)
        RegisterPassCheckDay(35,1,6,18,32,0,0)
        RegisterPassCheckDay(36,1,8,9,30,0,0)
        RegisterPassCheckDay(37,1,10,18,32,0,0)
        RegisterPassCheckDay(38,1,12,7,34,0,0)
        RegisterPassCheckDay(39,1,14,18,33,0,0)
        RegisterPassCheckDay(40,1,16,17,21,0,0)
        RegisterPassCheckDay(41,1,18,2,22,0,0)
        RegisterPassCheckDay(42,1,3,13,23,0,0)
        RegisterPassCheckDay(43,1,18,11,24,0,0)
        RegisterPassCheckDay(44,1,10,15,25,0,0)
        RegisterPassCheckDay(45,1,6,18,26,0,0)
        RegisterPassCheckDay(46,1,8,9,27,0,0)
        RegisterPassCheckDay(47,1,10,18,22,0,0)
        RegisterPassCheckDay(48,1,12,7,25,0,0)
        RegisterPassCheckDay(49,1,14,18,23,0,0)
        RegisterPassCheckDay(50,1,16,17,24,0,0)
        RegisterPassCheckDay(51,1,18,2,26,0,0)
        RegisterPassCheckDay(52,1,4,5,32,0,0)
        RegisterPassCheckDay(53,1,6,18,30,0,0)
        RegisterPassCheckDay(54,1,8,9,21,0,0)
        RegisterPassCheckDay(55,1,10,18,34,0,0)
        RegisterPassCheckDay(56,1,12,7,33,0,0)
        RegisterPassCheckDay(57,1,14,18,21,0,0)
        RegisterPassCheckDay(58,1,16,17,22,0,0)
        RegisterPassCheckDay(59,1,18,2,23,0,0)
        RegisterPassCheckDay(60,1,3,13,24,0,0)
        RegisterPassCheckDay(61,1,18,11,25,0,0)
        RegisterPassCheckDay(62,1,10,15,26,0,0)
        RegisterPassCheckDay(63,1,4,5,27,0,0)
        RegisterPassCheckDay(64,1,6,18,22,0,0)
        RegisterPassCheckDay(65,1,8,9,25,0,0)
        RegisterPassCheckDay(66,1,10,18,23,0,0)
        RegisterPassCheckDay(67,1,12,7,24,0,0)
        RegisterPassCheckDay(68,1,14,18,26,0,0)
        RegisterPassCheckDay(69,1,16,17,32,0,0)
        RegisterPassCheckDay(70,1,18,2,30,0,0)
        RegisterPassCheckDay(71,1,3,13,32,0,0)
        RegisterPassCheckDay(72,1,18,11,34,0,0)
        RegisterPassCheckDay(73,1,10,15,33,0,0)
        RegisterPassCheckDay(74,1,4,5,21,0,0)
        RegisterPassCheckDay(75,1,6,18,22,0,0)
        RegisterPassCheckDay(76,1,8,9,23,0,0)
        RegisterPassCheckDay(77,1,10,18,24,0,0)
        RegisterPassCheckDay(78,1,12,7,25,0,0)
        RegisterPassCheckDay(79,1,14,18,26,0,0)
        RegisterPassCheckDay(80,1,16,17,27,0,0)
        RegisterPassCheckDay(81,1,18,2,22,0,0)
        RegisterPassCheckDay(82,1,3,13,25,0,0)
        RegisterPassCheckDay(83,1,18,11,23,0,0)
        RegisterPassCheckDay(84,1,10,15,24,0,0)
        RegisterPassCheckDay(85,1,4,5,26,0,0)
        RegisterPassCheckDay(86,1,6,18,32,0,0)
        RegisterPassCheckDay(87,1,8,9,30,0,0)
        RegisterPassCheckDay(88,1,10,18,32,0,0)
        RegisterPassCheckDay(89,1,12,7,34,0,0)
        RegisterPassCheckDay(90,1,14,18,33,0,0)
        RegisterPassCheckDay(91,1,16,17,21,0,0)
        RegisterPassCheckDay(92,1,18,2,22,0,0)
        RegisterPassCheckDay(93,1,3,13,23,0,0)
        RegisterPassCheckDay(94,1,18,11,24,0,0)
        RegisterPassCheckDay(95,1,10,15,25,0,0)
        RegisterPassCheckDay(96,1,6,18,26,0,0)
        RegisterPassCheckDay(97,1,8,9,27,0,0)
        RegisterPassCheckDay(98,1,10,18,22,0,0)
        RegisterPassCheckDay(99,1,12,7,25,0,0)
        RegisterPassCheckDay(100,1,14,18,23,0,0)
                
    endfunction

    function InitPassCheckMission()
        ExecuteFunc("InitRegisterMission")
        ExecuteFunc("InitRegisterDay")
        ExecuteFunc("InitRegisterPrize")
    endfunction



    scope PlayerPassMission
        int array PassCheckPlayerData[12][680]
        #define PlayerPassData  PassCheckPlayerData[pid]

        function GetPlayerPassExp(int pid,int step)->int
            int exp = GetDzPlayerData(pid,4,1+step)
            return exp
        endfunction
        function GetPlayerPassLevel(int pid,int step)->int
            int exp = GetPlayerPassExp(pid,step)
            if  step == 0
                exp = exp + 7
            elseif  step == 1
                exp = exp + 6
            endif
            int level = exp / MaxPassCheckDayExp
            if  level > 20
                level = 20
            endif
            return level
        endfunction

        function GetMissionIndex(int pid,int missionid)->int//根据任务判断今天的index
            for i = 1,MaxMissionNum
                if  GetDayMissionId(i) == missionid
                    return i
                endif
            end
            return 0
        endfunction

        function GetShowMissionTips(int pid,int index,int missionid)->string
            int data = PlayerPassData[index]
            int use = GetMissionUse(missionid)
            if  use > data
                if  data == 0
                    return GetMissionTips(missionid)+"|cffffcc00 -- 进行中|r"
                else
                    return GetMissionTips(missionid)+"|cffffcc00 -- 当前数量：|r"+I2S(data)
                endif
            else
                return GetMissionTips(missionid)+"|cff00ff00 -- 已完成|r"
            endif
        endfunction
        function PlayerShowMission(int pid)//查询任务
            int missionid = 0
            DisplayTimedTextToPlayer(Player(pid),0,0,10, "|cffff0000[任务]：|r|cffcc99ff任务每天凌晨五点自动刷新！|r")
            DisplayTimedTextToPlayer(Player(pid),0,0,10, "|cffff0000[任务状态]：|r")
            for i = 1,MaxMissionNum
                missionid = PassCheckMissionId[MissionDay][i]
                if  missionid > 0
                    DisplayTimedTextToPlayer(Player(pid),0,0,10, "|cffffcc00[任务]：|r"+GetShowMissionTips(pid,i,missionid))
                endif
            end
        endfunction


        function PlayerMissionComplete(int pid,int missionid)//任务完成
            if  DzConA[0] == 1 //全局限制
                int exp = GetMissionExp(missionid)
                if  MissionDay > 41
                    AddDzPlayerData(pid,4,1,exp)
                    AddDzPlayerData(pid,4,2,exp)
                    AddDzPlayerData(pid,4,3,exp)
                elseif  MissionDay > 20
                    AddDzPlayerData(pid,4,1,exp)
                    AddDzPlayerData(pid,4,2,exp)
                else
                    AddDzPlayerData(pid,4,1,exp)
                endif
                //DisplayTimedTextToPlayer(Player(pid),0,0,10, "|cffffcc00[系统]：|r"+GetMissionName(missionid)+"任务完成！通行证经验+"+I2S(exp))
                DisplayTimedTextToPlayer(Player(pid),0,0,10, "|cffffcc00[系统]：|r任务完成！全部通行证经验+"+I2S(exp))
            endif
        endfunction
        
        function PlayerMissionAddNum(int pid,int missionid,int num)//任务计数
            int index = GetMissionIndex(pid,missionid)
            int data = PlayerPassData[index]
            int use = GetMissionUse(missionid)
            if  data < use
                data = data + num
                if  data >= use
                    data = use
                    PlayerPassData[index] = use
                    PlayerMissionComplete(pid,missionid)
                else
                    PlayerPassData[index] = PlayerPassData[index] + num
                    if  use <= 30
                        DisplayTimedTextToPlayer(Player(pid),0,0,10, "|cffffcc00[任务]：|r"+GetShowMissionTips(pid,index,missionid))
                    else
                        if  ModuloInteger(PlayerPassData[index],10) == 0
                            DisplayTimedTextToPlayer(Player(pid),0,0,10, "|cffffcc00[任务]：|r"+GetShowMissionTips(pid,index,missionid))
                        endif
                    endif
                endif
                SetDzPlayerData(pid,5,index,PlayerPassData[index])
                RePassClickFrame.execute(pid)
            else
                BJDebugMsg(I2S(missionid)+"任务已完成")
            endif
        endfunction

        
        
        function MissionAddNumFunc(int pid,int missionid,int num)//任务达成计数
            int index = 0
            if  DzConA[0] == 1 //全局限制
                index = GetMissionIndex(pid,missionid)
                if  index > 0
                    PlayerMissionAddNum(pid,missionid,num)

                else
                    //BJDebugMsg(I2S(missionid)+"不是今日任务")
                endif
            endif
        endfunction

        function TimerMissionAddNumFunc(int id,int missionid,int num)
            int pid = id
            int i1 = missionid
            int i2 = num
            TimerStart(0.0,false)
            {
                MissionAddNumFunc(pid,i1,i2)
                endtimer
                flush locals
            }
            flush locals
        endfunction


        function MissionKillUnit(int pid,int uid)
            if  uid >= 'm001' and uid <= 'm050'
                MissionAddNumFunc(pid,3,1)
            elseif  uid >= 'ma01' and uid <= 'ma0z'
                MissionAddNumFunc(pid,7,1)//精英怪
            elseif  uid >= 'mb01' and uid <= 'mb0z'
                MissionAddNumFunc(pid,8,1)//进攻boss
                MissionAddNumFunc(pid,32,1)//进攻boss
            elseif  uid >= 'u001' and uid <= 'u009'
                MissionAddNumFunc(pid,16,1)//送宝金蟾
            elseif  uid >= 'uT0A' and uid <= 'uT0Z'
                MissionAddNumFunc(pid,17,1)//山灵挑战
            elseif  uid >= 'uT1A' and uid <= 'uT1Z'
                MissionAddNumFunc(pid,14,1)//武灵挑战
            elseif  uid == 'u020'
                if  GetUnitAbilityLevel(Pu[1],'AG0B') > 0
                    MissionAddNumFunc(pid,31,1)//-妖魅
                endif
            endif
        endfunction

        

        function PlayerAddMission(int pid)//读取当前任务进度
            for i = 1,MaxMissionNum
                PlayerPassData[i] = GetDzPlayerData(pid,5,i)
            end
        endfunction



        function GivePassCheckPrize(int pid,int index,int num)
            int id = GetPassCheckPrize(index,num)
            real x = AttackRoomPostion[pid][1]
            real y = AttackRoomPostion[pid][2]
            if  id != 0
                
                if  id >= 'RS01' and id <= 'RS99'//普通通行证属性
                    BJDebugMsg("PassPrize :"+GetTypeIdName(id)+"---普通属性")
                    AddEquipState(Pu[1],id)
                elseif  id >= 'RT01' and id <= 'RT99'//封神通行证属性
                    BJDebugMsg("PassPrize :"+GetTypeIdName(id)+"---封神属性")
                    AddEquipState(Pu[1],id)
                elseif  id >= 'R000' and id <= 'RZZZ'
                    BJDebugMsg("PassPrize :"+GetTypeIdName(id)+"---道具类")
                    SetPlayerTechResearchedEx(Player(pid),id)
                elseif  id < 0
                    BJDebugMsg("PassPrize :钻石"+I2S(-id)+"---资源类")
                    AddPlayerFoodByIndex(pid,2,-id)
                elseif  id < 500
                    BJDebugMsg("PassPrize :玄铁"+I2S(id)+"---资源类")
                    AdjustPlayerStateBJ(id, Player(pid), PLAYER_STATE_RESOURCE_LUMBER )
                elseif  id < 1000000
                    BJDebugMsg("PassPrize :金币"+I2S(id)+"---资源类")
                    AdjustPlayerStateBJ(id, Player(pid), PLAYER_STATE_RESOURCE_GOLD )
                else
                    DisplayTimedTextToPlayer(Player(pid),0,0,10, "|cff00ff00[通行证奖励]：|r"+GetItemName(CreateItem(id,x-512,y-512))+"已创建至练功房左下角!")
                    
                    BJDebugMsg("PassPrize :"+GetTypeIdName(id)+"---物品类")
                endif
            endif
        endfunction




        function PlayerAddPassPrize(int pid)
            int lv = GetPlayerPassLevel(pid,0)
            int shop = 0
            if  DzShop(Player(pid),"RWK") == true
                shop = 1
            endif
            for i = 1,MaxPassCheckPrizeNum
                if  lv >= i
                    GivePassCheckPrize(pid,i,1)
                    
                    if  shop == 1
                        GivePassCheckPrize(pid,i,2)
                    endif
                endif
            end

            lv = GetPlayerPassLevel(pid,1)
            shop = 0
            if  DzShop(Player(pid),"RWK2") == true
                shop = 1
            endif
            for i2 = 1,MaxPassCheckPrizeNum
                if  lv >= i2
                    GivePassCheckPrize(pid,i2+20,1)
                    
                    if  shop == 1
                        GivePassCheckPrize(pid,i2+20,2)
                    endif
                endif
            end


            lv = GetPlayerPassLevel(pid,2)
            shop = 0
            if  DzShop(Player(pid),"RWK3") == true
                shop = 1
            endif
            for i2 = 1,MaxPassCheckPrizeNum
                if  lv >= i2
                    GivePassCheckPrize(pid,i2+40,1)
                    
                    if  shop == 1
                        GivePassCheckPrize(pid,i2+40,2)
                    endif
                endif
            end


        endfunction

        function PlayerLoadPassCheck(int pid)//加载通行证
            
            
            if  DzConA[0] == 1 //全局限制
                
                PlayerAddMission(pid)
                
                //通行证加载道具
                
                PlayerAddPassPrize(pid)
                
                if  TimeHour >= 17 and TimeHour<= 24
                    MissionAddNumFunc(pid,18,1)
                endif

                
                

            endif
        endfunction
    endscope
endlibrary

library PassCheckUI uses GameFrame,PassCheckMission

    /*按钮序号
    601-606     经验条
    611-620     等级标签
    621-630     普通通行证
    631-640     超级通行证
    641-646     任务完成进度
    681-686     每日任务

    650         当前等级
    651         等级预览
    652         普通通行证
    653         超级通行证
    654         每日任务
    655         快速升级
    661         ←
    662         →

    671         第一赛季
    672         第二赛季
    */
    private FRAME Button = 0
    private FRAME Back = 0
    private FRAME Key = 0
    private int origin = 0

    private int Page = 0
    private int PageMax = 1
    private int Step = 0


    function GetPassCheckStep()->int
        return Step
    endfunction
    

    function GetPassCheckPrizeId(int id,int num)->int
        return GetPassCheckPrize((Page+Step*2)*10+id,num)
    endfunction

    

    //刷新奖励显示
    function RePassClickPrize(int pid)
        int id = 0
        int index = 0
        int level = GetPlayerPassLevel(pid,Step)
        if  GetLocalPlayer() == Player(pid)
            Key.SetText(I2S(Page+1)+"/2")
            DzFrameSetText(BUTTON_Text[650],"|cffffcc00"+I2S(level)+"|r")
            BJDebugMsg("level"+I2S(level))
            for i = 1,10
                index = Page*10+i
                if  level >= index
                    DzFrameSetText(BUTTON_Text[610+i],"|cff000000"+I2S(index)+"|r")
                    DzFrameSetTexture(BUTTON_Back[610+i][0],"war3mapImported\\UI_Pass_LevelBack.tga",0)

                    
                    DzFrameSetTexture(BUTTON_Back[620+i][3],"war3mapImported\\alpha.tga",0)

                    if  DzShop(Player(pid),"RWK") == false and Step == 0
                        DzFrameSetTexture(BUTTON_Back[630+i][3],"war3mapImported\\UI_DisBack.tga",0)
                    elseif  DzShop(Player(pid),"RWK2") == false and Step == 1
                        DzFrameSetTexture(BUTTON_Back[630+i][3],"war3mapImported\\UI_DisBack.tga",0)
                    elseif  DzShop(Player(pid),"RWK3") == false and Step == 2
                        DzFrameSetTexture(BUTTON_Back[630+i][3],"war3mapImported\\UI_DisBack.tga",0)
                    elseif  DzShop(Player(pid),"RWK4") == false and Step == 3
                        DzFrameSetTexture(BUTTON_Back[630+i][3],"war3mapImported\\UI_DisBack.tga",0)
                    else
                        DzFrameSetTexture(BUTTON_Back[630+i][3],"war3mapImported\\alpha.tga",0)
                    endif
                else
                    DzFrameSetText(BUTTON_Text[610+i],"|cffffffff"+I2S(index)+"|r")
                    DzFrameSetTexture(BUTTON_Back[610+i][0],"war3mapImported\\alpha.tga",0)

                    DzFrameSetTexture(BUTTON_Back[620+i][3],"war3mapImported\\UI_DisBack.tga",0)
                    DzFrameSetTexture(BUTTON_Back[630+i][3],"war3mapImported\\UI_DisBack.tga",0)
                    
                endif


                for y = 1,2
                    id = GetPassCheckPrize(index+Step*20,y)
                    if  id != 0
                        if  id <= 0
                            DzFrameSetTexture(BUTTON_Back[610+y*10+i][1],"war3mapImported\\food.blp",0)
                        elseif  id < 500
                            DzFrameSetTexture(BUTTON_Back[610+y*10+i][1],"war3mapImported\\UI_PlayerState2.tga",0)
                        elseif  id < 1000000
                            DzFrameSetTexture(BUTTON_Back[610+y*10+i][1],"war3mapImported\\UI_PlayerState1.tga",0)
                        else
                            DzFrameSetTexture(BUTTON_Back[610+y*10+i][1],GetTypeIdIcon(id),0)
                        endif
                    else
                        DzFrameSetTexture(BUTTON_Back[610+y*10+i][1],"war3mapImported\\alpha.tga",0)
                    endif
                end
                
            end
        endif
    endfunction
    //刷新整体显示

    function RePassClickFrame(int pid)
        int missionid = 0
        int step = Step
        int level = GetPlayerPassLevel(pid,step)
        int nowexp = 0
        int use = 0
        int exp = 0
        int now = 0
        if  GetLocalPlayer() == Player(pid)
            for i = 1,MaxMissionNum
                missionid = GetDayMissionId(i)
                use = GetMissionUse(missionid)
                exp = GetMissionExp(missionid)
                now = PlayerPassData[i]
                

                if  exp == 1
                    DzFrameSetTexture(BUTTON_Back[680+i][0],"war3mapImported\\UI_Pass_Text1.tga",0)
                elseif  exp == 2
                    DzFrameSetTexture(BUTTON_Back[680+i][0],"war3mapImported\\UI_Pass_Text2.tga",0)
                endif

                DzFrameSetText(BUTTON_Text[680+i],GetMissionTips(missionid))

                if  now >= use
                    DzFrameSetText(BUTTON_Text[640+i],"|cff00ff00已完成")
                    
                else
                    DzFrameSetText(BUTTON_Text[640+i],I2S(now)+"/"+I2S(use))
                endif
            end

            if  level >= 20
                nowexp = 0
            else
                nowexp = GetPlayerPassExp(pid,step)
                if  step == 0
                    nowexp = nowexp + 7
                elseif  step == 1
                    nowexp = nowexp + 6
                endif
                nowexp = nowexp - (nowexp /MaxPassCheckDayExp) * MaxPassCheckDayExp
            endif
            BJDebugMsg("通行证"+I2S(step+1)+"exp"+I2S(nowexp))
            for i = 1,MaxPassCheckDayExp
                if  i <= nowexp
                    DzFrameSetTexture(BUTTON_Back[600+i][0],"war3mapImported\\UI_Pass_Exp1.tga",0)
                else
                    DzFrameSetTexture(BUTTON_Back[600+i][0],"war3mapImported\\UI_Pass_Exp0.tga",0)
                endif
            end
            RePassClickPrize(pid)
        endif
    endfunction


    //点击上一页
    function PassFreamClickLast(int pid)
        
        if  GetLocalPlayer() == Player(pid)
            if  Page > 0
                Page = Page - 1
                
                RePassClickPrize(pid)
            endif
        endif
    endfunction

    //点击下一页
    function PassFreamClickNext(int pid)
        if  GetLocalPlayer() == Player(pid)
            if  Page < PageMax
                Page = Page + 1
                
                RePassClickPrize(pid)
            endif
        endif
    endfunction


    //选择通行证分页
    function PassFreamClickNextStep(int pid,int step)
        if  GetLocalPlayer() == Player(pid)
            Step = step
            
            DzFrameSetTexture(BUTTON_Back[653][0],"replaceabletextures\\commandbuttons\\BTNTXZ0"+I2S(step+2)+".blp",0)
            RePassClickPrize(pid)
            RePassClickFrame(pid)
        endif
    endfunction

    //通用函数
    function ShowPassFrame(int pid,bool show)

        if  GetLocalPlayer() == Player(pid)
            Button.show = show
            if  show == true
                RePassClickFrame(pid)
            endif
        endif
    
    endfunction
    function GetPassFrameShow()->bool
        return Button.show
    endfunction


    function ClosePassFrame(int pid)
        if  GetLocalPlayer() == Player(pid)
            Button.show = false
        endif
    endfunction

    function ClickPassFrame(int pid)
        if  GetLocalPlayer() == Player(pid)
            if  Button.show  == true
                Button.show = false
            else
                Button.show = true
                RePassClickFrame(pid)
                RePassClickPrize(pid)
            endif
        endif
    endfunction


    //注册按钮
    private function CreateFrameButton1()
        int last = 0
        //快速升级
        CreateButton(655,Button.frameid,TYPE_BUTTON,2,Button.frameid,2,-0.01,-0.008,0.056,0.02,"war3mapImported\\UI_Pass_ClockIn.tga")
        
        


        //等级预览
        CreateButton(651,Button.frameid,TYPE_NULL,0,Button.frameid,0,0.0103,-0.033,0.028,0.014,"war3mapImported\\alpha.tga")
        CreateText(651,Button.frameid,"centertext008",4,4,0.0,0.0,"等级")

        last = 651
        for i = 1,10
            CreateButton(610+i,Button.frameid,TYPE_NULL,3,BUTTON_Back[last][0],5,0.002,0.0,0.028,0.014,"war3mapImported\\UI_Pass_LevelBack.tga") 
            CreateText(610+i,Button.frameid,"centertext008",4,4,0.0,0.0,"|cff000000"+I2S(i)+"|r")
            last = 610+i
        end

        //普通通行证
        CreateButton(652,Button.frameid,TYPE_BUTTON,0,BUTTON_Back[651][0],6,0.0,-0.001,0.028,0.028,"replaceabletextures\\commandbuttons\\BTNTXZ01.blp")
        
        last = 652
        for i = 1,10
            CreateButton(620+i,Button.frameid,TYPE_BUTTON,3,BUTTON_Back[last][0],5,0.002,0.0,0.028,0.028,"war3mapImported\\alpha.tga") 
            last = 620+i
        end

        //超级通行证
        CreateButton(653,Button.frameid,TYPE_BUTTON,0,BUTTON_Back[652][0],6,0.0,-0.009,0.028,0.028,"replaceabletextures\\commandbuttons\\BTNTXZ02.blp")
        
        last = 653
        for i = 1,10
            CreateButton(630+i,Button.frameid,TYPE_BUTTON,3,BUTTON_Back[last][0],5,0.002,0.0,0.028,0.028,"war3mapImported\\alpha.tga") 
            last = 630+i
        end

 
        
        //当前等级
        CreateButton(650,Button.frameid,TYPE_NULL,0,BUTTON_Back[653][0],6,0.0,-0.01,0.028,0.028,"war3mapImported\\UI_Pass_LevelText.tga") 
        CreateText(650,Button.frameid,"centertext013",7,7,0.0,0.0,"|cffffcc008|r")
        last = 650
        for i = 1,MaxPassCheckDayExp
            CreateButton(600+i,Button.frameid,TYPE_NULL,3,BUTTON_Back[last][0],5,0.002,0.0,0.028,0.0093,"war3mapImported\\UI_Pass_Exp0.tga") 
            last = 600+i
        end
        


        //每日任务
        CreateButton(654,Button.frameid,TYPE_NULL,0,BUTTON_Back[653][0],6,0.0,-0.045,0.028,0.028,"war3mapImported\\UI_Pass_Text3.tga") 

        CreateButton(641,Button.frameid,TYPE_NULL,0,BUTTON_Back[654][0],2,0.002,0.0,0.14,0.042,"war3mapImported\\UI_Pass_MissionButton.tga") 
        CreateButton(642,Button.frameid,TYPE_NULL,0,BUTTON_Back[641][0],6,0.0,-0.005,0.14,0.042,"war3mapImported\\UI_Pass_MissionButton.tga") 

        CreateButton(643,Button.frameid,TYPE_NULL,0,BUTTON_Back[641][0],2,0.018,0.0,0.14,0.042,"war3mapImported\\UI_Pass_MissionButton.tga") 
        CreateButton(644,Button.frameid,TYPE_NULL,0,BUTTON_Back[643][0],6,0.0,-0.005,0.14,0.042,"war3mapImported\\UI_Pass_MissionButton.tga") 


        CreateText(641,Button.frameid,"righttext008",5,5,-0.005,0.0,"")
        CreateText(642,Button.frameid,"righttext008",5,5,-0.005,0.0,"")
        CreateText(643,Button.frameid,"righttext008",5,5,-0.005,0.0,"")
        CreateText(644,Button.frameid,"righttext008",5,5,-0.005,0.0,"")
        


        

        for i = 1,4
            CreateButton(680+i,Button.frameid,TYPE_NULL,3,BUTTON_Back[640+i][0],3,0.0,0.0,0.028,0.028,"war3mapImported\\UI_Pass_Text1.tga")
        end
        CreateText(681,Button.frameid,"text008",3,3,0.03,0.0,"|cff00ff00已完成|r")
        CreateText(682,Button.frameid,"text008",3,3,0.03,0.0,"|cff00ff00已完成|r")
        CreateText(683,Button.frameid,"text008",3,3,0.03,0.0,"|cff00ff00已完成|r")
        CreateText(684,Button.frameid,"text008",3,3,0.03,0.0,"|cff00ff00已完成|r")

        DzFrameSetSize(BUTTON_Text[681],0.08,0.0)
        DzFrameSetSize(BUTTON_Text[682],0.08,0.0)
        DzFrameSetSize(BUTTON_Text[683],0.08,0.0)
        DzFrameSetSize(BUTTON_Text[684],0.08,0.0)

        CreateButton(661,Button.frameid,TYPE_BUTTON,0,Button.frameid,1,-0.03,-0.012,0.015,0.015,"war3mapImported\\UI_Pass_Left.tga")
        CreateButton(662,Button.frameid,TYPE_BUTTON,2,Button.frameid,1,0.03,-0.012,0.015,0.015,"war3mapImported\\UI_Pass_Right.tga")


        CreateButton(671,Button.frameid,TYPE_BUTTON,8,Button.frameid,8,-0.02,0.005,0.03,0.03,"war3mapImported\\UI_S1.tga")

        CreateButton(672,Button.frameid,TYPE_BUTTON,8,Button.frameid,8,-0.06,0.005,0.03,0.03,"war3mapImported\\UI_S2.tga")

        CreateButton(673,Button.frameid,TYPE_BUTTON,8,Button.frameid,8,-0.1,0.005,0.03,0.03,"war3mapImported\\UI_S3.tga")
    endfunction

    function PassCheckUIInit()

        Button = FRAME.create() //背景注册
        Back = FRAME.create()   //注册主背景
        Key = FRAME.create()    //注册快捷键文本

        //控件设置
        Button.frameid = FRAME.Tag("BUTTON","Check",GameUI,Button)
        Button.SetPoint(4,GameUI,4,0,0)
        Button.SetSize(0.35,0.2875)
        origin = Button.frameid

        //背景设置
        Back.frameid = FRAME.Tag("BACKDROP","Check",origin,Back)
        Back.SetPoint(4,origin,4,0,0)
        Back.SetSize(0.35,0.2875)
        Back.SetTexture("war3mapImported\\UI_Pass_Back.tga",0)

        //设置快捷键文本
        Key.frameid = FRAME.Fdf("centertext010",origin,Key)
        Key.SetText("1/2")
        Key.SetPoint(1,Button.frameid ,1,0.0,-0.015)

        CreateFrameButton1()

        if  MissionDay >= 42
            Step = 2
        elseif  MissionDay >= 21
            Step = 1
        else
            Step = 0
        endif
        DzFrameSetTexture(BUTTON_Back[653][0],"replaceabletextures\\commandbuttons\\BTNTXZ0"+I2S(Step+2)+".blp",0)
        
        Button.show = false
    endfunction



endlibrary




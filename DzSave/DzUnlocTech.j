library UnlocTech initializer InitAllUnlocTech uses DamageCode
    
    int Unloc_Type_Level = 1
    int Unloc_Type_Load  = 2
    int Unloc_Type_Group = 3
    int Unloc_Type_Blue  = 4
    int Unloc_Type_Shop  = 5
    int Unloc_Type_JF    = 6
    int Unloc_Type_API   = 7
    int Unloc_Type_Dad   = 8
    int Unloc_Type_Test  = 9
    
    

    int Unloc_Type_LvRank = 12

    int Unloc_Type_Comment = 13
    int Unloc_Type_ShopNum = 14

    int Unloc_Type_Day51 = 51
    int Unloc_Type_Day61 = 61
    int Unloc_Type_HuYa = 50
    
    int array UnlocTechData_TechId
    int UnlocTechData_index = 0
    int UnlocTechData_index2 = 0
    int UnlocTechData_index3 = 0
    int UnlocTechData_index4 = 0
    
    int array HolidayChangeData[12][680]



    scope HuYaActivity
        private string array NameData
        private int NameMax = 0

        function AddHuYaName(string s)
            NameMax = NameMax + 1
            NameData[NameMax] = s
        endfunction
        function InitHuYaActivity()
            AddHuYaName("a沉默不语冷依然")
            AddHuYaName("a星耀丶沙果")
            AddHuYaName("a醉卧听风雨灬")
            AddHuYaName("aMvp丶小炎")
            AddHuYaName("aZzn我老婆")
            AddHuYaName("a阿库娅neru")
            AddHuYaName("a青春五点半")
            AddHuYaName("a星耀丶云牧歌")
            AddHuYaName("a战三国之大神")
            AddHuYaName("a剑昊")
            AddHuYaName("a嘟噜噜噜噜丶")
            AddHuYaName("a魔法少女莉莉周")
            AddHuYaName("a端木佳慧")
            AddHuYaName("a林MMMMM")
            AddHuYaName("a秦王走位")
            AddHuYaName("a偏执的沁")
            AddHuYaName("a星耀丶酒仙呐")
            AddHuYaName("a凤求凰灬李白")
            AddHuYaName("a好多版本狗")
            AddHuYaName("a防蚊贴")
            AddHuYaName("a磊仔菜J")
            AddHuYaName("a邬天莹")
            AddHuYaName("a别叫我隐十")
            AddHuYaName("a星悦丶丨怵丨")
            AddHuYaName("a至臻丶白鲨")
            AddHuYaName("aflack")
            AddHuYaName("a红桃づ")
            AddHuYaName("a星耀、梦里陌")
            AddHuYaName("a乔碧萝（殿下）")
            AddHuYaName("aksq123")
            AddHuYaName("a蜡萌小新")
            AddHuYaName("a风之雨010")
            AddHuYaName("a青马培训员")
            AddHuYaName("a巩秋莲")
            AddHuYaName("a深沉的景承嗣")
            AddHuYaName("a吃芒果的虾扯蛋")
            AddHuYaName("aWrysunny。")
            AddHuYaName("a星耀咕咕鸡")
            AddHuYaName("a星耀丶Maple")
            AddHuYaName("a声声520")
            AddHuYaName("a凛冬初雪")
            AddHuYaName("a贼懒的树袋熊")
            AddHuYaName("a星耀丶摇头驴")
            AddHuYaName("aあ狂あ")
            AddHuYaName("a牛BBB")
            AddHuYaName("a星耀丶西瓜")
            AddHuYaName("a星耀丶懒哟")
            AddHuYaName("a白梦仙")
            AddHuYaName("aV丶3UMY8O")
            AddHuYaName("a苏杭大棒子啪啪啪")
            AddHuYaName("a沐北清歌瀚丶")
            AddHuYaName("at涛jr大")
            AddHuYaName("a乳尺惊人")
            AddHuYaName("a蓝丁素客")
            AddHuYaName("a星耀丶大圣人")
            AddHuYaName("a嗯，同意")
            AddHuYaName("a人王伏羲")
            AddHuYaName("a对象的祖宗")
            AddHuYaName("aChen独秀你坐下")
            AddHuYaName("astark222")
            AddHuYaName("aDemon陽")
            AddHuYaName("a苍月澜")
            AddHuYaName("a麻辣帝君")
            AddHuYaName("a1717171717171717")
            AddHuYaName("a星耀丶赞恩")
            AddHuYaName("a盖世猫咪")
            AddHuYaName("a星耀丶 记忆天籁")
            AddHuYaName("a云牧歌丶")
            AddHuYaName("a雷咯")
            AddHuYaName("a昭阳辞落日")
            AddHuYaName("a星悦丶爱笑")
            AddHuYaName("a至臻丶玉溪")
            AddHuYaName("a日暮旅人")
            AddHuYaName("a哈滴")
            AddHuYaName("a星耀丶陌心")
            AddHuYaName("a星耀丶摸比")
            AddHuYaName("a星耀丶祁一")
            AddHuYaName("a星耀迪欧")
            AddHuYaName("a星耀丶记忆的天籁")
            AddHuYaName("a恒总GZ")
            AddHuYaName("a星耀丶怀旧y")
            AddHuYaName("aY西瓜Y")
            AddHuYaName("a红笔写黑字")
            AddHuYaName("a这丿真灬有丶意思")
            AddHuYaName("a星耀丶脸白")
            AddHuYaName("a再青春")
            AddHuYaName("a万象天成丶")
            AddHuYaName("a星耀丶基陛大帝")
            AddHuYaName("a西楼丷丷")
            AddHuYaName("a星耀丶木头")
            AddHuYaName("a维多利亚彪哥")
            AddHuYaName("a七彩箐紫越")
            AddHuYaName("a左小染")
            AddHuYaName("a都是弟弟ii")
            AddHuYaName("a星耀丶博士")
            AddHuYaName("a星耀丶白痴")
            AddHuYaName("a星耀丶紫苑")
            AddHuYaName("a星耀丶硬邦邦")
            AddHuYaName("a星耀丶紫翼")
            AddHuYaName("a松zm")
            AddHuYaName("a星耀丶15逆")
            AddHuYaName("aHuangNinja")
            AddHuYaName("a星耀丶锋雪")
            AddHuYaName("a璐哥二号")
            AddHuYaName("a暗之殇珩")
            AddHuYaName("a星悦丶莫忆")
            AddHuYaName("a大鹏魔头")
            AddHuYaName("a尝尽温柔了吗")
            AddHuYaName("a（浪）")
            AddHuYaName("a神王出世")
            AddHuYaName("a星悦丶影魔")
            AddHuYaName("a星耀丶Lee")
            AddHuYaName("a丶大人物")
            AddHuYaName("a星耀丶地狱")
            AddHuYaName("a药药00")
            AddHuYaName("a堕落111")
            AddHuYaName("a无聊的阿西吧")
            AddHuYaName("a一泽啊")
            AddHuYaName("a荷里话大盗")
            AddHuYaName("aMm2651")
            AddHuYaName("a星耀丶猛猛打")
            AddHuYaName("a星悦丶巅峰对决")
            AddHuYaName("a无法撼动的决心")
            AddHuYaName("a星耀丶微风")
            AddHuYaName("a怎堪丶")
            AddHuYaName("a星耀丶淘气")
            AddHuYaName("a星耀丶原痕")
            AddHuYaName("a浮生—若梦")
            AddHuYaName("a、大人物")
            AddHuYaName("aWrysunny。")
            AddHuYaName("a温州热心市民")
            AddHuYaName("aMvp丶小炎")
            AddHuYaName("a麒麒77")
            AddHuYaName("a鬼舞辻無慘")
            AddHuYaName("a恒总Gz")
            AddHuYaName("a都是垃圾啊")
            AddHuYaName("a星耀丶樱月幻")
            AddHuYaName("a再見青春")
            AddHuYaName("a汪涛的大哥")
            AddHuYaName("aぁ狂ぁ")
            AddHuYaName("a番哥大魔王")

            
        endfunction
        function IsPlayerHuYa(int pid)->bool
            int max = NameMax
            string name = "a" + GetPlayerName(Player(pid))
            for i = 1,max
                if  name == NameData[i]
                    return true
                endif
            end
            return false
        endfunction

        
        


    endscope



    function IsPlayerInRank(int pid,int data)->bool
        int n = DzAPI_Map_GetMapLevelRank(Player(pid))
        if  n <= data
            if  n == 0
                return false
            else
                return true
            endif
        endif
        return false
    endfunction


    scope UnlocTechGameData
        private int array Data_list
        private int array Data_pos
        private int array Data_data
        
        private int array Data_UseList
        private int array Data_UsePos
        private int array Data_Use
        
        private int Data_index = 0
        
        function GameDataList(int list,int pos,int data)->int
            Data_index = Data_index + 1
            
            Data_pos[Data_index]  = pos
            Data_list[Data_index] = list
            Data_data[Data_index] = data
            return Data_index
        endfunction
        
        function GameDataCanUnloc(int pid,int index)->bool
            int list = Data_list[index]
            int data = Data_data[index]
            int pos  = Data_pos[index]
            return GetDzPlayerData(pid,list,pos) == data
        endfunction
        function JFCanUnloc(int pid,int index)->bool
            int list = Data_list[index]
            int data = Data_data[index]
            int pos  = Data_pos[index]
            BJDebugMsg("积分"+I2S(GetDzPlayerData(pid,list,pos)))
            return GetDzPlayerData(pid,list,pos) >= data
        endfunction
    endscope
    
    
    scope UnlocTechShop
        private string array Data_Shop
        private int Data_index = 0
        function ShopList(string shop)->int
            Data_index = Data_index + 1
            Data_Shop[Data_index]=shop
            return Data_index
        endfunction
        function ShopCanUnloc(int pid,int index)->bool
            return DzShop(Player(pid),Data_Shop[index])==true
        endfunction
        
        function AllShopUnloc(int pid,int data)->bool
            int num = GetPlayerBuyShopNumber(pid)
            return num >= data
        endfunction
        
    endscope
    
    scope UnlocTechGroup
        private string array Data_Group
        private int array Data_Level
        private int Data_index = 0
        function GroupList(string Group,int level)->int
            Data_index = Data_index + 1
            Data_Group[Data_index]=Group
            Data_Level[Data_index]=level
            return Data_index
        endfunction
        function GroupCanUnloc(int pid,int index)->bool
            
            if  DzAPI_Map_GetGuildName(Player(pid))==Data_Group[index]
                return DzAPI_Map_GetGuildRole(Player(pid)) >=  Data_Level[index]
            endif
            return false
        endfunction
    endscope
    
    scope LocalTechCond
        private int array Data_Type
        private int array Data_Data
        private int array Data_Cond
        function LoadUnlocTechCond(int id,int index)
            int listid = 0
            
            if  index != 0
                listid = index+Data_Cond[index]*10
                //BJDebugMsg("listid:"+I2S(listid))
                SetTypeIdData(id,500+listid,Data_Type[index])
                SetTypeIdData(id,600+listid,Data_Data[index])
                Data_Cond[index]= 0
                Data_Type[index]= 0
                Data_Data[index]= 0
            endif
            
        endfunction
        
        function InitCond1(int cond,int typeid,int data)->int
            int index = 1
            
            Data_Cond[index]= cond
            Data_Type[index]= typeid
            Data_Data[index]= data
            
            return index
        endfunction
        function InitCond2(int cond,int typeid,int data)->int
            int index = 2
            Data_Cond[index]= cond
            Data_Type[index]= typeid
            Data_Data[index]= data
            return index
        endfunction
        function InitCond3(int cond,int typeid,int data)->int
            int index = 3
            Data_Cond[index]= cond
            Data_Type[index]= typeid
            Data_Data[index]= data
            return index
        endfunction
        function InitCond4(int cond,int typeid,int data)->int
            int index = 4
            Data_Cond[index]= cond
            Data_Type[index]= typeid
            Data_Data[index]= data
            return index
        endfunction
        function InitCond5(int cond,int typeid,int data)->int
            int index = 5
            Data_Cond[index]= cond
            Data_Type[index]= typeid
            Data_Data[index]= data
            return index
        endfunction
    endscope
    
    
    
    function IsConditionsUnloc(int pid,int Type,int data)->bool
        if  savebool == true
            return true
        endif
        if  Type == Unloc_Type_Level
            BJDebugMsg("等级判断 需求："+I2S(data))
            return DzPlayerLv(Player(pid))>= data
        elseif  Type == Unloc_Type_Load
            return GameDataCanUnloc(pid,data) == true
        elseif  Type == Unloc_Type_Group
            return GroupCanUnloc(pid,data) == true
        elseif  Type == Unloc_Type_Blue
            return DzAPI_Map_IsBlueVIP(Player(pid)) == true
        elseif  Type == Unloc_Type_Shop
            return ShopCanUnloc(pid,data)==true
        elseif  Type == Unloc_Type_JF
            BJDebugMsg("积分判断 需求："+I2S(data))
            return JFCanUnloc(pid,data)==true
        elseif  Type == Unloc_Type_API
            return DzConA[data] == 1
        elseif  Type == Unloc_Type_Dad
            return AllShopUnloc(pid,data)==true
        elseif  Type == Unloc_Type_LvRank
            return IsPlayerInRank(pid,data)
        elseif  Type == Unloc_Type_Test
            return DzAPI_Map_GetServerValue(Player(pid), "maptest2020") == "1" or DzAPI_Map_GetServerValue(Player(pid), "preset_map_award") == "1"
        elseif  Type == Unloc_Type_Comment
            return DzAPI_Map_CommentCount(Player(pid)) > 0
        elseif  Type == Unloc_Type_Day51
            return Holiday51 >= data
        elseif  Type == Unloc_Type_Day61
            return Holiday61 >= data
        elseif  Type == Unloc_Type_ShopNum
            return DzMallNum(Player(pid),"WXBZ") >=data
        elseif  Type == Unloc_Type_HuYa
            return IsPlayerHuYa((pid)) == true
        endif
        return false
    endfunction
    
    function IsPlayerUnlocTech(int pid,int id)->bool
        int Type = 0
        int data = 0
        

        
        
        
        //绝对条件
        for i = 1,5
            Type =  GetTypeIdData(id,520+i)
            if  Type > 0
                //BJDebugMsg("绝对条件")
                data = GetTypeIdData(id,620+i)
                if  IsConditionsUnloc(pid,Type,data) == true
                    return true
                endif
            endif
        end
        
        
        //必要条件
        for i = 1,5
            Type =  GetTypeIdData(id,510+i)
            if  Type > 0
                //BJDebugMsg("必要条件")
                data = GetTypeIdData(id,610+i)
                if  IsConditionsUnloc(pid,Type,data) == false
                    return false
                endif
            endif
        end
        
        
        for i = 1,5
            Type =  GetTypeIdData(id,500+i)
            if  Type > 0
                //BJDebugMsg("通用条件")
                data = GetTypeIdData(id,600+i)
                if  IsConditionsUnloc(pid,Type,data) == true
                    return true
                endif
            endif
        end
            
        
        return false
    endfunction
    
    function LoadPlayerTechState4(int pid)
        int id = 0
        int min = UnlocTechData_index4+1
        int max = UnlocTechData_index
        for i = min,max
            id = UnlocTechData_TechId[i]
            if  IsPlayerHasTech(Player(pid),id) == true
                AddEquipState(Pu[1],id)
            endif
            //BJDebugMsg(I2S(id))
        end
        BJDebugMsg("加属性"+I2S(min)+":"+I2S(max))
    endfunction
    function LoadPlayerTechState3(int pid)
        int id = 0
        int min = UnlocTechData_index3+1
        int max = UnlocTechData_index4
        for i = min,max
            id = UnlocTechData_TechId[i]
            if  IsPlayerHasTech(Player(pid),id) == true
                AddEquipState(Pu[1],id)
            endif
            //BJDebugMsg(I2S(id))
        end
        BJDebugMsg("加属性"+I2S(min)+":"+I2S(max))
    endfunction
    function LoadPlayerTechState2(int pid)
        int id = 0
        int min = UnlocTechData_index2+1
        int max = UnlocTechData_index3
        for i = min,max
            id = UnlocTechData_TechId[i]
            if  IsPlayerHasTech(Player(pid),id) == true
                AddEquipState(Pu[1],id)
            endif
            //BJDebugMsg(I2S(id))
        end
        BJDebugMsg("加属性"+I2S(min)+":"+I2S(max))
    endfunction

    function LoadPlayerTechState1(int pid)
        int id = 0
        int min = 1
        int max = UnlocTechData_index2
        for i = min,max
            id = UnlocTechData_TechId[i]
            if  IsPlayerHasTech(Player(pid),id) == true
                AddEquipState(Pu[1],id)
            endif
            //BJDebugMsg(I2S(id))
        end
        BJDebugMsg("加属性"+I2S(min)+":"+I2S(max))
    endfunction
    
    
    function LoadPlayerTechState(int pid)
        LoadPlayerTechState1.execute(pid)
        LoadPlayerTechState2.execute(pid)
        LoadPlayerTechState3.execute(pid)
        LoadPlayerTechState4.execute(pid)
    endfunction
    

    function LoadPlayerAllUnlocTech4(int pid)
        int min = UnlocTechData_index4+1
        int max = UnlocTechData_index
        if  GetPlayerController(Player(pid)) == MAP_CONTROL_USER and GetPlayerSlotState(Player(pid)) == PLAYER_SLOT_STATE_PLAYING
            for i = min,max
                if  IsPlayerUnlocTech(pid,UnlocTechData_TechId[i]) == true
                    SetPlayerTechResearched(Player(pid),UnlocTechData_TechId[i],1)
                    //BJDebugMsg("unlock"+GetObjectName(UnlocTechData_TechId[i]))
                else
                    //BJDebugMsg("lock"+I2S(UnlocTechData_TechId[i]))
                endif
            end
            BJDebugMsg("读存档"+I2S(min)+":"+I2S(max))
        endif
        
    endfunction
    function LoadPlayerAllUnlocTech3(int pid)
        int min = UnlocTechData_index3+1
        int max = UnlocTechData_index4
        if  GetPlayerController(Player(pid)) == MAP_CONTROL_USER and GetPlayerSlotState(Player(pid)) == PLAYER_SLOT_STATE_PLAYING
            for i = min,max
                if  IsPlayerUnlocTech(pid,UnlocTechData_TechId[i]) == true
                    SetPlayerTechResearched(Player(pid),UnlocTechData_TechId[i],1)
                    //BJDebugMsg("unlock"+GetObjectName(UnlocTechData_TechId[i]))
                else
                    //BJDebugMsg("lock"+I2S(UnlocTechData_TechId[i]))
                endif
            end
            BJDebugMsg("读存档"+I2S(min)+":"+I2S(max))
        endif
        
    endfunction
    function LoadPlayerAllUnlocTech2(int pid)
        int min = UnlocTechData_index2+1
        int max = UnlocTechData_index3
        if  GetPlayerController(Player(pid)) == MAP_CONTROL_USER and GetPlayerSlotState(Player(pid)) == PLAYER_SLOT_STATE_PLAYING
            for i = min,max
                if  IsPlayerUnlocTech(pid,UnlocTechData_TechId[i]) == true
                    SetPlayerTechResearched(Player(pid),UnlocTechData_TechId[i],1)
                    //BJDebugMsg("unlock"+GetObjectName(UnlocTechData_TechId[i]))
                else
                    //BJDebugMsg("lock"+I2S(UnlocTechData_TechId[i]))
                endif
            end
            BJDebugMsg("读存档"+I2S(min)+":"+I2S(max))
        endif
        
    endfunction
    function LoadPlayerAllUnlocTech1(int pid)
        int min = 1
        int max = UnlocTechData_index2
        if  GetPlayerController(Player(pid)) == MAP_CONTROL_USER and GetPlayerSlotState(Player(pid)) == PLAYER_SLOT_STATE_PLAYING
            for i = min,max
                if  IsPlayerUnlocTech(pid,UnlocTechData_TechId[i]) == true
                    SetPlayerTechResearched(Player(pid),UnlocTechData_TechId[i],1)
                    //BJDebugMsg("unlock"+GetObjectName(UnlocTechData_TechId[i]))
                else
                    //BJDebugMsg("lock"+I2S(UnlocTechData_TechId[i]))
                endif
            end
            BJDebugMsg("读存档"+I2S(min)+":"+I2S(max))
        endif
    endfunction

    function LoadPlayerAllUnlocTech(int pid)
        LoadPlayerAllUnlocTech1.execute(pid)
        LoadPlayerAllUnlocTech2.execute(pid)
        LoadPlayerAllUnlocTech3.execute(pid)
        LoadPlayerAllUnlocTech4.execute(pid)
    endfunction
    
    
    function InitUnlocTechConditions(int id,int Cond1,int Cond2,int Cond3,int Cond4,int Cond5)
        UnlocTechData_index = UnlocTechData_index + 1
        UnlocTechData_TechId[UnlocTechData_index] = id
        
        
        LoadUnlocTechCond(id,Cond1)
        
        LoadUnlocTechCond(id,Cond2)
        
        LoadUnlocTechCond(id,Cond3)
        
        LoadUnlocTechCond(id,Cond4)
        
        LoadUnlocTechCond(id,Cond5)

    endfunction
    
    //InitCond1(1,Unloc_Type_Level,0)
    scope ExChange
        private int array Data_Int[1000][7]
        private int Data_index = 0
        #define data_list       Data_Int[index][1]
        #define data_pos        Data_Int[index][2]
        #define data_uselist    Data_Int[index][3]
        #define data_usepos     Data_Int[index][4]
        #define data_use        Data_Int[index][5]
        #define data_data       Data_Int[index][6]
        #define data_level      Data_Int[index][7]
        
        function IsCanExChange(int pid,int itemid)->bool
            int index = GetTypeIdData(itemid,0x10010)
            int list = data_list
            int pos = data_pos
            int data = data_data
            int Get = GetDzPlayerData(pid,list,pos)
            if  Get == 0 or Get != data
                return true
            endif
            return false
        endfunction
        function IsHasExChange(int pid,int itemid)->bool
            int index = GetTypeIdData(itemid,0x10010)
            int list = data_list
            int pos = data_pos
            return GetDzPlayerData(pid,list,pos) >= 1
        endfunction
        function ExChangeItem(int pid,int itemid)->bool
            int index = GetTypeIdData(itemid,0x10010)
            int list = data_list
            int pos = data_pos
            int uselist = data_uselist
            int usepos = data_usepos
            int use = data_use
            int data = data_data
            int level = data_level
            
            if  DzPlayerLv(Player(pid)) >= level
                if  GetDzPlayerData(pid,uselist,usepos) >= use
                    AddDzPlayerData(pid,uselist,usepos,-use)
                    SetDzPlayerData(pid,list,pos,data)
                    DisplayTimedTextToPlayer(Player(pid),0,0,5,"|cffffcc00[系统]|r:兑换成功！重新进入游戏生效！")
                    return true
                else
                    DisplayTimedTextToPlayer(Player(pid),0,0,5,"|cffffcc00[系统]|r:兑换失败！积分不足"+I2S(use))
                    return false
                endif
            else
                DisplayTimedTextToPlayer(Player(pid),0,0,5,"|cffffcc00[系统]|r:兑换失败！等级不足"+I2S(level))
                return false
            endif
        endfunction
        

        function ReExChangeTips(int pid,int itemid)
            int index = GetTypeIdData(itemid,0x10010)
            int id = itemid + 0x9000000
            string tip = ""

            if  GetDzPlayerData(pid,data_uselist,data_usepos) >= data_use
                tip = tip + "需求：|cff00ff00"+I2S(data_use)
            else
                tip = tip + "需求：|cffff0000"+I2S(data_use)
            endif
            

            if  data_uselist == 2
                if  data_usepos == 1
                    tip = tip + "|r 通关积分且地图"
                elseif  data_usepos == 4
                    tip = tip + "|r 异变积分且地图"
                endif
            endif

            if  DzPlayerLv(Player(pid)) >= data_level
                tip = tip +" |cff00ff00"+I2S(data_level)+" |r级\n\n|cffffcc00属性：|r"
            else
                tip = tip +" |cffff0000"+I2S(data_level)+" |r级\n\n|cffffcc00属性：|r"
            endif
            

            tip = tip + GetTypeIdStateTips(id)+GetTypeIdTips(id)
            if  GetLocalPlayer() == Player(pid)
                YDWESetItemDataString(itemid,3,tip)
            endif
            BJDebugMsg(YDWEId2S(id))
            BJDebugMsg(tip)
        endfunction
        
        function ExChangeList(int itemid,int level ,int uselist,int usepos,int use,int list,int pos,int data)->int
            Data_index = Data_index + 1
            int index = Data_index
            data_level = level
            data_list = list
            data_pos = pos
            data_uselist = uselist
            data_usepos = usepos
            data_use = use
            data_data = data
            SetTypeIdData(itemid,0x10010,Data_index)
            return Data_index
        endfunction
        
        #undef data_list
        #undef data_pos
        #undef data_UseList
        #undef data_UsePos
        #undef data_Use
        #undef data_data
        #undef data_level
    endscope


    //科技注册
    function InitAllUnlocTechFunc1()    

        InitUnlocTechConditions('RL01',InitCond1(2,Unloc_Type_Dad,16),0,0,0,0)
        
        InitUnlocTechConditions('RJ1Z',InitCond1(2,Unloc_Type_Shop,ShopList("LB6")),0,0,0,0)

        //商城
        InitUnlocTechConditions('RY1D',InitCond1(2,Unloc_Type_Shop,ShopList("GH1")),0,0,0,0)
        InitUnlocTechConditions('RY2D',InitCond1(2,Unloc_Type_Shop,ShopList("CB1")),0,0,0,0)
        InitUnlocTechConditions('RY3D',InitCond1(2,Unloc_Type_Shop,ShopList("WQ1")),0,0,0,0)
        InitUnlocTechConditions('RY4D',InitCond1(2,Unloc_Type_Shop,ShopList("CH1")),0,0,0,0)
        InitUnlocTechConditions('RK1A',InitCond1(2,Unloc_Type_Shop,ShopList("CW1")),0,0,0,0)
        InitUnlocTechConditions('RJ1U',InitCond1(2,Unloc_Type_Shop,ShopList("LB1")),0,0,0,0)
        InitUnlocTechConditions('RJ1V',InitCond1(2,Unloc_Type_Shop,ShopList("LB2")),0,0,0,0)
        InitUnlocTechConditions('RJ1W',InitCond1(2,Unloc_Type_Shop,ShopList("LB3")),0,0,0,0)
        
        InitUnlocTechConditions('RJ1X',InitCond1(2,Unloc_Type_Shop,ShopList("LB4")),0,0,0,0)
        InitUnlocTechConditions('RY2G',InitCond1(2,Unloc_Type_Shop,ShopList("CB2")),0,0,0,0)
        InitUnlocTechConditions('RP1A',InitCond1(2,Unloc_Type_Shop,ShopList("PF1")),0,0,0,0)
        InitUnlocTechConditions('RY3F',InitCond1(2,Unloc_Type_Shop,ShopList("WQ2")),0,0,0,0)

        InitUnlocTechConditions('RJ1Y',InitCond1(2,Unloc_Type_Shop,ShopList("LB5")),0,0,0,0)
        InitUnlocTechConditions('RJ1Z',InitCond1(2,Unloc_Type_Shop,ShopList("LB6")),0,0,0,0)
        InitUnlocTechConditions('RJ1P',InitCond1(2,Unloc_Type_Shop,ShopList("LB7")),0,0,0,0)
        

        InitUnlocTechConditions('RTX1',InitCond1(2,Unloc_Type_Shop,ShopList("RWK")),0,0,0,0)
        InitUnlocTechConditions('RTX2',InitCond1(2,Unloc_Type_Shop,ShopList("RWK2")),0,0,0,0)
        InitUnlocTechConditions('RTX3',InitCond1(2,Unloc_Type_Shop,ShopList("RWK3")),0,0,0,0)
        InitUnlocTechConditions('RTX4',InitCond1(2,Unloc_Type_Shop,ShopList("RWK4")),0,0,0,0)
        

        InitUnlocTechConditions('RQD0',InitCond1(2,Unloc_Type_Level,1),0,0,0,0)


        
                
        


        //成就  
        InitUnlocTechConditions('RJ2N',InitCond1(2,Unloc_Type_Level,1),0,0,0,0)
        InitUnlocTechConditions('RJ1I',InitCond1(2,Unloc_Type_Level,1),0,0,0,0)
        InitUnlocTechConditions('RJ1L',InitCond1(2,Unloc_Type_Level,1),0,0,0,0)
        InitUnlocTechConditions('RJ1A',InitCond1(2,Unloc_Type_Level,2),0,0,0,0)
        InitUnlocTechConditions('RJ1B',InitCond1(2,Unloc_Type_Level,3),0,0,0,0)
        InitUnlocTechConditions('RJ1C',InitCond1(2,Unloc_Type_Level,5),0,0,0,0)
        InitUnlocTechConditions('RJ1D',InitCond1(2,Unloc_Type_Level,8),0,0,0,0)
        InitUnlocTechConditions('RJ1E',InitCond1(2,Unloc_Type_Level,10),0,0,0,0)
        InitUnlocTechConditions('RJ1F',InitCond1(2,Unloc_Type_Level,12),0,0,0,0)
        InitUnlocTechConditions('RJ1G',InitCond1(2,Unloc_Type_Level,15),0,0,0,0)
        InitUnlocTechConditions('RJ1H',InitCond1(2,Unloc_Type_Level,20),0,0,0,0)
        InitUnlocTechConditions('RJ1J',InitCond1(2,Unloc_Type_Level,24),0,0,0,0)
        InitUnlocTechConditions('RJ1K',InitCond1(2,Unloc_Type_Level,27),0,0,0,0)
        InitUnlocTechConditions('RJ1M',InitCond1(2,Unloc_Type_Level,30),0,0,0,0)
        InitUnlocTechConditions('RJ1N',InitCond1(2,Unloc_Type_Level,33),0,0,0,0)
        InitUnlocTechConditions('RJ1O',InitCond1(2,Unloc_Type_Level,45),0,0,0,0)


        //全民竞速
        InitUnlocTechConditions('RJ2O',InitCond1(1,Unloc_Type_Level,1),InitCond2(0,Unloc_Type_JF,GameDataList(2,8,1)),0,0,0)
        InitUnlocTechConditions('RY4W',InitCond1(1,Unloc_Type_Level,1),InitCond2(0,Unloc_Type_JF,GameDataList(2,8,1)),0,0,0)
        InitUnlocTechConditions('RY4V',InitCond1(2,Unloc_Type_HuYa,0),0,0,0,0)
        


        set UnlocTechData_index2 = UnlocTechData_index


        InitUnlocTechConditions('RGAA',InitCond1(1,Unloc_Type_Level,3),InitCond2(0,Unloc_Type_JF,GameDataList(17,2,1)),0,0,0)
        InitUnlocTechConditions('RGAB',InitCond1(1,Unloc_Type_Level,3),InitCond2(0,Unloc_Type_JF,GameDataList(17,3,1)),0,0,0)
        InitUnlocTechConditions('RGAC',InitCond1(1,Unloc_Type_Level,5),InitCond2(0,Unloc_Type_JF,GameDataList(17,4,1)),0,0,0)
        InitUnlocTechConditions('RGAD',InitCond1(1,Unloc_Type_Level,7),InitCond2(0,Unloc_Type_JF,GameDataList(17,5,1)),0,0,0)
        InitUnlocTechConditions('RGAE',InitCond1(1,Unloc_Type_Level,9),InitCond2(0,Unloc_Type_JF,GameDataList(17,6,1)),0,0,0)
        InitUnlocTechConditions('RGAF',InitCond1(1,Unloc_Type_Level,10),InitCond2(0,Unloc_Type_JF,GameDataList(17,7,1)),0,0,0)
        InitUnlocTechConditions('RGAG',InitCond1(1,Unloc_Type_Level,12),InitCond2(0,Unloc_Type_JF,GameDataList(17,8,1)),0,0,0)
        InitUnlocTechConditions('RGAH',InitCond1(1,Unloc_Type_Level,14),InitCond2(0,Unloc_Type_JF,GameDataList(17,9,1)),0,0,0)
        InitUnlocTechConditions('RGAI',InitCond1(1,Unloc_Type_Level,15),InitCond2(0,Unloc_Type_JF,GameDataList(17,10,1)),0,0,0)
        InitUnlocTechConditions('RGAJ',InitCond1(1,Unloc_Type_Level,16),InitCond2(0,Unloc_Type_JF,GameDataList(17,11,1)),0,0,0)
        InitUnlocTechConditions('RGAK',InitCond1(1,Unloc_Type_Level,16),InitCond2(0,Unloc_Type_JF,GameDataList(17,12,1)),0,0,0)

        InitUnlocTechConditions('RGBA',InitCond1(1,Unloc_Type_Level,3),InitCond2(0,Unloc_Type_JF,GameDataList(20,2,1)),0,0,0)
        InitUnlocTechConditions('RGBB',InitCond1(1,Unloc_Type_Level,3),InitCond2(0,Unloc_Type_JF,GameDataList(20,3,1)),0,0,0)
        InitUnlocTechConditions('RGBC',InitCond1(1,Unloc_Type_Level,5),InitCond2(0,Unloc_Type_JF,GameDataList(20,4,1)),0,0,0)
        InitUnlocTechConditions('RGBD',InitCond1(1,Unloc_Type_Level,7),InitCond2(0,Unloc_Type_JF,GameDataList(20,5,1)),0,0,0)
        InitUnlocTechConditions('RGBE',InitCond1(1,Unloc_Type_Level,9),InitCond2(0,Unloc_Type_JF,GameDataList(20,6,1)),0,0,0)
        InitUnlocTechConditions('RGBF',InitCond1(1,Unloc_Type_Level,10),InitCond2(0,Unloc_Type_JF,GameDataList(20,7,1)),0,0,0)
        InitUnlocTechConditions('RGBG',InitCond1(1,Unloc_Type_Level,12),InitCond2(0,Unloc_Type_JF,GameDataList(20,8,1)),0,0,0)
        /*
        InitUnlocTechConditions('RGBH',InitCond1(1,Unloc_Type_Level,14),InitCond2(0,Unloc_Type_JF,GameDataList(20,9,1)),0,0,0)
        InitUnlocTechConditions('RGBI',InitCond1(1,Unloc_Type_Level,15),InitCond2(0,Unloc_Type_JF,GameDataList(20,10,1)),0,0,0)
        */
        InitUnlocTechConditions('RGCA',InitCond1(1,Unloc_Type_Level,3),InitCond2(0,Unloc_Type_JF,GameDataList(20,2,8)),0,0,0)
        InitUnlocTechConditions('RGCB',InitCond1(1,Unloc_Type_Level,3),InitCond2(0,Unloc_Type_JF,GameDataList(20,3,8)),0,0,0)
        InitUnlocTechConditions('RGCC',InitCond1(1,Unloc_Type_Level,5),InitCond2(0,Unloc_Type_JF,GameDataList(20,4,8)),0,0,0)
        InitUnlocTechConditions('RGCD',InitCond1(1,Unloc_Type_Level,7),InitCond2(0,Unloc_Type_JF,GameDataList(20,5,8)),0,0,0)
        InitUnlocTechConditions('RGCE',InitCond1(1,Unloc_Type_Level,9),InitCond2(0,Unloc_Type_JF,GameDataList(20,6,8)),0,0,0)
        InitUnlocTechConditions('RGCF',InitCond1(1,Unloc_Type_Level,10),InitCond2(0,Unloc_Type_JF,GameDataList(20,7,8)),0,0,0)
        InitUnlocTechConditions('RGCG',InitCond1(1,Unloc_Type_Level,12),InitCond2(0,Unloc_Type_JF,GameDataList(20,8,8)),0,0,0)
        /*
        InitUnlocTechConditions('RGCH',InitCond1(1,Unloc_Type_Level,14),InitCond2(0,Unloc_Type_JF,GameDataList(20,9,8)),0,0,0)
        InitUnlocTechConditions('RGCI',InitCond1(1,Unloc_Type_Level,15),InitCond2(0,Unloc_Type_JF,GameDataList(20,10,8)),0,0,0)
        */
        InitUnlocTechConditions('RGDA',InitCond1(1,Unloc_Type_Level,3),InitCond2(0,Unloc_Type_JF,GameDataList(20,2,15)),0,0,0)
        InitUnlocTechConditions('RGDB',InitCond1(1,Unloc_Type_Level,3),InitCond2(0,Unloc_Type_JF,GameDataList(20,3,15)),0,0,0)
        InitUnlocTechConditions('RGDC',InitCond1(1,Unloc_Type_Level,5),InitCond2(0,Unloc_Type_JF,GameDataList(20,4,15)),0,0,0)
        InitUnlocTechConditions('RGDD',InitCond1(1,Unloc_Type_Level,7),InitCond2(0,Unloc_Type_JF,GameDataList(20,5,15)),0,0,0)
        InitUnlocTechConditions('RGDE',InitCond1(1,Unloc_Type_Level,9),InitCond2(0,Unloc_Type_JF,GameDataList(20,6,15)),0,0,0)
        InitUnlocTechConditions('RGDF',InitCond1(1,Unloc_Type_Level,10),InitCond2(0,Unloc_Type_JF,GameDataList(20,7,15)),0,0,0)
        InitUnlocTechConditions('RGDG',InitCond1(1,Unloc_Type_Level,12),InitCond2(0,Unloc_Type_JF,GameDataList(20,8,15)),0,0,0)

        


        InitUnlocTechConditions('RG0B',InitCond1(1,Unloc_Type_Level,3),InitCond2(0,Unloc_Type_JF,GameDataList(3,3,5)),0,0,0)
        InitUnlocTechConditions('RG0C',InitCond1(1,Unloc_Type_Level,5),InitCond2(0,Unloc_Type_JF,GameDataList(3,4,5)),0,0,0)
        InitUnlocTechConditions('RG0D',InitCond1(1,Unloc_Type_Level,7),InitCond2(0,Unloc_Type_JF,GameDataList(3,5,5)),0,0,0)
        InitUnlocTechConditions('RG0E',InitCond1(1,Unloc_Type_Level,9),InitCond2(0,Unloc_Type_JF,GameDataList(3,6,5)),0,0,0)
        InitUnlocTechConditions('RG0F',InitCond1(1,Unloc_Type_Level,10),InitCond2(0,Unloc_Type_JF,GameDataList(3,7,5)),0,0,0)
        InitUnlocTechConditions('RG0G',InitCond1(1,Unloc_Type_Level,12),InitCond2(0,Unloc_Type_JF,GameDataList(3,8,5)),0,0,0)
        InitUnlocTechConditions('RG0H',InitCond1(1,Unloc_Type_Level,14),InitCond2(0,Unloc_Type_JF,GameDataList(3,9,5)),0,0,0)
        InitUnlocTechConditions('RG0I',InitCond1(1,Unloc_Type_Level,15),InitCond2(0,Unloc_Type_JF,GameDataList(3,10,5)),0,0,0)
        InitUnlocTechConditions('RG0J',InitCond1(1,Unloc_Type_Level,16),InitCond2(0,Unloc_Type_JF,GameDataList(3,11,5)),0,0,0)
        InitUnlocTechConditions('RG0K',InitCond1(1,Unloc_Type_Level,16),InitCond2(0,Unloc_Type_JF,GameDataList(3,12,5)),0,0,0)

        

        InitUnlocTechConditions('RG1A',InitCond1(1,Unloc_Type_Level,5),InitCond2(0,Unloc_Type_JF,GameDataList(3,2,15)),0,0,0)
        InitUnlocTechConditions('RG1B',InitCond1(1,Unloc_Type_Level,5),InitCond2(0,Unloc_Type_JF,GameDataList(3,3,15)),0,0,0)
        InitUnlocTechConditions('RG1C',InitCond1(1,Unloc_Type_Level,7),InitCond2(0,Unloc_Type_JF,GameDataList(3,4,15)),0,0,0)
        InitUnlocTechConditions('RG1D',InitCond1(1,Unloc_Type_Level,9),InitCond2(0,Unloc_Type_JF,GameDataList(3,5,15)),0,0,0)
        InitUnlocTechConditions('RG1E',InitCond1(1,Unloc_Type_Level,11),InitCond2(0,Unloc_Type_JF,GameDataList(3,6,15)),0,0,0)
        InitUnlocTechConditions('RG1F',InitCond1(1,Unloc_Type_Level,13),InitCond2(0,Unloc_Type_JF,GameDataList(3,7,15)),0,0,0)
        InitUnlocTechConditions('RG1G',InitCond1(1,Unloc_Type_Level,14),InitCond2(0,Unloc_Type_JF,GameDataList(3,8,15)),0,0,0)
        InitUnlocTechConditions('RG1H',InitCond1(1,Unloc_Type_Level,15),InitCond2(0,Unloc_Type_JF,GameDataList(3,9,15)),0,0,0)
        InitUnlocTechConditions('RG1I',InitCond1(1,Unloc_Type_Level,16),InitCond2(0,Unloc_Type_JF,GameDataList(3,10,15)),0,0,0)
        InitUnlocTechConditions('RG1J',InitCond1(1,Unloc_Type_Level,17),InitCond2(0,Unloc_Type_JF,GameDataList(3,11,15)),0,0,0)
        InitUnlocTechConditions('RG1K',InitCond1(1,Unloc_Type_Level,17),InitCond2(0,Unloc_Type_JF,GameDataList(3,12,15)),0,0,0)



        set UnlocTechData_index3 = UnlocTechData_index

        InitUnlocTechConditions('RGEA',InitCond1(1,Unloc_Type_Level,3),InitCond2(0,Unloc_Type_JF,GameDataList(21,2,1)),0,0,0)
        InitUnlocTechConditions('RGEB',InitCond1(1,Unloc_Type_Level,3),InitCond2(0,Unloc_Type_JF,GameDataList(21,3,1)),0,0,0)
        InitUnlocTechConditions('RGEC',InitCond1(1,Unloc_Type_Level,5),InitCond2(0,Unloc_Type_JF,GameDataList(21,4,1)),0,0,0)
        InitUnlocTechConditions('RGED',InitCond1(1,Unloc_Type_Level,7),InitCond2(0,Unloc_Type_JF,GameDataList(21,5,1)),0,0,0)
        InitUnlocTechConditions('RGEE',InitCond1(1,Unloc_Type_Level,9),InitCond2(0,Unloc_Type_JF,GameDataList(21,6,1)),0,0,0)

        InitUnlocTechConditions('RGFA',InitCond1(1,Unloc_Type_Level,3),InitCond2(0,Unloc_Type_JF,GameDataList(21,2,5)),0,0,0)
        InitUnlocTechConditions('RGFB',InitCond1(1,Unloc_Type_Level,3),InitCond2(0,Unloc_Type_JF,GameDataList(21,3,5)),0,0,0)
        InitUnlocTechConditions('RGFC',InitCond1(1,Unloc_Type_Level,5),InitCond2(0,Unloc_Type_JF,GameDataList(21,4,5)),0,0,0)
        InitUnlocTechConditions('RGFD',InitCond1(1,Unloc_Type_Level,7),InitCond2(0,Unloc_Type_JF,GameDataList(21,5,5)),0,0,0)
        InitUnlocTechConditions('RGFE',InitCond1(1,Unloc_Type_Level,9),InitCond2(0,Unloc_Type_JF,GameDataList(21,6,5)),0,0,0)



        //积分兑换
        InitUnlocTechConditions('RY1C',InitCond1(1,Unloc_Type_Level,4),InitCond2(0,Unloc_Type_Load,GameDataList(11,3,3)),0,0,0)
        InitUnlocTechConditions('RY2C',InitCond1(1,Unloc_Type_Level,3),InitCond2(0,Unloc_Type_Load,GameDataList(12,3,3)),0,0,0)
        InitUnlocTechConditions('RY3C',InitCond1(1,Unloc_Type_Level,6),InitCond2(0,Unloc_Type_Load,GameDataList(13,3,3)),0,0,0)
        InitUnlocTechConditions('RY4C',InitCond1(1,Unloc_Type_Level,3),InitCond2(0,Unloc_Type_Load,GameDataList(14,3,3)),0,0,0)
        InitUnlocTechConditions('RY2E',InitCond1(1,Unloc_Type_Level,9),InitCond2(0,Unloc_Type_Load,GameDataList(12,5,5)),0,0,0)
        InitUnlocTechConditions('RY2F',InitCond1(1,Unloc_Type_Level,12),InitCond2(0,Unloc_Type_Load,GameDataList(12,6,6)),0,0,0)
        InitUnlocTechConditions('RY4O',InitCond1(1,Unloc_Type_Level,14),InitCond2(0,Unloc_Type_Load,GameDataList(14,15,15)),0,0,0)
        InitUnlocTechConditions('RY1E',InitCond1(1,Unloc_Type_Level,16),InitCond2(0,Unloc_Type_Load,GameDataList(11,5,5)),0,0,0)
        InitUnlocTechConditions('RY3E',InitCond1(1,Unloc_Type_Level,18),InitCond2(0,Unloc_Type_Load,GameDataList(13,5,5)),0,0,0)
        InitUnlocTechConditions('RY3H',InitCond1(1,Unloc_Type_Level,18),InitCond2(0,Unloc_Type_Load,GameDataList(13,8,8)),0,0,0)

        InitUnlocTechConditions('RY0A',InitCond1(1,Unloc_Type_Level,6),InitCond2(0,Unloc_Type_Load,GameDataList(10,1,2)),0,0,0)
        InitUnlocTechConditions('RY3I',InitCond1(1,Unloc_Type_Level,8),InitCond2(0,Unloc_Type_Load,GameDataList(13,9,7)),0,0,0)


        

        



        InitUnlocTechConditions('RY2K',InitCond1(1,Unloc_Type_Level,6),InitCond2(1,Unloc_Type_Day61,2),InitCond3(0,Unloc_Type_Load,GameDataList(12,10,10)),0,0)
        InitUnlocTechConditions('RY3K',InitCond1(1,Unloc_Type_Level,8),InitCond2(1,Unloc_Type_Day61,4),InitCond3(0,Unloc_Type_Load,GameDataList(13,10,10)),0,0)
        InitUnlocTechConditions('RP1C',InitCond1(1,Unloc_Type_Level,8),InitCond2(1,Unloc_Type_Day61,4),InitCond3(0,Unloc_Type_Load,GameDataList(19,10,10)),0,0)
        
        InitUnlocTechConditions('RJ2G',InitCond1(1,Unloc_Type_Level,6),InitCond2(1,Unloc_Type_Day51,2),InitCond3(0,Unloc_Type_Load,GameDataList(10,7,7)),0,0)
        InitUnlocTechConditions('RP1B',InitCond1(1,Unloc_Type_Level,8),InitCond2(1,Unloc_Type_Day51,4),InitCond3(0,Unloc_Type_Load,GameDataList(19,2,2)),0,0)
        InitUnlocTechConditions('RY4S',InitCond1(1,Unloc_Type_Level,8),InitCond2(1,Unloc_Type_Day51,4),InitCond3(0,Unloc_Type_Load,GameDataList(14,19,19)),0,0)


        InitUnlocTechConditions('RY2I',InitCond1(2,Unloc_Type_Level,35),0,0,0,0)

        //称号
        InitUnlocTechConditions('RY4E',InitCond1(1,Unloc_Type_Level,1),InitCond2(0,Unloc_Type_JF,GameDataList(3,2,1)),0,0,0)
        InitUnlocTechConditions('RY4F',InitCond1(1,Unloc_Type_Level,2),InitCond2(0,Unloc_Type_JF,GameDataList(3,3,1)),0,0,0)
        InitUnlocTechConditions('RY4G',InitCond1(1,Unloc_Type_Level,3),InitCond2(0,Unloc_Type_JF,GameDataList(3,4,1)),0,0,0)
        InitUnlocTechConditions('RY4H',InitCond1(1,Unloc_Type_Level,3),InitCond2(0,Unloc_Type_JF,GameDataList(3,5,1)),0,0,0)
        InitUnlocTechConditions('RY4I',InitCond1(1,Unloc_Type_Level,4),InitCond2(0,Unloc_Type_JF,GameDataList(3,6,1)),0,0,0)
        InitUnlocTechConditions('RY4L',InitCond1(1,Unloc_Type_Level,6),InitCond2(0,Unloc_Type_JF,GameDataList(3,7,1)),0,0,0)
        InitUnlocTechConditions('RY4M',InitCond1(1,Unloc_Type_Level,8),InitCond2(0,Unloc_Type_JF,GameDataList(3,8,1)),0,0,0)
        InitUnlocTechConditions('RY4Q',InitCond1(1,Unloc_Type_Level,10),InitCond2(0,Unloc_Type_JF,GameDataList(3,9,1)),0,0,0)
        InitUnlocTechConditions('RY4R',InitCond1(1,Unloc_Type_Level,12),InitCond2(0,Unloc_Type_JF,GameDataList(3,10,1)),0,0,0)
        InitUnlocTechConditions('RY4T',InitCond1(1,Unloc_Type_Level,14),InitCond2(0,Unloc_Type_JF,GameDataList(3,11,1)),0,0,0)
        InitUnlocTechConditions('RY4U',InitCond1(1,Unloc_Type_Level,14),InitCond2(0,Unloc_Type_JF,GameDataList(3,12,1)),0,0,0)

        //等级排行
        InitUnlocTechConditions('RY4J',InitCond1(2,Unloc_Type_LvRank,10),0,0,0,0)
        InitUnlocTechConditions('RY4K',InitCond1(2,Unloc_Type_LvRank,100),0,0,0,0)
        //测试先锋
        InitUnlocTechConditions('RY4N',InitCond1(1,Unloc_Type_Level,5),InitCond2(0,Unloc_Type_Test,1),0,0,0)
        

        

        set UnlocTechData_index4 = UnlocTechData_index


        //	InitUnlocTechConditions('RDAA',InitCond1(1,Unloc_Type_Level,6),InitCond2(0,Unloc_Type_JF,GameDataList(15,1,1)),0,0,0)
            InitUnlocTechConditions('RDAB',InitCond1(1,Unloc_Type_Level,4),InitCond2(0,Unloc_Type_JF,GameDataList(15,2,2)),0,0,0)
            InitUnlocTechConditions('RDAC',InitCond1(1,Unloc_Type_Level,1),InitCond2(0,Unloc_Type_JF,GameDataList(15,3,3)),0,0,0)
            InitUnlocTechConditions('RDAD',InitCond1(1,Unloc_Type_Level,1),InitCond2(0,Unloc_Type_JF,GameDataList(15,4,4)),0,0,0)
        	InitUnlocTechConditions('RDAE',InitCond1(1,Unloc_Type_Level,6),InitCond2(0,Unloc_Type_JF,GameDataList(15,5,5)),0,0,0)
        	InitUnlocTechConditions('RDAF',InitCond1(1,Unloc_Type_Level,8),InitCond2(0,Unloc_Type_JF,GameDataList(15,6,6)),0,0,0)
        	InitUnlocTechConditions('RDAG',InitCond1(1,Unloc_Type_Level,6),InitCond2(0,Unloc_Type_JF,GameDataList(15,7,7)),0,0,0)
            InitUnlocTechConditions('RDAH',InitCond1(1,Unloc_Type_Level,1),InitCond2(0,Unloc_Type_JF,GameDataList(15,8,8)),0,0,0)
            InitUnlocTechConditions('RDAI',InitCond1(1,Unloc_Type_Level,4),InitCond2(0,Unloc_Type_JF,GameDataList(15,9,9)),0,0,0)
            InitUnlocTechConditions('RDAJ',InitCond1(1,Unloc_Type_Level,2),InitCond2(0,Unloc_Type_JF,GameDataList(15,10,10)),0,0,0)
            InitUnlocTechConditions('RDAK',InitCond1(1,Unloc_Type_Level,2),InitCond2(0,Unloc_Type_JF,GameDataList(15,11,11)),0,0,0)
            InitUnlocTechConditions('RDAL',InitCond1(1,Unloc_Type_Level,2),InitCond2(0,Unloc_Type_JF,GameDataList(15,12,12)),0,0,0)
            InitUnlocTechConditions('RDAM',InitCond1(1,Unloc_Type_Level,4),InitCond2(0,Unloc_Type_JF,GameDataList(15,13,13)),0,0,0)
            InitUnlocTechConditions('RDAN',InitCond1(1,Unloc_Type_Level,4),InitCond2(0,Unloc_Type_JF,GameDataList(15,14,14)),0,0,0)
            InitUnlocTechConditions('RDAO',InitCond1(1,Unloc_Type_Level,2),InitCond2(0,Unloc_Type_JF,GameDataList(15,15,15)),0,0,0)
        //	InitUnlocTechConditions('RDAP',InitCond1(1,Unloc_Type_Level,6),InitCond2(0,Unloc_Type_JF,GameDataList(15,16,16)),0,0,0)
        //	InitUnlocTechConditions('RDAQ',InitCond1(1,Unloc_Type_Level,6),InitCond2(0,Unloc_Type_JF,GameDataList(15,17,17)),0,0,0)
        //	InitUnlocTechConditions('RDAR',InitCond1(1,Unloc_Type_Level,6),InitCond2(0,Unloc_Type_JF,GameDataList(15,18,18)),0,0,0)
        //	InitUnlocTechConditions('RDAS',InitCond1(1,Unloc_Type_Level,6),InitCond2(0,Unloc_Type_JF,GameDataList(15,19,19)),0,0,0)
        	InitUnlocTechConditions('RDAT',InitCond1(1,Unloc_Type_Level,6),InitCond2(0,Unloc_Type_JF,GameDataList(15,20,20)),0,0,0)
        	InitUnlocTechConditions('RDAU',InitCond1(1,Unloc_Type_Level,6),InitCond2(0,Unloc_Type_JF,GameDataList(15,21,21)),0,0,0)
        	InitUnlocTechConditions('RDAV',InitCond1(1,Unloc_Type_Level,4),InitCond2(0,Unloc_Type_JF,GameDataList(15,22,22)),0,0,0)
        	InitUnlocTechConditions('RDAW',InitCond1(1,Unloc_Type_Level,2),InitCond2(0,Unloc_Type_JF,GameDataList(15,23,23)),0,0,0)
        	InitUnlocTechConditions('RDAX',InitCond1(1,Unloc_Type_Level,6),InitCond2(0,Unloc_Type_JF,GameDataList(15,24,24)),0,0,0)
            InitUnlocTechConditions('RDAY',InitCond1(1,Unloc_Type_Level,1),InitCond2(0,Unloc_Type_JF,GameDataList(15,25,25)),0,0,0)
            
            InitUnlocTechConditions('RDAZ',InitCond1(2,Unloc_Type_Comment,1),0,0,0,0)

            InitUnlocTechConditions('RDBA',InitCond1(1,Unloc_Type_Level,1),InitCond2(0,Unloc_Type_Load,GameDataList(15,27,1)),0,0,0)
            InitUnlocTechConditions('RDBB',InitCond1(1,Unloc_Type_Level,1),InitCond2(0,Unloc_Type_Load,GameDataList(15,28,9)),0,0,0)
            
            


            //封神谕令
            InitUnlocTechConditions('RY9A',InitCond1(1,Unloc_Type_Level,2),InitCond2(0,Unloc_Type_JF,GameDataList(16,1,128)),0,0,0)
            InitUnlocTechConditions('RY9B',InitCond1(1,Unloc_Type_Level,3),InitCond2(0,Unloc_Type_JF,GameDataList(16,1,640)),0,0,0)
            InitUnlocTechConditions('RY9C',InitCond1(1,Unloc_Type_Level,4),InitCond2(0,Unloc_Type_JF,GameDataList(16,1,1792)),0,0,0)
            InitUnlocTechConditions('RY9D',InitCond1(1,Unloc_Type_Level,6),InitCond2(0,Unloc_Type_JF,GameDataList(16,1,3840)),0,0,0)
            InitUnlocTechConditions('RY9E',InitCond1(1,Unloc_Type_Level,7),InitCond2(0,Unloc_Type_JF,GameDataList(16,1,6400)),0,0,0)
            InitUnlocTechConditions('RY9F',InitCond1(1,Unloc_Type_Level,8),InitCond2(0,Unloc_Type_JF,GameDataList(16,1,9472)),0,0,0)
            InitUnlocTechConditions('RY9G',InitCond1(1,Unloc_Type_Level,10),InitCond2(0,Unloc_Type_JF,GameDataList(16,1,13619)),0,0,0)
            InitUnlocTechConditions('RY9H',InitCond1(1,Unloc_Type_Level,11),InitCond2(0,Unloc_Type_JF,GameDataList(16,1,18180)),0,0,0)
            InitUnlocTechConditions('RY9I',InitCond1(1,Unloc_Type_Level,12),InitCond2(0,Unloc_Type_JF,GameDataList(16,1,23198)),0,0,0)
            InitUnlocTechConditions('RY9J',InitCond1(1,Unloc_Type_Level,14),InitCond2(0,Unloc_Type_JF,GameDataList(16,1,32718)),0,0,0)
            

    endfunction


    //物品说明修改
    
    function ReTechFuncItemTips(int pid)
        ReExChangeTips(pid,'IY1C')
        ReExChangeTips(pid,'IY2C')
        ReExChangeTips(pid,'IY3C')
        ReExChangeTips(pid,'IY4C')
        ReExChangeTips(pid,'IY2E')
        ReExChangeTips(pid,'IY2F')
        ReExChangeTips(pid,'IY4O')
        ReExChangeTips(pid,'IY1E')
        ReExChangeTips(pid,'IY3E')
        ReExChangeTips(pid,'IY3H')
        ReExChangeTips(pid,'IY0A')
        ReExChangeTips(pid,'IY3I')
    endfunction

    //物品兑换注册
    function InitAllUnlocTechFuncItem()
        ExChangeList('IY2C',3,2,1,200,12,3,3)
        ExChangeList('IY4C',3,2,1,600,14,3,3)
        ExChangeList('IY1C',4,2,1,1200,11,3,3)
        ExChangeList('IY3C',6,2,1,3000,13,3,3)
        
        ExChangeList('IY2E',9,2,1,1600,12,5,5)
        ExChangeList('IY2F',12,2,1,1900,12,6,6)

        ExChangeList('IY4O',14,2,1,2300,14,15,15)
        ExChangeList('IY1E',16,2,1,3200,11,5,5)

        ExChangeList('IY3E',18,2,1,3300,13,5,5)

        ExChangeList('IY3H',18,2,1,4000,13,8,8)

        ExChangeList('IY0A',6,2,4,1100,10,1,2)
        ExChangeList('IY3I',8,2,4,1250,13,9,7)

    endfunction


    

    //初始化
    function InitAllUnlocTech()

        ExecuteFunc("InitAllUnlocTechFunc1")

        ExecuteFunc("InitHuYaActivity")
    endfunction
    
    
    
endlibrary


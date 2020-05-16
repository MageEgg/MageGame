library ItemAttackUnitChallenge uses DamageCode,ItemGameFunc

    int array AttackUnitChallengeStatePriceA[400][20]
    int array AttackUnitChallengeStatePriceB[400][20]
    int array AttackUnitChallengeStatePriceC[400][20]
    int array AttackUnitChallengeStatePriceD[400][20]

    int array AttackUnitChallengeStateType[400][20]
    int array AttackUnitChallengeStateTypeValueA[400][20]
    int array AttackUnitChallengeStateTypeValueB[400][20]
    int array AttackUnitChallengeStateTypeValueC[400][20]
    int array AttackUnitChallengeStateTypeValueD[400][20]

    string array AttackUnitChallengeStateTypeString[400][20]

    int array AttackUnitChallengePlayerArrayInt[12][680]

    int array AttackUnitChallengeCombat[20][400]

    #define AttackUnitChallengeStateGold                    AttackUnitChallengeStatePriceA
    #define AttackUnitChallengeStateLumber                  AttackUnitChallengeStatePriceB

    #define AttackUnitChallengePlayerInt                    AttackUnitChallengePlayerArrayInt[pid]
    #define AttackUnitChallengePlayerZuNum(num)             AttackUnitChallengePlayerInt[0+num]
    #define AttackUnitChallengePlayerWeiNum(num)            AttackUnitChallengePlayerInt[10+num]
    #define IsPlayerInAttackUnitChallenge(num)              AttackUnitChallengePlayerInt[20+num]
    #define AttackUnitChallengePlayerKillCos(num)           AttackUnitChallengePlayerInt[30+num]

    #define Buy_Tech 0             
    #define Buy_Unit 1             
    #define Buy_Item 2              
    #define Buy_Unit_Item 3        

    #define AttackUnitChallengeStateStockMax 8

    function InitAttackUnitChallengeStateData(int zu,int wei,int gold,int lumber,int othertype,int othervalue,int typeid,int typea,int typeb,int typec,int typed,string s)                                                    
        AttackUnitChallengeStateGold[zu][wei] = gold
        AttackUnitChallengeStateLumber[zu][wei] = lumber
        AttackUnitChallengeStatePriceC[zu][wei] = othertype
        AttackUnitChallengeStatePriceD[zu][wei] = othervalue

        AttackUnitChallengeStateType[zu][wei] = typeid //购买类型
        AttackUnitChallengeStateTypeValueA[zu][wei] = typea //类型参数
        AttackUnitChallengeStateTypeValueB[zu][wei] = typeb //类型参数 
        AttackUnitChallengeStateTypeValueC[zu][wei] = typec //类型参数 
        AttackUnitChallengeStateTypeValueD[zu][wei] = typed //类型参数 未使用的

        AttackUnitChallengeStateTypeString[zu][wei] = s
    endfunction

    function InitAttackUnitChallengeCombatData(int nandu,int zu,int i1,int i2,int i3,int i4,int i5,int i6,int i7,int i8,int i9,int i10,int i11,int i12)
        AttackUnitChallengeCombat[nandu][zu+0] = i1
        AttackUnitChallengeCombat[nandu][zu+1] = i2
        AttackUnitChallengeCombat[nandu][zu+2] = i3
        AttackUnitChallengeCombat[nandu][zu+3] = i4
        AttackUnitChallengeCombat[nandu][zu+4] = i5
        AttackUnitChallengeCombat[nandu][zu+5] = i6
        AttackUnitChallengeCombat[nandu][zu+6] = i7
        AttackUnitChallengeCombat[nandu][zu+7] = i8
        AttackUnitChallengeCombat[nandu][zu+8] = i9
        AttackUnitChallengeCombat[nandu][zu+9] = i10
        AttackUnitChallengeCombat[nandu][zu+10] = i11
        AttackUnitChallengeCombat[nandu][zu+11] = i12
    endfunction

    function InitAttackUnitChallengeState()
        //轮数 次数 金币 玄铁 属性消耗序号 属性消耗值 挑战类型 技能ID 参数1 参数2 说明
        InitAttackUnitChallengeStateData(0,0,0,0,0,0,Buy_Unit,'ATAA',6,0,0,"|CffFFD24D历练奖励：|r|n杀敌金币|Cffffc926+3|r，分裂攻击|Cffffc926+20%|r")
        InitAttackUnitChallengeStateData(0,1,0,0,0,0,Buy_Unit,'ATAB',1,0,0,"|CffFFD24D历练奖励：|r|n练功房怪物|Cffffc926+1|r，攻击吸血|Cffffc926+5%|r")
        InitAttackUnitChallengeStateData(0,2,0,0,0,0,Buy_Unit,'ATAC',6,0,0,"|CffFFD24D历练奖励：|r|n金币加成|Cffffc926+20%|r，技能吸血|Cffffc926+4%|r")
        InitAttackUnitChallengeStateData(0,3,0,0,0,0,Buy_Unit_Item,'ATAD',1,'IZ0D',0,"|CffFFD24D历练奖励：|r|n解锁|Cffff0000副本挑战|r")
        InitAttackUnitChallengeStateData(0,4,0,0,0,0,Buy_Unit,'ATAE',1,0,0,"|CffFFD24D历练奖励：|r|n攻击速度|Cffffc926+40%|r")
        InitAttackUnitChallengeStateData(0,5,0,0,0,0,Buy_Unit_Item,'ATAF',12,'IS14',0,"|CffFFD24D历练奖励：|r|n药品升级为|Cff3399ff明清灵水|r。")
        InitAttackUnitChallengeStateData(0,6,0,0,0,0,Buy_Unit_Item,'ATAG',8,'IZ0F',0,"|CffFFD24D历练奖励：|r|n金币|Cffffc926+20000|r")
        InitAttackUnitChallengeStateData(0,7,0,0,0,0,Buy_Unit_Item,'ATAH',1,'IZ0G',0,"|CffFFD24D历练奖励：|r|n玄铁|Cffffc926+10|r")

        InitAttackUnitChallengeStateData(1,0,0,0,0,0,Buy_Unit,'ATAI',8,0,0,"|CffFFD24D历练奖励：|r|n攻击|Cffffc926+20000|r，业力|Cffffc926+20000|r")
        InitAttackUnitChallengeStateData(1,1,0,0,0,0,Buy_Unit,'ATAJ',1,0,0,"|CffFFD24D历练奖励：|r|n攻击伤害|Cffffc926+20%|r，技能伤害|Cffffc926+20%|r")
        InitAttackUnitChallengeStateData(1,2,0,0,0,0,Buy_Unit,'ATAK',1,0,0,"|CffFFD24D历练奖励：|r|n生命|Cffffc926+500000|r，防御|Cffffc92650|r")
        InitAttackUnitChallengeStateData(1,3,0,0,0,0,Buy_Unit_Item,'ATAL',1,'IZ0E',0,"|CffFFD24D历练奖励：|r|n领悟|Cffff0000觉醒神通【R】|r技能")
        InitAttackUnitChallengeStateData(1,4,0,0,0,0,Buy_Unit,'ATAM',12,0,0,"|CffFFD24D历练奖励：|r|n攻击速度|Cffffc926+60%|r")
        InitAttackUnitChallengeStateData(1,5,0,0,0,0,Buy_Unit_Item,'ATAN',1,'IS14',0,"|CffFFD24D历练奖励：|r|n药品升级为|Cffffc926九曲灵参丹|r。")
        InitAttackUnitChallengeStateData(1,6,0,0,0,0,Buy_Unit,'ATAO',15,0,0,"|CffFFD24D历练奖励：|r|n攻击|Cffffc926+20%|r")
        InitAttackUnitChallengeStateData(1,7,0,0,0,0,Buy_Unit,'ATAP',20,0,0,"|CffFFD24D历练奖励：|r|n生命|Cffffc926+20%|r，防御|Cffffc926+100|r")

        InitAttackUnitChallengeStateData(200,0,1000,0,0,0,Buy_Unit,'AT0A',1,0,0,"|CffFFD24D挑战奖励：|r|n玄铁|Cffffc926+5|r")

        InitAttackUnitChallengeStateData(210,0,0,5,0,0,Buy_Unit,'AT1A',1,0,0,"|CffFFD24D挑战奖励：|r|n武灵等级|Cffffc926+1|r。|Cffcccccc点击法宝|r【F4】|Cffcccccc查看。|r")
        InitAttackUnitChallengeStateData(210,1,0,5,0,0,Buy_Unit,'AT1B',1,0,0,"|CffFFD24D挑战奖励：|r|n武灵等级|Cffffc926+1|r。|Cffcccccc点击法宝|r【F4】|Cffcccccc查看。|r")
        InitAttackUnitChallengeStateData(210,2,0,10,0,0,Buy_Unit,'AT1C',1,0,0,"|CffFFD24D挑战奖励：|r|n武灵等级|Cffffc926+1|r。|Cffcccccc点击法宝|r【F4】|Cffcccccc查看。|r")
        InitAttackUnitChallengeStateData(210,3,0,10,0,0,Buy_Unit,'AT1D',1,0,0,"|CffFFD24D挑战奖励：|r|n武灵等级|Cffffc926+1|r。|Cffcccccc点击法宝|r【F4】|Cffcccccc查看。|r")
        InitAttackUnitChallengeStateData(210,4,0,15,0,0,Buy_Unit,'AT1E',1,0,0,"|CffFFD24D挑战奖励：|r|n武灵等级|Cffffc926+1|r。|Cffcccccc点击法宝|r【F4】|Cffcccccc查看。|r")
        InitAttackUnitChallengeStateData(210,5,0,15,0,0,Buy_Unit,'AT1F',1,0,0,"|CffFFD24D挑战奖励：|r|n武灵等级|Cffffc926+1|r。|Cffcccccc点击法宝|r【F4】|Cffcccccc查看。|r")
        InitAttackUnitChallengeStateData(210,6,0,20,0,0,Buy_Unit,'AT1G',1,0,0,"|CffFFD24D挑战奖励：|r|n武灵等级|Cffffc926+1|r。|Cffcccccc点击法宝|r【F4】|Cffcccccc查看。|r")
        InitAttackUnitChallengeStateData(210,7,0,20,0,0,Buy_Unit,'AT1H',1,0,0,"|CffFFD24D挑战奖励：|r|n武灵等级|Cffffc926+1|r。|Cffcccccc点击法宝|r【F4】|Cffcccccc查看。|r")
        InitAttackUnitChallengeStateData(210,8,0,25,0,0,Buy_Unit,'AT1I',1,0,0,"|CffFFD24D挑战奖励：|r|n武灵等级|Cffffc926+1|r。|Cffcccccc点击法宝|r【F4】|Cffcccccc查看。|r")
        InitAttackUnitChallengeStateData(210,9,0,25,0,0,Buy_Unit,'AT1J',1,0,0,"|CffFFD24D挑战奖励：|r|n武灵等级|Cffffc926+1|r。|Cffcccccc点击法宝|r【F4】|Cffcccccc查看。|r")
        /*InitAttackUnitChallengeStateData(210,10,0,25,0,0,Buy_Unit,'AT1K',1,0,0,"|CffFFD24D挑战奖励：|r|n武灵等级|Cffffc926+1|r。|Cffcccccc点击法宝|r【F4】|Cffcccccc查看。|r")
        InitAttackUnitChallengeStateData(210,11,0,25,0,0,Buy_Unit,'AT1L',1,0,0,"|CffFFD24D挑战奖励：|r|n武灵等级|Cffffc926+1|r。|Cffcccccc点击法宝|r【F4】|Cffcccccc查看。|r")
        InitAttackUnitChallengeStateData(210,12,0,25,0,0,Buy_Unit,'AT1M',1,0,0,"|CffFFD24D挑战奖励：|r|n武灵等级|Cffffc926+1|r。|Cffcccccc点击法宝|r【F4】|Cffcccccc查看。|r")
        InitAttackUnitChallengeStateData(210,13,0,25,0,0,Buy_Unit,'AT1N',1,0,0,"|CffFFD24D挑战奖励：|r|n武灵等级|Cffffc926+1|r。|Cffcccccc点击法宝|r【F4】|Cffcccccc查看。|r")
        InitAttackUnitChallengeStateData(210,14,0,25,0,0,Buy_Unit,'AT1O',1,0,0,"|CffFFD24D挑战奖励：|r|n武灵等级|Cffffc926+1|r。|Cffcccccc点击法宝|r【F4】|Cffcccccc查看。|r")
        */
        InitAttackUnitChallengeStateData(220,0,0,5,0,0,Buy_Unit,'AT2A',1,0,0,"|CffFFD24D挑战奖励：|r|n|Cffff0000随机符印*1|n|n|r|Cffcccccc合理选择和搭配符印，可显著提高你的实力。|r")
        InitAttackUnitChallengeStateData(220,1,0,5,0,0,Buy_Unit,'AT2B',1,0,0,"|CffFFD24D挑战奖励：|r|n|Cffff0000随机符印*1|n|n|r|Cffcccccc合理选择和搭配符印，可显著提高你的实力。|r")
        InitAttackUnitChallengeStateData(220,2,0,5,0,0,Buy_Unit,'AT2C',1,0,0,"|CffFFD24D挑战奖励：|r|n|Cffff0000随机符印*1|n|n|r|Cffcccccc合理选择和搭配符印，可显著提高你的实力。|r")
        InitAttackUnitChallengeStateData(220,3,0,5,0,0,Buy_Unit,'AT2D',1,0,0,"|CffFFD24D挑战奖励：|r|n|Cffff0000随机符印*1|n|n|r|Cffcccccc合理选择和搭配符印，可显著提高你的实力。|r")
        /*InitAttackUnitChallengeStateData(220,4,0,5,0,0,Buy_Unit,'AT2E',1,0,0,"|CffFFD24D挑战奖励：|r|n|Cffff0000随机符印*1|n|n|r|Cffcccccc合理选择和搭配符印，可显著提高你的实力。|r")
        InitAttackUnitChallengeStateData(220,5,0,5,0,0,Buy_Unit,'AT2F',1,0,0,"|CffFFD24D挑战奖励：|r|n|Cffff0000随机符印*1|n|n|r|Cffcccccc合理选择和搭配符印，可显著提高你的实力。|r")
        InitAttackUnitChallengeStateData(220,6,0,5,0,0,Buy_Unit,'AT2G',1,0,0,"|CffFFD24D挑战奖励：|r|n|Cffff0000随机符印*1|n|n|r|Cffcccccc合理选择和搭配符印，可显著提高你的实力。|r")
        InitAttackUnitChallengeStateData(220,7,0,5,0,0,Buy_Unit,'AT2H',1,0,0,"|CffFFD24D挑战奖励：|r|n|Cffff0000随机符印*1|n|n|r|Cffcccccc合理选择和搭配符印，可显著提高你的实力。|r")*/

        //境界 引索
        InitAttackUnitChallengeCombatData(1,250,250,640,3000,10000,28000,68000,160000,360000,780000,1300000,0,0)
        InitAttackUnitChallengeCombatData(2,250,310,790,3700,13000,34000,83000,200000,440000,950000,1600000,0,0)
        InitAttackUnitChallengeCombatData(3,250,460,1200,5500,19000,51000,130000,290000,660000,1500000,2400000,0,0)
        InitAttackUnitChallengeCombatData(4,250,660,1800,7900,27000,74000,190000,430000,960000,2100000,3400000,0,0)
        InitAttackUnitChallengeCombatData(5,250,970,2500,12000,39000,110000,270000,620000,1400000,3100000,5000000,0,0)
        InitAttackUnitChallengeCombatData(6,250,1400,3500,16000,53000,150000,370000,850000,2000000,4200000,6800000,0,0)
        InitAttackUnitChallengeCombatData(7,250,1800,4700,22000,72000,200000,490000,1200000,2600000,5600000,9200000,0,0)
        InitAttackUnitChallengeCombatData(8,250,2300,5700,27000,89000,250000,610000,1500000,3200000,6900000,12000000,0,0)
        InitAttackUnitChallengeCombatData(9,250,3400,8600,40000,140000,370000,910000,2200000,4800000,11000000,17000000,0,0)
        

        //山灵 引索
        InitAttackUnitChallengeCombatData(1,0,130,1400,7300,19000,32000,59000,100000,150000,220000,330000,520000,730000)
        InitAttackUnitChallengeCombatData(2,0,150,1600,8900,23000,39000,72000,130000,190000,270000,400000,640000,890000)
        InitAttackUnitChallengeCombatData(3,0,230,2400,14000,34000,59000,110000,190000,280000,400000,590000,950000,1400000)
        InitAttackUnitChallengeCombatData(4,0,330,3500,20000,50000,85000,160000,270000,400000,580000,860000,1400000,2000000)
        InitAttackUnitChallengeCombatData(5,0,480,5100,29000,72000,130000,230000,390000,590000,850000,1300000,2100000,2900000)
        InitAttackUnitChallengeCombatData(6,0,650,7000,39000,99000,170000,320000,530000,800000,1200000,1800000,2800000,3900000)
        InitAttackUnitChallengeCombatData(7,0,880,9500,53000,140000,230000,430000,720000,1100000,1600000,2400000,3800000,5300000)
        InitAttackUnitChallengeCombatData(8,0,1100,12000,65000,170000,290000,530000,890000,1400000,2000000,2900000,4600000,6500000)
        InitAttackUnitChallengeCombatData(9,0,1700,18000,97000,250000,430000,790000,1400000,2000000,2900000,4300000,6900000,9800000)


        //武灵 引索
        InitAttackUnitChallengeCombatData(1,50,1400,5300,15000,29000,51000,90000,150000,360000,830000,1500000,0,0)
        InitAttackUnitChallengeCombatData(2,50,1600,6400,19000,35000,62000,110000,190000,440000,1100000,1900000,0,0)
        InitAttackUnitChallengeCombatData(3,50,2400,9600,28000,53000,93000,170000,280000,660000,1600000,2800000,0,0)
        InitAttackUnitChallengeCombatData(4,50,3500,14000,40000,76000,140000,240000,400000,960000,2200000,4000000,0,0)
        InitAttackUnitChallengeCombatData(5,50,5100,21000,58000,120000,200000,350000,590000,1400000,3200000,5800000,0,0)
        InitAttackUnitChallengeCombatData(6,50,7000,28000,80000,160000,280000,480000,800000,2000000,4400000,8000000,0,0)
        InitAttackUnitChallengeCombatData(7,50,9500,38000,110000,210000,370000,650000,1100000,2600000,6000000,11000000,0,0)
        InitAttackUnitChallengeCombatData(8,50,12000,47000,140000,260000,460000,800000,1400000,3200000,7300000,14000000,0,0)
        InitAttackUnitChallengeCombatData(9,50,18000,70000,200000,380000,680000,1200000,2000000,4800000,11000000,20000000,0,0)



        //符印 引索
        InitAttackUnitChallengeCombatData(1,150,56000,130000,220000,420000,750000,1300000,1500000,1500000,0,0,0,0)
        InitAttackUnitChallengeCombatData(2,150,69000,150000,270000,510000,920000,1600000,1900000,1900000,0,0,0,0)
        InitAttackUnitChallengeCombatData(3,150,110000,230000,400000,760000,1400000,2400000,2800000,2800000,0,0,0,0)
        InitAttackUnitChallengeCombatData(4,150,150000,330000,580000,1100000,2000000,3400000,4000000,4000000,0,0,0,0)
        InitAttackUnitChallengeCombatData(5,150,220000,480000,850000,1700000,3000000,5000000,5800000,5800000,0,0,0,0)
        InitAttackUnitChallengeCombatData(6,150,300000,650000,1200000,2200000,4000000,6800000,8000000,8000000,0,0,0,0)
        InitAttackUnitChallengeCombatData(7,150,410000,880000,1600000,3000000,5400000,9200000,11000000,11000000,0,0,0,0)
        InitAttackUnitChallengeCombatData(8,150,500000,1100000,2000000,3700000,6700000,12000000,14000000,14000000,0,0,0,0)
        InitAttackUnitChallengeCombatData(9,150,750000,1700000,2900000,5500000,10000000,17000000,20000000,20000000,0,0,0,0)


        //挑战0
        InitAttackUnitChallengeCombatData(1,300,80,160,320,510,3500,5900,14000,22000,0,0,0,0)
        InitAttackUnitChallengeCombatData(2,300,100,190,390,620,4200,7200,17000,26000,0,0,0,0)
        InitAttackUnitChallengeCombatData(3,300,75,290,580,930,6300,11000,26000,39000,0,0,0,0)
        InitAttackUnitChallengeCombatData(4,300,110,410,840,1400,9200,16000,37000,57000,0,0,0,0)
        InitAttackUnitChallengeCombatData(5,300,160,600,1300,2000,14000,23000,54000,83000,0,0,0,0)
        InitAttackUnitChallengeCombatData(6,300,220,830,1700,2700,19000,32000,74000,120000,0,0,0,0)
        InitAttackUnitChallengeCombatData(7,300,300,1200,2300,3700,25000,43000,100000,160000,0,0,0,0)
        InitAttackUnitChallengeCombatData(8,300,370,1400,2800,4500,31000,52000,130000,190000,0,0,0,0)
        InitAttackUnitChallengeCombatData(9,300,550,2100,4200,6800,46000,78000,190000,290000,0,0,0,0)

        


        //挑战1
        InitAttackUnitChallengeCombatData(1,310,28000,44000,68000,97000,140000,190000,260000,390000,0,0,0,0)
        InitAttackUnitChallengeCombatData(2,310,34000,54000,83000,120000,160000,230000,320000,470000,0,0,0,0)
        InitAttackUnitChallengeCombatData(3,310,51000,81000,130000,180000,240000,340000,480000,710000,0,0,0,0)
        InitAttackUnitChallengeCombatData(4,310,74000,120000,190000,260000,350000,490000,690000,1100000,0,0,0,0)
        InitAttackUnitChallengeCombatData(5,310,110000,180000,270000,380000,510000,710000,1000000,1500000,0,0,0,0)
        InitAttackUnitChallengeCombatData(6,310,150000,240000,370000,520000,700000,970000,1400000,2100000,0,0,0,0)
        InitAttackUnitChallengeCombatData(7,310,200000,320000,490000,700000,950000,1400000,1900000,2800000,0,0,0,0)
        InitAttackUnitChallengeCombatData(8,310,250000,390000,610000,860000,1200000,1700000,2300000,3500000,0,0,0,0)
        InitAttackUnitChallengeCombatData(9,310,370000,590000,910000,1300000,1800000,2500000,3500000,5200000,0,0,0,0)

        ExecuteFunc("InitAttackUnitChallengeStateStock")
    endfunction

    function GetStockSkillConsume(int pid,int zu,int wei)->string
        int id = AttackUnitChallengeStateTypeValueA[zu][wei] 
        string s = "|CffFFD24D挑战消耗：|r"
        int combat = 0
        if  zu == 0 //挑战0
            combat = 300
        elseif  zu == 1 //挑战1
            combat = 310
        elseif  zu == 200 //山灵
            combat = 0
        elseif  zu == 210 //武灵
            combat = 50
        elseif  zu == 220 //符印
            combat = 150
        endif
        if  zu == 200 //山灵
            if  AttackUnitChallengePlayerWeiNum(1) < 12
                combat = combat + AttackUnitChallengePlayerWeiNum(1)
            else
                combat = combat + 11
            endif
        else
            combat = combat + wei
        endif
        if  AttackUnitChallengeStateGold[zu][wei] > 0
            if  zu == 200
                if  AttackUnitChallengePlayerWeiNum(1) == 0
                    s = s + "|n"+I2S(AttackUnitChallengeStateGold[zu][wei])+"金币"
                else
                    s = s + "|n"+I2S(LoadInteger(ht,GetHandleId(Pu[1]),'AT0A'))+"金币"
                endif
            else
                s = s + "|n"+I2S(AttackUnitChallengeStateGold[zu][wei])+"金币"
            endif
        endif
        if  AttackUnitChallengeStateLumber[zu][wei] > 0
            s = s + "|n"+I2S(AttackUnitChallengeStateLumber[zu][wei])+"玄铁"
        endif
        if  AttackUnitChallengeStatePriceC[zu][wei] > 0 and AttackUnitChallengeStatePriceD[zu][wei] > 0
            s = s + "|n"+I2S(AttackUnitChallengeStatePriceD[zu][wei])+StateName[AttackUnitChallengeStatePriceC[zu][wei]]
        endif
        if  s == "|CffFFD24D挑战消耗：|r"
            s = ""
        endif
        if  GameMode == 3 or GameLevel > 9
            s = "|CffFFD24D战斗力推荐：|r|n|cffff0000？？？|r"
        else
            if  AttackUnitChallengeCombat[GameLevel][combat] > 0
                if  s == ""
                    s = "|CffFFD24D战斗力推荐：|r|n"+I2S(AttackUnitChallengeCombat[GameLevel][combat])+"|r"
                else
                    s = s + "|n|n|CffFFD24D战斗力推荐：|r|n"+I2S(AttackUnitChallengeCombat[GameLevel][combat])+"|r"
                endif
            endif
        endif
        if  s == ""
            return ""
        else
            return s+"|n|n"
        endif
    endfunction

    function AddAttackUnitChallengeStateStock(int pid,int zu,int wei)
        int id = AttackUnitChallengeStateTypeValueA[zu][wei]
        int zero = AttackUnitChallengeStateTypeValueA[zu][0]
        string s = ""
        real time = 2//挑战时间
        if  GameMode == 3
            time = 1
        elseif  GameMode == 4
            if  zu == 200
                time = 60
            elseif  zu == 210
                time = 160
            elseif  zu == 220 
                time = 240
            endif
        endif
        //BJDebugMsg(YDWEId2S(id))
        UnitAddAbility(Pu[42],id)
        if  GetPlayerTechCount(Player(pid),id+167772160-1,true) > 0 or id == zero
            s = GetStockSkillConsume(pid,zu,wei)
            //BJDebugMsg("GetStockSkillConsume")
        endif
        s = s + AttackUnitChallengeStateTypeString[zu][wei]
        if  Player(pid) == GetLocalPlayer()
            YDWESetUnitAbilityDataString(Pu[42],id,1,218,s)
        endif
        YDWESetUnitAbilityDataReal(Pu[42],id,1,105,time)
        YDWESetUnitAbilityState(Pu[42],id,1,time)
    endfunction

    function InitAttackUnitChallengeStateStock()
        for pid = 0,3
            if  IsPlaying(pid) == true
                for num = 0,AttackUnitChallengeStateStockMax
                    AddAttackUnitChallengeStateStock(pid,0,num)
                end
                AddAttackUnitChallengeStateStock(pid,210,0)
                AddAttackUnitChallengeStateStock(pid,220,0)
                
                //AttackUnitChallengeStateTypeString[200][0] = "|cffffff00推荐：|n - 战斗力"+I2S(AttackUnitChallengeCombat[GameLevel][0])+"|r|n|n"+AttackUnitChallengeStateTypeString[200][0]
                if  GameSaveClose == 0
                    if  GetPlayerTechCount(Player(pid),'RJ1X',true) > 0
                        if  Player(pid) == GetLocalPlayer()
                            AttackUnitChallengeStateTypeString[200][0] = "|cffffcc00挑战奖励：|r|n玄铁|Cffffc926+"+I2S(5)+"|r(|cff00ff00+5|r)"
                        endif
                    endif
                endif
                AddAttackUnitChallengeStateStock(pid,200,0)
                AddAttackUnitChallengeStateStock(pid,250,0)

                //UnitAddAbility(Pu[42],'AZ40')
            endif
        end
        //改境界战力说明
        int id = 0
        for i = 1,10
            if  i == 10
                id = 'IT10'
            else
                id = 'IT00'+i
            endif
            if  GameMode == 3 or GameLevel > 9
                YDWESetItemDataString(id, 3,GetTypeIdTips(id)+"|n|n|CffFFD24D战斗力推荐：|r|n|cffff0000？？？")
            else
                if  i <= 7
                    YDWESetItemDataString(id, 3,GetTypeIdTips(id)+"|n|n|CffFFD24D战斗力推荐：|r|n"+I2S(AttackUnitChallengeCombat[GameLevel][250+i-1]) )
                else
                    YDWESetItemDataString(id, 3,GetTypeIdTips(id)+"|n|n|CffFFD24D战斗力推荐：|r|n？？？")
                endif
            endif
        end

        if  GameMode == 4
            InitAttackUnitChallengeStateData(220,4,0,5,0,0,Buy_Unit,'AT2E',1,0,0,"|CffFFD24D挑战奖励：|r|n|Cffff0000随机符印*1|n|n|r|Cffcccccc合理选择和搭配符印，可显著提高你的实力。|r")
        endif
       
    endfunction
    
    function IsCanGetAttackUnitChallengeState(int pid,int challenge)->bool
        int zu = 0
        int wei = 0
        int gold = 0
        int lumber = 0
        int othertype = 0
        int othervalue = 0
        int other = 0
        if  challenge == 0
            zu = AttackUnitChallengePlayerZuNum(challenge) 
            wei = AttackUnitChallengePlayerWeiNum(challenge)
        elseif  challenge == 1
            zu = 200
            wei = 0
        elseif  challenge == 6
            zu = 250
            wei = 0
        else
            zu = AttackUnitChallengePlayerZuNum(challenge) + 200+10*(challenge-1)
            wei = AttackUnitChallengePlayerWeiNum(challenge)
        endif
        gold = AttackUnitChallengeStateGold[zu][wei]
        lumber = AttackUnitChallengeStateLumber[zu][wei]
        othertype = AttackUnitChallengeStatePriceC[zu][wei]
        othervalue = AttackUnitChallengeStatePriceD[zu][wei]
        if  zu == 200 and AttackUnitChallengePlayerWeiNum(1) > 0
            gold = LoadInteger(ht,GetHandleId(Pu[1]),'AT0A')
        endif
        if  othertype > 0 and othervalue > 0
            other = othervalue
        endif
        if  gold > 0 and lumber > 0 and other > 0
            if  GetPlayerState(Player(pid),PLAYER_STATE_RESOURCE_GOLD) >= gold
                if  GetPlayerState(Player(pid),PLAYER_STATE_RESOURCE_LUMBER) >= lumber
                    if  othertype < 100
                        if  GetUnitRealState(Pu[1],othertype) >= other
                            AddPlayerState(pid,PLAYER_STATE_RESOURCE_GOLD,-gold)
                            AddPlayerState(pid,PLAYER_STATE_RESOURCE_LUMBER,-lumber)
                            AddUnitRealState(Pu[1],othertype,-other)
                            return true
                        else
                            DisplayTimedTextToPlayer(Player(pid),0,0,5,"|cffffcc00[系统]：|r|cffff0000您的"+StateName[othertype]+"不足"+I2S(other)+"！|r")
                            return false
                        endif
                    else
                        if  GetUnitIntState(Pu[1],othertype) >= other
                            AddPlayerState(pid,PLAYER_STATE_RESOURCE_GOLD,-gold)
                            AddPlayerState(pid,PLAYER_STATE_RESOURCE_LUMBER,-lumber)
                            AddUnitIntState(Pu[1],othertype,-other)
                            return true
                        else
                            DisplayTimedTextToPlayer(Player(pid),0,0,5,"|cffffcc00[系统]：|r|cffff0000您的"+StateName[othertype]+"不足"+I2S(other)+"！|r")
                            return false
                        endif
                    endif
                else
                    DisplayTimedTextToPlayer(Player(pid),0,0,5,"|cffffcc00[系统]：|r|cffff0000您的玄铁不足"+I2S(lumber)+"！|r")
                    return false
                endif
            else
                DisplayTimedTextToPlayer(Player(pid),0,0,5,"|cffffcc00[系统]：|r|cffff0000您的金币不足"+I2S(gold)+"！|r")
                return false
            endif
        elseif  gold > 0 and lumber > 0 and other == 0
            if  GetPlayerState(Player(pid),PLAYER_STATE_RESOURCE_GOLD) >= gold
                if  GetPlayerState(Player(pid),PLAYER_STATE_RESOURCE_LUMBER) >= lumber
                    AddPlayerState(pid,PLAYER_STATE_RESOURCE_GOLD,-gold)
                    AddPlayerState(pid,PLAYER_STATE_RESOURCE_LUMBER,-lumber)
                    return true
                else
                    DisplayTimedTextToPlayer(Player(pid),0,0,5,"|cffffcc00[系统]：|r|cffff0000您的玄铁不足"+I2S(lumber)+"！|r")
                    return false
                endif
            else
                DisplayTimedTextToPlayer(Player(pid),0,0,5,"|cffffcc00[系统]：|r|cffff0000您的金币不足"+I2S(gold)+"！|r")
                return false
            endif
        elseif  gold > 0 and lumber == 0 and other > 0
            if  GetPlayerState(Player(pid),PLAYER_STATE_RESOURCE_GOLD) >= gold
                if  othertype < 100
                    if  GetUnitRealState(Pu[1],othertype) >= other
                        AddPlayerState(pid,PLAYER_STATE_RESOURCE_GOLD,-gold)
                        AddPlayerState(pid,PLAYER_STATE_RESOURCE_LUMBER,-lumber)
                        AddUnitRealState(Pu[1],othertype,-other)
                        return true
                    else
                        DisplayTimedTextToPlayer(Player(pid),0,0,5,"|cffffcc00[系统]：|r|cffff0000您的"+StateName[othertype]+"不足"+I2S(other)+"！|r")
                        return false
                    endif
                else
                    if  GetUnitIntState(Pu[1],othertype) >= other
                        AddPlayerState(pid,PLAYER_STATE_RESOURCE_GOLD,-gold)
                        AddPlayerState(pid,PLAYER_STATE_RESOURCE_LUMBER,-lumber)
                        AddUnitIntState(Pu[1],othertype,-other)
                        return true
                    else
                        DisplayTimedTextToPlayer(Player(pid),0,0,5,"|cffffcc00[系统]：|r|cffff0000您的"+StateName[othertype]+"不足"+I2S(other)+"！|r")
                        return false
                    endif
                endif
            else
                DisplayTimedTextToPlayer(Player(pid),0,0,5,"|cffffcc00[系统]：|r|cffff0000您的金币不足"+I2S(gold)+"！|r")
                return false
            endif
        elseif  gold == 0 and lumber > 0 and other > 0
            if  GetPlayerState(Player(pid),PLAYER_STATE_RESOURCE_LUMBER) >= lumber
                if  othertype < 100
                    if  GetUnitRealState(Pu[1],othertype) >= other
                        AddPlayerState(pid,PLAYER_STATE_RESOURCE_GOLD,-gold)
                        AddPlayerState(pid,PLAYER_STATE_RESOURCE_LUMBER,-lumber)
                        AddUnitRealState(Pu[1],othertype,-other)
                        return true
                    else
                        DisplayTimedTextToPlayer(Player(pid),0,0,5,"|cffffcc00[系统]：|r|cffff0000您的"+StateName[othertype]+"不足"+I2S(other)+"！|r")
                        return false
                    endif
                else
                    if  GetUnitIntState(Pu[1],othertype) >= other
                        AddPlayerState(pid,PLAYER_STATE_RESOURCE_GOLD,-gold)
                        AddPlayerState(pid,PLAYER_STATE_RESOURCE_LUMBER,-lumber)
                        AddUnitIntState(Pu[1],othertype,-other)
                        return true
                    else
                        DisplayTimedTextToPlayer(Player(pid),0,0,5,"|cffffcc00[系统]：|r|cffff0000您的"+StateName[othertype]+"不足"+I2S(other)+"！|r")
                        return false
                    endif
                endif
            else
                DisplayTimedTextToPlayer(Player(pid),0,0,5,"|cffffcc00[系统]：|r|cffff0000您的玄铁不足"+I2S(lumber)+"！|r")
                return false
            endif
        elseif  gold > 0 and lumber == 0 and other == 0
            if  GetPlayerState(Player(pid),PLAYER_STATE_RESOURCE_GOLD) >= gold
                AddPlayerState(pid,PLAYER_STATE_RESOURCE_GOLD,-gold)
                return true
            else
                DisplayTimedTextToPlayer(Player(pid),0,0,5,"|cffffcc00[系统]：|r|cffff0000您的金币不足"+I2S(gold)+"！|r")
                return false
            endif
        elseif  gold == 0 and lumber > 0 and other == 0
            if  GetPlayerState(Player(pid),PLAYER_STATE_RESOURCE_LUMBER) >= lumber
                AddPlayerState(pid,PLAYER_STATE_RESOURCE_LUMBER,-lumber)
                return true
            else
                DisplayTimedTextToPlayer(Player(pid),0,0,5,"|cffffcc00[系统]：|r|cffff0000您的玄铁不足"+I2S(lumber)+"！|r")
                return false
            endif
        elseif  gold == 0 and lumber == 0 and other > 0
            if  othertype < 100
                if  GetUnitRealState(Pu[1],othertype) >= other
                    AddPlayerState(pid,PLAYER_STATE_RESOURCE_GOLD,-gold)
                    AddPlayerState(pid,PLAYER_STATE_RESOURCE_LUMBER,-lumber)
                    AddUnitRealState(Pu[1],othertype,-other)
                    return true
                else
                    DisplayTimedTextToPlayer(Player(pid),0,0,5,"|cffffcc00[系统]：|r|cffff0000您的"+StateName[othertype]+"不足"+I2S(other)+"！|r")
                    return false
                endif
            else
                if  GetUnitIntState(Pu[1],othertype) >= other
                    AddPlayerState(pid,PLAYER_STATE_RESOURCE_GOLD,-gold)
                    AddPlayerState(pid,PLAYER_STATE_RESOURCE_LUMBER,-lumber)
                    AddUnitIntState(Pu[1],othertype,-other)
                    return true
                else
                    DisplayTimedTextToPlayer(Player(pid),0,0,5,"|cffffcc00[系统]：|r|cffff0000您的"+StateName[othertype]+"不足"+I2S(other)+"！|r")
                    return false
                endif
            endif
        elseif  gold == 0 and lumber == 0 and other == 0
            return true
        endif
        return false
    endfunction

    function AddAttackUnitChallengeStateLevel(int pid,int challenge)
        AttackUnitChallengePlayerWeiNum(challenge) = AttackUnitChallengePlayerWeiNum(challenge) + 1
        if  challenge == 0
            if  AttackUnitChallengePlayerWeiNum(challenge) == AttackUnitChallengeStateStockMax
                AttackUnitChallengePlayerZuNum(challenge) = AttackUnitChallengePlayerZuNum(challenge) + 1
                AttackUnitChallengePlayerWeiNum(challenge) = 0
                for num = 0,AttackUnitChallengeStateStockMax
                    AddAttackUnitChallengeStateStock(pid,AttackUnitChallengePlayerZuNum(challenge),num)
                end
            else
                AddAttackUnitChallengeStateStock(pid,AttackUnitChallengePlayerZuNum(challenge),AttackUnitChallengePlayerWeiNum(challenge))
            endif
        else
            AddAttackUnitChallengeStateStock(pid,AttackUnitChallengePlayerZuNum(challenge) + 200+10*(challenge-1),AttackUnitChallengePlayerWeiNum(challenge))
        endif
    endfunction

    function AddAttackUnitChallengeState(int pid,int sid)
        int zu = 0
        int wei = 0
        int id = 0
        int tech = 0
        int uid = 0
        int itemid = 0
        int unitnum = 0
        int challenge = 0
        real x = AttackRoomPostion[pid][1]
        real y = AttackRoomPostion[pid][2]
        unit u = null
        if  sid == 'AT0A'
            challenge = 1
            zu = 200
            wei = 0
            
            id = 'AT0A'+AttackUnitChallengePlayerWeiNum(challenge)
            //BJDebugMsg(YDWEId2S(sid)+"@@"+YDWEId2S(id)+"@@"+I2S(challenge))
            tech = 'KT0A'+AttackUnitChallengePlayerWeiNum(challenge)
            uid = 'uT0A'+AttackUnitChallengePlayerWeiNum(challenge)
            if  AttackUnitChallengePlayerWeiNum(challenge) >= 12
                id = 'AT0L'
                tech = 'KT0L'
                uid = 'uT0L'
            endif
        elseif  sid == 'AT5A'
            challenge = 6
            zu = 250
            wei = 0
            
            id = 'AT5A'+AttackUnitChallengePlayerWeiNum(challenge)
            //BJDebugMsg(YDWEId2S(sid)+"@@"+YDWEId2S(id)+"@@"+I2S(challenge))
            tech = 'KT5A'+AttackUnitChallengePlayerWeiNum(challenge)
            uid = 'uT5A'+AttackUnitChallengePlayerWeiNum(challenge)
            if  AttackUnitChallengePlayerWeiNum(challenge) >= 12
                id = 'AT5L'
                tech = 'KT5L'
                uid = 'uT5L'
            endif
        elseif  sid - 'AT9A' < 2048
            challenge = S2I(SubString(YDWEId2S(sid),2,3)) + 1
            zu = AttackUnitChallengePlayerZuNum(challenge) + 200+10*(challenge-1)
            wei = AttackUnitChallengePlayerWeiNum(challenge)

            id = AttackUnitChallengeStateTypeValueA[zu][wei]
            //BJDebugMsg(YDWEId2S(sid)+"@@"+YDWEId2S(id)+"@@"+I2S(challenge))
            tech = id+167772160
            uid = id+872415232

        else
            zu = AttackUnitChallengePlayerZuNum(challenge)
            wei = AttackUnitChallengePlayerWeiNum(challenge)

            id = AttackUnitChallengeStateTypeValueA[zu][wei]
            //BJDebugMsg(YDWEId2S(sid)+"@@"+YDWEId2S(id)+"@@"+I2S(challenge))
            tech = id+167772160
            uid = id+872415232

        endif
        if  IsPlayerInAttackUnitChallenge(challenge) == 0
            if  IsCanGetAttackUnitChallengeState(pid,challenge) == true
                if  AttackUnitChallengeStateType[zu][wei] == Buy_Tech
                    UnitRemoveAbility(Pu[42],id)
                    SetPlayerTechResearchedEx(Player(pid),tech)
                    DisplayTimedTextToPlayer(Player(pid),0,0,5,"|cffffcc00[系统]：|r恭喜你完成"+GetObjectName(id)+"！")
                    AddAttackUnitChallengeStateLevel(pid,challenge)
                elseif  AttackUnitChallengeStateType[zu][wei] == Buy_Unit
                    IsPlayerInAttackUnitChallenge(challenge) = 1
                    unitnum = AttackUnitChallengeStateTypeValueB[zu][wei]
                    for num = 1,unitnum
                        u = CreateUnit(Player(PLAYER_NEUTRAL_AGGRESSIVE),uid,x-440,y+440,270)
                        if  (challenge == 1 or challenge == 6) and AttackUnitChallengePlayerWeiNum(challenge) >= 12
                            SetUnitRealStateOfOtherIdAddValue(u,uid,1.0+0.3*I2R(AttackUnitChallengePlayerWeiNum(challenge)-12))
                        endif
                        UnitAddAbility(u,'AZ99')
                        SetUnitAbilityLevel(u,'AZ99',pid+1)
                        AddAttackSummonUnit.execute(pid,u)
                        SetUnitIntState(u,101,id)
                        IssuePointOrderById(u,851983,GetUnitX(Pu[1]),GetUnitY(Pu[1]))
                    end
                    DisplayTimedTextToPlayer(Player(pid),0,0,5,"|cffffcc00[系统]：|r为您召唤"+GetObjectName(uid)+"！")
                elseif  AttackUnitChallengeStateType[zu][wei] == Buy_Item
                    itemid = AttackUnitChallengeStateTypeValueB[zu][wei]
                    UnitRemoveAbility(Pu[42],id)
                    SetPlayerTechResearchedEx(Player(pid),tech)
                    UnitAddItemEx(Pu[1],itemid)
                    DisplayTimedTextToPlayer(Player(pid),0,0,5,"|cffffcc00[系统]：|r恭喜你完成"+GetObjectName(id)+"！")
                    AddAttackUnitChallengeStateLevel(pid,challenge)
                elseif  AttackUnitChallengeStateType[zu][wei] == Buy_Unit_Item
                    IsPlayerInAttackUnitChallenge(challenge) = 1
                    unitnum = AttackUnitChallengeStateTypeValueB[zu][wei]
                    itemid = AttackUnitChallengeStateTypeValueC[zu][wei]
                    for num = 1,unitnum
                        u = CreateUnit(Player(PLAYER_NEUTRAL_AGGRESSIVE),uid,x-440,y+440,270)
                        UnitAddAbility(u,'AZ99')
                        SetUnitAbilityLevel(u,'AZ99',pid+1)
                        AddAttackSummonUnit.execute(pid,u)
                        SetUnitIntState(u,101,id)
                        SetUnitIntState(u,102,itemid)
                        IssuePointOrderById(u,851983,GetUnitX(Pu[1]),GetUnitY(Pu[1]))
                    end
                    DisplayTimedTextToPlayer(Player(pid),0,0,5,"|cffffcc00[系统]：|r为您召唤"+GetObjectName(uid)+"！")
                endif
            endif
        else
            DisplayTimedTextToPlayer(Player(pid),0,0,5,"|cffffcc00[系统]：|r|cffff0000当前正在挑战！")
        endif
        u = null
    endfunction

    function AttackUnitChallengeStateDeathEvent(int pid,unit u)
        int zu = 0
        int wei = 0
        int id = GetUnitIntState(u,101)
        int itemid = GetUnitIntState(u,102)
        int tech = id+167772160
        int unitnum = 0
        int challenge = 0
        int ran = 0
        int newid = 0
        int lumber = 0
        int nextlumber = 0
        if  id >= 'AT0A' and id <= 'AT0L'
            challenge = 1
            zu = 200
            wei = 0
        elseif  id >= 'AT5A' and id <= 'AT5L'
            challenge = 6
            zu = 250
            wei = 0
        elseif  id - 'AT9A' < 2048
            challenge = S2I(SubString(YDWEId2S(id),2,3)) + 1
            zu = AttackUnitChallengePlayerZuNum(challenge) + 200+10*(challenge-1)
            wei = AttackUnitChallengePlayerWeiNum(challenge)
        else
            zu = AttackUnitChallengePlayerZuNum(challenge)
            wei = AttackUnitChallengePlayerWeiNum(challenge)
        endif
        unitnum = AttackUnitChallengeStateTypeValueB[zu][wei]
        AttackUnitChallengePlayerKillCos(challenge) = AttackUnitChallengePlayerKillCos(challenge) + 1
        BJDebugMsg(YDWEId2S(id)+"@@"+I2S(challenge))
        if  challenge == 0
            if  unitnum >= 15
                if  ModuloInteger(AttackUnitChallengePlayerKillCos(challenge),4) == 0 or AttackUnitChallengePlayerKillCos(challenge) == unitnum
                    DisplayTimedTextToPlayer(Player(pid),0,0,1,"|cffffcc00[历练挑战]：|r成功击杀"+GetUnitName(u)+"(|cffffcc00"+I2S(AttackUnitChallengePlayerKillCos(challenge))+"/"+I2S(unitnum)+"|r)")
                endif
            elseif  unitnum >= 9
                if  ModuloInteger(AttackUnitChallengePlayerKillCos(challenge),3) == 0 or AttackUnitChallengePlayerKillCos(challenge) == unitnum
                    DisplayTimedTextToPlayer(Player(pid),0,0,1,"|cffffcc00[历练挑战]：|r成功击杀"+GetUnitName(u)+"(|cffffcc00"+I2S(AttackUnitChallengePlayerKillCos(challenge))+"/"+I2S(unitnum)+"|r)")
                endif
            elseif  unitnum >= 2
                if  ModuloInteger(AttackUnitChallengePlayerKillCos(challenge),2) == 0 or AttackUnitChallengePlayerKillCos(challenge) == unitnum
                    DisplayTimedTextToPlayer(Player(pid),0,0,1,"|cffffcc00[历练挑战]：|r成功击杀"+GetUnitName(u)+"(|cffffcc00"+I2S(AttackUnitChallengePlayerKillCos(challenge))+"/"+I2S(unitnum)+"|r)")
                endif
            elseif  unitnum == 1
                DisplayTimedTextToPlayer(Player(pid),0,0,1,"|cffffcc00[历练挑战]：|r成功击杀"+GetUnitName(u)+"(|cffffcc00"+I2S(AttackUnitChallengePlayerKillCos(challenge))+"/"+I2S(unitnum)+"|r)")
            endif
            if  AttackUnitChallengePlayerKillCos(challenge) == unitnum
                AttackUnitChallengePlayerKillCos(challenge) = 0
                UnitRemoveAbility(Pu[42],id)
                SetPlayerTechResearchedEx(Player(pid),tech)
                if  itemid > 0
                    UnitAddItemEx(Pu[1],itemid)
                endif
                //zu = 0是挑战 
                if  zu == 0 and wei == 3 //历练4解锁
                    PlayerUnLockPlot.execute(pid,1)
                    PlayerUnLockPlot.execute(pid,2)
                    PlayerUnLockPlot.execute(pid,3)
                elseif  zu == 0 and wei == 5 //历练6解锁
                    PlayerUnLockPlot.execute(pid,4)
                elseif  zu == 0 and wei == 7 //历练8解锁
                    PlayerUnLockPlot.execute(pid,5)
                elseif  zu == 1 and wei == 1 //10
                    PlayerUnLockPlot.execute(pid,6)
                elseif  zu == 1 and wei == 3 //12
                    PlayerUnLockPlot.execute(pid,7)
                elseif  zu == 1 and wei == 4 //13
                    PlayerUnLockPlot.execute(pid,8)
                endif
                DisplayTimedTextToPlayer(Player(pid),0,0,5,"|cffffcc00[系统]：|r恭喜你完成"+GetObjectName(id)+SubString(AttackUnitChallengeStateTypeString[zu][wei],29,StringLength(AttackUnitChallengeStateTypeString[zu][wei]))+"！")
                AddAttackUnitChallengeStateLevel(pid,challenge)
                IsPlayerInAttackUnitChallenge(challenge) = 0
            endif
        else
            ///////////////////////分割判断/////////////////////
            if  challenge == 1
                DisplayTimedTextToPlayer(Player(pid),0,0,1,"|cffffcc00[山灵挑战]：|r成功击杀"+GetUnitName(u)+"(|cffffcc00"+I2S(AttackUnitChallengePlayerKillCos(challenge))+"/"+I2S(unitnum)+"|r)")
            elseif  challenge == 2
                DisplayTimedTextToPlayer(Player(pid),0,0,1,"|cffffcc00[器灵挑战]：|r成功击杀"+GetUnitName(u)+"(|cffffcc00"+I2S(AttackUnitChallengePlayerKillCos(challenge))+"/"+I2S(unitnum)+"|r)")
            elseif  challenge == 3
                DisplayTimedTextToPlayer(Player(pid),0,0,1,"|cffffcc00[符印挑战]：|r成功击杀"+GetUnitName(u)+"(|cffffcc00"+I2S(AttackUnitChallengePlayerKillCos(challenge))+"/"+I2S(unitnum)+"|r)")
            elseif  challenge == 6
                DisplayTimedTextToPlayer(Player(pid),0,0,1,"|cffffcc00[资源挑战]：|r成功击杀"+GetUnitName(u)+"(|cffffcc00"+I2S(AttackUnitChallengePlayerKillCos(challenge))+"/"+I2S(unitnum)+"|r)")
            endif
            ///////////////////////分割判断/////////////////////
            if  AttackUnitChallengePlayerKillCos(challenge) == unitnum
                AttackUnitChallengePlayerKillCos(challenge) = 0
                if  challenge == 1
                    AttackUnitChallengePlayerWeiNum(challenge) = AttackUnitChallengePlayerWeiNum(challenge) + 1
                    SetPlayerTechResearched(Player(pid),tech,1)
                    UnitRemoveAbility(Pu[42],id)
                    if  AttackUnitChallengePlayerWeiNum(challenge) < 12
                        newid = AttackUnitChallengePlayerWeiNum(challenge)+'uT0A'
                        if  AttackUnitChallengePlayerWeiNum(challenge) >= 9
                            lumber = 20
                        elseif  AttackUnitChallengePlayerWeiNum(challenge) >= 5
                            lumber = 15
                        elseif  AttackUnitChallengePlayerWeiNum(challenge) >= 2
                            lumber = 10
                        else
                            lumber = 5
                        endif
                        if  AttackUnitChallengePlayerWeiNum(challenge) >= 8
                            nextlumber = 20
                        elseif  AttackUnitChallengePlayerWeiNum(challenge) >= 4
                            nextlumber = 15
                        else
                            nextlumber = 10
                        endif
                        if  AttackUnitChallengePlayerWeiNum(challenge) < 5
                            SaveInteger(ht,GetHandleId(Pu[1]),'AT0A',LoadInteger(ht,GetHandleId(Pu[1]),'AT0A')+500)
                        else
                            SaveInteger(ht,GetHandleId(Pu[1]),'AT0A',LoadInteger(ht,GetHandleId(Pu[1]),'AT0A')+1000)
                        endif
                        //AttackUnitChallengeStateTypeString[zu][wei] = "|cffffff00推荐：|n - 战斗力"+I2S(AttackUnitChallengeCombat[GameLevel][0+AttackUnitChallengePlayerWeiNum(challenge)])+"|r|n|n|cffffcc00挑战奖励：|r|n玄铁|Cffffc926+"+I2S(nextlumber)+"|r"
                        AttackUnitChallengeStateTypeString[zu][wei] = "|cffffcc00挑战奖励：|r|n玄铁|Cffffc926+"+I2S(nextlumber)+"|r"
                        if  GameSaveClose == 0
                            if  GetPlayerTechCount(Player(pid),'RJ1X',true) > 0
                                if  Player(pid) == GetLocalPlayer()
                                    AttackUnitChallengeStateTypeString[zu][wei] = "|cffffcc00挑战奖励：|r|n玄铁|Cffffc926+"+I2S(nextlumber)+"|r(|cff00ff00+5|r)"
                                endif
                            endif
                        endif
                    else
                        newid = 'uT0L'
                        lumber = 20
                    endif

                    if  GetPlayerTechCount(Player(pid),'RJ1X',true) > 0 and GameSaveClose == 0
                        AddPlayerState(pid,PLAYER_STATE_RESOURCE_LUMBER,lumber+5)
                        DisplayTimedTextToPlayer(Player(pid),0,0,5,"|cffffcc00[系统]：|r恭喜你完成"+GetUnitName(u)+",|cffffff00奖励玄铁x"+I2S(lumber)+"|r！")
                        DisplayTimedTextToPlayer(Player(pid),0,0,5,"|cffffcc00[系统]：|r拥有《|cff00ff00赞助礼包|r》,|cffffff00奖励玄铁x5|r")
                        
                    else
                        AddPlayerState(pid,PLAYER_STATE_RESOURCE_LUMBER,lumber)
                        DisplayTimedTextToPlayer(Player(pid),0,0,5,"|cffffcc00[系统]：|r恭喜你完成"+GetUnitName(u)+",|cffffff00奖励玄铁x"+I2S(lumber)+"|r！")
                    endif

                    
                    AddAttackUnitChallengeStateStock(pid,zu,wei)
                    if  Player(pid) == GetLocalPlayer()
                        YDWESetUnitAbilityDataString(Pu[42],'AT0A',1,215,GetObjectName(newid))
                    endif
                elseif  challenge == 6
                    SetPlayerTechResearched(Player(pid),tech,1)
                    UnitAddItemEx(Pu[1],'IN30')
                    DisplayTimedTextToPlayer(Player(pid),0,0,5,"|cffffcc00[系统]：|r恭喜你完成"+GetUnitName(u)+",|cffffff00获得"+GetObjectName('IN30')+"|r！")
                    AttackUnitChallengePlayerWeiNum(challenge) = AttackUnitChallengePlayerWeiNum(challenge) + 1
                else
                    UnitRemoveAbility(Pu[42],id)
                    if  challenge == 2
                        //法宝减属性
                        RemAllMagicState(Pu[1])
                        SetPlayerTechResearchedEx(Player(pid),tech)
                        AddAllMagicState(Pu[1])
                        //法宝加属性
                    else
                        SetPlayerTechResearchedEx(Player(pid),tech)
                    endif


                    if  itemid > 0
                        UnitAddItemEx(Pu[1],itemid)
                    endif
                    DisplayTimedTextToPlayer(Player(pid),0,0,5,"|cffffcc00[系统]：|r恭喜你完成"+GetObjectName(id)+"！")
                    AddAttackUnitChallengeStateLevel(pid,challenge)
                    ///////////////////////分割判断/////////////////////
                    if  challenge == 3 //这里写符印奖励
                        GivePlayerRunePrizeFrame(pid)
                        //PlayerUnLockPlot.execute(pid,AttackUnitChallengePlayerWeiNum(challenge))
                        //if  AttackUnitChallengePlayerWeiNum(challenge) == 8
                        //    AddAttackUnitChallengeStateStock(pid,230,0)
                        //endif
                    endif 
                    ///////////////////////分割判断/////////////////////
                endif
                IsPlayerInAttackUnitChallenge(challenge) = 0
            endif
        endif
    endfunction

    function ItemEventOfAttackUnitChallengeState(int pid,int itid)
        int ran = 0
        if  itid == 'IZ0D'
            UnitAddAbility(Pu[1],'AG09')
            UnitMakeAbilityPermanent(Pu[1],true,'AG09')
            ShowUnit(Pu[24],true)
            CreateUnit(Player(PLAYER_NEUTRAL_PASSIVE),'nc04',GetUnitX(Pu[24]),GetUnitY(Pu[24]),270)//副本入口
            UnitAddEffectOfNPC.execute(Pu[24])
            if  GetLocalPlayer() == Player(pid)
                DzFrameShow(BUTTON_Back[700+4][0], true)
            endif
            CloseCollectFrame(pid)
        elseif  itid == 'IZ0E'
            HeroAddAbilityByIndex(Pu[1],4,'S230'+GetRandomInt(0,7))
            for num = 1,3
                DisplayTimedTextToPlayer(GetLocalPlayer(),0,0,8,"|cffffcc00[系统]：|r|cffffff80恭喜"+GetPlayerNameOfColor(pid)+"|cffffff80觉醒了|cffff0080“"+GetTypeIdString(GetUnitIntState(Pu[1],114),100)+"[R]”|cffffff80！|r")
            end
            /*
            GivePlayerMissionPrize(pid,'RR0A')
            */

            /*ran = GetRandomInt(0,7)
            AddPlayerMonsterSoulState(pid,ran)
            AddPlayerTechResearched(Player(pid),'RM50'+ran,1)
            DisplayTimedTextToPlayer(GetLocalPlayer(),0,0,5,"|cffffcc00[系统]：|r|cffffff80恭喜"+GetPlayerNameOfColor(pid)+"|cffffff80获得|cffff0080“"+GetMonsterSoulLuck(ran)+"”|cffffff80！|r")
            UnitAddEffectSetSize(Pu[1],"effect_hero_levelup.mdx",3)*/
        elseif  itid == 'IZ0F'
            AddPlayerState(pid,PLAYER_STATE_RESOURCE_GOLD,20000)
            /*HeroAddAbilityByIndex(Pu[1],4,'S230'+GetRandomInt(0,7))
            for num = 1,3
                DisplayTimedTextToPlayer(GetLocalPlayer(),0,0,8,"|cffffcc00[系统]：|r|cffffff80恭喜"+GetPlayerNameOfColor(pid)+"|cffffff80觉醒了|cffff0080“[R]技能”|cffffff80！|r")
            end
            GivePlayerMissionPrize(pid,'RR0A')*/
        elseif  itid == 'IZ0G'
            AddPlayerState(pid,PLAYER_STATE_RESOURCE_LUMBER,10)
        endif
    endfunction

endlibrary 

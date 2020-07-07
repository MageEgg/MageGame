
library ShowSaveFrameFunction  uses GameFrame,MagicItemCollectCode
    /*
    581-600 左侧按钮
    */

  

    private FRAME Button = 0
    private FRAME Slider = 0
    private FRAME Back = 0
    private FRAME Back2 = 0
    private int origin = 0

    private int array Page
    private int array Step

    int array ShowSaveData[10][1600]

    

    //获取max
    function GetShowSaveMax(int page)->int
        return ShowSaveData[page][0]
    endfunction
    //设置max
    function SetShowSaveMax(int page,int max)
        ShowSaveData[page][0] = max
    endfunction
    //增加max
    function AddShowSaveMax(int page,int add)
        ShowSaveData[page][0] = ShowSaveData[page][0] + add
    endfunction

    //获取id
    function GetShowSaveId(int page,int index)->int
        return ShowSaveData[page][index]
    endfunction
    //获取需求科技
    function GetShowSaveTech(int page,int index,int num)->int
        return ShowSaveData[page][200*num+index]
    endfunction


    //注册数据    
    function RegisterShowSaveFrameData(int page,int id,int use1,int use2,int use3,int use4,int use5)
        int index = ShowSaveData[page][0] + 1
        ShowSaveData[page][index] = id
        ShowSaveData[page][200+index] = use1
        ShowSaveData[page][400+index] = use2
        ShowSaveData[page][600+index] = use3
        ShowSaveData[page][800+index] = use4
        ShowSaveData[page][1200+index] = use5
        ShowSaveData[page][0] = index
    endfunction
    //初始化函数
    function InitShowSaveFrameData()
        
        RegisterShowSaveFrameData(5,'RJ1V','RJ1V',0,0,0,0) //金币礼包
        RegisterShowSaveFrameData(5,'RJ1W','RJ1W',0,0,0,0) //木材礼包
        RegisterShowSaveFrameData(5,'RJ1U','RJ1U',0,0,0,0) //封神礼包
        RegisterShowSaveFrameData(5,'RJ1X','RJ1X',0,0,0,0) //赞助礼包
        RegisterShowSaveFrameData(5,'RY1D','RY1D',0,0,0,0) //星月光环
        RegisterShowSaveFrameData(5,'RP1A','RP1A',0,0,0,0) //笑天犬
        RegisterShowSaveFrameData(5,'RK1A','RK1A',0,0,0,0) //小狐妖
        RegisterShowSaveFrameData(5,'RY2G','RY2G',0,0,0,0) //幽冥之翼
        RegisterShowSaveFrameData(5,'RY2D','RY2D',0,0,0,0) //幻莲仙翼
        RegisterShowSaveFrameData(5,'RY4D','RY4D',0,0,0,0) //鼠年大吉
        RegisterShowSaveFrameData(5,'RY3D','RY3D',0,0,0,0) //戮仙剑
        RegisterShowSaveFrameData(5,'RY3F','RY3F',0,0,0,0) //诛仙剑
    

        RegisterShowSaveFrameData(5,'RTX1','RTX1',0,0,0,0) //通行证1
        RegisterShowSaveFrameData(5,'RTX2','RTX2',0,0,0,0) //通行证2
        RegisterShowSaveFrameData(5,'RTX3','RTX3',0,0,0,0) //通行证3
        RegisterShowSaveFrameData(5,'RTX4','RTX4',0,0,0,0) //通行证4
        RegisterShowSaveFrameData(5,'RTX5','RTX5',0,0,0,0) //通行证5
        RegisterShowSaveFrameData(5,'RTX6','RTX6',0,0,0,0) //通行证6

        
        RegisterShowSaveFrameData(5,'RJ1Z','RJ1Z',0,0,0,0) //良心赞助
        
        RegisterShowSaveFrameData(5,'RJ1Y','RJ1Y',0,0,0,0) //劳动节礼包
        RegisterShowSaveFrameData(5,'RJ1P','RJ1P',0,0,0,0) //儿童节礼包
        RegisterShowSaveFrameData(5,'RJ1Q','RJ1Q',0,0,0,0) //端午节礼包

        RegisterShowSaveFrameData(5,'RSHA','RSHA',0,0,0,0) //商城3件套
        RegisterShowSaveFrameData(5,'RSHD','RSHD',0,0,0,0) //商城4件套
        RegisterShowSaveFrameData(5,'RSHB','RSHB',0,0,0,0) //商城5件套
        RegisterShowSaveFrameData(5,'RSHC','RSHC',0,0,0,0) //商城8件套

        RegisterShowSaveFrameData(5,'RSHE','RSHE',0,0,0,0) //商城11件套
        RegisterShowSaveFrameData(5,'RSHF','RSHF',0,0,0,0) //商城13件套
        RegisterShowSaveFrameData(5,'RSHG','RSHG',0,0,0,0) //商城14件套
        
        RegisterShowSaveFrameData(5,'RSHH','RSHH',0,0,0,0) //商城16件套

        
        
        
        


        
        

        RegisterShowSaveFrameData(2,'RY1C','RY1C',0,0,0,0) //天乾地坤
        RegisterShowSaveFrameData(2,'RY1E','RY1E',0,0,0,0) //麒麟光环
        RegisterShowSaveFrameData(2,'RY1A','RY1A',0,0,0,0) //血灵光环
        RegisterShowSaveFrameData(2,'RY1B','RY1B',0,0,0,0) //罪焰光环
        RegisterShowSaveFrameData(2,'RY1F','RY1F',0,0,0,0) //墨麟光环
        RegisterShowSaveFrameData(2,'RY1G','RY1G',0,0,0,0) //金龙环绕

        
        RegisterShowSaveFrameData(2,'RY3C','RY3C',0,0,0,0) //崩鸣刃
        RegisterShowSaveFrameData(2,'RY3E','RY3E',0,0,0,0) //凛霜战锤
        RegisterShowSaveFrameData(2,'RY3H','RY3H',0,0,0,0) //方天画戟
        RegisterShowSaveFrameData(2,'RY3I','RY3I',0,0,0,0) //异变之刃    
        RegisterShowSaveFrameData(2,'RY3K','RY3K',0,0,0,0) //糖葫芦
        RegisterShowSaveFrameData(2,'RY3A','RY3A',0,0,0,0) //凝霜
        RegisterShowSaveFrameData(2,'RY3B','RY3B',0,0,0,0) //破阙
        RegisterShowSaveFrameData(2,'RY3G','RY3G',0,0,0,0) //五火七禽扇
        RegisterShowSaveFrameData(2,'RY3J','RY3J',0,0,0,0) //穿刺利刃
        
        


        RegisterShowSaveFrameData(2,'RY2C','RY2C',0,0,0,0) //五彩凰翼
        RegisterShowSaveFrameData(2,'RY2E','RY2E',0,0,0,0) //冰火双翼
        RegisterShowSaveFrameData(2,'RY2F','RY2F',0,0,0,0) //羽族之音
        RegisterShowSaveFrameData(2,'RY2A','RY2A',0,0,0,0) //光洁之翼
        RegisterShowSaveFrameData(2,'RY2B','RY2B',0,0,0,0) //圣灵之翼
        RegisterShowSaveFrameData(2,'RY2H','RY2H',0,0,0,0) //魅惑之翼
        RegisterShowSaveFrameData(2,'RY2J','RY2J',0,0,0,0) //神灵之翼
        RegisterShowSaveFrameData(2,'RY2I','RY2I',0,0,0,0) //断罪神灵
        RegisterShowSaveFrameData(2,'RY2K','RY2K',0,0,0,0) //风筝
        RegisterShowSaveFrameData(2,'RY2L','RY2L',0,0,0,0) //幽兰绝影

        RegisterShowSaveFrameData(2,'RP1B','RP1B',0,0,0,0) //GM-小咸鱼
        RegisterShowSaveFrameData(2,'RP1C','RP1C',0,0,0,0) //福娃
        RegisterShowSaveFrameData(2,'RP1D','RP1D',0,0,0,0) //粽子
        

        
        
        RegisterShowSaveFrameData(1,'RY4E','RY4E',0,0,0,0) //铜皮锻骨 N1
        RegisterShowSaveFrameData(1,'RY4F','RY4F',0,0,0,0) //名将良才 N2
        RegisterShowSaveFrameData(1,'RY4G','RY4G',0,0,0,0) //绝世高人 N3
        RegisterShowSaveFrameData(1,'RY4H','RY4H',0,0,0,0) //降龙伏虎 N4
        RegisterShowSaveFrameData(1,'RY4I','RY4I',0,0,0,0) //剑血浮生 N5
        RegisterShowSaveFrameData(1,'RY4L','RY4L',0,0,0,0) //独孤求败 N6
        RegisterShowSaveFrameData(1,'RY4M','RY4M',0,0,0,0) //独孤求败 N7
        RegisterShowSaveFrameData(1,'RY4Q','RY4Q',0,0,0,0) //九五之尊 N8
        RegisterShowSaveFrameData(1,'RY4R','RY4R',0,0,0,0) //无极修罗 N9
        RegisterShowSaveFrameData(1,'RY4T','RY4T',0,0,0,0) //无极修罗 N10
        RegisterShowSaveFrameData(1,'RY4U','RY4U',0,0,0,0) //魅影无双 N11
        RegisterShowSaveFrameData(1,'RY4X','RY4X',0,0,0,0) //毁天灭地 N12
        RegisterShowSaveFrameData(1,'RY4C','RY4C',0,0,0,0) //俯瞰寰宇
        RegisterShowSaveFrameData(1,'RY4O','RY4O',0,0,0,0) //凌风之灵
        RegisterShowSaveFrameData(1,'RY4A','RY4A',0,0,0,0) //君临天下
        RegisterShowSaveFrameData(1,'RY4B','RY4B',0,0,0,0) //精英玩家
        RegisterShowSaveFrameData(1,'RY4S','RY4S',0,0,0,0) //劳动节称号
        RegisterShowSaveFrameData(1,'RY4V','RY4V',0,0,0,0) //天罡星
        RegisterShowSaveFrameData(1,'RY4W','RY4W',0,0,0,0) //小虎牙
        RegisterShowSaveFrameData(1,'RY4J','RY4J',0,0,0,0) //传说十席
        RegisterShowSaveFrameData(1,'RY4K','RY4K',0,0,0,0) //勇者百席
        RegisterShowSaveFrameData(1,'RY4N','RY4N',0,0,0,0) //测试先锋
        RegisterShowSaveFrameData(1,'RY4P','RY4P',0,0,0,0) //魔芝星耀
        

        

        RegisterShowSaveFrameData(0,'RQD0','RQD0',0,0,0,0) //签到说明
        RegisterShowSaveFrameData(0,'RJ2N','RJ2N',0,0,0,0) //狗作者的道歉
        RegisterShowSaveFrameData(0,'RJ1I','RJ1I',0,0,0,0) //停服补偿
        RegisterShowSaveFrameData(0,'RJ1L','RJ1L',0,0,0,0) //延期补偿

        RegisterShowSaveFrameData(0,'RJ2O','RJ2O',0,0,0,0) //全民竞速
        RegisterShowSaveFrameData(0,'RJ1A','RJ1A',0,0,0,0) //小有成就
        RegisterShowSaveFrameData(0,'RJ1B','RJ1B',0,0,0,0) //老油条
        RegisterShowSaveFrameData(0,'RJ1C','RJ1C',0,0,0,0) //心肝宝贝

        RegisterShowSaveFrameData(0,'RJ1D','RJ1D',0,0,0,0) //铁石心肝
        RegisterShowSaveFrameData(0,'RJ1E','RJ1E',0,0,0,0) //浑身是肝
        RegisterShowSaveFrameData(0,'RJ1F','RJ1F',0,0,0,0) //千年肝帝
        RegisterShowSaveFrameData(0,'RJ1G','RJ1G',0,0,0,0) //万年肝圣

        RegisterShowSaveFrameData(0,'RJ1H','RJ1H',0,0,0,0) //老司机
        RegisterShowSaveFrameData(0,'RJ1J','RJ1J',0,0,0,0) //老司机
        RegisterShowSaveFrameData(0,'RJ1K','RJ1K',0,0,0,0) //老司机
        RegisterShowSaveFrameData(0,'RJ1M','RJ1M',0,0,0,0) //我超强

        RegisterShowSaveFrameData(0,'RJ1N','RJ1N',0,0,0,0) //我究极强
        RegisterShowSaveFrameData(0,'RJ1O','RJ1O',0,0,0,0) //我强无敌
        RegisterShowSaveFrameData(0,0,0,0,0,0,0) //填空假id
        RegisterShowSaveFrameData(0,0,0,0,0,0,0) //填空假id


        RegisterShowSaveFrameData(0,'RJ2A','RJ2A',0,0,0,0) //荣耀之初
        RegisterShowSaveFrameData(0,'RJ2B','RJ2B',0,0,0,0) //荣耀之信
        RegisterShowSaveFrameData(0,'RJ2C','RJ2C',0,0,0,0) //荣耀之心
        RegisterShowSaveFrameData(0,'RJ2D','RJ2D',0,0,0,0) //荣耀之证

        RegisterShowSaveFrameData(0,'RJ2E','RJ2E',0,0,0,0) //荣耀之光
        RegisterShowSaveFrameData(0,'RJ2F','RJ2F',0,0,0,0) //中流砥柱
        RegisterShowSaveFrameData(0,'RJ2G','RJ2G',0,0,0,0) //劳动光荣
        RegisterShowSaveFrameData(0,'RY0A','RY0A',0,0,0,0) //异变之光

        RegisterShowSaveFrameData(0,'RJ2H','RJ2H',0,0,0,0) //狂欢序幕
        RegisterShowSaveFrameData(0,'RJ2I','RJ2I',0,0,0,0) //狂欢进行时
        RegisterShowSaveFrameData(0,'RJ2J','RJ2J',0,0,0,0) //狂欢派对
        RegisterShowSaveFrameData(0,'RJ2K','RJ2K',0,0,0,0) //派对之王

        RegisterShowSaveFrameData(0,'RJ2L','RJ2L',0,0,0,0) //前奏
        RegisterShowSaveFrameData(0,'RJ2M','RJ2M',0,0,0,0) //闪耀之星
        RegisterShowSaveFrameData(0,'RJ2P','RJ2P',0,0,0,0) //夏日赠礼
        RegisterShowSaveFrameData(0,'RJ2Q','RJ2Q',0,0,0,0) //火热开场
        RegisterShowSaveFrameData(0,'RJ2R','RJ2R',0,0,0,0) //酷爽时刻
        RegisterShowSaveFrameData(0,'RJ2S','RJ2S',0,0,0,0) //清凉一夏
        RegisterShowSaveFrameData(0,'RJ2T','RJ2T',0,0,0,0) //夏日之星
        RegisterShowSaveFrameData(0,'RJ2U','RJ2U',0,0,0,0) //火力全开

        RegisterShowSaveFrameData(0,'RJ3A','RJ3A',0,0,0,0)//无尽预热
        RegisterShowSaveFrameData(0,'RJ3B','RJ3B',0,0,0,0)//无尽序幕
        RegisterShowSaveFrameData(0,'RJ3C','RJ3C',0,0,0,0)//无尽先锋
        RegisterShowSaveFrameData(0,'RJ3D','RJ3D',0,0,0,0)//无尽carry
        RegisterShowSaveFrameData(0,'RJ3E','RJ3E',0,0,0,0)//无尽之力
        RegisterShowSaveFrameData(0,'RJ3F','RJ3F',0,0,0,0)//世界之力
        RegisterShowSaveFrameData(0,'RJ3G','RJ3G',0,0,0,0)//三界凭证
        RegisterShowSaveFrameData(0,'RJ3H','RJ3H',0,0,0,0)//返璞归真

        RegisterShowSaveFrameData(0,'RJ3I','RJ3I',0,0,0,0)//出奇制胜
        RegisterShowSaveFrameData(0,'RJ3J','RJ3J',0,0,0,0)//雄才大略
        RegisterShowSaveFrameData(0,'RJ3K','RJ3K',0,0,0,0)//势如破竹
        RegisterShowSaveFrameData(0,'RJ3L','RJ3L',0,0,0,0)//家财万贯
        RegisterShowSaveFrameData(0,'RJ3M','RJ3M',0,0,0,0)//战无不克
        RegisterShowSaveFrameData(0,'RJ3N','RJ3N',0,0,0,0)//全民皆兵
        RegisterShowSaveFrameData(0,'RJ3O','RJ3O',0,0,0,0)//用兵如神
        RegisterShowSaveFrameData(0,'RJ3P','RJ3P',0,0,0,0)//过关斩将
        

        RegisterShowSaveFrameData(0,'RG0B','RG0B',0,0,0,0) //难2通关5次
        RegisterShowSaveFrameData(0,'RG0C','RG0C',0,0,0,0) //难3通关5次
        RegisterShowSaveFrameData(0,'RG0D','RG0D',0,0,0,0) //难4通关5次
        RegisterShowSaveFrameData(0,'RG0E','RG0E',0,0,0,0) //难5通关5次
        RegisterShowSaveFrameData(0,'RG0F','RG0F',0,0,0,0) //难6通关5次
        RegisterShowSaveFrameData(0,'RG0G','RG0G',0,0,0,0) //难7通关5次
        RegisterShowSaveFrameData(0,'RG0H','RG0H',0,0,0,0) //难8通关5次
        RegisterShowSaveFrameData(0,'RG0I','RG0I',0,0,0,0) //难9通关5次
        RegisterShowSaveFrameData(0,'RG0J','RG0J',0,0,0,0) //难10通关5次
        RegisterShowSaveFrameData(0,'RG0K','RG0K',0,0,0,0) //难11通关5次
        RegisterShowSaveFrameData(0,'RG0L','RG0L',0,0,0,0) //难12通关5次
        RegisterShowSaveFrameData(0,0,0,0,0,0,0) //填空假id


        RegisterShowSaveFrameData(0,'RG1A','RG1A',0,0,0,0) //难1通关15次
        RegisterShowSaveFrameData(0,'RG1B','RG1B',0,0,0,0) //难2通关15次
        RegisterShowSaveFrameData(0,'RG1C','RG1C',0,0,0,0) //难3通关15次
        RegisterShowSaveFrameData(0,'RG1D','RG1D',0,0,0,0) //难4通关15次
        RegisterShowSaveFrameData(0,'RG1E','RG1E',0,0,0,0) //难5通关15次
        RegisterShowSaveFrameData(0,'RG1F','RG1F',0,0,0,0) //难6通关15次
        RegisterShowSaveFrameData(0,'RG1G','RG1G',0,0,0,0) //难7通关15次
        RegisterShowSaveFrameData(0,'RG1H','RG1H',0,0,0,0) //难8通关15次
        RegisterShowSaveFrameData(0,'RG1I','RG1I',0,0,0,0) //难9通关15次
        RegisterShowSaveFrameData(0,'RG1J','RG1J',0,0,0,0) //难10通关15次
        RegisterShowSaveFrameData(0,'RG1K','RG1K',0,0,0,0) //难11通关15次
        RegisterShowSaveFrameData(0,'RG1L','RG1L',0,0,0,0) //难12通关15次
    


        RegisterShowSaveFrameData(0,'RGAA','RGAA',0,0,0,0) //通关疯狂N1
        RegisterShowSaveFrameData(0,'RGAB','RGAB',0,0,0,0) //通关疯狂N2
        RegisterShowSaveFrameData(0,'RGAC','RGAC',0,0,0,0) //通关疯狂N3
        RegisterShowSaveFrameData(0,'RGAD','RGAD',0,0,0,0) //通关疯狂N4
        RegisterShowSaveFrameData(0,'RGAE','RGAE',0,0,0,0) //通关疯狂N5
        RegisterShowSaveFrameData(0,'RGAF','RGAF',0,0,0,0) //通关疯狂N6
        RegisterShowSaveFrameData(0,'RGAG','RGAG',0,0,0,0) //通关疯狂N7
        RegisterShowSaveFrameData(0,'RGAH','RGAH',0,0,0,0) //通关疯狂N8
        RegisterShowSaveFrameData(0,'RGAI','RGAI',0,0,0,0) //通关疯狂N9
        RegisterShowSaveFrameData(0,'RGAJ','RGAJ',0,0,0,0) //通关疯狂N10
        RegisterShowSaveFrameData(0,'RGAK','RGAK',0,0,0,0) //通关疯狂N11
        RegisterShowSaveFrameData(0,'RGAL','RGAL',0,0,0,0) //通关疯狂N12


        RegisterShowSaveFrameData(0,'RGBA','RGBA',0,0,0,0) //通关异变N1
        RegisterShowSaveFrameData(0,'RGBB','RGBB',0,0,0,0) //通关异变N2
        RegisterShowSaveFrameData(0,'RGBC','RGBC',0,0,0,0) //通关异变N3
        RegisterShowSaveFrameData(0,'RGBD','RGBD',0,0,0,0) //通关异变N4
        RegisterShowSaveFrameData(0,'RGBE','RGBE',0,0,0,0) //通关异变N5
        RegisterShowSaveFrameData(0,'RGBF','RGBF',0,0,0,0) //通关异变N6
        RegisterShowSaveFrameData(0,'RGBG','RGBG',0,0,0,0) //通关异变N7
        RegisterShowSaveFrameData(0,'RGBH','RGBH',0,0,0,0) //通关异变N8

        RegisterShowSaveFrameData(0,'RGCA','RGCA',0,0,0,0) //通关异变N1 8次
        RegisterShowSaveFrameData(0,'RGCB','RGCB',0,0,0,0) //通关异变N2 8次
        RegisterShowSaveFrameData(0,'RGCC','RGCC',0,0,0,0) //通关异变N3 8次
        RegisterShowSaveFrameData(0,'RGCD','RGCD',0,0,0,0) //通关异变N4 8次
        RegisterShowSaveFrameData(0,'RGCE','RGCE',0,0,0,0) //通关异变N5 8次
        RegisterShowSaveFrameData(0,'RGCF','RGCF',0,0,0,0) //通关异变N6 8次
        RegisterShowSaveFrameData(0,'RGCG','RGCG',0,0,0,0) //通关异变N7 8次
        RegisterShowSaveFrameData(0,'RGCH','RGCH',0,0,0,0) //通关异变N8 8次

        RegisterShowSaveFrameData(0,'RGDA','RGDA',0,0,0,0) //通关异变N1 15次
        RegisterShowSaveFrameData(0,'RGDB','RGDB',0,0,0,0) //通关异变N2 15次
        RegisterShowSaveFrameData(0,'RGDC','RGDC',0,0,0,0) //通关异变N3 15次
        RegisterShowSaveFrameData(0,'RGDD','RGDD',0,0,0,0) //通关异变N4 15次
        RegisterShowSaveFrameData(0,'RGDE','RGDE',0,0,0,0) //通关异变N5 15次
        RegisterShowSaveFrameData(0,'RGDF','RGDF',0,0,0,0) //通关异变N6 15次
        RegisterShowSaveFrameData(0,'RGDG','RGDG',0,0,0,0) //通关异变N7 15次
        RegisterShowSaveFrameData(0,'RGDH','RGDH',0,0,0,0) //通关异变N8 15次

        RegisterShowSaveFrameData(0,'RGEA','RGEA',0,0,0,0) //通关超爽N1&地图3级
        RegisterShowSaveFrameData(0,'RGEB','RGEB',0,0,0,0) //通关超爽N2&地图3级
        RegisterShowSaveFrameData(0,'RGEC','RGEC',0,0,0,0) //通关超爽N3&地图5级
        RegisterShowSaveFrameData(0,'RGED','RGED',0,0,0,0) //通关超爽N4&地图7级
        RegisterShowSaveFrameData(0,'RGEE','RGEE',0,0,0,0) //通关超爽N5&地图9级
        RegisterShowSaveFrameData(0,0,0,0,0,0,0) //填空假id
        RegisterShowSaveFrameData(0,0,0,0,0,0,0) //填空假id
        RegisterShowSaveFrameData(0,0,0,0,0,0,0) //填空假id

        RegisterShowSaveFrameData(0,'RGFA','RGFA',0,0,0,0) //超爽N1通关5次&地图3级
        RegisterShowSaveFrameData(0,'RGFB','RGFB',0,0,0,0) //超爽N2通关5次&地图3级
        RegisterShowSaveFrameData(0,'RGFC','RGFC',0,0,0,0) //超爽N3通关5次&地图5级
        RegisterShowSaveFrameData(0,'RGFD','RGFD',0,0,0,0) //超爽N4通关5次&地图7级
        RegisterShowSaveFrameData(0,'RGFE','RGFE',0,0,0,0) //超爽N5通关5次&地图9级
        RegisterShowSaveFrameData(0,0,0,0,0,0,0) //填空假id
        RegisterShowSaveFrameData(0,0,0,0,0,0,0) //填空假id
        RegisterShowSaveFrameData(0,0,0,0,0,0,0) //填空假id

        RegisterShowSaveFrameData(0,'RGGA','RGGA',0,0,0,0) //超爽N1通关12次&地图3级
        RegisterShowSaveFrameData(0,'RGGB','RGGB',0,0,0,0) //超爽N2通关12次&地图3级
        RegisterShowSaveFrameData(0,'RGGC','RGGC',0,0,0,0) //超爽N3通关12次&地图5级
        RegisterShowSaveFrameData(0,'RGGD','RGGD',0,0,0,0) //超爽N4通关12次&地图7级
        RegisterShowSaveFrameData(0,'RGGE','RGGE',0,0,0,0) //超爽N5通关12次&地图9级
        RegisterShowSaveFrameData(0,0,0,0,0,0,0) //填空假id
        RegisterShowSaveFrameData(0,0,0,0,0,0,0) //填空假id
        RegisterShowSaveFrameData(0,0,0,0,0,0,0) //填空假id


        RegisterShowSaveFrameData(0,'RGHA','RGHA',0,0,0,0)//无尽N1达到15层
        RegisterShowSaveFrameData(0,'RGHB','RGHB',0,0,0,0)//无尽N2达到15层
        RegisterShowSaveFrameData(0,'RGHC','RGHC',0,0,0,0)//无尽N3达到15层
        RegisterShowSaveFrameData(0,'RGHD','RGHD',0,0,0,0)//无尽N4达到15层

        RegisterShowSaveFrameData(0,'RGIA','RGIA',0,0,0,0)//无尽N1达到30层
        RegisterShowSaveFrameData(0,'RGIB','RGIB',0,0,0,0)//无尽N2达到30层
        RegisterShowSaveFrameData(0,'RGIC','RGIC',0,0,0,0)//无尽N3达到30层
        RegisterShowSaveFrameData(0,'RGID','RGID',0,0,0,0)//无尽N4达到30层

        RegisterShowSaveFrameData(0,'RGJA','RGJA',0,0,0,0)//无尽N1达到40层
        RegisterShowSaveFrameData(0,'RGJB','RGJB',0,0,0,0)//无尽N2达到40层
        RegisterShowSaveFrameData(0,'RGJC','RGJC',0,0,0,0)//无尽N3达到40层
        RegisterShowSaveFrameData(0,'RGJD','RGJD',0,0,0,0)//无尽N4达到40层

        

//        RegisterShowSaveFrameData(6,'RDAA','RDAA',0,0,0,0) //果然暴君
        RegisterShowSaveFrameData(6,'RDAB','RDAB',0,0,0,0) //我真的知错了
        RegisterShowSaveFrameData(6,'RDAC','RDAC',0,0,0,0) //老婆别打了
        RegisterShowSaveFrameData(6,'RDAD','RDAD',0,0,0,0) //家暴
        RegisterShowSaveFrameData(6,'RDAE','RDAE',0,0,0,0) //我救我自己
        RegisterShowSaveFrameData(6,'RDAF','RDAF',0,0,0,0) //我也护犊子
        RegisterShowSaveFrameData(6,'RDAG','RDAG',0,0,0,0) //爸，我回来了
        RegisterShowSaveFrameData(6,'RDAH','RDAH',0,0,0,0) //太欧了！
        RegisterShowSaveFrameData(6,'RDAI','RDAI',0,0,0,0) //护犊子
        RegisterShowSaveFrameData(6,'RDAJ','RDAJ',0,0,0,0) //真假....猴精..
        RegisterShowSaveFrameData(6,'RDAK','RDAK',0,0,0,0) //穿越回来还打你！
        RegisterShowSaveFrameData(6,'RDAL','RDAL',0,0,0,0) //抓了再救
        RegisterShowSaveFrameData(6,'RDAM','RDAM',0,0,0,0) //我自己来
        RegisterShowSaveFrameData(6,'RDAN','RDAN',0,0,0,0) //报仇雪恨
        RegisterShowSaveFrameData(6,'RDAO','RDAO',0,0,0,0) //悬壶济世
//        RegisterShowSaveFrameData(6,'RDAP','RDAP',0,0,0,0) //销售精英
//        RegisterShowSaveFrameData(6,'RDAQ','RDAQ',0,0,0,0) //红颜祸水
//        RegisterShowSaveFrameData(6,'RDAR','RDAR',0,0,0,0) //今晚的月亮好圆啊
//        RegisterShowSaveFrameData(6,'RDAS','RDAS',0,0,0,0) //自己人也打？
        RegisterShowSaveFrameData(6,'RDAT','RDAT',0,0,0,0) //师弟，你不行
        RegisterShowSaveFrameData(6,'RDAU','RDAU',0,0,0,0) //师弟，你真不行
       RegisterShowSaveFrameData(6,'RDAV','RDAV',0,0,0,0) //姐妹情深
        RegisterShowSaveFrameData(6,'RDAW','RDAW',0,0,0,0) //打自己人怎么了？
        RegisterShowSaveFrameData(6,'RDAX','RDAX',0,0,0,0) //龙王出来喷水
        RegisterShowSaveFrameData(6,'RDAY','RDAY',0,0,0,0) //今天爆率真高啊
        RegisterShowSaveFrameData(6,'RDAZ','RDAZ',0,0,0,0) //评论
        RegisterShowSaveFrameData(6,'RDBA','RDBA',0,0,0,0) //小富豪
        RegisterShowSaveFrameData(6,'RDBB','RDBB',0,0,0,0) //万匹斯

        

        RegisterShowSaveFrameData(3,'RHD1','RHD1',0,0,0,0) //小有所成
        RegisterShowSaveFrameData(3,'RHD2','RHD2',0,0,0,0) //炉火纯青
        RegisterShowSaveFrameData(3,'RHD3','RHD3',0,0,0,0) //一代宗师
        RegisterShowSaveFrameData(3,'RHD4','RHD4',0,0,0,0) //名震一方
        RegisterShowSaveFrameData(3,'RHD5','RHD5',0,0,0,0) //名扬四海
        RegisterShowSaveFrameData(3,'RHD6','RHD6',0,0,0,0) //封神之巅
        RegisterShowSaveFrameData(3,'RHD7','RHD7',0,0,0,0) //创世之初
//        RegisterShowSaveFrameData(3,'RHD8','RHD8',0,0,0,0) //创世元神
        RegisterShowSaveFrameData(3,'RH01','RH01',0,0,0,0) //神兵杨戬
        RegisterShowSaveFrameData(3,'RH02','RH02',0,0,0,0) //土行孙
        RegisterShowSaveFrameData(3,'RH03','RH03',0,0,0,0) //元始天尊
        RegisterShowSaveFrameData(3,'RH04','RH04',0,0,0,0) //魔化哪吒
        RegisterShowSaveFrameData(3,'RH05','RH05',0,0,0,0) //老子
        RegisterShowSaveFrameData(3,'RH06','RH06',0,0,0,0) //陆压
//        RegisterShowSaveFrameData(3,'RH07','RH07',0,0,0,0) //女娲
        RegisterShowSaveFrameData(3,'RH08','RH08',0,0,0,0) //妖皇妲己
        RegisterShowSaveFrameData(3,'RH09','RH09',0,0,0,0) //剑仙广成子
        RegisterShowSaveFrameData(3,'RH10','RH10',0,0,0,0) //变幻杨戬
        RegisterShowSaveFrameData(3,'RH11','RH11',0,0,0,0) //姜子牙
        RegisterShowSaveFrameData(3,'RH12','RH12',0,0,0,0) //天王李靖
        RegisterShowSaveFrameData(3,'RH13','RH13',0,0,0,0) //美猴王
        RegisterShowSaveFrameData(3,'RH14','RH14',0,0,0,0) //龙吉公主
        RegisterShowSaveFrameData(3,'RH15','RH15',0,0,0,0) //龟灵圣母
        RegisterShowSaveFrameData(3,'RH16','RH16',0,0,0,0) //老年纣王
        RegisterShowSaveFrameData(3,'RH17','RH17',0,0,0,0) //枪阵哪吒
        RegisterShowSaveFrameData(3,'RH18','RH18',0,0,0,0) //太乙真人
        RegisterShowSaveFrameData(3,'RH19','RH19',0,0,0,0) //天眼杨戬
        RegisterShowSaveFrameData(3,'RH20','RH20',0,0,0,0) //莲花化身
        RegisterShowSaveFrameData(3,'RH21','RH21',0,0,0,0) //嫦娥
        RegisterShowSaveFrameData(3,'RH22','RH22',0,0,0,0) //疾风雷震子
        RegisterShowSaveFrameData(3,'RH23','RH23',0,0,0,0) //狐媚妲己
        RegisterShowSaveFrameData(3,'RH24','RH24',0,0,0,0) //申公豹
        RegisterShowSaveFrameData(3,'RH25','RH25',0,0,0,0) //黄天化
        RegisterShowSaveFrameData(3,'RH26','RH26',0,0,0,0) //斗战胜佛
        RegisterShowSaveFrameData(3,'RH27','RH27',0,0,0,0) //暴君纣王
        RegisterShowSaveFrameData(3,'RH28','RH28',0,0,0,0) //蛮力纣王
        RegisterShowSaveFrameData(3,'RH29','RH29',0,0,0,0) //神农
        RegisterShowSaveFrameData(3,'RH30','RH30',0,0,0,0) //后羿
        RegisterShowSaveFrameData(3,'RH32','RH32',0,0,0,0) //帝皇姬昌
        RegisterShowSaveFrameData(3,'RH33','RH33',0,0,0,0) //哮天犬
        RegisterShowSaveFrameData(3,'RH34','RH34',0,0,0,0) //准提道人
        RegisterShowSaveFrameData(3,'RH35','RH35',0,0,0,0) //邓婵玉
        RegisterShowSaveFrameData(3,'RH36','RH36',0,0,0,0) //苟作者
        RegisterShowSaveFrameData(3,'RH37','RH37',0,0,0,0) //苟策划
        RegisterShowSaveFrameData(3,'RH38','RH38',0,0,0,0) //女娲
        RegisterShowSaveFrameData(3,'RH39','RH39',0,0,0,0) //孔宣
        RegisterShowSaveFrameData(3,'RH40','RH40',0,0,0,0) //龟丞相
        RegisterShowSaveFrameData(3,'RH41','RH41',0,0,0,0) //巨灵神
        RegisterShowSaveFrameData(3,'RH42','RH42',0,0,0,0) //老龙王




        RegisterShowSaveFrameData(7,'RM10','RM1A',0,0,0,0) //任脉
        RegisterShowSaveFrameData(7,'RM20','RM2A',0,0,0,0) //督脉
        RegisterShowSaveFrameData(7,'RM30','RM3A',0,0,0,0) //冲脉
        RegisterShowSaveFrameData(7,'RM40','RM4A',0,0,0,0) //带脉
        RegisterShowSaveFrameData(7,'RM50','RM5A',0,0,0,0) //阴跷脉
        RegisterShowSaveFrameData(7,'RM60','RM6A',0,0,0,0) //阳跷脉
        RegisterShowSaveFrameData(7,'RM70','RM7A',0,0,0,0) //阴维脉
        RegisterShowSaveFrameData(7,'RM80','RM8A',0,0,0,0) //阳维脉
        RegisterShowSaveFrameData(7,'RX10','RX1A',0,0,0,0) //龙筋
        RegisterShowSaveFrameData(7,'RX20','RX2A',0,0,0,0) //龙鳞
        RegisterShowSaveFrameData(7,'RX30','RX3A',0,0,0,0) //龙血
        RegisterShowSaveFrameData(7,'RX40','RX4A',0,0,0,0) //龙骨
        RegisterShowSaveFrameData(7,'RX50','RX5A',0,0,0,0) //龙爪
        RegisterShowSaveFrameData(7,'RX60','RX6A',0,0,0,0) //龙角
        RegisterShowSaveFrameData(7,'RX70','RX7A',0,0,0,0) //龙皮
        RegisterShowSaveFrameData(7,'RX80','RX8A',0,0,0,0) //龙心




        RegisterShowSaveFrameData(4,'RY9A','RY9A',0,0,0,0) //封神谕令Lv1
        RegisterShowSaveFrameData(4,'RY9B','RY9B',0,0,0,0) //封神谕令Lv2
        RegisterShowSaveFrameData(4,'RY9C','RY9C',0,0,0,0) //封神谕令Lv3
        RegisterShowSaveFrameData(4,'RY9D','RY9D',0,0,0,0) //封神谕令Lv4
        RegisterShowSaveFrameData(4,'RY9E','RY9E',0,0,0,0) //封神谕令Lv5
        RegisterShowSaveFrameData(4,'RY9F','RY9F',0,0,0,0) //封神谕令Lv6
        RegisterShowSaveFrameData(4,'RY9G','RY9G',0,0,0,0) //封神谕令Lv7
        RegisterShowSaveFrameData(4,'RY9H','RY9H',0,0,0,0) //封神谕令Lv8
        RegisterShowSaveFrameData(4,'RY9I','RY9I',0,0,0,0) //封神谕令Lv9
        RegisterShowSaveFrameData(4,'RY9J','RY9J',0,0,0,0) //封神谕令Lv10
        RegisterShowSaveFrameData(4,'RY9K','RY9K',0,0,0,0) //封神谕令Lv11
        RegisterShowSaveFrameData(4,'RY9L','RY9L',0,0,0,0) //封神谕令Lv12
        RegisterShowSaveFrameData(4,'RY9M','RY9M',0,0,0,0) //封神谕令Lv13
    endfunction


    
    function IsSaveFrameTechUnLock(int pid,int index)->bool
        string s = ""
        int step = Step[pid]
        int page = Page[pid]
        int techid = 0
        int lock = 1
        for i = 1,5
            techid = GetShowSaveTech(page,index+step*4,i)
            if  techid > 0
                if  GetPlayerTechCount(Player(pid),techid,true) == 0
                    return false
                endif
            else
                exitwhen true
            endif
        end
        return true
    endfunction

    function GetShowSaveFrameTechTips(int pid,int index)->string
        string s = ""
        int step = Step[pid]
        int page = Page[pid]
        int techid = 0
        int lock = 1
        
        for i = 1,5
            techid = GetShowSaveTech(page,index+step*4,i)
            if  techid > 0
                lock = 0
                if  GetPlayerTechCount(Player(pid),techid,true) > 0
                    s = s + "\n|cff00ff00 - "+GetObjectName(techid) + "|r"
                else
                    s = s + "\n|cff808080 - "+GetObjectName(techid) + "|r"
                endif
            else
                exitwhen true
            endif
        end
        if  lock == 1
            return ""
        else
            return "|cffffff00需求：|r"+s
        endif
    endfunction

    //判断是否有外观显示
    function IsSaveIdCanShow(int id,int page)->bool
        if  page == 1 or page == 2
            return true
        elseif  id == 'RY1D' or id == 'RY2D' or id == 'RY3D' or id == 'RY4D' or id == 'RY2G' or id == 'RP1A' or id == 'RY3F'
            return true
        endif
        return false
    endfunction

    function BoxShowPassCheck(int pid,int index,int id)
        if  id > 0
            DzFrameShow(UI_TipsHead, true)
            SetTipsData(1,"",GetTypeIdName(id))
            
            SetTipsData(10,"",GetTypeIdStateTips(id))
            SetTipsData(11,"",GetTypeIdTips(id))
            ShowTipsUI()
        endif
    endfunction



    
    function RefreshOrnament(int pid,int id)
        int sid = id - 0x11000000
        int index = 0
        int nowid = 0
        if  sid >= 'AY1A' and sid <= 'AY1Z'
            index = 1
        elseif  sid >= 'AY2A' and sid <= 'AY2Z'
            index = 2
        elseif  sid >= 'AY3A' and sid <= 'AY3Z'
            index = 3
        elseif  sid >= 'AY4A' and sid <= 'AY4Z'
            index = 4
        elseif  sid >= 'AP1A' and sid <= 'AP1Z'
            index = 9
        endif

        BJDebugMsg("点击的id"+YDWEId2S(sid))

        if  index != 0
            if  index == 9
                for i2 = 0,25
                    if  GetUnitAbilityLevel(Pu[1],'AP1A'+i2) > 0
                        nowid = 'AP1A'+i2
                        exitwhen true
                    endif
                end
            else
                for i = 0,25
                    if  GetUnitAbilityLevel(Pu[1],'AY0A'+i+index*0x100) > 0
                        nowid = 'AY0A'+i+index*0x100
                        exitwhen true
                    endif
                end
            endif
            
            if  nowid != 0
                UnitRemoveAbility(Pu[1],nowid)
            endif


            if  sid == nowid
                
                if  nowid >= 'AP1A' and nowid <= 'AP1Z'
                    DzSetUnitModel(Pu[2],"Unit_CraneGod.mdl")
                    SetUnitScale(Pu[2],0.9,0.9,0.9)
                    DisplayTimedTextToPlayer(Player(pid),0,0,10,"|cffff0000[系统]：|r助手皮肤隐藏成功！")
                else
                    DisplayTimedTextToPlayer(Player(pid),0,0,10,"|cffff0000[系统]：|r外观隐藏成功！")
                endif
            else
                BJDebugMsg(YDWEId2S(sid))
                if  sid >= 'AP1A' and sid <= 'AP1Z'
                    if  sid == 'AP1A'
                        DzSetUnitModel(Pu[2],"zs_rykj.mdl")
                        SetUnitScale(Pu[2],2.5,2.5,2.5)
                    elseif  sid == 'AP1B'
                        DzSetUnitModel(Pu[2],"moster_sumo.mdl")
                        SetUnitScale(Pu[2],1,1,1)
                    elseif  sid == 'AP1C'
                        DzSetUnitModel(Pu[2],"AttackRoom_renshenwawaA1.mdl")
                        SetUnitScale(Pu[2],0.8,0.8,0.8)
                    elseif  sid == 'AP1D'
                        DzSetUnitModel(Pu[2],"GUAI_zongziEx.mdl")
                        SetUnitScale(Pu[2],0.8,0.8,0.8)
                    endif
                    DisplayTimedTextToPlayer(Player(pid),0,0,10,"|cffff0000[系统]：|r助手皮肤替换成功！")
                else
                    if  nowid == 0
                        DisplayTimedTextToPlayer(Player(pid),0,0,10,"|cffff0000[系统]：|r外观激活成功！")
                    else
                        DisplayTimedTextToPlayer(Player(pid),0,0,10,"|cffff0000[系统]：|r外观替换成功！")
                    endif
                endif
                UnitAddAbility(Pu[1],sid)
            endif
        endif
    endfunction

    function GetShowLevelTip(int lv,int now)->string
        if  now >= lv
            return "Lv."+I2S(lv)
        else
            return "|cff808080Lv."+I2S(lv)
        endif
    endfunction


    function BoxShowHeroSave(int pid,int uid)
        int id = uid - 'H000' + 'RH00'
        int lv = 0
        int use = 0
        int exp = 0
        int state
        real value
        if  id > 0
            DzFrameShow(UI_TipsHead, true)
            
            lv = GetDzHeroExpLevel(pid,uid)
            if  lv == 0
                use = 12
            elseif  lv == 1
                use = 24
            elseif  lv == 2
                use = 36
            elseif  lv == 3
                use = 72
            else
                use = 96
            endif

            exp = GetDzHeroExp(pid,uid)
            if  use > 96
                use = 96
            endif
            if  exp > 96
                exp = 96
            endif

            
            if  lv == 4
                SetTipsData(1,"",GetTypeIdName(id)+" Lv.Max")
                SetTipsData(10,"","|cff808080熟练度：|r")
                SetTipsData(11,"","|cff00ff000|r/0\n ")
            else
                SetTipsData(1,"",GetTypeIdName(id)+" Lv."+I2S(lv))
                SetTipsData(10,"","|cff808080熟练度：|r")
                SetTipsData(11,"","|cff00ff00"+I2S(exp*10)+"|r/"+I2S(use*10)+"\n ")
            endif
            
            
    

            for s = 1,3
                state = GetTypeIdData(id,200+s)
                value = GetTypeIdReal(id,200+s)
                SetTipsData(11+s,"",GetShowLevelTip(s,lv)+"：提高该英雄"+I2S(R2I(value))+StateName[1000+state]+StateName[state])
            end

            SetTipsData(15,"",GetShowLevelTip(4,lv)+"：提高该英雄30%暴击伤害，异变模式下经验加成+30%")


            SetTipsData(16,"","")
            SetTipsData(17,"","|Cff00FF7F每次通关增加(难度+1)*10熟练度。|r\n|Cff00FF7F15波后游戏失败时增加20熟练度。|r")
            
            
            if  id == 'RH36'
                SetTipsData(18,"","地图等级16级加入随机英雄池，30级可手选。")
            elseif  id == 'RH37'
                SetTipsData(18,"","地图等级36级可手选。")
            elseif  id == 'RH40'
                SetTipsData(18,"","龙宫积分达到48个时可选择，输入“JF”查询。")
            elseif  id == 'RH42'
                SetTipsData(18,"","任意龙宝达到10级时可选择。")
            endif

            ShowTipsUI()
        endif
    endfunction


    //显示说明
    function BoxShowSaveFrame(int pid,int index)
        int step = Step[pid]
        int page = Page[pid]
        int id = GetShowSaveId(page,index+step*4)
        int h = 10
        
        int unlock = 0
        string tech = ""
        int lv = 0
        int uid = 0
        int exp = 0
        int use = 0
        int num = 0

        real value = 0
        int state = 0
        //BJDebugMsg("page"+I2S(page)+"step"+I2S(step))
        if  id > 0
            DzFrameSetTexture(BUTTON_Back[index+500][4] , "war3mapImported\\UI_BUTTON_High.blp", 0)
            DzFrameShow(UI_TipsHead, true)
            
            if  id >= 'RM10' and id <= 'RM80'
                lv = GetDzPlayerData(pid,6,(id - 'RM00')/256+1)
                SetTipsData(1,"",GetTypeIdName(id)+" Lv."+I2S(lv))
                //当前经脉最高10级
                if  lv == 0
                    SetTipsData(10,"","|cffffff00需求：|r\n - |cff808080解锁该经脉|r")
                else
                    SetTipsData(10,""," ")
                endif
                h = 11
                for i = 1,10
                    if  lv >= i
                        SetTipsData(h,"","Lv."+I2S(i)+"："+GetTypeIdName(id+i+16))
                    else
                        SetTipsData(h,"","|cff808080Lv."+I2S(i)+"："+GetTypeIdName(id+i+16)+"|r")
                    endif
                    h = h + 1
                end

            elseif  id >= 'RX10' and id <= 'RX80'
                lv = GetDzPlayerData(pid,6,(id - 'RX00')/256+11)
                SetTipsData(1,"",GetTypeIdName(id)+" Lv."+I2S(lv))
                //当前龙宫最高5级
                if  lv == 0
                    SetTipsData(10,"","|cffffff00需求：|r\n - |cff808080解锁该宝物|r")
                else
                    SetTipsData(10,""," ")
                endif
                h = 11
                for i = 1,10
                    if  lv >= i
                        if  i > 5
                            SetTipsData(h,"","Lv."+I2S(i)+"："+GetTypeIdName(id+i+0x100B))
                        else
                            SetTipsData(h,"","Lv."+I2S(i)+"："+GetTypeIdName(id+i+16))
                        endif
                    else
                        if  i > 5
                            SetTipsData(h,"","|cff808080Lv."+I2S(i)+"："+GetTypeIdName(id+i+0x100B)+"|r")
                        else
                            SetTipsData(h,"","|cff808080Lv."+I2S(i)+"："+GetTypeIdName(id+i+16)+"|r")
                        endif
                    endif
                    h = h + 1
                end
            elseif  id == 'RQD0'
                int sign = GetDzPlayerData(pid,1,5) //今日
                int Lsign = GetDzPlayerData(pid,1,6) //连续
                int Asign = GetDzPlayerData(pid,1,7) //累积
                SetTipsData(1,"","签到")

                SetTipsData(10,"","|cffffcc00累计签到：|r"+I2S(Asign))
                SetTipsData(11,"","|cffffcc00连续签到：|r"+I2S(Lsign))
                SetTipsData(12,"","")

                SetTipsData(13,"","|cff00ff00 每日签到奖励：6+连签天数个签到钻石。最多上限为14")
                

            elseif  id >= 'RH01' and id <= 'RH99'
                uid = id-'RH00'+'H000'
                lv = GetDzHeroExpLevel(pid,uid)
                if  lv == 0
                    use = 12
                elseif  lv == 1
                    use = 24
                elseif  lv == 2
                    use = 36
                elseif  lv == 3
                    use = 72
                else
                    use = 96
                endif

                exp = GetDzHeroExp(pid,uid)
                if  use > 96
                    use = 96
                endif
                if  exp > 96
                    exp = 96
                endif

                
                if  lv == 4
                    SetTipsData(1,"",GetTypeIdName(id)+" Lv.Max")
                    SetTipsData(10,"","|cff808080熟练度：|r")
                    SetTipsData(11,"","|cff00ff000|r/0\n ")
                else
                    SetTipsData(1,"",GetTypeIdName(id)+" Lv."+I2S(lv))
                    SetTipsData(10,"","|cff808080熟练度：|r")
                    SetTipsData(11,"","|cff00ff00"+I2S(exp*10)+"|r/"+I2S(use*10)+"\n ")
                endif
                
                
        

                for s = 1,3
                    state = GetTypeIdData(id,200+s)
                    value = GetTypeIdReal(id,200+s)
                    SetTipsData(11+s,"",GetShowLevelTip(s,lv)+"：提高该英雄"+I2S(R2I(value))+StateName[1000+state]+StateName[state])
                end

                SetTipsData(15,"",GetShowLevelTip(4,lv)+"：提高该英雄30%暴击伤害，异变模式下经验加成+30%")


                SetTipsData(16,"","")
                SetTipsData(17,"","|Cff00FF7F每次通关增加(难度+1)*10熟练度。|r\n|Cff00FF7F15波后游戏失败时增加20熟练度。|r")
                
                
                if  id == 'RH36'
                    SetTipsData(18,"","地图等级16级加入随机英雄池，30级可手选。")
                elseif  id == 'RH37'
                    SetTipsData(18,"","地图等级36级可手选。")
                elseif  id == 'RH40'
                    SetTipsData(18,"","龙宫积分达到48个时可选择，输入“JF”查询。")
                elseif  id == 'RH42'
                    SetTipsData(18,"","任意龙宝达到10级时可选择。")
                endif
            
                
            elseif  id >= 'RDAA' and id <= 'RDBZ'
                if  IsSaveFrameTechUnLock(pid,index) == true
                    SetTipsData(1,"",GetTypeIdName(id))
                    
                    SetTipsData(10,"",GetTypeIdStateTips(id))
                    SetTipsData(11,"",GetTypeIdTips(id))
                else
                    SetTipsData(1,"","|cff808080[彩蛋]？？？")
                    SetTipsData(10,"","|cffffff00需求：|r|n |cff808080- 未知解锁条件|r")
                    SetTipsData(11,"","|cff808080"+GetTypeIdStateTips(id)+"|r")
                    SetTipsData(12,"","|cff808080"+GetTypeIdTips(id))
                endif
            else
                if  GetUnitAbilityLevel(Pu[1],id - 0x11000000 ) > 0 and ( page == 1 or page == 2 or page == 5 )
                    SetTipsData(1,"",GetTypeIdName(id)+" - |cff00ff00已激活|r")
                else
                    if  id >= 'RSHA' and id <= 'RSHZ'
                        num = GetPlayerBuyShopNumber(pid)
                        if  id == 'RSHA' and num < 3
                            SetTipsData(1,"",GetTypeIdName(id)+"(|cffff0000"+I2S(num)+"|r/3)")
                        elseif  id == 'RSHB' and num < 5
                            SetTipsData(1,"",GetTypeIdName(id)+"(|cffff0000"+I2S(num)+"|r/5)")
                        elseif  id == 'RSHC' and num < 8
                            SetTipsData(1,"",GetTypeIdName(id)+"(|cffff0000"+I2S(num)+"|r/8)")
                        elseif  id == 'RSHD' and num < 4
                            SetTipsData(1,"",GetTypeIdName(id)+"(|cffff0000"+I2S(num)+"|r/4)")
                        elseif  id == 'RSHE' and num < 11
                            SetTipsData(1,"",GetTypeIdName(id)+"(|cffff0000"+I2S(num)+"|r/11)")
                        elseif  id == 'RSHF' and num < 13
                            SetTipsData(1,"",GetTypeIdName(id)+"(|cffff0000"+I2S(num)+"|r/13)")
                        elseif  id == 'RSHG' and num < 14
                            SetTipsData(1,"",GetTypeIdName(id)+"(|cffff0000"+I2S(num)+"|r/14)")
                        elseif  id == 'RSHH' and num < 16
                            SetTipsData(1,"",GetTypeIdName(id)+"(|cffff0000"+I2S(num)+"|r/16)")
                        else
                            SetTipsData(1,"",GetTypeIdName(id))
                        endif
                    elseif  id >= 'RHD1' and id <= 'RHD9'
                        num = DzHeroExpLevelCount[0]
                        if  id == 'RHD1'and num < 6
                            SetTipsData(1,"",GetTypeIdName(id)+"(|cffff0000"+I2S(num)+"|r/6)")
                        elseif  id == 'RHD2' and num < 12
                            SetTipsData(1,"",GetTypeIdName(id)+"(|cffff0000"+I2S(num)+"|r/12)")
                        elseif  id == 'RHD3' and num < 20
                            SetTipsData(1,"",GetTypeIdName(id)+"(|cffff0000"+I2S(num)+"|r/20)")
                        elseif  id == 'RHD4' and num < 34
                            SetTipsData(1,"",GetTypeIdName(id)+"(|cffff0000"+I2S(num)+"|r/34)")
                        elseif  id == 'RHD5' and num < 54
                            SetTipsData(1,"",GetTypeIdName(id)+"(|cffff0000"+I2S(num)+"|r/54)")
                        elseif  id == 'RHD6' and num < 80
                            SetTipsData(1,"",GetTypeIdName(id)+"(|cffff0000"+I2S(num)+"|r/80)")
                        elseif  id == 'RHD7' and num < 112
                            SetTipsData(1,"",GetTypeIdName(id)+"(|cffff0000"+I2S(num)+"|r/112)")
                        elseif  id == 'RHD8' and num < 150
                            SetTipsData(1,"",GetTypeIdName(id)+"(|cffff0000"+I2S(num)+"|r/150)")
                        else
                            SetTipsData(1,"",GetTypeIdName(id))
                        endif
                    else
                        SetTipsData(1,"",GetTypeIdName(id))
                    endif
                endif
                tech = GetShowSaveFrameTechTips(pid,index)
                if  tech != ""
                    SetTipsData(10,"",tech)
                    h = 11
                endif


                
                if  IsSaveFrameTechUnLock(pid,index) == true
                    unlock = 1
                else
                    unlock = 0
                endif
                

                if  id == 'RY2I'
                    if  unlock == 1
                        lv = DzPlayerLv(Player(pid))
                        if  lv > 35
                            SetTipsData(h,"","每秒攻击+10\n每秒业力+10\n伤害加成+10%")
                            h = h + 1
                            SetTipsData(h,"","")
                            h = h + 1
                            

                            num = lv - 35
                            SetTipsData(h,"","伤害加成+|cff00ff00"+I2S(num)+"|r%")
                            h = h + 1

                            num = (lv - 35) / 3
                            if  num > 0
                                SetTipsData(h,"","暴击伤害+|cff00ff00"+I2S(num*3)+"|r%")
                                h = h + 1
                            endif

                            num = (lv - 35) / 2
                            if  num > 0
                                SetTipsData(h,"","攻击伤害+|cff00ff00"+I2S(num*2)+"|r%")
                                h = h + 1
                                SetTipsData(h,"","技能伤害+|cff00ff00"+I2S(num*2)+"|r%")
                                h = h + 1
                            endif

                            num = (lv - 35) / 5
                            if  num > 0
                                SetTipsData(h,"","攻击加成+|cff00ff00"+I2S(num*3)+"|r%")
                                h = h + 1
                                SetTipsData(h,"","业力加成+|cff00ff00"+I2S(num*3)+"|r%")
                                h = h + 1
                            endif

                        else
                            SetTipsData(h,"","每秒攻击+10\n每秒业力+10\n伤害加成+10%")
                        endif
                    else
                        SetTipsData(h,"","|cff808080每秒攻击+10\n每秒业力+10\n伤害加成+10%|r")
                    endif
                else
                    if  unlock == 1
                        SetTipsData(h,"",GetTypeIdStateTips(id))
                    else
                        SetTipsData(h,"","|cff808080"+GetTypeIdStateTips(id)+"|r")
                    endif
                endif

                h = h + 1

                if  GetTypeIdTips(id) != ""
                    if  unlock == 1
                        SetTipsData(h,"",GetTypeIdTips(id))
                    else
                        SetTipsData(h,"","|cff808080"+GetTypeIdTips(id))
                    endif
                    h = h + 1
                endif

                
                if  IsSaveIdCanShow(id,page) == true
                    if  unlock == 1
                        SetTipsData(h,"","|cffffcc00所有内容属性均叠加|r\n|cff00ff00（点击激活/隐藏外观）|r")
                    else
                        SetTipsData(h,"","|cff808080（解锁后可激活/隐藏外观）|r")
                    endif
                endif


                if  page == 5
                    if  id == 'RY2D' or id == 'RY3D' or id == 'RY4D'
                        h=h+2
                        SetTipsData(h,"","解锁条件均达成属性+50%")
                    endif
                endif
                
            endif


            

            ShowTipsUI()
        endif
    endfunction

    

    //刷新显示
    function ReShowSaveFrame(int pid,int page,int step)
        int id = 0
        int index = 0
        int techid = 0
        int lv = 0
        if  GetLocalPlayer() == Player(pid)

            for x = 0,3 
                for y = 0,3
                    index = 1 + x + y*4

                    id = GetShowSaveId(page,index+step*4)
                    

                    

                    if  id > 0
                        

                        if  id >= 'RH01' and id <= 'RH99'
                            lv = GetDzHeroExpLevel(pid,id-'RH00'+'H000')
                            if  lv > 0
                                DzFrameSetTexture(BUTTON_Back[500+index][3],"war3mapImported\\UI_Hero_SaveLevel_"+I2S(lv)+".tga",0)
                            else
                                DzFrameSetTexture(BUTTON_Back[500+index][3],"war3mapImported\\UI_DisBack.tga",0)
                            endif
                        else
                            for i = 1,5
                                techid = GetShowSaveTech(page,index+step*4,i)
                                if  techid == 0
                                    DzFrameSetTexture(BUTTON_Back[500+index][3],"war3mapImported\\alpha.tga",0)
                                    exitwhen true
                                else
                                    if  GetPlayerTechCount(Player(pid),techid,true) > 0
                                        DzFrameSetTexture(BUTTON_Back[500+index][3],"war3mapImported\\alpha.tga",0)
                                    else
                                        DzFrameSetTexture(BUTTON_Back[500+index][3],"war3mapImported\\UI_DisBack.tga",0)
                                        exitwhen true
                                    endif
                                endif
                            end
                        endif

         
                        if  page == 1 or page == 2 or page == 5
                            if  GetUnitAbilityLevel(Pu[1],id - 0x11000000 ) > 0
                                DzFrameSetTexture(BUTTON_Back[500+index][3],"war3mapImported\\UI_Activation.tga",0)
                            endif
                        
                        endif
                        DzFrameSetTexture(BUTTON_Back[500+index][1],GetTypeIdIcon(id),0)
                        DzFrameSetText(BUTTON_Text[500+index],GetTypeIdColor(id)+GetTypeIdName(id))
                    else
                        
                        DzFrameSetTexture(BUTTON_Back[500+index][1],"war3mapImported\\alpha.tga",0)
                        DzFrameSetTexture(BUTTON_Back[500+index][3],"war3mapImported\\alpha.tga",0)
                        DzFrameSetText(BUTTON_Text[500+index],"")
                    endif
                end
            end
        endif
    endfunction

    //点击按钮
    function PlayerClickShowSaveFrame(int pid,int index)
        int step = Step[pid]
        int page = Page[pid]
        int id = GetShowSaveId(page,index+step*4)
        
        BJDebugMsg("存档id"+YDWEId2S(id))
        if  IsSaveIdCanShow(id,page) == true
            if  IsSaveFrameTechUnLock(pid,index) == true
                BJDebugMsg("已解锁")
                RefreshOrnament(pid,id)
                
                ReShowSaveFrame(pid,page,step)
            else
                BJDebugMsg("未解锁")
            endif
        else
            
            BJDebugMsg("不是外观类")
        endif

    endfunction
    
    function SetPlayerShowSaveStep(int pid,int step)
        int max = GetShowSaveMax(Page[pid])
        int stepmax = 0
        Step[pid] = step
        if  GetLocalPlayer() == Player(pid)
            stepmax = (max - 13) / 4
            if  stepmax > 0
                Slider.SetPoint(2,Back2.frameid ,2,-0.001,-0.005-0.197/I2R(stepmax+1)*I2R(step))
                Slider.SetSize(0.005,0.197/I2R(stepmax+1))
                Slider.SetTexture("war3mapImported\\UI_Save_Stripe.tga",0)
            else
                Slider.SetTexture("war3mapImported\\alpha.tga",0)
            endif
            ReShowSaveFrame(pid,Page[pid],step)
        endif
    endfunction

    function SetPlayerShowSavePage(int pid,int page)
        if  GetLocalPlayer() == Player(pid)
            DzFrameSetTexture(BUTTON_Back[581+Page[pid]][4],"war3mapImported\\alpha.tga",0)
        endif
        Page[pid] = page
        if  GetLocalPlayer() == Player(pid)
            DzFrameSetTexture(BUTTON_Back[581+Page[pid]][4],"war3mapImported\\UI_Save_Color1.tga",0)
        endif
        SetPlayerShowSaveStep(pid,0)
        if  GetLocalPlayer() == Player(pid)
            ReShowSaveFrame(pid,Page[pid],Step[pid])
        endif
    endfunction

    function PlayerWheelShowSaveFrame(int pid,int whell)
        int page = Page[pid]
        int step = Step[pid]
        int max = GetShowSaveMax(page)
        int stepmax = 0

        if  whell < 0
            if  max > 16
                stepmax = (max - 13) / 4
                if  step < stepmax
                    SetPlayerShowSaveStep(pid,step+1)
                    
                endif
            endif
        else
            if  step > 0
                SetPlayerShowSaveStep(pid,step-1)
            endif
        endif
    endfunction


    

    


    

    //通用函数
    function ShowSaveFrame(int pid,bool show)

        if  GetLocalPlayer() == Player(pid)
            Button.show = show
            if  show == true
                ReShowSaveFrame(pid, Page[pid], Step[pid])
            endif
        endif
    
    endfunction
    function GetShowSaveFrameShow()->bool
        return Button.show
    endfunction


    function CloseShowSaveFrame(int pid)
        if  GetLocalPlayer() == Player(pid)
            Button.show = false
        endif
    endfunction

    function ClickShowSaveFrame(int pid)
        if  GetLocalPlayer() == Player(pid)
            if  Button.show  == true
                Button.show = false
            else
                Button.show = true
                ReShowSaveFrame(pid, Page[pid], Step[pid])
            endif
        endif
    endfunction

    
    


    function CreateShowSaveButton1() //创建列表按钮
        int index = 0
        for x = 0,7
            index = 581+x
            CreateButton(index,Button.frameid,TYPE_BUTTON,0,Button.frameid,0,0.003,-0.026-x*0.026,0.075,0.024,"war3mapImported\\alpha.tga")
            
        end

        CreateText(581,Button.frameid,"centertext009",4,4,0.0,0.0,"成就")
        CreateText(582,Button.frameid,"centertext009",4,4,0.0,0.0,"称号")
        CreateText(583,Button.frameid,"centertext009",4,4,0.0,0.0,"皮肤外观")
        CreateText(584,Button.frameid,"centertext009",4,4,0.0,0.0,"英雄熟练度")
        CreateText(585,Button.frameid,"centertext009",4,4,0.0,0.0,"封神谕令")
        CreateText(586,Button.frameid,"centertext009",4,4,0.0,0.0,"商城")
        CreateText(587,Button.frameid,"centertext009",4,4,0.0,0.0,"彩蛋")
        CreateText(588,Button.frameid,"centertext009",4,4,0.0,0.0,"特殊成就")

    endfunction

    function CreateShowSaveButton2() //创建图标按钮
        int index = 0

        for x = 0,3 
            for y = 0,3
                index = 501 + x + y*4
                CreateButton(index,Button.frameid,TYPE_BUTTON,0,Back2.frameid,0,0.005+x*0.045,-0.005-y*0.05,0.034,0.034,"war3mapImported\\alpha.tga")
                CreateText(index,Button.frameid,"centertext008",1,7,0.0,-0.002,"")
            end
        end

    endfunction


    function InitShowSaveFrame()
        Slider = FRAME.create() //背景注册
        Button = FRAME.create() //背景注册
        
        Back2 = FRAME.create()  //注册按钮背景
        Back = FRAME.create()   //注册主背景
        

        //控件设置
        Button.frameid = FRAME.Tag("BUTTON","ShowSave",GameUI,Button)
        Button.SetPoint(8,GameUI,5,-0.01,-0.1)
        Button.SetSize(0.288,0.25)
        origin = Button.frameid

        //背景设置
        Back.frameid = FRAME.Tag("BACKDROP","ShowSave",origin,Back)
        Back.SetPoint(4,origin,4,0,0)
        Back.SetSize(Button.Width,Button.Height)
        Back.SetTexture("war3mapImported\\UI_Save_Back.tga",0)

        //按钮背景设置
        Back2.frameid = FRAME.Tag("BACKDROP","ShowSave",origin,Back2)
        Back2.SetPoint(0,origin,0,0.09,-0.03)
        Back2.SetSize(0.19,0.207)
        Back2.SetTexture("war3mapImported\\alpha.tga",0)

        Slider.frameid = FRAME.Tag("BACKDROP","ShowSave",origin,Slider)
        Slider.SetPoint(2,Back2.frameid ,2,-0.001,-0.005)
        Slider.SetSize(0.005,0.02)
        Slider.alpha = 120
        Slider.SetTexture("war3mapImported\\UI_Save_Stripe.tga",0)

        

        FrameSetScriptByExecute( origin, 6,580,TYPE_NULL)


        CreateShowSaveButton1()
        CreateShowSaveButton2()
        Button.show = false

        for pid = 0,3
            SetPlayerShowSaveStep(pid,0)
            SetPlayerShowSavePage(pid,0)
        end
        
    endfunction
endlibrary






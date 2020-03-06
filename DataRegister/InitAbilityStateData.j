
scope AbilityStateData initializer init
    private function init()
//输出代码
//call InitAbilityData('技能id',技能类型,品质,伤害参数,参数A,参数B,参数C,伤害类型,冷却时间,"技能名称","技能说明","技能图标")
call InitAbilityData('S0Q0',1,9,0,0,0,0,0,0,0,0,10,"Q技能","|Cff00FF7F需求：\n |r|Cff808080- 完成新手任务|r","ReplaceableTextures\\CommandButtons\\BTN013.blp")
call InitAbilityData('S0W0',1,9,0,0,0,0,0,0,0,0,10,"W技能","|Cff00FF7F需求：\n |r|Cff808080- 完成新手任务|r","ReplaceableTextures\\CommandButtons\\BTN014.blp")
call InitAbilityData('S0E0',1,9,0,0,0,0,0,0,0,0,10,"E技能","|Cff00FF7F需求：\n |r|Cff808080- 完成新手任务|r","ReplaceableTextures\\CommandButtons\\BTN015.blp")
call InitAbilityData('S0R0',1,9,0,0,0,0,0,0,0,0,10,"R技能","|Cff00FF7F需求：\n|r|cff808080 - 完成历练挑战14后解锁|r","ReplaceableTextures\\CommandButtons\\BTN016.blp")
call InitAbilityData('S0Q1',1,9,0,0,0,0,0,0,0,0,10,"Q技能","暂未学习技能\n\n在|cff00ff40技能商店|r内购买|cff00ff40技能书|r学习。","ReplaceableTextures\\CommandButtons\\BTNSelectHeroOn.blp")
call InitAbilityData('S0W1',1,9,0,0,0,0,0,0,0,0,10,"W技能","暂未学习技能\n\n在|cff00ff40技能商店|r内购买|cff00ff40技能书|r学习。","ReplaceableTextures\\CommandButtons\\BTNSelectHeroOn.blp")
call InitAbilityData('S0E1',1,9,0,0,0,0,0,0,0,0,10,"E技能","暂未学习技能\n\n在|cff00ff40技能商店|r内购买|cff00ff40技能书|r学习。","ReplaceableTextures\\CommandButtons\\BTNSelectHeroOn.blp")
call InitAbilityData('S0R1',1,9,0,0,0,0,0,0,0,0,10,"R技能","觉醒后获得\n\n突破至|cff00ff40境界七-劫变期|r，兽魂觉醒商店内抽中|cff00ff40任意三个兽魂|r觉醒。","ReplaceableTextures\\CommandButtons\\BTNSelectHeroOn.blp")
call InitAbilityData('S075',1,5,1,3.8,5.6,7.5,9.4,11.3,2,0,0,"夺命刺","攻击|Cffffc9266%|r概率对目标范围造成伤害。","ReplaceableTextures\\CommandButtons\\BTNS075.blp")
call InitAbilityData('S076',3,3,1,0,0,6.1,7.6,9.1,2,8,0,"连环刺","对目标范围造成伤害。\n3s内|Cffffc926刺杀系技能|r触发概率|Cffffc926+6%|r。","ReplaceableTextures\\CommandButtons\\BTNS076.blp")
call InitAbilityData('S027',1,4,2,0,7,9.4,11.7,14,2,0,0,"九天御雷击","攻击|Cffffc9266%|r概率对目标范围造成伤害。","ReplaceableTextures\\CommandButtons\\BTNS027.blp")
call InitAbilityData('S028',8,5,2,3.8,5.7,7.6,9.5,11.5,2,8,0,"冥月流星落","对目标范围造成伤害。\n3s内|Cffffc926刺杀系技能|r触发概率|Cffffc926+6%|r。","ReplaceableTextures\\CommandButtons\\BTNS028.blp")
call InitAbilityData('S002',2,3,0,0,0,7.4,9.2,11,0,8,0,"夺天一击","|CffFFC926下一次攻击|r必定触发|Cffffc926致命一击|r。","ReplaceableTextures\\CommandButtons\\BTNS002.blp")
call InitAbilityData('S003',1,4,0,0,5.6,7.5,9.4,11.3,0,0,0,"残暴","攻击|Cffffc9266%|r概率造成|Cffffc926致命一击|r。|n|n|Cff00ff7f致命一击概率和倍率可叠加。|r","ReplaceableTextures\\CommandButtons\\BTNS003.blp")
call InitAbilityData('S004',1,5,0,1.5,2.2,3,3.8,4.6,0,0,0,"无情","攻击|Cffffc92615%|r概率造成|Cffffc926致命一击|r。|n|n|Cff00ff7f致命一击概率和倍率可叠加。|r","ReplaceableTextures\\CommandButtons\\BTNS004.blp")
call InitAbilityData('S006',8,4,1,0,0.9,1.2,1.5,1.8,2,8,0,"无影杀","对目标范围内怪物进行5次攻击，附带|Cffffc926普攻效果|r。","ReplaceableTextures\\CommandButtons\\BTNS006.blp")
call InitAbilityData('S070',8,2,1,0,0,0,0.23,0.3,2,8,0,"暴风剑雨","对目标范围内怪物造成多次伤害。|n|n|Cff00ff7f可触发致命一击效果。|r","ReplaceableTextures\\CommandButtons\\BTNS070.blp")
call InitAbilityData('S052',1,5,2,4.5,6.8,9.1,11.4,13.7,2,0,1,"神火天降","每|Cff00bfff16|r次攻击施动神火天降，对目标范围内敌人造成伤害，所有技能|Cff00bfff冷却减少0.5秒|r。","ReplaceableTextures\\CommandButtons\\BTNS052.blp")
call InitAbilityData('S053',2,5,2,3.7,5.5,7.4,9.2,11,2,2,1,"落魂咒","对周围单位造成伤害，|Cff00bfff30%|r几率造成|Cff00bfff双倍|r伤害\n\n|Cff00ff7f不受冷却缩减影响|r","ReplaceableTextures\\CommandButtons\\BTNS053.blp")
call InitAbilityData('S080',3,2,1,0,0,0,1.5,1.8,2,8,1,"剑灵诛仙式","万剑出鞘，对目标范围造成伤害。","ReplaceableTextures\\CommandButtons\\BTNS080.blp")
call InitAbilityData('S007',1,2,99,0,0,0,4.6,5.5,2,0,1,"太清妙术","攻击|Cffffc9266%|r概率对目标范围造成伤害。\n触发后|Cffffc926仙术系|r技能伤害|Cffffc926+20%|r，持续|Cffffc9266|r秒。","ReplaceableTextures\\CommandButtons\\BTNS007.blp")
call InitAbilityData('S011',1,4,99,0,3,4,5,6,2,0,1,"玄灵诀","攻击|Cffffc9266%|r概率对目标范围造成伤害。\n触发后|Cffffc926所有技能冷却|r降低|Cffffc9260.5|r秒。","ReplaceableTextures\\CommandButtons\\BTNS011.blp")
call InitAbilityData('S012',1,3,2,0,0,7.5,9.4,11.3,2,0,1,"龙之吼","攻击|Cffffc9266%|r概率对目标范围造成伤害。\n触发后|Cffffc9266|r秒内进入|Cffffc926龙神状态|r，|Cffffc926业力+20%|r。","ReplaceableTextures\\CommandButtons\\BTNS012.blp")
call InitAbilityData('S078',7,4,1,0,5.3,7.1,8.8,10.6,2,8,1,"彗星灭世","蓄力|Cffffd24d1.5|r秒后，对目标范围造成伤害。\n|CffFFC9263秒|r内每次攻击视为|Cffffc9262次攻击计数|r。","ReplaceableTextures\\CommandButtons\\BTNS078.blp")
call InitAbilityData('S079',3,5,2,4.6,6.9,9.2,11.6,14,2,8,1,"龙神陨光","蓄力|Cffffd24d3秒|r后，对直线范围造成伤害。","ReplaceableTextures\\CommandButtons\\BTNS079.blp")
call InitAbilityData('S010',1,3,1,0,0,6.6,8.2,9.8,2,0,1,"龙之怒","攻击|Cffffc9266%|r概率对目标范围造成伤害。\n触发后|Cffffc9266|r秒内进入|Cffffc926龙神状态|r，|Cffffc926攻击+20%|r。","ReplaceableTextures\\CommandButtons\\BTNS010.blp")
call InitAbilityData('S001',1,3,2,0,0,7,8.8,10.6,2,0,2,"南明离火","每|Cff00bfff16|r次攻击施动南明离火，对目标范围造成伤害","ReplaceableTextures\\CommandButtons\\BTNS001.blp")
call InitAbilityData('S005',8,5,2,3.5,5.2,6.9,8.7,10.4,2,8,2,"焚心咒","施动焚心咒术对目标范围造成伤害。\n3秒内每次攻击视为|Cffffc9262次攻击计数|r。","ReplaceableTextures\\CommandButtons\\BTNS005.blp")
call InitAbilityData('S035',1,5,1,2.9,4.3,5.8,7.2,8.6,2,0,2,"业火咒","每|Cff00bfff16|r次攻击施动业火咒术，对目标范围造成伤害","ReplaceableTextures\\CommandButtons\\BTNS035.blp")
call InitAbilityData('S030',3,3,1,0,0,7.1,8.8,10.6,2,8,2,"三昧真火","施动业三昧真火对目标范围造成伤害。\n3秒内每次攻击视为|Cffffc9262次攻击计数|r。","ReplaceableTextures\\CommandButtons\\BTNS030.blp")
call InitAbilityData('S073',1,4,1,0,0.5,0.6,0.8,1,2,0,2,"混元珠","攻击|Cffffc9266%|r概率掷出混元宝珠，|Cffffc926每次碰撞|r到怪物时造成伤害并|Cffffc926眩晕0.1秒|r。","ReplaceableTextures\\CommandButtons\\BTNS073.blp")
call InitAbilityData('S074',3,5,1,3,4.4,5.9,7.4,9,2,8,2,"戮目珠","对目标范围掷出戮目宝珠，碰撞怪物时造成伤害，3秒内增加自身|Cffffc92620点护甲穿透|r。\n\n|Cff00ff7f效果可叠加|r","ReplaceableTextures\\CommandButtons\\BTNS074.blp")
call InitAbilityData('S013',1,2,99,0,0,0,5,6,2,0,2,"轮回之狱","每|Cffffc92624次|r攻击对目标范围造成伤害并|Cffffc926眩晕1秒|r。","ReplaceableTextures\\CommandButtons\\BTNS013.blp")
call InitAbilityData('S022',8,2,5,0,0,0.34,0.42,0.5,2,8,2,"强攻阵","火莲降世，对周围怪物造成伤害，3s内增加|Cffffc92610%|r暴击。\n\n|Cff00ff7f效果可叠加|r","ReplaceableTextures\\CommandButtons\\BTNS022.blp")
call InitAbilityData('S102',1,4,2,0,1.35,1.8,2.3,2.8,2,0,2,"黑龙之灵","释放1条|Cff999999黑龙之灵|r，每秒对敌人造成伤害。","ReplaceableTextures\\CommandButtons\\BTNS102.blp")
call InitAbilityData('S081',8,2,5,0,0,0,0.1,0.1,2,8,3,"真空领域","将目标范围内的所有单位聚卷入中心，每|Cff00bfff0.5|r秒造成伤害。\n4秒内，攻击附带|Cffffc926最大生命*20%|r技能伤害","ReplaceableTextures\\CommandButtons\\BTNS081.blp")
call InitAbilityData('S083',2,4,1,0,1.4,1.8,2.3,2.8,2,8,3,"十方飓风破","自身每|Cff00bfff0.75|r秒向周围逸散暴风，造成伤害。\n4秒内|Cffffc926闪避+15%|r。|n|Cff00ff7f效果不可叠加。|r","ReplaceableTextures\\CommandButtons\\BTNS083.blp")
call InitAbilityData('S095',1,2,5,0,0,0,0.44,0.5,2,0,3,"佛陀法身","被攻击|Cff00bfff8%|r概率触对周围敌人伤害","ReplaceableTextures\\CommandButtons\\BTNS095.blp")
call InitAbilityData('S015',1,5,5,0.14,0.21,0.28,0.35,0.4,2,0,3,"反震","被攻击|Cff00bfff8%|r概率触对周围敌人伤害","ReplaceableTextures\\CommandButtons\\BTNS015.blp")
call InitAbilityData('S014',1,5,2,5.6,8.4,11.3,14.1,17,2,0,3,"后发制人","|CffFFC926闪避|r时对周围敌人伤害。","ReplaceableTextures\\CommandButtons\\BTNS014.blp")
call InitAbilityData('S096',1,2,1,4.5,6.8,9,11.3,13.6,2,0,3,"酒仙剑舞","|CffFFC926闪避|r时对周围敌人伤害。","ReplaceableTextures\\CommandButtons\\BTNS096.blp")
call InitAbilityData('S097',1,3,5,0,0,0.35,0.44,0.5,2,0,3,"佛怒","被攻击|Cffffc92616次|r对自身范围内敌人造成伤害。","ReplaceableTextures\\CommandButtons\\BTNS097.blp")
call InitAbilityData('S101',7,5,5,0.19,0.28,0.38,0.47,0.6,2,8,3,"雷光破","对目标范围造成造成伤害。\n|Cffffc9264秒|r内|Cffffc926佛门系|r触发概率|Cffffc926+6%|r。","ReplaceableTextures\\CommandButtons\\BTNS101.blp")
call InitAbilityData('S104',2,4,5,0,0.05,0.07,0.09,0.12,2,8,3,"熔炉之身","每秒对自身范围内敌人造成伤害，攻击附带|Cffffc926最大生命*1%|r伤害，持续6秒。","ReplaceableTextures\\CommandButtons\\BTNS104.blp")
call InitAbilityData('S082',1,2,99,0,0,0,0.29,0.32,2,0,4,"雷神之子","召唤|Cffffc9263朵|r雷云环绕自身。\n|Cff00ff7f雷云拥有溅射攻击。|r","ReplaceableTextures\\CommandButtons\\BTNS082.blp")
call InitAbilityData('S086',1,5,1,0.08,0.11,0.15,0.19,0.25,2,0,4,"幻影剑阵","召唤|Cffffc9263把|r飞剑环绕自身。\n|Cff00ff7f飞剑拥有溅射攻击。|r","ReplaceableTextures\\CommandButtons\\BTNS086.blp")
call InitAbilityData('S089',2,4,99,0,0.42,0.56,0.7,0.85,2,16,4,"天神道兵","召唤|Cffffc9261|r个天神道兵，持续12秒。\n|Cff00ff7f道兵拥有致命一击和分裂|r","ReplaceableTextures\\CommandButtons\\BTNS089.blp")
call InitAbilityData('S090',8,3,2,0,0,1.15,1.45,1.75,2,10,4,"噬魂龙魄","召唤1个噬魂龙魄，使其周围600码单位生机骤减，每|Cffffc9260.5|r秒造成伤害，持续|Cffffc9264秒|r。\n|Cff00ff7f多个噬魂灵魄伤害可叠加。|r","ReplaceableTextures\\CommandButtons\\BTNS090.blp")












call InitAbilityData('S230',3,0,1,20,0,0,0,0,2,30,9,"血之裂痕","化身狴犴扑杀目标范围，造成大量伤害并|Cffffd24d眩晕|r3秒。","ReplaceableTextures\\CommandButtons\\BTNIH01.blp")
call InitAbilityData('S231',2,0,2,2,0,0,0,0,2,30,9,"十绝阵","天降龙柱，十绝阵现。\n每根龙柱造成大量伤害。","ReplaceableTextures\\CommandButtons\\BTNIH02.blp")
call InitAbilityData('S232',2,0,5,0.12,0,0,0,0,2,30,9,"八荒斗神","|CffFFC9266秒|r内|Cffffc926伤害减免+20%|r，强制周围敌方单位攻击自己，每次|Cffffc926被攻击|r对目标造成伤害。","ReplaceableTextures\\CommandButtons\\BTNIH03.blp")
call InitAbilityData('S233',2,0,1,10,0,0,0,0,2,30,9,"冰封之域","对自身周围敌人造成大量伤害，受影响单位|Cffffc9266秒|r内承受|Cffffc926物理伤害+40%|r，3秒后进入|Cffffc926极冻状态|r。","ReplaceableTextures\\CommandButtons\\BTNIH04.blp")
call InitAbilityData('S234',7,0,2,12.5,0,0,0,0,2,30,9,"离魂秘术","对目标范围内的单位造成大量伤害，使其|Cffffc9266s|r内攻击力降低70%，|Cffffc926承受技能伤害+40%|r。","ReplaceableTextures\\CommandButtons\\BTNIH05.blp")
call InitAbilityData('S235',2,0,0,0,0,0,0,0,0,30,9,"修罗之怒","释放时根据当前血量增加自身|Cffffc9262%~22%暴击概率|r，|Cffffc9264秒|r内|Cffffc926每次暴击|r增加自身|Cffffc92620%|r暴击伤害。","ReplaceableTextures\\CommandButtons\\BTNIH06.blp")
call InitAbilityData('S236',5,0,99,10,0,0,0,0,2,30,9,"神威一击","突刺至目标身后并造成伤害。随后|Cffffc9266秒|r内|Cffffc926攻击速度+75%|r。","ReplaceableTextures\\CommandButtons\\BTNIH07.blp")
call InitAbilityData('S237',2,0,0,0,0,0,0,0,0,30,9,"道法自然","|CffFFC9266|r秒内|Cffffc926冷却缩减+100%，|r每次释放技能增加自身|Cffffc9265%伤害加成|r。","ReplaceableTextures\\CommandButtons\\BTNIH08.blp")

call InitAbilityData('S501',2,0,1,2.3,0,0,0,0,2,12,0,"天罚连击","突刺至目标区域并挥砍|Cffffc9263|r次，每次造成|Cffffc926攻击*230%|r伤害。","ReplaceableTextures\\CommandButtons\\BTNS501_1.blp")
call InitAbilityData('S502',5,0,1,1.92,0,0,0,0,2,10,0,"土遁袭杀","钻入地底突进至目标身后进行|Cffffc9262次|r爪击，每次造成|Cffffc926攻击*192%|r伤害。|n|n|Cff00ff7f每100%攻速增加一次爪击。|r","ReplaceableTextures\\CommandButtons\\BTNS502.blp")
call InitAbilityData('S503',1,0,2,4.32,0,0,0,0,2,6,1,"玉清合荒","若600码范围内，有敌/友军|Cffffc926释放主动技能|r，你对自身周围造成|Cffffc926业力*432%|r伤害。","ReplaceableTextures\\CommandButtons\\BTNS503.blp")
call InitAbilityData('S504',3,0,1,1.92,0,0,0,0,2,10,2,"火尖枪舞","突向前方瞬间刺击|Cffffc9263|r次，每次造成|Cffffc926攻击*192%|r伤害。|n|n|Cff00ff7f暴击≥40%：额外造成一次弑龙枪，造成攻击*300%伤害。|r","ReplaceableTextures\\CommandButtons\\BTNS504.blp")
call InitAbilityData('S505',2,0,2,1.2,0,0,0,0,2,12,1,"一气化三清","幻化|Cffffc9262|r个无法移动的分身，每个分身拥有|Cffffc92630%|r攻击力。|n4秒后分身爆炸，造成|Cffffc926业力*120%|r伤害。|n|n|Cff00ff7f分身可触发致命一击及分裂效果|r","ReplaceableTextures\\CommandButtons\\BTNS505.blp")
call InitAbilityData('S506',1,0,0,0,0,0,0,0,0,0,1,"斩仙飞刀","斩杀低于|Cffffbf006%|r最大生命值的敌人。","ReplaceableTextures\\CommandButtons\\BTNS506.blp")
call InitAbilityData('S507',1,0,1,0,0,0,0,0,0,0,4,"万物亲和","攻击|Cffffc9266%|r概率召唤|Cffffc9261个元素体|r。\n元素体继承你|Cffffc92670%攻击力|r，持续15秒。","ReplaceableTextures\\CommandButtons\\BTNS507.blp")
call InitAbilityData('S508',1,0,2,5.76,0,0,0,0,2,0,0,"镜花之舞","攻击|Cffffc92610%|r概率积累|Cffffc9261|r层|Cffffc926妖狐印记|r，达到|Cffffc9267|r层时向周围释放|Cffffc926镜花之舞|r。|n每层妖狐印记提高|Cffffc9266%|r攻击速度，镜花之舞造成|Cffffc926业力*576%|r伤害。","ReplaceableTextures\\CommandButtons\\BTNS508.blp")
call InitAbilityData('S509',2,0,1,1,0,0,0,0,0,6,0,"奕剑之道","使用后|Cffffc9263秒|r内进入|Cffffc926心剑状态|r，每次攻击对敌人造成|Cffffc926攻击*100%|r伤害并击退50码。","ReplaceableTextures\\CommandButtons\\BTNS509.blp")
call InitAbilityData('S510',2,0,0,0,0,0,0,0,0,2,1,"八九玄功","使用后依次|Cffffc926变幻形态|r，并获得相应加成：\n幽冥龙形态：暴击|Cffffc926+10%|r|Cfff0f0f0|r\n赤炎虎形态：攻速|Cffffc926+45%|r|Cfff0f0f0|r\n人形态：|Cfff0f0f0冷却缩减|r|Cffffc926+10%|r","ReplaceableTextures\\CommandButtons\\BTNS510_1.blp")
call InitAbilityData('S511',1,0,0,0,0,0,0,0,0,0,1,"命途多舛","释放主动技能|Cffffc92630%|r几率大成功，该伤害提高|Cffffc926100%|r。","ReplaceableTextures\\CommandButtons\\BTNS511.blp")
call InitAbilityData('S512',7,0,1,4.6,0,0,0,0,2,8,1,"天王宝塔","掷出天王宝塔镇压目标，造成|Cffffc926攻击*460%|r技能伤害。\n\n|Cff00ff7f暴击>30%|r：伤害翻倍。","ReplaceableTextures\\CommandButtons\\BTNS512.blp")
call InitAbilityData('S513',3,0,0,0,0,0,0,0,0,12,1,"身外法身","使用毫毛在目标地点|Cffffc926幻化一个法身|r，可|Cffffc926模仿你施放|r的|Cffffc926主动伤害技能|r，但只造成|Cffffd24d50%|r|Cfff0f0f0伤害|r。\n\n|Cffbbbbbb法身无法攻击，不可选取，不受攻击。|r","ReplaceableTextures\\CommandButtons\\BTNS513.blp")
call InitAbilityData('S514',2,0,2,5.76,0,0,0,0,2,8,1,"冰封万里","对自身周围发动一次冰封术，造成|Cffffd24d业力*576%|r伤害|n|n|Cff00ff7f冷却缩减>100%：|r额外发动一次冰暴，造成|Cffffd24d业力*500%|r伤害。","ReplaceableTextures\\CommandButtons\\BTNS514.blp")
call InitAbilityData('S515',1,0,1,9.2,0,0,0,0,2,0,2,"日月珠","|CffFFC926每次施法|r凝聚|Cffffc9261|r颗|Cffffc926日月珠|r环绕自身，数量达到|Cffffc9264颗|r时，向攻击目标造成|Cffffc926攻击*920%|r范围伤害。","ReplaceableTextures\\CommandButtons\\BTNS515.blp")
call InitAbilityData('S516',2,0,0,0,0,0,0,0,0,15,0,"悔悟","|CffFFD24D自裁|r悔过，英雄立即死亡，所有人回复|Cffffd24d50%|r生命，|Cffffd24d6|r秒内提高|Cffffd24d30%|r技能伤害。","ReplaceableTextures\\CommandButtons\\BTNS516.blp")
call InitAbilityData('S517',1,0,1,4.6,0,0,0,0,0,8,0,"乾坤-阵","每|Cffffc9268秒|r对目标范围发动枪阵，造成|Cffffc926攻击*460%|r伤害，并|Cffffc926眩晕2秒|r。","ReplaceableTextures\\CommandButtons\\BTNS517.blp")
call InitAbilityData('S518',1,0,0,0,0,0,0,0,0,0,3,"九转神功","每次突破境界|Cffffbf0040%|r概率获得额外|Cffffbf0010%|r收益","ReplaceableTextures\\CommandButtons\\BTNS518.blp")
call InitAbilityData('S519',1,0,2,5.76,0,0,0,0,2,0,1,"天眼神光","|CffFFD24D攻击或施法|r时，|Cffffd24d4%|r几率开启天眼发射神光，造成|Cffffd24d业力*576%|r伤害。","ReplaceableTextures\\CommandButtons\\BTNS519.blp")
call InitAbilityData('S520',2,0,0,0,0,0,0,0,0,10,2,"莲花化身","使用后|Cffffc9266|r秒内增加自身|Cffffc92624%|r伤害减免。","ReplaceableTextures\\CommandButtons\\BTNS520.blp")
call InitAbilityData('S521',2,0,2,1,0,0,0,0,2,10,1,"月盈","每秒对周围单位造成|Cffffc926业力*100%|r技能伤害，持续|Cffffc9266秒|r。","ReplaceableTextures\\CommandButtons\\BTNS521.blp")
call InitAbilityData('S522',1,0,0,0,0,0,0,0,0,0,0,"风雷咒术","获得风雷咒术加持，攻击速度提高|Cffffd24d50%|r|Cfff0f0f0。|r过快的攻击速度导致技能伤害|Cffff0000降低25%|r。","ReplaceableTextures\\CommandButtons\\BTNS522.blp")
call InitAbilityData('S523',6,0,0,0,0,0,0,0,0,12,2,"狐媚术","回复目标|Cffffd24d30%|r生命并|Cffffd24d解除所有负面效果|r，|Cffffd24d4|rs内提高|Cffffd24d20%|r攻击。","ReplaceableTextures\\CommandButtons\\BTNS523.blp")
call InitAbilityData('S524',8,0,2,1.8,0,0,0,0,2,8,3,"道友请留步","对目标范围进行蛊惑，每秒造成|Cffffc926业力*180%|r技能伤害，持续|Cffffc9264|r秒。","ReplaceableTextures\\CommandButtons\\BTNS524.blp")
call InitAbilityData('S525',3,0,1,1.92,0,0,0,0,2,8,0,"攒心钉","发射|Cffffd24d3枚|r攒心钉，造成|Cffffd24d攻击*192%|r伤害，|Cffffd24d4|r秒内增加自身|Cffffd24d30点|r护甲穿透。\n\n|Cff00ff7f效果不可叠加。|r","ReplaceableTextures\\CommandButtons\\BTNS525.blp")
call InitAbilityData('S526',1,0,1,2,0,0,0,0,2,6,0,"当头棒击","每6秒攻击对直线范围造成|Cffff8000攻击*200%|r伤害。","ReplaceableTextures\\CommandButtons\\BTNS526.blp")
call InitAbilityData('S527',9,0,0,0,0,0,0,0,0,16,2,"昏庸无道","|CffFFD24D处决|r一名队友，|Cffffd24d8|r秒内增加你的攻击力，增加量为|Cffffd24d该队友攻击的12%|r|Cfff0f0f0。|r\n|Cff00ff7f处决自己获得一半加成。|r\n|Cff00ff7f施法距离全图|r","ReplaceableTextures\\CommandButtons\\BTNS527.blp")
call InitAbilityData('S528',1,0,0,0,0,0,0,0,0,0,0,"尚武乏谋","有什么问题是暴力不能解决的呢？|n技能伤害+|Cffffd24d15%|r。","ReplaceableTextures\\CommandButtons\\BTNS528.blp")
call InitAbilityData('S529',1,0,0,0,0,0,0,0,0,20,3,"神医救世","队友或你死亡时，直接|Cffffd24d复活|r。","ReplaceableTextures\\CommandButtons\\BTNS529.blp")
call InitAbilityData('S530',1,0,0,0,0,0,0,0,0,0,0,"百发百中","攻击|Cffffc9265%|r概率造成|Cffffc926480%|r致命一击。","ReplaceableTextures\\CommandButtons\\BTNS530.blp")
















InitAbilityStringEx('S501',"挥砍一段伤害+100%","挥砍二段伤害+100%","第三段挥砍造成4秒眩晕","","")
InitAbilityStringEx('S502',"附带2秒眩晕效果","爪击伤害提高50%。","爪击后3秒内提高30%暴击伤害","","")
InitAbilityStringEx('S503',"冷却时间4秒","冷却时间2秒","冷却时间移除","","")
InitAbilityStringEx('S504',"刺击次数+1","刺击次数+1","刺击次数+2","","")
InitAbilityStringEx('S505',"幻化3个分身","幻化4个分身","幻化6个分身","","")
InitAbilityStringEx('S506',"斩杀血限提高至8%","斩杀血限提高至10%","斩杀血限提高至15%","","")
InitAbilityStringEx('S507',"元素体继承100%攻速加成。","元素体继承攻击特效。","元素继承120%攻击力","元素体属于召唤物机制：类同魔兽的幽灵狼,重复触发和主动召唤都会替换场上已存在的召唤物。数量只受召唤物数量影响。（即法宝上召唤物数量+2，女娲这个技能就召3个）","")
InitAbilityStringEx('S508',"每层妖狐印记提高9%攻速","每层妖狐印记提高12%攻速","镜花之舞伤害+80%","","")
InitAbilityStringEx('S509',"心剑状态下闪避额外提高15%","攻击速度+40%","残影伤害+30%","","")
InitAbilityStringEx('S510',"幽冥龙形态下，攻击速度+40%","赤炎虎形态下触发暴击时，对周围造成攻击*300%技能伤害，内置冷却2秒","人形态下，施放Q技能时对周围造成业力*700%伤害，内置冷却6秒","","")
InitAbilityStringEx('S511',"大成功几率+10%","大成功伤害+50%","大成功几率+20%","","")
InitAbilityStringEx('S512',"宝塔伤害+20%","宝塔伤害+30%","宝塔伤害+40%，附带2秒眩晕效果","","")
InitAbilityStringEx('S513',"法身释放技能造成60%伤害","法身释放技能造成70%伤害","法身释放技能造成100%伤害","","")
InitAbilityStringEx('S514',"伤害范围+100%","冰封术伤害+50%","冰封术伤害+50%，附带2秒冰冻效果","","")
InitAbilityStringEx('S515',"日月珠伤害+40%","日月珠伤害+60%","日月珠伤害+80%","","")
InitAbilityStringEx('S516',"自裁后立即复活，并对周围单位造成攻击*1000%伤害。","回复满额生命","技能伤害提高至60%","自裁悔过到10次给的攻击加成干掉","")
InitAbilityStringEx('S517',"枪阵伤害+40%","触发致命一击时，降低该技能0.5秒冷却。","发动后4秒内致命一击概率+5%，致命倍率+200%","","")
InitAbilityStringEx('S518',"概率提升至70%","概率提升至100%","重塑：施放技能对自身周围造成（攻击+业力）*720%技能伤害","","")
InitAbilityStringEx('S519',"施法100%几率开启天眼","攻击开启天眼几率翻倍","神光伤害翻倍","","")
InitAbilityStringEx('S520',"持续时间内，每次攻击附加自身最大生命值*10%伤害","免疫技能负面效果","受到技能伤害时，回复30%最大生命值","","")
InitAbilityStringEx('S521',"月盈伤害+30%","月盈伤害+50%","攻击3%概率重置月盈冷却。","","")
InitAbilityStringEx('S522',"攻击速度提高70%","攻击速度提高90%","攻击速度提高150%","","")
InitAbilityStringEx('S523',"回复50%生命","攻击加成效果+30%","对目标周围单位造成攻击*600%技能伤害","","")
InitAbilityStringEx('S524',"蛊惑造成伤害时，眩晕目标0.4秒","蛊惑造成伤害时，眩晕目标0.8秒","被眩晕的单位3秒内承受伤害+30%","","")
InitAbilityStringEx('S525',"释放攒心钉时,3秒内增加自身15%技能伤害加成。","基础冷却降低2秒。","攒心钉数量+3","","")
InitAbilityStringEx('S526',"冷却时间降低至4秒","冷却时间降低至2秒","当头棒击必定触发暴击","","")
InitAbilityStringEx('S527',"处决目标获得神仙搭救，立即原地复活。","被处决队友8秒内提高24%攻击。","对处决目标600码范围内造成攻击*800%技能伤害","","")
InitAbilityStringEx('S528',"勇猛：施放Q技能时，50%概率对周围造成攻击*1000%伤害。","技能伤害+15%","勇猛必定触发","","")
InitAbilityStringEx('S529',"触发时对自身周围600码造成生命*300%伤害","被复活单位5s内攻击速度+30%，暴击率+10%。","冷却时间降低至10秒","","")
InitAbilityStringEx('S530',"攻击必定命中。","触发致命一击时回复自身3%最大生命值","领悟三重射，可触发攻击特效","","")

endfunction
endscope


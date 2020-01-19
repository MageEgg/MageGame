
scope AbilityStateData initializer init
    private function init()
//call InitAbilityData('技能id',技能类型,品质,伤害参数,参数A,参数B,参数C,伤害类型,冷却时间,"技能名称","技能说明","技能图标")
call InitAbilityData('S0Q0',1,9,0,0,0,0,0,0,0,0,"Q技能","|Cff00FF7F需求：\n |r|Cff808080- 完成新手任务|r","ReplaceableTextures\\CommandButtons\\BTN013.blp")
call InitAbilityData('S0W0',1,9,0,0,0,0,0,0,0,0,"W技能","|Cff00FF7F需求：\n |r|Cff808080- 完成新手任务|r","ReplaceableTextures\\CommandButtons\\BTN014.blp")
call InitAbilityData('S0E0',1,9,0,0,0,0,0,0,0,0,"E技能","|Cff00FF7F需求：\n |r|Cff808080- 完成新手任务|r","ReplaceableTextures\\CommandButtons\\BTN015.blp")
call InitAbilityData('S0R0',1,9,0,0,0,0,0,0,0,0,"R技能","|Cff00FF7F需求：\n|r|cff808080 - 境界七-觉醒后解锁|r","ReplaceableTextures\\CommandButtons\\BTN016.blp")
call InitAbilityData('S0Q1',1,9,0,0,0,0,0,0,0,0,"Q技能","暂未学习技能\n\n在|cff00ff40技能商店|r内购买|cff00ff40技能书|r学习。","ReplaceableTextures\\CommandButtons\\BTNSelectHeroOn.blp")
call InitAbilityData('S0W1',1,9,0,0,0,0,0,0,0,0,"W技能","暂未学习技能\n\n在|cff00ff40技能商店|r内购买|cff00ff40技能书|r学习。","ReplaceableTextures\\CommandButtons\\BTNSelectHeroOn.blp")
call InitAbilityData('S0E1',1,9,0,0,0,0,0,0,0,0,"E技能","暂未学习技能\n\n在|cff00ff40技能商店|r内购买|cff00ff40技能书|r学习。","ReplaceableTextures\\CommandButtons\\BTNSelectHeroOn.blp")
call InitAbilityData('S0R1',1,9,0,0,0,0,0,0,0,0,"R技能","觉醒后获得\n\n突破至|cff00ff40境界七-劫变期|r，兽魂觉醒商店内抽中|cff00ff40任意三个兽魂|r觉醒。","ReplaceableTextures\\CommandButtons\\BTNSelectHeroOn.blp")
call InitAbilityData('S002',1,1,0,2,4,6,8,10,0,6,"夺天一击","每|Cffffc9266|r秒，攻击必定触发|Cffffc926致命一击|r","ReplaceableTextures\\CommandButtons\\BTNS002.blp")
call InitAbilityData('S003',1,1,0,0,0,0,0,4,0,0,"残暴","提高|Cffffc926致命倍数|r","ReplaceableTextures\\CommandButtons\\BTNS003.blp")
call InitAbilityData('S004',1,1,0,2,3,4,5,6,0,0,"无情","攻击|Cffffc9266%|r概率造成|Cffffc926致命一击|r","ReplaceableTextures\\CommandButtons\\BTNS004.blp")
call InitAbilityData('S005',1,1,0,0.25,0.4,0.55,0.75,1,0,0,"横扫千军","","ReplaceableTextures\\CommandButtons\\BTNS005.blp")
call InitAbilityData('S006',8,1,1,0.4,0.6,0.8,1,1.2,2,6,"无影杀","对目标范围内怪物进行5次攻击，附带|Cffffc926普攻效果|r。","ReplaceableTextures\\CommandButtons\\BTNS006.blp")
call InitAbilityData('S009',1,1,0,5,4,3,2,1,0,0,"连击","攻击命中后立即|Cffff8000追加一次|r普通攻击。|n|Cff00ff7f触发攻击特效|r","ReplaceableTextures\\CommandButtons\\BTNS009.blp")
call InitAbilityData('S018',2,1,1,0,0,3,4,5,2,8,"破甲阵","使用精湛的刀术对周围怪物造成伤害，并降低|Cffff800015%防御|r3秒。|n|Cff00ff7f效果不可叠加|r","ReplaceableTextures\\CommandButtons\\BTNS018.blp")
call InitAbilityData('S019',1,1,0,0,0.33,0.53,0.73,1,0,0,"卸甲","","ReplaceableTextures\\CommandButtons\\BTNS019.blp")
call InitAbilityData('S022',8,1,1,0,0,0,2,3,2,10,"强攻阵","火莲降世，对周围怪物造成伤害，3s内增加|Cffffc92610%|r暴击。\n\n|Cff00ff7f效果可叠加|r","ReplaceableTextures\\CommandButtons\\BTNS022.blp")
call InitAbilityData('S028',1,1,1,3,4,5,6,8,2,0,"冥月流星落","攻击|Cffffc9266%|r概率引动冥月流星，对目标范围造成伤害","ReplaceableTextures\\CommandButtons\\BTNS028.blp")
call InitAbilityData('S029',1,1,0,0,0.4,0.6,0.8,1,0,0,"天命","","ReplaceableTextures\\CommandButtons\\BTNS029.blp")
call InitAbilityData('S032',1,1,0,0.2,0.4,0.6,0.8,1,0,0,"血之沸腾","","ReplaceableTextures\\CommandButtons\\BTNS032.blp")
call InitAbilityData('S033',2,1,0,0,0,0.2,0.3,0.4,0,8,"斩意诀","|CffFFC9266|r秒内增加|Cffffc92640%|r攻击速度。|n|Cff00ff7f效果可叠加|r","ReplaceableTextures\\CommandButtons\\BTNS033.blp")
call InitAbilityData('S035',1,1,1,3,4,5,6,8,2,0,"业火咒","每|Cff00bfff10|r次攻击施动业火咒术，对目标范围内造成伤害","ReplaceableTextures\\CommandButtons\\BTNS035.blp")
call InitAbilityData('S048',1,1,1,4,6,8,10,12,2,0,"狐媚术","攻击|Cffffc9266%|r概率对目标范围造成魅惑状态及伤害，3秒内降低|Cffffc92620%|r攻速及移动速度。","ReplaceableTextures\\CommandButtons\\BTNS048.blp")
call InitAbilityData('S052',3,1,1,0,0,0,4,5,2,6,"神火天降","对目标范围内敌人造成伤害，所有技能|Cff00bfff冷却减少0.5秒|r。","ReplaceableTextures\\CommandButtons\\BTNS052.blp")
call InitAbilityData('S053',2,1,1,0,2,3,4,5,2,2,"落魂咒","对周围单位造成伤害，|Cff00bfff20%|r几率造成|Cff00bfff双倍|r伤害\n\n|Cff00ff7f固定冷却时间|r","ReplaceableTextures\\CommandButtons\\BTNS053.blp")
call InitAbilityData('S056',1,1,0,0,0,0.03,0.04,0.05,0,0,"术神式","攻击一定几率重置所有技能冷却时间。\n\n|Cff00ff7f概率不受天命影响。|r","ReplaceableTextures\\CommandButtons\\BTNS056.blp")
call InitAbilityData('S058',1,1,0,0,0.4,0.52,0.8,1,0,0,"仙之心","","ReplaceableTextures\\CommandButtons\\BTNS058.blp")
call InitAbilityData('S061',1,1,0,0,0,0.3,0.35,0.4,0,0,"帝星","一定概率|Cffffc926额外施法|r1次","ReplaceableTextures\\CommandButtons\\BTNS061.blp")
call InitAbilityData('S066',1,1,0,0,0.33,0.53,0.73,1,0,0,"灭魂","","ReplaceableTextures\\CommandButtons\\BTNS066.blp")
call InitAbilityData('S074',3,1,1,0,0.5,1,1.5,2,2,6,"戮目珠","对目标范围掷出戮目珠，对碰撞到的怪物造成伤害，并使其进入失明状态，攻击命中率降低30%，持续3秒。","ReplaceableTextures\\CommandButtons\\BTNS074.blp")
call InitAbilityData('S075',1,1,1,3,4,6,8,10,2,0,"夺命刺","攻击|Cffffc9266%|r概率对目标造成伤害，\n\n触发后追加一次|Cffffc926连环刺|r。|Cff00ff7f（需已学习连环刺）|r","ReplaceableTextures\\CommandButtons\\BTNS075.blp")
call InitAbilityData('S076',1,1,1,2,3,4,5,6,2,0,"连环刺","攻击|Cffffc9266%|r概率对目标范围造成伤害。\n\n触发后2s内|Cffffc926夺命刺|r概率增加|Cffffc92610%|r。","ReplaceableTextures\\CommandButtons\\BTNS076.blp")
call InitAbilityData('S078',3,1,1,0,5,6,7,8,2,0,"彗星灭世","蓄力|Cffffd24d1.5|r秒后，对目标范围造成伤害。","ReplaceableTextures\\CommandButtons\\BTNS078.blp")
call InitAbilityData('S079',3,1,1,6,7,8,9,10,2,0,"龙神陨光","蓄力|Cffffd24d3秒|r后，对直线范围造成伤害。","ReplaceableTextures\\CommandButtons\\BTNS079.blp")
call InitAbilityData('S081',3,1,1,0,0,0,0.8,1,2,8,"真空领域","将目标范围内的所有单位聚卷入中心，每|Cff00bfff0.5|r秒造成伤害。","ReplaceableTextures\\CommandButtons\\BTNS081.blp")
call InitAbilityData('S083',2,1,1,0,0,1,1.5,2,2,8,"十方飓风破","自身每|Cff00bfff0.75|r秒向周围逸散暴风，造成伤害。","ReplaceableTextures\\CommandButtons\\BTNS083.blp")
call InitAbilityData('S095',1,1,1,4,5,6,7,8,2,0,"佛陀法身","被攻击|Cff00bfff8%|r概率触对周围敌人伤害","ReplaceableTextures\\CommandButtons\\BTNS095.blp")
call InitAbilityData('S097',1,1,5,0,0.5,1,1.5,2,2,0,"神怒","被攻击|Cffffcc0016|r|Cfff0f0f0次|r对自身范围内敌人造成伤害","ReplaceableTextures\\CommandButtons\\BTNS097.blp")
call InitAbilityData('S099',1,1,0,0,0,0.66,0.83,1,0,0,"刚毅之心","","ReplaceableTextures\\CommandButtons\\BTNS099.blp")
call InitAbilityData('S102',1,1,1,1,1.3,1.5,1.8,2,2,0,"黑龙之灵","释放1条|Cff999999黑龙之灵|r，每秒对敌人造成伤害。","ReplaceableTextures\\CommandButtons\\BTNS102.blp")
call InitAbilityData('S118',1,1,0,0,0.4,0.6,0.8,1,0,0,"血脉之力","","ReplaceableTextures\\CommandButtons\\BTNS118.blp")
call InitAbilityData('S119',1,1,0,0.33,0.5,0.66,0.83,1,0,0,"嗜血","","ReplaceableTextures\\CommandButtons\\BTNS119.blp")
call InitAbilityData('S120',2,1,1,0,2,3,4,5,2,8,"撼地击","对自身周围造成伤害。\n\n|Cff00ff7f40%几率额外释放一次大范围撼地击。|r","ReplaceableTextures\\CommandButtons\\BTNS120.blp")
call InitAbilityData('S123',2,1,1,3,4,5,6,7,2,8,"冰暴术","自身周围每秒产生一次随机冰暴，造成伤害。","ReplaceableTextures\\CommandButtons\\BTNS123.blp")
call InitAbilityData('S127',2,1,0,0.2,0.28,0.36,0.42,0.5,0,10,"回春术","|CffFFBF005|r秒内回复|Cfff0f0f0生命值|r\n\n|Cff00ff7f效果不可叠加|r","ReplaceableTextures\\CommandButtons\\BTNS127.blp")
call InitAbilityData('S129',1,1,0,0.1,0.25,0.5,0.75,1,0,0,"贪婪","杀敌|Cffffc926金币|r奖励增加。","ReplaceableTextures\\CommandButtons\\BTNS129.blp")
call InitAbilityData('S230',3,0,1,24,0,0,0,0,1,20,"血之裂痕","化身狴犴扑杀目标范围，造成|Cffff8000攻击*24|r物理伤害并|Cffffbf00眩晕|r3秒。","ReplaceableTextures\\CommandButtons\\BTNBTNIH00.blp")
call InitAbilityData('S231',10,0,2,2,0,0,0,0,2,20,"十绝阵","天降龙柱，十绝阵现。\n每根龙柱造成|Cff00bfff法强*3|r法术伤害。\n\n|Cff00ff7f基础数量6根，法强越高道棺越多。\n持续时间3秒，施法期间无法攻击和移动。|r","ReplaceableTextures\\CommandButtons\\BTNBTNIH01.blp")
call InitAbilityData('S232',2,0,5,2,0,0,0,0,2,12,"八荒斗神","强制800范围内所有敌方单位攻击自己，伤害免疫|Cffffbf00+20%|r\n每次被攻击，对目标造成|Cffffbf00生命值*2|r法术伤害","ReplaceableTextures\\CommandButtons\\BTNBTNIH02.blp")
call InitAbilityData('S233',2,0,0,0,0,0,0,0,0,20,"冰封之域","|CffFF80006|r秒内降低周围单位50%攻速和移动速度，受影响的单位3s后进入|Cffff8000极冻状态|r，|Cffff8000承受物理伤害+100%|r，承受法术伤害-50%。","ReplaceableTextures\\CommandButtons\\BTNBTNIH03.blp")
call InitAbilityData('S234',5,0,2,18,0,0,0,0,2,20,"离魂秘术","对目标造成|Cff00bfff法强*18|r伤害，随后使目标周围单位无法攻击，|Cff00bfff承受法术伤害+80%|r，承受物理伤害-50%。","ReplaceableTextures\\CommandButtons\\BTNBTNIH04.blp")
call InitAbilityData('S235',2,0,0,0,0,0,0,0,0,15,"修罗之怒","释放后根据|Cffffbf00当前血量|r增加自身|Cffffbf003%~33%|r暴击概率，持续时间内，每次|Cffffbf00暴击|r增加自身|Cffffbf0030%|r暴击伤害。","ReplaceableTextures\\CommandButtons\\BTNBTNIH05.blp")
call InitAbilityData('S236',5,0,0,12,0,0,0,0,2,12,"神威一击","突刺至目标身后，造成|Cffff8000攻击|r或|Cff00bfff法强*20|r自适应伤害。随后4秒内|Cffff8000攻击速度+220%|r。","ReplaceableTextures\\CommandButtons\\BTNBTNIH06.blp")
call InitAbilityData('S237',2,0,0,0,0,0,0,0,0,20,"道法自然","持续时间内，|Cff00bfff冷却缩减+40%|r，每次释放技能增加自身|Cffffbf0010%|r增伤。","ReplaceableTextures\\CommandButtons\\BTNBTNIH07.blp")

call InitAbilityData('S501',2,0,1,2,0,0,0,0,1,12,"天罚连击","突刺至目标区域并挥砍|Cffffc9263|r次，每次造成|Cffffc926攻击*150%|r物理伤害。","ReplaceableTextures\\CommandButtons\\BTNS501_1.blp")
call InitAbilityData('S502',5,0,1,1.5,0,0,0,0,1,10,"土遁袭杀","钻入地底突进至目标身后进行|Cffffc9262次|r爪击，每次造成|Cffffc926攻击*100%|r伤害。|n|n|Cff00ff7f每100%攻速增加一次爪击。|r","ReplaceableTextures\\CommandButtons\\BTNS502.blp")
call InitAbilityData('S503',1,0,99,3,0,0,0,0,2,6,"玉清合荒","若600码范围内，有敌/友军|Cffffc926释放主动技能|r，你对自身周围造成|Cffffc926攻击*3|r法术伤害。","ReplaceableTextures\\CommandButtons\\BTNS503.blp")
call InitAbilityData('S504',3,0,1,2,0,0,0,0,1,10,"火尖枪舞","突向前方瞬间刺击|Cffffc9263|r次，每次造成|Cffffc926攻击*100%|r伤害。|n|n|Cff00ff7f暴击≥40%：额外造成一次弑龙枪，造成攻击*300%物理伤害。|r","ReplaceableTextures\\CommandButtons\\BTNS504.blp")
call InitAbilityData('S505',2,0,2,4,0,0,0,0,2,12,"一气化三清","幻化|Cffffc9262|r个无法移动的分身，每个分身拥有|Cffffc92630%|r攻击力。|n4秒后分身爆炸，造成|Cffffc926业力*80%|r法术伤害。|n|n|Cff00ff7f分身可触发致命一击及分裂效果|r","ReplaceableTextures\\CommandButtons\\BTNS505.blp")
call InitAbilityData('S506',1,0,0,0,0,0,0,0,0,0,"斩仙飞刀","斩杀低于|Cffffbf006%|r最大生命值的敌人。","ReplaceableTextures\\CommandButtons\\BTNS506.blp")
call InitAbilityData('S507',1,0,0,0,0,0,0,0,0,0,"万物亲和","每|Cffffbf0010|r秒回复|Cffffbf0020%最大生命值","ReplaceableTextures\\CommandButtons\\BTNS507.blp")
call InitAbilityData('S508',1,0,2,8,0,0,0,0,2,0,"镜花之舞","攻击|Cffffc92610%|r概率积累|Cffffc9261|r层|Cffffc926妖狐印记|r，达到|Cffffc9267|r层时向周围释放|Cffffc926镜花之舞|r。|n每层妖狐印记提高|Cffffc9266%|r攻击速度，镜花之舞造成|Cffffc926攻击*400%|r伤害。","ReplaceableTextures\\CommandButtons\\BTNS508.blp")
call InitAbilityData('S509',1,0,0,0,0,0,0,0,0,0,"奕剑之道","奕剑之道，在于无招。|n攻击|Cffffc9266%|r概率进入|Cffffc926心剑状态|r，|Cffffc9268|r秒内攻击速度提高|Cffffc92620%|r。","ReplaceableTextures\\CommandButtons\\BTNS509.blp")
call InitAbilityData('S510',2,0,0,0,0,0,0,0,0,2,"八九玄功","使用后依次|Cffffc926变幻形态|r，并获得相应加成：\n龙形态：暴击|Cffffc926+10%|r|Cfff0f0f0|r\n虎形态：攻速|Cffffc926+45%|r|Cfff0f0f0|r\n人形态：|Cfff0f0f0冷却缩减|r|Cffffc926+10%|r","ReplaceableTextures\\CommandButtons\\BTNS510_1.blp")
call InitAbilityData('S511',1,0,0,0,0,0,0,0,0,0,"命途多舛","释放|Cffffc926主动技能|r有|Cffffc92650%|r几率|Cffbbbbbb失败|r，该伤害|Cffbbbbbb降低50%|r|Cfff0f0f0；|r|Cffffc92650%|r|Cfff0f0f0几|r率|Cffffc926大成功|r，该伤害提高至|Cffffc926160%|r|Cfff0f0f0。|r","ReplaceableTextures\\CommandButtons\\BTNS511.blp")
call InitAbilityData('S512',3,0,1,3,0,0,0,0,1,12,"天王宝塔","掷出天王宝塔镇压目标，造成|Cffffc926攻击*200%|r物理伤害并|Cffffbf00眩晕|r2秒。\n\n|Cff00ff7f暴击>40%|r：伤害翻倍。","ReplaceableTextures\\CommandButtons\\BTNS512.blp")
call InitAbilityData('S513',3,0,0,0,0,0,0,0,0,12,"身外法身","使用毫毛在目标地点|Cffffc926幻化一个法身|r，可|Cffffc926模仿你施放|r的|Cffffc926主动伤害技能|r，但只造成|Cffffd24d50%|r|Cfff0f0f0伤害|r。\n\n|Cffbbbbbb法身无法攻击，不可选取，不受攻击。|r","ReplaceableTextures\\CommandButtons\\BTNS513.blp")
call InitAbilityData('S514',2,0,2,3,0,0,0,0,2,10,"冰封万里","对自身周围发动一次冰封术，造成|Cffffd24d攻击*200%|r伤害|n|n|Cff00ff7f冷却缩减>35%：|r额外发动一次冰暴，造成|Cffffd24d攻击*500%|r伤害。","ReplaceableTextures\\CommandButtons\\BTNS514.blp")
call InitAbilityData('S515',1,0,2,8,0,0,0,0,2,0,"日月珠","每次施法凝聚1颗日月珠环绕自身，数量达到4颗时，向攻击目标造成攻击*150%范围伤害。","ReplaceableTextures\\CommandButtons\\BTNS515.blp")
call InitAbilityData('S516',2,0,0,0,0,0,0,0,0,30,"悔悟","|CffFFD24D自裁|r悔过，所有人回复|Cffffd24d50%|r生命，|Cffffd24d3|r秒内提高|Cffffd24d20%|r法术伤害。|n|n|Cff00ff7f悔过次数>10：|r|Cfff0f0f0永久增|r加自身|Cffffd24d当前攻击30%|r","ReplaceableTextures\\CommandButtons\\BTNS516.blp")
call InitAbilityData('S517',1,0,0,0,0,0,0,0,0,0,"天资聪颖","每次学习技能获得|Cff00bfff200~800|r攻击。","ReplaceableTextures\\CommandButtons\\BTNS517.blp")
call InitAbilityData('S518',1,0,0,0,0,0,0,0,0,0,"九转神功","每次突破境界|Cffffbf0040%|r概率获得额外|Cffffbf0010%|r收益","ReplaceableTextures\\CommandButtons\\BTNS518.blp")
call InitAbilityData('S519',1,0,2,3,0,0,0,0,2,0,"天眼神光","|CffFFD24D攻击或施法|r时，|Cffffd24d4%|r几率开启天眼发射神光，造成|Cffffd24d攻击*200%|r伤害。","ReplaceableTextures\\CommandButtons\\BTNS519.blp")
call InitAbilityData('S520',1,0,0,0,0,0,0,0,0,0,"莲花化身","法抗|Cffffd24d+12%|r","ReplaceableTextures\\CommandButtons\\BTNS520.blp")
call InitAbilityData('S521',2,0,0,0,0,0,0,0,0,40,"中秋快乐","每次使用获得一个|Cffffd24d随机月饼|r。|n|Cffffd24d蛋黄月饼|r：回复|Cffffd24d80%|r生命，|Cffffd24d解除异常状态|r|n|Cffffd24d豆沙月饼|r：增加|Cffffd24d+10%|r暴击|n|Cffffd24d果蔬月饼|r：法术伤害提高|Cffffd24d20%|r|n|Cffffd24d鲜肉月饼|r：物理伤害提高|Cffffd24d20%|r|n|Cffffd24d冰皮月饼|r：攻速|Cffffd24d+40%|r|n|n|Cff00ff7f状态持续15秒。|r","ReplaceableTextures\\CommandButtons\\BTNS521.blp")
call InitAbilityData('S522',1,0,0,0,0,0,0,0,0,0,"风雷咒术","获得风雷咒术加持，攻击速度提高|Cffffd24d40%|r|Cfff0f0f0。|r过快的攻击速度导致物理伤害|Cffbbbbbb降低50%|r。","ReplaceableTextures\\CommandButtons\\BTNS522.blp")
call InitAbilityData('S523',6,0,0,0,0,0,0,0,0,12,"狐媚术","回复目标|Cffffd24d30%|r生命并|Cffffd24d解除所有负面效果|r，|Cffffd24d4|rs内提高|Cffffd24d10%|r攻击。","ReplaceableTextures\\CommandButtons\\BTNS523.blp")
call InitAbilityData('S524',6,0,0,0,0,0,0,0,0,180,"道友请留步","劝说目标队友分享属性：\n|Cffffd24d30%|r成功，该队友和你攻击提高|Cffffd24d10%\n40%|r暴力劝说，获得该队友|Cffffd24d25%|r攻击。\n|Cffffd24d30%|r失败，队友获得你|Cffffd24d25%|r攻击\n劝说效果持续3分钟。\n|Cff00ff7f该技能冷却时间固定。|r","ReplaceableTextures\\CommandButtons\\BTNS524.blp")
call InitAbilityData('S525',3,0,1,1.5,0,0,0,0,1,8,"攒心钉","发射|Cffffd24d3枚|r攒心钉，造成|Cffffd24d攻击*120%|r伤害，|Cffffd24d4|r秒内降低怪物|Cffffd24d10%|r防御。\n\n|Cff00ff7f效果不可叠加。|r","ReplaceableTextures\\CommandButtons\\BTNS525.blp")
call InitAbilityData('S526',1,0,1,4,0,0,0,0,1,6,"当头棒击","每8秒攻击对直线范围造成|Cffff8000攻击*200%|r物理伤害。","ReplaceableTextures\\CommandButtons\\BTNS526.blp")
call InitAbilityData('S527',9,0,0,0,0,0,0,0,0,30,"昏庸无道","|CffFFD24D处决|r一名队友，|Cffffd24d8|r秒内增加你的攻击力，增加量为|Cffffd24d该队友攻击的12%|r|Cfff0f0f0。|r\n|Cff00ff7f处决自己获得一半加成。|r\n|Cff00ff7f施法距离全图|r","ReplaceableTextures\\CommandButtons\\BTNS527.blp")
call InitAbilityData('S528',1,0,0,0,0,0,0,0,0,0,"尚武乏谋","有什么问题是暴力不能解决的呢？|n物理伤害+|Cffffd24d20%|r|Cfff0f0f0，|r法术伤害|Cffbbbbbb-30%|r","ReplaceableTextures\\CommandButtons\\BTNS528.blp")
call InitAbilityData('S529',1,0,0,0,0,0,0,0,0,20,"神医救世","队友或你死亡时，直接|Cffffd24d复活|r。","ReplaceableTextures\\CommandButtons\\BTNS529.blp")
call InitAbilityData('S530',1,0,0,0,0,0,0,0,0,0,"百发百中","攻击必定命中。","ReplaceableTextures\\CommandButtons\\BTNS530.blp")
call InitAbilityData('S531',1,0,0,0,0,0,0,0,0,0,"料事如神","对|Cffffd24d混沌星灵|r造成的伤害提高|Cffffd24d50%|r|Cfff0f0f0。|r","ReplaceableTextures\\CommandButtons\\BTNS531.blp")

InitAbilityStringEx('S501',"挥砍一段伤害+100%","挥砍二段伤害+100%","第三段挥砍造成4秒眩晕","","")
InitAbilityStringEx('S502',"附带2秒眩晕效果","爪击伤害提高50%。","爪击后3秒内提高30%伤害加成","","")
InitAbilityStringEx('S503',"冷却时间4秒","冷却时间2秒","冷却时间移除","","")
InitAbilityStringEx('S504',"刺击次数+1","刺击次数+1","刺击次数+2","","")
InitAbilityStringEx('S505',"幻化3个分身","幻化4个分身","幻化6个分身","","")
InitAbilityStringEx('S506',"斩杀血限提高至8%","斩杀血限提高至10%","斩杀血限提高至15%","","")
InitAbilityStringEx('S507',"回复量+5%","回复量+5%","回复量+10%","","")
InitAbilityStringEx('S508',"每层妖狐印记提高9%攻速","每层妖狐印记提高12%攻速","镜花之舞造成法强*16法术伤害","","")
InitAbilityStringEx('S509',"普攻伤害+10%","普攻伤害+10%","攻击间隔-0.1","","")
InitAbilityStringEx('S510',"金龙形态下伤害减免+10%","白虎形态下闪避+10%","人形态伤害吸血+5%","","")
InitAbilityStringEx('S511',"大成功伤害提高至180%","大成功伤害提高至210%","大成功伤害提高至300%","","")
InitAbilityStringEx('S512',"造成攻击*5物理伤害","造成攻击*7物理伤害","造成攻击*9物理伤害","","")
InitAbilityStringEx('S513',"法身释放技能造成60%伤害","法身释放技能造成70%伤害","法身释放技能造成100%伤害","","")
InitAbilityStringEx('S514',"伤害范围+100%","冰封术造成法强*4法术伤害","冰封术造成法强*6法术伤害和2秒冰冻","","")
InitAbilityStringEx('S515',"造成法强*10法术伤害","造成法强*12法术伤害","造成法强*16法术伤害","","")
InitAbilityStringEx('S516',"回复满额生命","伤害加成提高至40%","伤害加成持续时间+1.5s","","")
InitAbilityStringEx('S517',"获得1本B级技能书","获得1本A级技能书","获得1本S级技能书","","")
InitAbilityStringEx('S518',"概率提升至70%","概率提升至100%","获得2个补天石","","")
InitAbilityStringEx('S519',"施法100%几率开启天眼","攻击开启天眼几率翻倍","神光伤害翻倍","","")
InitAbilityStringEx('S520',"承受技能伤害减少60%","免疫技能负面效果","受到技能伤害时，回复30%最大生命值","","")
InitAbilityStringEx('S521',"获得1个技能附魔卷","50%概率额外获得1个随机月饼","技能冷却时间降低至30s","","")
InitAbilityStringEx('S522',"攻击速度+20%","攻击速度+20%","攻击速度+60%","","")
InitAbilityStringEx('S523',"回复50%生命","攻击和法强效果提高至20%","攻击和法强效果提高至30%","","")
InitAbilityStringEx('S524',"失败劝说移除负面效果。","暴力劝说移除负面效果。","成功时攻击及法强加成提高至30%","","")
InitAbilityStringEx('S525',"攒心钉数量+1","攒心钉数量+1","攒心钉数量+2","","")
InitAbilityStringEx('S526',"冷却时间降低至4秒","冷却时间降低至2秒","当头棒击必定触发暴击","","")
InitAbilityStringEx('S527',"处决目标获得神仙搭救，立即原地复活。","被处决队友8秒内提高20%攻击。","增加量提高至30%","","")
InitAbilityStringEx('S528',"物理伤害+10%","物理伤害+10%","物理伤害+20%","","")
InitAbilityStringEx('S529',"冷却时间降低至18秒","冷却时间降低至16秒","冷却时间降低至12秒","","")
InitAbilityStringEx('S530',"触发致命一击时回复自身3%最大生命值","致命倍率+300%","领悟三重射，可触发攻击特效","","")
InitAbilityStringEx('S531',"增加量提高至境界*400","增加量提高至境界*500","领悟大道，攻击10%概率造成法强*占星次数法术伤害","","")

    endfunction
endscope


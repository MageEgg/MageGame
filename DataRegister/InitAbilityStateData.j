
scope AbilityStateData initializer init
    private function init()
//输出代码
//call InitAbilityData('技能id',技能类型,品质,伤害参数,参数A,参数B,参数C,伤害类型,冷却时间,"技能名称","技能说明","技能图标")
call InitAbilityData('S0Q0',1,9,0,0,0,0,0,0,"Q技能","|Cff00FF7F需求：\n |r|Cff808080- 完成新手任务|r","ReplaceableTextures\\CommandButtons\\BTNCancel.blp")
call InitAbilityData('S0W0',1,9,0,0,0,0,0,0,"W技能","|Cff00FF7F需求：\n |r|Cff808080- 完成新手任务|r","ReplaceableTextures\\CommandButtons\\BTNCancel.blp")
call InitAbilityData('S0E0',1,9,0,0,0,0,0,0,"E技能","|Cff00FF7F需求：\n |r|Cff808080- 完成新手任务|r","ReplaceableTextures\\CommandButtons\\BTNCancel.blp")
call InitAbilityData('S0R0',1,9,0,0,0,0,0,0,"R技能","|Cff00FF7F需求：\n|r|cff808080 - 境界七-觉醒后解锁|r","ReplaceableTextures\\CommandButtons\\BTNCancel.blp")
call InitAbilityData('S0Q1',1,9,0,0,0,0,0,0,"Q技能","暂未学习技能\n\n在|cff00ff40技能商店|r内购买|cff00ff40技能书|r学习。","ReplaceableTextures\\CommandButtons\\BTNSelectHeroOn.blp")
call InitAbilityData('S0W1',1,9,0,0,0,0,0,0,"W技能","暂未学习技能\n\n在|cff00ff40技能商店|r内购买|cff00ff40技能书|r学习。","ReplaceableTextures\\CommandButtons\\BTNSelectHeroOn.blp")
call InitAbilityData('S0E1',1,9,0,0,0,0,0,0,"E技能","暂未学习技能\n\n在|cff00ff40技能商店|r内购买|cff00ff40技能书|r学习。","ReplaceableTextures\\CommandButtons\\BTNSelectHeroOn.blp")
call InitAbilityData('S0R1',1,9,0,0,0,0,0,0,"R技能","觉醒后获得\n\n突破至|cff00ff40境界七-劫变期|r，兽魂觉醒商店内抽中|cff00ff40任意三个兽魂|r觉醒。","ReplaceableTextures\\CommandButtons\\BTNSelectHeroOn.blp")
call InitAbilityData('S001',1,1,0,0,0,0,0,0,"鬼剑式","增加|Cffff8000120%|r普攻伤害","ReplaceableTextures\\CommandButtons\\BTNS001.blp")
call InitAbilityData('S002',1,1,0,0,0,0,0,6,"夺天一击","每6秒，必定触发|Cffff800020倍|r致命一击","ReplaceableTextures\\CommandButtons\\BTNS002.blp")
call InitAbilityData('S003',1,1,0,0,0,0,0,0,"残暴","致命概率|Cffff8000+15%|r，致命倍率|Cffff8000+650%\n\n|r|Cff00ff7f致命一击仅能通过普攻触发，与暴击效果叠加。|r","ReplaceableTextures\\CommandButtons\\BTNS003.blp")
call InitAbilityData('S004',1,2,0,0,0,0,0,0,"无情","致命概率|Cffff8000+5%|r，致命倍数|Cffff8000+600%|r\n\n|Cff00ff7f致命一击仅能通过普攻触发，与暴击效果叠加。|r","ReplaceableTextures\\CommandButtons\\BTNS004.blp")
call InitAbilityData('S005',1,2,0,0,0,0,0,0,"横扫千军","分裂|Cffff8000+70%|r","ReplaceableTextures\\CommandButtons\\BTNS005.blp")
call InitAbilityData('S006',8,2,1,10,0,0,1,6,"无影杀","对目标范围内每个怪物进行攻击，造成|Cffff8000攻击*2.5|r物理伤害，附带|Cffff8000普攻效果|r。","ReplaceableTextures\\CommandButtons\\BTNS006.blp")
call InitAbilityData('S007',1,3,0,0,0,0,0,0,"巨人之力","增加|Cffff8000150%|r普攻伤害，|Cffff8000-80%|r攻击速度","ReplaceableTextures\\CommandButtons\\BTNS007.blp")
call InitAbilityData('S008',1,3,0,0,0,0,0,0,"摧枯","|CffFF8000致命一击|r时，使目标进入脆弱状态，|Cffff8000承受伤害+30%|r，持续4秒。\n\n|Cff00ff7f脆弱状态不叠加。|r","ReplaceableTextures\\CommandButtons\\BTNS008.blp")
call InitAbilityData('S009',1,3,0,0,0,0,0,2,"连击","攻击命中后立即|Cffff8000追加一次|r普通攻击","ReplaceableTextures\\CommandButtons\\BTNS009.blp")
call InitAbilityData('S010',1,4,0,0,0,0,0,0,"技击","普攻伤害|Cffff8000-20%|r,致命概率|Cffff8000+20%|r\n\n|Cff00ff7f致命一击仅能通过普攻触发，与暴击效果叠加。|r","ReplaceableTextures\\CommandButtons\\BTNS010.blp")
call InitAbilityData('S011',1,4,0,0,0,0,0,0,"寸劲","致命概率|Cffff8000-5%|r，致命倍率|Cffff8000+450%\n|r\n|Cff00ff7f致命一击仅能通过普攻触发，与暴击效果叠加。|r","ReplaceableTextures\\CommandButtons\\BTNS011.blp")
call InitAbilityData('S012',1,4,0,0,0,0,0,0,"横扫","分裂|Cffff8000+30%|r","ReplaceableTextures\\CommandButtons\\BTNS012.blp")
call InitAbilityData('S013',1,7,0,0,0,0,0,0,"知微","致命概率|Cffff8000+15%|r\n\n|Cff00ff7f致命一击仅能通过普攻触发，与暴击效果叠加。|r","ReplaceableTextures\\CommandButtons\\BTNS013.blp")
call InitAbilityData('S014',1,7,0,0,0,0,0,0,"善武乏谋","法术伤害|Cffff8000-30%|r，致命倍率|Cffff8000+300%|r\n\n|Cff00ff7f致命一击仅能通过普攻触发，与暴击效果叠加。|r","ReplaceableTextures\\CommandButtons\\BTNS014.blp")
call InitAbilityData('S015',1,7,0,0,0,0,0,0,"洞察","致命概率|Cffff8000+10%|r，致命倍率|Cffff8000+100%|r\n\n|Cff00ff7f致命一击仅能通过普攻触发，与暴击效果叠加。|r","ReplaceableTextures\\CommandButtons\\BTNS015.blp")
call InitAbilityData('S016',1,7,0,0,0,0,0,0,"骁勇","增加|Cffff800030%|r普攻伤害","ReplaceableTextures\\CommandButtons\\BTNS016.blp")
call InitAbilityData('S018',2,1,1,6,0,0,1,8,"破甲阵","使用精湛的刀术对周围怪物造成造成|Cffff8000攻击*16|r物理伤害，3s内增加自身|Cffff800015%|r物理穿透。\n\n|Cff00ff7f效果可叠加|r","ReplaceableTextures\\CommandButtons\\BTNS018.blp")
call InitAbilityData('S019',1,2,0,0,0,0,0,0,"卸甲","增加|Cffff800025%|r护甲穿透","ReplaceableTextures\\CommandButtons\\BTNS019.blp")
call InitAbilityData('S020',1,3,0,0,0,0,0,0,"腐蚀","|CffFF8000攻击+10000|r，增加|Cffff800015%|r护甲穿透","ReplaceableTextures\\CommandButtons\\BTNS020.blp")
call InitAbilityData('S022',8,1,99,3,0,0,1,10,"强攻阵","对周围怪物造成|Cffff8000攻击*12|r+|Cff00bfff法强*12|r物理伤害，3s内增加|Cffff800010%|r暴击。\n\n|Cff00ff7f效果可叠加|r","ReplaceableTextures\\CommandButtons\\BTNS022.blp")
call InitAbilityData('S023',1,1,99,2,0,0,2,0,"天罚","攻击或释放|Cff00ff7f技能暴击|r时，对目标范围内怪物造成|Cffff8000攻击*2|r+|Cff00bfff法强*2|r法术伤害。\n\n|Cffaaaaaa内置冷却0.1秒。|r","ReplaceableTextures\\CommandButtons\\BTNS023.blp")
call InitAbilityData('S024',1,1,0,0,0,0,0,0,"诛仙","增加|Cffff800015%|r暴击,|Cffff8000100%|r暴击伤害","ReplaceableTextures\\CommandButtons\\BTNS024.blp")
call InitAbilityData('S025',1,2,0,0,0,0,0,0,"降魔","|CffFF8000降低5%|r暴击，增加|Cffff8000200%|r暴击伤害","ReplaceableTextures\\CommandButtons\\BTNS025.blp")
call InitAbilityData('S027',1,1,1,8,0,0,1,0,"九天御雷击","攻击|Cffff800010%|r概率对目标范围造成|Cffff8000攻击*13|r物理伤害","ReplaceableTextures\\CommandButtons\\BTNS027.blp")
call InitAbilityData('S028',1,1,2,8,0,0,2,0,"冥月流星落","攻击|Cff00bfff10%|r概率对目标范围造成|Cff00bfff法强*15|r法术伤害","ReplaceableTextures\\CommandButtons\\BTNS028.blp")
call InitAbilityData('S029',1,1,0,0,0,0,0,0,"天命","增加|Cffffcc0010%|r所有触发概率\n\n|Cff00ff7f影响被动技能/多重施法/致命一击概率。|r","ReplaceableTextures\\CommandButtons\\BTNS029.blp")
call InitAbilityData('S030',1,1,1,4,0,0,1,0,"三昧真火","每|Cffff800010|r次攻击释放三昧真火，对敌方造成|Cffff8000攻击*10|r+|Cff00bfff法强*10|r物理伤害","ReplaceableTextures\\CommandButtons\\BTNS030.blp")
call InitAbilityData('S031',1,2,0,0,0,0,0,6,"魔茧","|CffFF8000降低|r自身|Cffff800030%|r攻击速度。\n攻击|Cffff800020%|r几率4秒内增加自身|Cffff8000120%|r攻击速度。","ReplaceableTextures\\CommandButtons\\BTNS031.blp")
call InitAbilityData('S032',1,2,0,0,0,0,0,0,"血之沸腾","增加|Cffff800060%|r攻击速度","ReplaceableTextures\\CommandButtons\\BTNS032.blp")
call InitAbilityData('S033',2,2,0,0,0,0,0,8,"斩意诀","|CffFF80006|r秒内增加|Cffff800050%|r攻击速度。\n\n|Cff00ff7f效果可叠加。|r","ReplaceableTextures\\CommandButtons\\BTNS033.blp")
call InitAbilityData('S034',1,3,0,0,0,0,0,0,"风扬阵","600码范围内所有玩家增加|Cffff800040%|r攻击速度","ReplaceableTextures\\CommandButtons\\BTNS034.blp")
call InitAbilityData('S035',1,3,2,8,0,0,2,0,"业火咒","每|Cff00bfff8|r次攻击施动业火咒术，对目标范围内造成|Cff00bfff法强*8|r法术伤害","ReplaceableTextures\\CommandButtons\\BTNS035.blp")
call InitAbilityData('S036',1,3,0,0,0,0,0,0,"幻击","每次攻击|Cffff8000视为2次|r攻击。\n\n|Cff00ff7f仅作用与攻击次数累计|r","ReplaceableTextures\\CommandButtons\\BTNS036.blp")
call InitAbilityData('S037',1,4,0,0,0,0,0,0,"轻灵","普攻伤害|Cffff8000-30%|r，攻击速度|Cffff8000+40%|r","ReplaceableTextures\\CommandButtons\\BTNS037.blp")
call InitAbilityData('S038',1,4,1,4,0,0,1,0,"罡风破","每|Cffff800012|r次攻击对目标范围造成|Cffff8000攻击*4|r物理伤害","ReplaceableTextures\\CommandButtons\\BTNS038.blp")
call InitAbilityData('S039',1,4,2,6,0,0,2,0,"他山之石","每|Cff00bfff12|r次攻击对目标范围造成|Cff00bfff法强*5|r法术伤害。","ReplaceableTextures\\CommandButtons\\BTNS039.blp")
call InitAbilityData('S040',1,7,2,3,0,0,2,0,"弱水咒","攻击|Cff00bfff10%|r概率对目标范围造成|Cff00bfffAP*4|r法术伤害","ReplaceableTextures\\CommandButtons\\BTNS040.blp")
call InitAbilityData('S041',1,7,0,0,0,0,0,0,"速攻","增加|Cffff800025%|r攻击速度","ReplaceableTextures\\CommandButtons\\BTNS041.blp")
call InitAbilityData('S042',1,7,0,0,0,0,0,0,"若风","法术伤害|Cff00bfff-30%|r，攻击速度|Cff00bfff+40%|r","ReplaceableTextures\\CommandButtons\\BTNS042.blp")
call InitAbilityData('S043',1,7,1,2,0,0,2,0,"气流杀","攻击|Cffff800010%|r概率对目标范围造成|Cffff8000攻击*3|r物理伤害","ReplaceableTextures\\CommandButtons\\BTNS043.blp")
call InitAbilityData('S045',1,1,0,0,0,0,0,0,"毒仙","毒体|Cff00bfff持续时间|r翻倍，每秒叠加|Cff00bfff2|r次，|Cff00bfff上限翻倍|r。","ReplaceableTextures\\CommandButtons\\BTNS045.blp")
call InitAbilityData('S046',2,2,2,3,0,0,2,6,"引爆","对自身范围内敌人造成|Cff00bfff法强*4*中毒叠加次数|r法术伤害","ReplaceableTextures\\CommandButtons\\BTNS046.blp")
call InitAbilityData('S047',2,3,2,0.75,0,0,2,16,"毒体","开启后使周围地方单位进入|Cff00ff7f中毒状态|r，每秒造成|Cff00bfff法强*0.75|r法术伤害。\n\n|Cff00ff7f持续伤害最多可叠加8次。|r","ReplaceableTextures\\CommandButtons\\BTNS047.blp")
call InitAbilityData('S048',1,3,2,5,0,0,2,0,"狐媚术","攻击|Cff00bfff12.5%|r概率对目标范围施加一次|Cffff80c0魅惑|r，造成|Cff00bfff法强*5|r法术伤害，|Cff00bfff8|r秒内降低|Cff00bfff6%|r攻速及移动速度。\n\n|Cff00ff7f减速效果可叠加，上限8次|r","ReplaceableTextures\\CommandButtons\\BTNS048.blp")
call InitAbilityData('S049',2,3,2,4,0,0,2,8,"失心令","对周围敌人造成|Cff00bfff法强*4*魅惑层数|r法术伤害","ReplaceableTextures\\CommandButtons\\BTNS049.blp")
call InitAbilityData('S052',3,1,2,10,0,0,2,6,"神火天降","对目标范围内敌人造成|Cff00bfff法强*18|r法术伤害，所有技能|Cff00bfff冷却减少0.5秒|r。","ReplaceableTextures\\CommandButtons\\BTNS052.blp")
call InitAbilityData('S053',2,2,2,2,0,0,2,2,"落魂咒","对周围单位造成|Cff00bfff法强*8|r法术伤害，|Cff00bfff20%|r几率造成|Cff00bfff双倍|r伤害\n\n|Cff00ff7f固定冷却时间|r","ReplaceableTextures\\CommandButtons\\BTNS053.blp")
call InitAbilityData('S054',1,3,0,0,0,0,0,0,"法魂","不再享受冷却缩减效果，每|Cff00bfff0.32%冷却|r提高|Cff00bfff1%法强加成|r。","ReplaceableTextures\\CommandButtons\\BTNS054.blp")
call InitAbilityData('S056',1,3,0,0,0,0,0,0,"术神式","攻击|Cff00bfff3%|r重置所有技能冷却时间。\n\n|Cff00ff7f概率不受天命影响。|r","ReplaceableTextures\\CommandButtons\\BTNS056.blp")
call InitAbilityData('S057',1,4,0,0,0,0,0,0,"灵犀式","攻击|Cff00bfff24次|r重置所有技能冷却","ReplaceableTextures\\CommandButtons\\BTNS057.blp")
call InitAbilityData('S058',1,4,0,0,0,0,0,0,"仙之心","增加|Cff00bfff15%|r冷却缩减","ReplaceableTextures\\CommandButtons\\BTNS058.blp")
call InitAbilityData('S059',1,7,0,0,0,0,0,0,"灵之心","增加|Cff00bfff10%|r冷却缩减","ReplaceableTextures\\CommandButtons\\BTNS059.blp")
call InitAbilityData('S061',1,1,0,0,0,0,0,0,"帝星","|Cff00BFFF50%|r概率额外施法|Cff00bfff3|r次","ReplaceableTextures\\CommandButtons\\BTNS061.blp")
call InitAbilityData('S062',1,2,0,0,0,0,0,0,"帝命","|Cff00FF7F帝星或将星|r触发时，额外|Cff00bfff释放技能次数+2|r。","ReplaceableTextures\\CommandButtons\\BTNS062.blp")
call InitAbilityData('S063',1,3,0,0,0,0,0,0,"将星","|Cff00BFFF40%|r概率额外施法|Cff00bfff2次|r","ReplaceableTextures\\CommandButtons\\BTNS063.blp")
call InitAbilityData('S065',2,1,2,10,0,0,2,8,"破法阵","对周围怪物造成|Cff00bfff法强*10|r法术伤害，3s内增加|Cff00bfff15%法术穿透|r。\n\n|Cff00ff7f效果可叠加|r","ReplaceableTextures\\CommandButtons\\BTNS065.blp")
call InitAbilityData('S066',1,2,0,0,0,0,0,0,"灭魂","增加|Cff00bfff25%|r法术穿透","ReplaceableTextures\\CommandButtons\\BTNS066.blp")
call InitAbilityData('S067',1,2,0,0,0,0,0,0,"威慑","降低周围怪物|Cff00bfff10%|r法术抗性。\n\n|Cff00ff7f效果可叠加。|r","ReplaceableTextures\\CommandButtons\\BTNS067.blp")
call InitAbilityData('S068',1,3,0,0,0,0,0,0,"穿魂","|Cff00BFFF法强+10000|r，增加|Cff00bfff15%|r法术穿透","ReplaceableTextures\\CommandButtons\\BTNS068.blp")
call InitAbilityData('S070',3,1,1,3,0,0,1,20,"暴风剑雨","对目标范围内怪物造成|Cffff80004次|r攻击，每次攻击造成|Cffff8000攻击*5|r物理伤害。\n\n|Cff00ff7f每25%攻速额外攻击1次。|r","ReplaceableTextures\\CommandButtons\\BTNS070.blp")
call InitAbilityData('S071',1,3,0,0,0,0,0,0,"妖之力","不再享受攻速加成。每|Cffff80003.3%攻速|r提供|Cffff80001%攻击|r加成","ReplaceableTextures\\CommandButtons\\BTNS071.blp")
call InitAbilityData('S073',2,2,1,4,0,0,1,12,"混元珠","掷出|Cffff80004颗|r混元宝珠围绕自身旋转，每次碰撞到怪物时造成|Cffff8000攻击*4|r物理伤害，并|Cffffcc00眩晕0.5秒|r。\n对|Cff00ff7f失明状态|r的怪物造成|Cffff8000额外30%物理伤害|r。\n\n|Cff00ff7f技能结束时重置戮目珠的技能冷却。|r","ReplaceableTextures\\CommandButtons\\BTNS073.blp")
call InitAbilityData('S074',3,3,1,4.5,0,0,1,6,"戮目珠","对目标范围掷出戮目珠，对碰撞到的怪物造成|Cffff8000攻击*4.5|r物理伤害，并使其进入|Cff00ff7f失明状态|r，攻击命中率降低30%，持续3秒。","ReplaceableTextures\\CommandButtons\\BTNS074.blp")
call InitAbilityData('S075',1,1,1,10,0,0,1,0,"夺命刺","攻击|Cffff800015%|r概率对目标造成|Cffff8000攻击*10|r物理伤害，\n\n触发后追加一次|Cff00bfff连环刺|r。|Cff00ff7f（需已学习连环刺）|r","ReplaceableTextures\\CommandButtons\\BTNS075.blp")
call InitAbilityData('S076',1,3,1,5,0,0,1,0,"连环刺","攻击|Cffff800015%|r概率对目标范围造成|Cffff8000AD*5|r物理伤害。\n\n触发后2s内|Cffff0000夺命刺|r概率增加|Cffff800010%|r。","ReplaceableTextures\\CommandButtons\\BTNS076.blp")
call InitAbilityData('S078',3,1,1,5,0,0,1,8,"彗星灭世","对目标范围造成|Cffff8000攻击*5*蓄力时间|r物理伤害。\n\n|Cff00ff7f攻击越高，蓄力时间越长。|r","ReplaceableTextures\\CommandButtons\\BTNS078.blp")
call InitAbilityData('S079',3,1,2,5,0,0,2,8,"龙神陨光","对前方造成|Cff00bfff法强*5*蓄力时间|r物理伤害。\n\n|Cff00ff7f法强越高，蓄力时间越长。|r","ReplaceableTextures\\CommandButtons\\BTNS079.blp")
call InitAbilityData('S080',3,2,1,2.5,0,0,1,8,"剑灵诛仙式","万剑出鞘，对目标范围造成|Cffff8000攻击*1.2|r物理伤害。\n\n|Cff00ff7f攻击越高，持续时间越长。|r","ReplaceableTextures\\CommandButtons\\BTNS080.blp")
call InitAbilityData('S081',3,2,2,2.5,0,0,2,8,"真空领域","将目标范围内的所有单位聚卷入中心，每|Cff00bfff0.5|r秒造成|Cff00bfff法强*2|r法术伤害。\n\n|Cff00ff7f法强越高，持续时间越长。|r","ReplaceableTextures\\CommandButtons\\BTNS081.blp")
call InitAbilityData('S082',2,3,1,2.5,0,0,1,8,"雷神之子","召唤4个雷球，雷球每|Cffff80000.75|r秒对发起范围攻击造成|Cffff8000攻击*2.5|r物理伤害。\n\n|Cff00bfff攻击越高，雷球持续时间越长。|r","ReplaceableTextures\\CommandButtons\\BTNS082.blp")
call InitAbilityData('S083',2,3,2,2.5,0,0,2,8,"十方飓风破","自身每|Cff00bfff0.75|r秒向周围逸散暴风，造成|Cff00bfff法强*2.5|r法术伤害。\n\n|Cff00ff7f法强越高，持续时间越长。|r","ReplaceableTextures\\CommandButtons\\BTNS083.blp")
call InitAbilityData('S085',1,1,0,0,0,0,0,0,"通灵秘术","使以下召唤技能附带|Cff00ff7f额外效果|r：\n\n|Cffffcc00幻影剑阵|r：飞剑25%几率造成2倍伤害\n|Cff00bfff天神道兵|r：进化为混沌道兵\n|Cff00bfff噬魂灵魄|r：伤害提高400%\n|Cffffcc00五行道兵|r：10%概率触发一次额外攻击。","ReplaceableTextures\\CommandButtons\\BTNS085.blp")
call InitAbilityData('S086',2,2,0,0,0,0,0,20,"幻影剑阵","召唤|Cffff80004|r把飞剑，每把飞剑|Cff00ff7f攻击9次幻化|r出额外一把飞剑，最多幻化1次。\n\n飞剑继承人物|Cffff800050%攻击|r。","ReplaceableTextures\\CommandButtons\\BTNS086.blp")
call InitAbilityData('S087',2,2,0,0,0,0,0,7,"五行道兵","召唤1个五行道兵。道兵拥有多重箭，每次攻击伤害递增|Cffff800010%|r，上限|Cffff8000100%|r。\n|Cff00ff7f道兵攻击与人物法强有关|r\n\n|Cff00ff7f通灵秘术：|r|Cffcccccc10%概率触发一次额外攻击。|r","ReplaceableTextures\\CommandButtons\\BTNS087.blp")
call InitAbilityData('S088',1,2,0,0,0,0,0,0,"通灵契约","召唤物数量|Cffffcc00+2|r","ReplaceableTextures\\CommandButtons\\BTNS088.blp")
call InitAbilityData('S089',2,3,0,0,0,0,0,16,"天神道兵","召唤1个天神道兵。道兵每次攻击伤害递增|Cffff800010%|r，上限|Cffff8000100%|r。\n|Cff00ff7f道兵攻击与人物攻击和法强有关|r\n\n|Cff00ff7f通灵秘术：|r|Cffcccccc进化为混沌道兵，攻击力翻倍，每次攻击伤害递增20%，上限200%。|r","ReplaceableTextures\\CommandButtons\\BTNS089.blp")
call InitAbilityData('S090',2,3,0,0,0,0,2,10,"噬魂龙魄","召唤1个噬魂龙魄，使周围600码单位生机骤减，每0.5秒造成|Cff00bfff法强*1|r法术伤害。\n\n|Cff00ff7f多个噬魂灵魄伤害可叠加。|r","ReplaceableTextures\\CommandButtons\\BTNS090.blp")
call InitAbilityData('S091',2,1,0,0,0,0,0,12,"魔主","吞噬场上属于自己的所有召唤物，4s内自身获得以下相应加成：\n|Cffffcc00幻影剑阵|r：暴击+30%\n|Cffffcc00五行道兵|r：AD+40%，AP+40%\n|Cff00bfff天道神兵|r：攻击速度+80%\n|Cff00bfff噬魂龙魄|r：冷却缩减-25%","ReplaceableTextures\\CommandButtons\\BTNS091.blp")
call InitAbilityData('S094',1,1,5,10,0,0,1,0,"五色华光","被攻击|Cffffcc0010%|r概率对周围敌人造成|Cffffcc00生命值*10|r物理伤害","ReplaceableTextures\\CommandButtons\\BTNS094.blp")
call InitAbilityData('S095',1,1,5,16,0,0,2,0,"佛陀法身","被攻击|Cff00bfff20%|r概率触对周围敌人|Cff00bfff法强*16|r法术伤害","ReplaceableTextures\\CommandButtons\\BTNS095.blp")
call InitAbilityData('S096',1,1,5,16,0,0,1,0,"酒仙剑舞","被攻击|Cffff800020%|r概率对周围敌人|Cffff8000攻击*16|r物理伤害","ReplaceableTextures\\CommandButtons\\BTNS096.blp")
call InitAbilityData('S097',1,1,5,8,0,0,2,0,"神怒","被攻击|Cffffcc008次|r对自身范围内敌人造成|Cffffcc00生命值*8|r法术伤害","ReplaceableTextures\\CommandButtons\\BTNS097.blp")
call InitAbilityData('S098',1,2,1,6,0,0,1,0,"反震","被攻击|Cffffcc0010%|r概率对周围敌人造成|Cffffcc00生命值*6|r物理伤害","ReplaceableTextures\\CommandButtons\\BTNS098.blp")
call InitAbilityData('S099',1,2,0,0,0,0,0,0,"刚毅之心","最大生命值|Cffffcc00+15%|r","ReplaceableTextures\\CommandButtons\\BTNS099.blp")
call InitAbilityData('S100',2,2,0,0,0,0,0,12,"挑衅","增加怪物|Cffffcc00100%|r攻速，降低怪物|Cffffcc0070%|r攻击力","ReplaceableTextures\\CommandButtons\\BTNS100.blp")
call InitAbilityData('S101',3,3,1,8,0,0,1,8,"雷光破","对目标范围造成|Cffff8000攻击*8|r物理伤害，额外造成|Cffffcc00生命值*4|r物理伤害。","ReplaceableTextures\\CommandButtons\\BTNS101.blp")
call InitAbilityData('S102',1,4,5,3,0,0,2,0,"黑龙之灵","释放1条|Cff999999黑龙之灵|r，每秒对敌人造成|Cffffcc00生命值*1.2|r法术伤害。","ReplaceableTextures\\CommandButtons\\BTNS102.blp")
call InitAbilityData('S103',2,7,0,0,0,0,0,8,"梦魇","|CffCCCCCC梦魇缠身，具有神秘效果。|r","ReplaceableTextures\\CommandButtons\\BTNS103.blp")
call InitAbilityData('S104',1,7,5,0.6,0,0,0,0,"熔炉之身","每0.8秒对自身范围内敌人造成|Cffffcc00生命值*0.6|r法术伤害。","ReplaceableTextures\\CommandButtons\\BTNS104.blp")
call InitAbilityData('S105',1,1,1,2,0,0,0,0,"后发制人","闪避时对自身周围敌人造成攻击*2法术伤害","ReplaceableTextures\\CommandButtons\\BTNS105.blp")
call InitAbilityData('S106',1,1,2,2,0,0,2,0,"伏击","闪避时对自身周围敌人造成法强*2法术伤害","ReplaceableTextures\\CommandButtons\\BTNS106.blp")
call InitAbilityData('S107',1,2,0,0,0,0,0,0,"鬼魅","增加|Cffffcc0025%|r闪避","ReplaceableTextures\\CommandButtons\\BTNS107.blp")
call InitAbilityData('S108',1,3,0,0,0,0,0,0,"迅捷","增加|Cffffcc0015%|r闪避","ReplaceableTextures\\CommandButtons\\BTNS108.blp")

call InitAbilityData('S110',7,4,1,3,0,0,1,10,"虚灵斩","对目标范围内怪物造成|Cffff80003次攻击|r，每次攻击造成|Cffff8000攻击*3|r物理伤害。\n\n|Cff00ff7f每30%攻速额外攻击1次。|r","ReplaceableTextures\\CommandButtons\\BTNS110.blp")
call InitAbilityData('S111',2,4,2,3,0,0,2,12,"寒霜符箓","在自身脚下放置1个|Cff00bfff寒霜符|r，敌方单位进入该区域时发生爆炸，造成|Cff00bfff法强*3|r法术伤害。\n\n|Cff00ff7f该技能属于召唤类技能|r","ReplaceableTextures\\CommandButtons\\BTNS111.blp")
call InitAbilityData('S112',3,4,1,1,0,0,1,20,"机关塔","召唤1个机关塔，每秒向360°发射|Cffff80008|r支箭，每支箭造成|Cffff8000攻击*1|r物理伤害。","ReplaceableTextures\\CommandButtons\\BTNS112.blp")
call InitAbilityData('S113',3,4,1,4,0,0,1,8,"紫金葫","投射一个紫金葫，沿途造成|Cffff8000攻击*4|r物理伤害。\n到达目标区域后爆炸，造成|Cff00bfff法强*4|r法术伤害\n\n|Cff00ff7f30%几率额外投射2个葫芦。|r","ReplaceableTextures\\CommandButtons\\BTNS113.blp")
call InitAbilityData('S114',1,4,0,0,0,0,0,0,"除妖","增加|Cffffcc0010%|r暴击率","ReplaceableTextures\\CommandButtons\\BTNS114.blp")
call InitAbilityData('S115',3,4,1,4,0,0,2,8,"元神箭","向目标区域射出三支元神箭，造成|Cffff8000法强*5|r法术伤害\n\n|Cff00ff7f距离越远伤害越高，最多造成200%伤害。|r","ReplaceableTextures\\CommandButtons\\BTNS115.blp")
call InitAbilityData('S116',2,4,2,3,0,0,2,8,"罪焰","自身周围随机点产生一次罪焰。\n罪焰每秒造成|Cff00bfff法强*3|r法术伤害，持续3秒","ReplaceableTextures\\CommandButtons\\BTNS116.blp")
call InitAbilityData('S117',1,4,2,3,0,0,2,0,"元气破","攻击|Cff00bfff15%|r几率对目标范围造成|Cff00bfff法强*4|r法术伤害，并回复|Cff00bfff10|r点蓝量","ReplaceableTextures\\CommandButtons\\BTNS117.blp")
call InitAbilityData('S118',1,5,0,0,0,0,0,0,"血脉之力","每秒回复|Cffffcc003%|r最大生命值","ReplaceableTextures\\CommandButtons\\BTNS118.blp")
call InitAbilityData('S119',1,5,0,0,0,0,0,0,"嗜血","伤害吸血|Cffffcc00+3%|r","ReplaceableTextures\\CommandButtons\\BTNS119.blp")
call InitAbilityData('S120',2,5,1,4,0,0,1,8,"撼地击","对自身周围造成|Cffff8000攻击*4|r物理伤害。\n\n|Cff00ff7f40%几率额外释放一次大范围撼地击。|r","ReplaceableTextures\\CommandButtons\\BTNS120.blp")
call InitAbilityData('S121',2,6,2,5,0,0,0,0,"锁魂","对自身周围造成|Cffff8000法强*5|r法术伤害。\n\n|Cff00ff7f40%几率额外释放一次。4秒内增加|Cff00bfff10%|r法术穿透","ReplaceableTextures\\CommandButtons\\BTNS121.blp")
call InitAbilityData('S122',2,6,1,5,0,0,0,0,"破甲","对自身周围造成|Cffff8000攻击*5|r物理伤害。\n\n|Cff00ff7f40%几率额外释放一次。|r4秒内增加|Cffff800010%|r护甲穿透","ReplaceableTextures\\CommandButtons\\BTNS122.blp")
call InitAbilityData('S123',2,6,2,6,0,0,2,8,"冰暴术","自身周围每秒产生一次随机冰暴，造成|Cff00bfff法强*6|r法术。","ReplaceableTextures\\CommandButtons\\BTNS123.blp")
call InitAbilityData('S124',5,7,2,6,0,0,2,8,"驭雷术","向目标投射一个电球，造成|Cff00bfff法强*5|r法术伤害。电球返回自身时，回复|Cff00bfff命中次数*5|r蓝量。\n\n|Cff00ff7f电球最多跳跃6次。|r","ReplaceableTextures\\CommandButtons\\BTNS124.blp")
call InitAbilityData('S125',1,7,0,0,0,0,0,0,"斩铁式","被攻击|Cffff800010%|r概率4秒内提高|Cffff800050%|r普攻伤害。","ReplaceableTextures\\CommandButtons\\BTNS125.blp")
call InitAbilityData('S126',1,7,0,0,0,0,0,0,"灵巧","闪避|Cffffcc00+10%|r","ReplaceableTextures\\CommandButtons\\BTNS126.blp")
call InitAbilityData('S127',2,8,0,0,0,0,0,10,"回春术","|CffFFBF005|r秒内回复|Cffffcc0060%|r最大生命值\n\n|Cff00ff7f效果不可叠加|r","ReplaceableTextures\\CommandButtons\\BTNS127.blp")
call InitAbilityData('S128',1,8,0,0,0,0,0,0.3,"以战养战","|CffFFBF00闪避|r时回复|Cffffbf002%|r最大生命值。\n\n|Cff00ff7f内置冷却0.3秒|r","ReplaceableTextures\\CommandButtons\\BTNS128.blp")
call InitAbilityData('S129',1,8,0,0,0,0,0,0,"贪婪","杀敌金币|Cffffbf00+3|r","ReplaceableTextures\\CommandButtons\\BTNS129.blp")
call InitAbilityData('S230',3,0,1,24,0,0,1,20,"血之裂痕","化身狴犴扑杀目标范围，造成|Cffff8000攻击*24|r物理伤害并|Cffffbf00眩晕|r3秒。","ReplaceableTextures\\CommandButtons\\BTNS230.blp")
call InitAbilityData('S231',10,0,2,2,0,0,2,20,"十绝阵","天降龙柱，十绝阵现。\n每根龙柱造成|Cff00bfff法强*3|r法术伤害。\n\n|Cff00ff7f基础数量6根，法强越高道棺越多。\n持续时间3秒，施法期间无法攻击和移动。|r","ReplaceableTextures\\CommandButtons\\BTNS231.blp")
call InitAbilityData('S232',2,0,5,2,0,0,2,12,"八荒斗神","强制800范围内所有敌方单位攻击自己，伤害免疫|Cffffbf00+20%|r\n每次被攻击，对目标造成|Cffffbf00生命值*2|r法术伤害","ReplaceableTextures\\CommandButtons\\BTNS232.blp")
call InitAbilityData('S233',2,0,0,0,0,0,0,20,"冰封之域","|CffFF80006|r秒内降低周围单位50%攻速和移动速度，受影响的单位3s后进入|Cffff8000极冻状态|r，|Cffff8000承受物理伤害+100%|r，承受法术伤害-50%。","ReplaceableTextures\\CommandButtons\\BTNS233.blp")
call InitAbilityData('S234',5,0,2,12,0,0,2,20,"离魂秘术","对目标造成|Cff00bfff法强*18|r伤害，随后使目标周围单位无法攻击，|Cff00bfff承受法术伤害+80%|r，承受物理伤害-50%。","ReplaceableTextures\\CommandButtons\\BTNS234.blp")
call InitAbilityData('S235',2,0,0,0,0,0,0,15,"修罗之怒","释放后根据|Cffffbf00当前血量|r增加自身|Cffffbf003%~33%|r暴击概率，持续时间内，每次|Cffffbf00暴击|r增加自身|Cffffbf0030%|r暴击伤害。","ReplaceableTextures\\CommandButtons\\BTNS235.blp")
call InitAbilityData('S236',5,0,0,12,0,0,2,12,"神威一击","突刺至目标身后，造成|Cffff8000攻击|r或|Cff00bfff法强*20|r自适应伤害。随后4秒内|Cffff8000攻击速度+220%|r。","ReplaceableTextures\\CommandButtons\\BTNS236.blp")
call InitAbilityData('S237',2,0,0,0,0,0,0,20,"道法自然","持续时间内，|Cff00bfff冷却缩减+40%|r，每次释放技能增加自身|Cffffbf0010%|r增伤。","ReplaceableTextures\\CommandButtons\\BTNS237.blp")
call InitAbilityData('S238',2,0,1,2,0,0,1,20,"孔雀之魂","4秒内，冷却缩减+40%，每次释放技能增加自身10%增伤。","ReplaceableTextures\\CommandButtons\\BTNS238.blp")
call InitAbilityData('S239',1,0,0,0,0,0,0,20,"未命名","获得后每波增加波数相关的金币&木头奖励。\n该收益在被替换后，效果消失。","ReplaceableTextures\\CommandButtons\\BTNS239.blp")
call InitAbilityData('S501',2,0,1,2,0,0,1,12,"天罚连击","突刺至目标区域并挥砍|Cffff80003|r次，每次造成|Cffff8000攻击*4|r物理伤害。","ReplaceableTextures\\CommandButtons\\BTNS501.blp")
call InitAbilityData('S502',5,0,1,2,0,0,1,10,"土遁袭杀","钻入地底突进至目标身后进行|Cffff80002次|r爪击，每次造成|Cffff8000攻击*1.5|r伤害。","ReplaceableTextures\\CommandButtons\\BTNS502.blp")
call InitAbilityData('S503',1,0,99,1,0,0,2,0.2,"玉清合荒","若600码范围内，有敌/友军释放主动技能，你对自身周围造成|Cffffbf00（攻击+法强）*3|r法术伤害。","ReplaceableTextures\\CommandButtons\\BTNS503.blp")
call InitAbilityData('S504',2,0,1,2,0,0,1,10,"火尖枪舞","突向前方瞬间刺击|Cffff80003|r次，每次造成|Cffff8000攻击*2|r物理伤害。\n\n|Cff00ff7f暴击≥30%|r：额外发出一道弑龙枪，造成|Cffff8000攻击*8|r物理伤害。","ReplaceableTextures\\CommandButtons\\BTNS504.blp")
call InitAbilityData('S505',2,0,2,4,0,0,2,12,"一气化三清","幻化|Cffff80002|r个无法移动的分身，每个分身拥有|Cffff800070%攻击力|r。\n4秒后分身爆炸，造成|Cff00bfff法强*4|r法术伤害。\n\n|Cff00ff7f分身可触发致命一击及分裂效果","ReplaceableTextures\\CommandButtons\\BTNS505.blp")
call InitAbilityData('S506',1,0,0,0,0,0,0,0,"斩仙飞刀","斩杀低于|Cffffbf006%|r最大生命值的敌人。","ReplaceableTextures\\CommandButtons\\BTNS506.blp")
call InitAbilityData('S507',1,0,0,0,0,0,0,0,"万物亲和","每|Cffffbf0010|r秒回复|Cffffbf0020%最大生命值\n|r\n|Cff00ff7f物穿>30%:|r召唤物伤害+30%\n|Cff00ff7f法穿>30%:|r召唤物数量+1","ReplaceableTextures\\CommandButtons\\BTNS507.blp")
call InitAbilityData('S508',1,0,2,6,0,0,2,0,"镜花之舞","攻击|Cff00bfff10%|r概率积累|Cff00bfff1|r层|Cff00bfff妖狐印记|r，达到|Cff00bfff7|r层时向周围释放|Cff00bfff镜花之舞|r。\n每层妖狐印记提高|Cff00bfff6%|r攻击速度，镜花之舞造成|Cff00bfff法强*6|r法术伤害。\n\n|Cff00ff7f概率受天命影响。","ReplaceableTextures\\CommandButtons\\BTNS508.blp")
call InitAbilityData('S509',1,0,0,0,0,0,0,0,"奕剑之道","奕剑之道，在于无招。\n普攻伤害|Cffff8000+20%\n|r\n|Cff00ff7f普攻伤害>120%|r：物理伤害+30%。","ReplaceableTextures\\CommandButtons\\BTNS509.blp")
call InitAbilityData('S510',2,0,0,0,0,0,0,2,"八九玄功","使用后依次|Cff00ff7f变幻形态|r，并获得相应加成：\n金龙形态：暴击|Cffffbf00+10%|r\n白虎形态：攻速|Cffff8000+45%|r\n人形态：冷却|Cff00bfff-10%","ReplaceableTextures\\CommandButtons\\BTNS510.blp")
call InitAbilityData('S511',1,0,0,0,0,0,0,0,"命途多舛","释放|Cff00bfff主动技能|r有|Cff00bfff50%|r几率失败，|Cff00bfff50%|r几率大成功，该伤害提高|Cff00bfff150%|r。","ReplaceableTextures\\CommandButtons\\BTNS511.blp")
call InitAbilityData('S512',2,0,1,6,0,0,1,12,"天王宝塔","掷出天王宝塔镇压目标，造成|Cffff8000攻击*3|r物理伤害并|Cffffbf00眩晕|r2秒。\n\n|Cff00ff7f暴击>30%|r：伤害翻倍。","ReplaceableTextures\\CommandButtons\\BTNS512.blp")
call InitAbilityData('S513',2,0,0,0,0,0,0,12,"身外法身","使用毫毛在目标地点|Cff00bfff幻化一个法身|r，可|Cff00bfff模仿你施放|r的|Cff00bfff主动伤害技能|r，但只造成|Cff00bfff30%伤害|r。\n\n|Cffbbbbbb法身无法攻击，不可选取，不受攻击。","ReplaceableTextures\\CommandButtons\\BTNS513.blp")
call InitAbilityData('S514',2,0,2,4,0,0,2,10,"冰封万里","对自身周围发动一次冰封术，造成|Cff00bfff法强*3|r法术伤害\n\n|Cff00ff7f冷却缩减>30%|r：额外发动一次冰暴，造成|Cff00bfff法强*8|r法术伤害。","ReplaceableTextures\\CommandButtons\\BTNS514.blp")
call InitAbilityData('S515',1,0,2,8,0,0,2,0,"日月珠","每次|Cff00bfff施法|r凝聚|Cff00bfff1|r颗日月珠环绕自身，数量达到|Cff00bfff4|r颗时，向攻击目标造成|Cff00bfff法强*8|r范围伤害。","ReplaceableTextures\\CommandButtons\\BTNS515.blp")
call InitAbilityData('S516',2,0,0,0,0,0,0,30,"悔悟","自裁悔过，所有人回复|Cffffbf0050%|r生命，3秒内提高|Cffffbf0020%|r增伤。\n\n|Cff00ff7f悔过次数>10|r：增加自身当前攻击60%","ReplaceableTextures\\CommandButtons\\BTNS516.blp")
call InitAbilityData('S517',1,0,0,0,0,0,0,0,"天资聪颖","每次学习技能获得|Cff00bfff200~800|r法强。","ReplaceableTextures\\CommandButtons\\BTNS517.blp")
call InitAbilityData('S518',1,0,0,0,0,0,0,0,"九转神功","每次突破境界|Cffffbf0040%|r概率获得额外|Cffffbf0010%|r收益","ReplaceableTextures\\CommandButtons\\BTNS518.blp")
call InitAbilityData('S519',1,0,2,2,0,0,2,0,"天眼神光","|CffFFBF00攻击或施法|r时，|Cffffbf005%|r几率开启天眼发射神光，造成|Cffff8000法强*3|r法术伤害。","ReplaceableTextures\\CommandButtons\\BTNS519.blp")
call InitAbilityData('S520',1,0,0,0,0,0,0,0,"莲花化身","承受技能伤害减少|Cffffd24d40%|r。","ReplaceableTextures\\CommandButtons\\BTNS520.blp")
call InitAbilityData('S521',2,0,0,0,0,0,0,40,"中秋快乐","每次使用获得一个|Cffffd24d随机月饼|r。\n|Cffffd24d蛋黄月饼|r：回复|Cffffd24d80%生命|r，解除异常状态\n|Cff00bfff豆沙月饼|r：回复|Cff00bfff70%蓝量|r\n|Cff00bfff果蔬月饼|r：法术伤害提高|Cff00bfff30%|r\n|Cffff8000鲜肉月饼|r：物理伤害提高|Cffff800030%|r\n|Cffff8000冰皮月饼|r：攻速|Cffff8000+50%|r\n\n|Cff00ff7f状态持续15秒。","ReplaceableTextures\\CommandButtons\\BTNS521.blp")
call InitAbilityData('S522',1,0,0,0,0,0,0,0,"风雷咒术","获得风雷咒术加持，攻击速度提高|Cffff800050%|r。过快的攻击速度导致物理伤害降低50%。","ReplaceableTextures\\CommandButtons\\BTNS522.blp")
call InitAbilityData('S523',6,0,0,0,0,0,0,12,"狐媚术","回复目标|Cffffd24d30%|r生命并解除所有负面效果，|Cffffd24d4|rs内提高|Cffffd24d10%|r攻击和法强。","ReplaceableTextures\\CommandButtons\\BTNS523.blp")
call InitAbilityData('S524',6,0,0,0,0,0,0,180,"道友请留步","劝说目标队友分享属性：\n|Cffffd24d30%|r成功，该队友和你攻击及法强提高|Cffffd24d10%\n40%|r暴力劝说，获得该队友|Cffffd24d30%|r攻击及法强。\n|Cffffd24d30%|r失败，队友获得你|Cffffd24d30%|r攻击及法强\n劝说效果持续3分钟。\n|Cff00ff7f该技能冷却时间固定。|r","ReplaceableTextures\\CommandButtons\\BTNS524.blp")
call InitAbilityData('S525',2,0,1,2,0,0,1,8,"攒心钉","发射|Cffff80003枚|r攒心钉，造成|Cffff8000攻击*1.5|r物理伤害，4s内降低10护甲。\n\n|Cff00ff7f效果不可叠加。","ReplaceableTextures\\CommandButtons\\BTNS525.blp")
call InitAbilityData('S526',1,0,1,1,0,0,1,6,"当头棒击","每6秒攻击对直线范围造成|Cffff8000攻击*4|r物理伤害。","ReplaceableTextures\\CommandButtons\\BTNS526.blp")
call InitAbilityData('S527',9,0,0,0,0,0,0,30,"昏庸无道","处决一名队友，8秒内增加你的攻击力，增加量为该队友攻击的|Cffff800015%|r。\n|Cff00ff7f处决自己获得一半加成。|r\n|Cff00ff7f施法距离全图|r","ReplaceableTextures\\CommandButtons\\BTNS527.blp")
call InitAbilityData('S528',1,0,0,0,0,0,0,0,"尚武乏谋","有什么问题是暴力不能解决的呢？\n物理伤害|Cffff8000+20%|r，法术伤害|Cff00bfff-30%","ReplaceableTextures\\CommandButtons\\BTNS528.blp")
call InitAbilityData('S529',1,0,0,0,0,0,0,15,"神医救世","队友或你死亡时，直接复活。","ReplaceableTextures\\CommandButtons\\BTNS529.blp")
call InitAbilityData('S530',1,0,0,0,0,0,0,0,"百发百中","攻击必定命中。","ReplaceableTextures\\CommandButtons\\BTNS530.blp")
call InitAbilityData('S531',1,0,0,0,0,0,0,0,"料事如神","每次占星增加|Cff00bfff境界等级*300|r法强。","ReplaceableTextures\\CommandButtons\\BTNS531.blp")
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
InitAbilityStringEx('S522',"攻击速度提高70%","攻击速度提高90%","攻击速度提高150%","","")
InitAbilityStringEx('S523',"回复50%生命","攻击和法强效果提高至20%","攻击和法强效果提高至30%","","")
InitAbilityStringEx('S524',"失败劝说移除负面效果。","暴力劝说移除负面效果。","成功时攻击及法强加成提高至30%","","")
InitAbilityStringEx('S525',"攒心钉数量+1","攒心钉数量+1","攒心钉数量+2","","")
InitAbilityStringEx('S526',"冷却时间降低至4秒","冷却时间降低至2秒","当头棒击必定触发暴击","","")
InitAbilityStringEx('S527',"处决目标获得神仙搭救，立即原地复活。","被处决队友8秒内提高20%攻击。","增加量提高至30%","","")
InitAbilityStringEx('S528',"物理伤害+30%","物理伤害+40%","物理伤害+60%","","")
InitAbilityStringEx('S529',"冷却时间降低至18秒","冷却时间降低至16秒","冷却时间降低至12秒","","")
InitAbilityStringEx('S530',"触发致命一击时回复自身3%最大生命值","致命倍率+300%","领悟三重射，可触发攻击特效","","")
InitAbilityStringEx('S531',"增加量提高至境界*400","增加量提高至境界*500","领悟大道，攻击10%概率造成法强*占星次数法术伤害","","")

    endfunction
endscope


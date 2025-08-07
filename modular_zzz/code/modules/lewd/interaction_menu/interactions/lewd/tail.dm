/obj/item/organ/tail
	var/always_accessible = TRUE

/datum/interaction/tail_hug
	name = "Обнять хвостом."
	description = "Обнять кого-то хвостом."
	user_required_parts = list(ORGAN_SLOT_TAIL = REQUIRE_GENITAL_ANY)
	message = list("обнимает хвостом %TARGET%.")
	category = "Tail"
	sound_use = TRUE
	sound_possible = list('sound/items/weapons/thudswoosh.ogg')

/datum/interaction/tail_pet
	name = "Поглаживания хвостом."
	description = "Погладить кого-то хвостом."
	user_required_parts = list(ORGAN_SLOT_TAIL = REQUIRE_GENITAL_ANY)
	message = list("поглаживает хвостом %TARGET%.")
	category = "Tail"
	sound_use = TRUE
	sound_possible = list('sound/items/weapons/thudswoosh.ogg')

/datum/interaction/tail_weave
	name = "Сплестись хвостами."
	description = "Сплестись с чужим хвостом."
	message = list("сплетается с хвостом TARGET.")
	color = "pink"
	user_required_parts = list(ORGAN_SLOT_TAIL = REQUIRE_GENITAL_ANY)
	target_required_parts = list(ORGAN_SLOT_TAIL = REQUIRE_GENITAL_ANY)
	sound_use = TRUE
	interaction_sound = 'sound/weapons/thudswoosh.ogg'

/datum/interaction/selfhugtail
	name = "Обнять свой хвост."
	description = "Демонстрация собственной независимости через хвост."
	simple_message = "обнимает свой хвост."
	usage = INTERACTION_SELF
	user_required_parts = list(ORGAN_SLOT_TAIL = REQUIRE_GENITAL_ANY)
	interaction_sound = 'sound/weapons/thudswoosh.ogg'

/datum/component/interactable/get_interaction_attributes(mob/living/carbon/human/target)
	. = ..()
	if(istype(target) && target.has_tail(REQUIRE_GENITAL_ANY))
		. += "have a tail"
	return .

/datum/interaction/lewd/tail
	user_required_parts = list(ORGAN_SLOT_TAIL = REQUIRE_GENITAL_ANY)
	cum_target = list(CLIMAX_POSITION_TARGET = null)
	sound_use = TRUE
	category = "Tail"
	var/try_milking = FALSE
	var/help_text
	var/grab_text
	var/harm_text

/datum/interaction/lewd/tail/act(mob/living/user, mob/living/target)
	// Дойка
	var/obj/item/reagent_containers/liquid_container
	if(try_milking)
		var/obj/item/cached_item = user.get_active_held_item()
		if(istype(cached_item) && cached_item.is_refillable() && cached_item.is_drainable())
			liquid_container = cached_item
		else
			cached_item = user.pulling
			if(istype(cached_item) && cached_item.is_refillable() && cached_item.is_drainable())
				liquid_container = cached_item

	// Обнуление всех изменённых переменных
	message = null	// используем для сообщения базовую переменную
	target_arousal = 6
	target_pleasure = 4
	target_pain = 0
	user_arousal = 0
	user_pleasure = 4
	user_pain = 0

	// сообщение от интента
	switch(resolve_intent_name(user.combat_mode))
		if("help")
			message = islist(help_text) ? pick(help_text) : help_text
		if("grab", "disarm")
			message = islist(grab_text) ? pick(grab_text) : grab_text
			target_arousal += 3
			target_pleasure += 2
		if("harm")
			target_pain = 5
			message = islist(harm_text) ? pick(harm_text) : harm_text

	if(liquid_container)
		message += " Стараясь ловить исходящие жидкости в [liquid_container]"
		interaction_modifier_flags |= INTERACTION_OVERRIDE_FLUID_TRANSFER
	if(usage == INTERACTION_SELF)
		user_arousal = target_arousal
		user_pleasure = target_pleasure
		user_pain = target_pain

	message = list(message)
	..() // отправка сообщения в родительском проке
	if(liquid_container)
		interaction_modifier_flags &= ~INTERACTION_OVERRIDE_FLUID_TRANSFER

/datum/interaction/lewd/tail/dick
	name = "Хвост. Подрочить член."
	description = "Подрочить чужой член при помощи хвоста."
	target_required_parts = list(ORGAN_SLOT_PENIS = REQUIRE_GENITAL_EXPOSED)
	cum_genital = list(CLIMAX_POSITION_TARGET = CLIMAX_PENIS)
	additional_details = list(INTERACTION_FILLS_CONTAINERS)
	try_milking = TRUE
	sound_possible = list('modular_zzplurt/sound/interactions/bang1.ogg',
						'modular_zzplurt/sound/interactions/bang2.ogg',
						'modular_zzplurt/sound/interactions/bang3.ogg')
	help_text = list(
		"удовлетворяет член %TARGET%, гуляя по нему своим хвостиком.",
		"водит кончиком хвоста вдоль ствола %TARGET%.",
		"двигает хвостом вверх-вниз по члену %TARGET%, стараясь доставить удовольствие."
	)
	grab_text = list(
		"крепко зажимает хвостом член %TARGET%, то и дело проскальзывая по всей его длине.",
		"хищно охватывает хвостом член %TARGET% и двигается по нему, не давая расслабиться.",
		"удерживает член %TARGET% плотным кольцом хвоста, совершая настойчивые поступательные движения."
	)
	harm_text = list(
		"издевательски грубо мучает член %TARGET%, явно не заботясь об ощущениях партнера.",
		"давит и тянет член %TARGET% хвостом, словно наслаждаясь причиняемой болью.",
		"резко сжимает и выкручивает член %TARGET%, действуя без жалости и удерживая с силой."
	)
	cum_message_text_overrides = list(CLIMAX_POSITION_TARGET = list("обдаёт семенем хвост %USER%."))

/datum/interaction/lewd/tail/vagina
	name = "Хвост. Проникнуть в вагину."
	description = "Проникнуть внутрь чужой вагины при помощи хвоста."
	target_required_parts = list(ORGAN_SLOT_VAGINA = REQUIRE_GENITAL_EXPOSED)
	cum_genital = list(CLIMAX_POSITION_TARGET = CLIMAX_VAGINA)
	try_milking = TRUE
	additional_details = list(INTERACTION_FILLS_CONTAINERS)
	help_text = list(
		"нежно проталкивает хвостик внутрь вагины %TARGET%.",
		"лаского движется хвостом вглубь лона, прислушиваясь к реакции %TARGET%.",
		"ритмично вводит хвост в киску %TARGET%, стараясь доставить максимум удовольствия."
	)
	grab_text = list(
		"настойчиво вбивается в вагину %TARGET% хвостом, то и дело поёрзывая из стороны в сторону.",
		"глубоко продвигает хвост в вагину %TARGET%, с усилием раздвигая её стенки.",
		"вдавливает хвост в вагину %TARGET% и начинает двигаться, будто хочет заполнить её полностью."
	)
	harm_text = list(
		"издевательски грубо насилует вагину %TARGET% хвостом, стараясь дотянуться до самых глубин чужого нутра.",
		"с силой вбивает хвост в вагину %TARGET% с безжалостной силой, не давая ей ни секунды покоя.",
		"резко проникает хвостом в вагину %TARGET%, растягивая её и причиняя дискомфорт."
	)
	sound_possible = list('modular_zzplurt/sound/interactions/champ1.ogg',
						'modular_zzplurt/sound/interactions/champ2.ogg')
	cum_message_text_overrides = list(CLIMAX_POSITION_TARGET = list("обдаёт соками хвост %USER%."))

/datum/interaction/lewd/tail/ass
	name = "Хвост. Проникнуть в задницу."
	description = "Проникнуть внутрь чужого зада при помощи хвоста."
	target_required_parts = list(ORGAN_SLOT_ANUS = REQUIRE_GENITAL_EXPOSED)
	help_text = list(
		"скользит внутри зада %TARGET% своим хвостом.",
		"нежно двигает хвостом в анусе %TARGET%, массируя его изнутри.",
		"медленно проникает хвостом в зад %TARGET%, стараясь доставить приятные ощущения."
	)
	grab_text = list(
		"активно вбивается хвостом внутрь ануса %TARGET%, то и дело стараясь утыкаться в чувствительные части.",
		"вдавливает хвост в анальное отверстие %TARGET%, двигаясь уверенно и быстро.",
		"ритмично проталкивает хвост в анус %TARGET%, извиваясь и надавливая изнутри."
	)
	harm_text = list(
		"насилует зад %TARGET% хвостом, словно стараясь прошить насквозь.",
		"с силой проникает хвостом в анальное отверстие %TARGET%, причиняя тому болезненные ощущения.",
		"грубо вбивает хвост в задний проход %TARGET%, действуя с напором и без капли жалости."
	)
	sound_possible = list('modular_zzplurt/sound/interactions/bang1.ogg',
						'modular_zzplurt/sound/interactions/bang2.ogg',
						'modular_zzplurt/sound/interactions/bang3.ogg')
	cum_message_text_overrides = list(CLIMAX_POSITION_TARGET = list("крепко сжимает хвост %USER%."))

/datum/interaction/lewd/tail/urethra
	name = "Хвост. Проникнуть в уретру."
	description = "Проникнуть внутрь чужой уретры при помощи хвоста."
	target_required_parts = list(ORGAN_SLOT_PENIS = REQUIRE_GENITAL_EXPOSED)
	cum_genital = list(CLIMAX_POSITION_TARGET = CLIMAX_PENIS)
	sound_possible = list('modular_zzplurt/sound/interactions/bang1.ogg',
						'modular_zzplurt/sound/interactions/bang2.ogg',
						'modular_zzplurt/sound/interactions/bang3.ogg',
						'modular_zzplurt/sound/interactions/bang4.ogg',
						'modular_zzplurt/sound/interactions/bang5.ogg',
						'modular_zzplurt/sound/interactions/bang6.ogg',)
	help_text = list(
		"проталкивает и изучает уретру %TARGET% своим хвостом.",
		"медленно двигает хвост внутри уретры %TARGET%, ощущая каждую деталь.",
		"ласково толкается хвостом в уретре %TARGET%, стараясь принести удовольствие."
	)
	grab_text = list(
		"старается хвостиком дойти до паха %TARGET% через уретру.",
		"активно продвигает хвост вглубь уретры %TARGET%, словно стремясь дотянуться до самого основания.",
		"вдавливает хвост всё дальше по уретре %TARGET%, упорно пробираясь к паху."
	)
	harm_text = list(
		"использует уретру %TARGET% как игрушку, явно не заботясь о чужих ощущениях.",
		"безжалостно вбивает хвост в уретру %TARGET%, не снижая давления ни на секунду.",
		"грубо насилует уретру %TARGET% хвостом, растягивая её изнутри."
	)
	cum_message_text_overrides = list(CLIMAX_POSITION_TARGET = list("крепко сжимает хвост %USER%, обдавая тот семенем."))


/datum/interaction/lewd/tail/dick/self
	name = "Хвост. Подрочить свой член."
	usage = INTERACTION_SELF
	target_required_parts = list()
	cum_genital = list(CLIMAX_POSITION_USER = CLIMAX_PENIS)
	user_required_parts = list(ORGAN_SLOT_TAIL = REQUIRE_GENITAL_ANY, ORGAN_SLOT_PENIS = REQUIRE_GENITAL_EXPOSED)
	sound_possible = list('modular_zzplurt/sound/interactions/bang1.ogg',
						'modular_zzplurt/sound/interactions/bang2.ogg',
						'modular_zzplurt/sound/interactions/bang3.ogg')
	help_text = list(
		"безуспешно удовлетворяет себя, гуляя по своему члену хвостиком.",
		"нежно скользит хвостом вверх-вниз по своему члену, подстраиваясь под каждое движение.",
		"ритмично ласкает свой член хвостом, стараясь доставить себе удовольствие."
	)
	grab_text = list(
		"крепко зажимает хвостом собственный член, то и дело проскальзывая по всей его длине.",
		"не отпуская сжимает член хвостом, двигаясь по нему с нарастающей силой.",
		"удерживает свой член плотным кольцом хвоста и активно мастурбирует, не сбавляя темпа."
	)
	harm_text = list(
		"явно желая доставить себе болезненные ощущения, особенно активно хвостом надрачивает свой член.",
		"намеренно сжимает член до боли хвостом, маструбируя резкими движениями.",
		"грубо работает хвостом по своему члену, будто стремясь испытать боль и наслаждение одновременно."
	)
	cum_message_text_overrides = list(CLIMAX_POSITION_USER = list("обдаёт семенем собственный хвост."))

/datum/interaction/lewd/tail/vagina/self
	name = "Хвост. Проникнуть в свою вагину."
	usage = INTERACTION_SELF
	target_required_parts = list()
	cum_genital = list(CLIMAX_POSITION_USER = CLIMAX_VAGINA)
	user_required_parts = list(ORGAN_SLOT_TAIL = REQUIRE_GENITAL_ANY, ORGAN_SLOT_VAGINA = REQUIRE_GENITAL_EXPOSED)
	help_text = list(
		"нежно проталкивает хвостик внутрь своего лона.",
		"мягко скользит хвостом в собственной вагине.",
		"ласково играет хвостом внутри своей вагины, двигаясь плавно и осторожно."
	)

	grab_text = list(
		"настойчиво вбивается внутрь своего лона, то и дело поёрзывая из стороны в сторону.",
		"глубоко вводит хвост в себя, активно двигаясь и постанывая.",
		"продавливает свой хвост вглубь вагины, не стесняясь плотных толчков и движений."
	)

	harm_text = list(
		"насилует собственное лоно при помощи хвоста, словно пытаясь вбиться как можно глубже.",
		"с напором вбивает хвост в себя, будто нарочно причиняя себе боль.",
		"грубо раздвигает собственную вагину хвостом, действуя резко и без пощады."
	)
	sound_possible = list('modular_zzplurt/sound/interactions/champ1.ogg',
						'modular_zzplurt/sound/interactions/champ2.ogg')
	cum_message_text_overrides = list(CLIMAX_POSITION_USER = list("обдаёт соками собственный хвост."))

/datum/interaction/lewd/tail/ass/self
	name = "Хвост. Проникнуть в свою задницу."
	usage = INTERACTION_SELF
	target_required_parts = list()
	user_required_parts = list(ORGAN_SLOT_TAIL = REQUIRE_GENITAL_ANY, ORGAN_SLOT_ANUS = REQUIRE_GENITAL_EXPOSED)
	help_text = list(
		"скользит внутри своего кишечника при помощи хвоста.",
		"аккуратно двигает хвостом в собственном анусе, наслаждаясь внутренним давлением.",
		"нежно водит хвостом внутри себя, массируя задний проход."
	)
	grab_text = list(
		"активно вбивается хвостом внутрь собственного ануса.",
		"резко толкает хвост в свое колечко, двигаясь с упорством и силой.",
		"плотно заполняет свой зад хвостом, не прекращая движений."
	)
	harm_text = list(
		"насилует свой зад хвостом, словно стараясь прошить себя насквозь.",
		"безжалостно вгоняет хвост в свой анус, не давая себе ни малейшего отдыха.",
		"с силой продавливает хвост в задний проход, будто стремясь разорвать себя изнутри."
	)
	sound_possible = list('modular_zzplurt/sound/interactions/bang1.ogg',
						'modular_zzplurt/sound/interactions/bang2.ogg',
						'modular_zzplurt/sound/interactions/bang3.ogg')
	cum_message_text_overrides = list(CLIMAX_POSITION_USER = list("крепко сжимает собственный хвост внутри своего зада."))

/datum/interaction/lewd/tail/urethra/self
	name = "Хвост. Проникнуть в свою уретру."
	usage = INTERACTION_SELF
	target_required_parts = list()
	user_required_parts = list(ORGAN_SLOT_TAIL = REQUIRE_GENITAL_ANY, ORGAN_SLOT_PENIS = REQUIRE_GENITAL_EXPOSED)
	sound_possible = list('modular_zzplurt/sound/interactions/bang1.ogg',
						'modular_zzplurt/sound/interactions/bang2.ogg',
						'modular_zzplurt/sound/interactions/bang3.ogg',
						'modular_zzplurt/sound/interactions/bang4.ogg',
						'modular_zzplurt/sound/interactions/bang5.ogg',
						'modular_zzplurt/sound/interactions/bang6.ogg',)
	help_text = list(
		"проталкивает и изучает собственную уретру при помощи хвоста.",
		"осторожно двигает хвостом в своей уретре , чувствуя каждый изгиб и сжатие.",
		"медленно и плавно продвигает хвост вглубь уретры, словно исследуя изнутри."
	)
	grab_text = list(
		"старается хвостиком дойти до своего паха через уретру.",
		"упорно проталкивает хвост вглубь своей уретры, стремясь проникнуть как можно дальше.",
		"с напором двигает хвост по уретре, будто желая коснуться основания своего тела."
	)
	harm_text = list(
		"вбивает хвостик в собственную уретру, с явной грубостью обходясь со своим телом.",
		"резко и безжалостно продавливает хвост внутрь своей уретры, не обращая внимания на боль.",
		"жестко использует свою уретру для проникновения хвоста, причиняя себе резкое, пронизывающее ощущение."
	)
	cum_message_text_overrides = list(CLIMAX_POSITION_USER = list("крепко сжимает собственный хвост уретрой, обдавая тот семенем."))

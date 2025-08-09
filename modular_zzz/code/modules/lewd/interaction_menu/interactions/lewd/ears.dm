/datum/interaction/ears_rub
	name = "Погладить уши."
	description = "Погладить чужие уши."
	interaction_requires = list(INTERACTION_REQUIRE_SELF_HAND)
	category = "Miscellaneous"
	message = list("поглаживает уши %TARGET%.")
	sound_use = TRUE
	sound_possible = list('sound/items/weapons/thudswoosh.ogg')

/datum/interaction/ears_lick
	name = "Полизать ухо."
	description = "Полизать чужие ухо."
	interaction_requires = list(INTERACTION_REQUIRE_SELF_MOUTH)
	category = "Miscellaneous"
	message = list("лижет ухо %TARGET%.")
	sound_use = TRUE
	sound_possible = list('sound/items/weapons/thudswoosh.ogg')

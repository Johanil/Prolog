mammal(X):-				viviparous(X), % give birth to living little ones
	carnivore(X). % meat-eater

viviparous(lion).		
viviparous(tiger).	
	
carnivore(Y):-		
	has_sharp_teeth(Y),
	has_claws(Y).

has_sharp_teeth(lion).		
has_sharp_teeth(tiger).
		
has_claws(tiger).
has_claws(lion).

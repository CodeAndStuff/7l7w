#!/usr/bin/env io

"Holla Muchachos" println

Shotgun := Object clone

Shotgun ammo := 12
Shotgun model := "Remington"

Shotgun addAmmo := method(a, ammo=a+ammo)

Shotgun fire := method(ammo=ammo-1, "Bam" println)

Shotgun addAmmo(12)
Shotgun fire
Shotgun fire

Shotgun println

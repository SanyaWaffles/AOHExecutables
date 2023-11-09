
// Ettin --------------------------------------------------------------------

class Ettin : Actor
{
	Default
	{
		Health 175;
		Radius 25;
		Height 68;
		Mass 175;
		Speed 13;
		Damage 3;
		Painchance 60;
		Monster;
		+FLOORCLIP
		+TELESTOMP
		SeeSound "EttinSight";
		AttackSound "EttinAttack";
		PainSound "EttinPain";
		DeathSound "EttinDeath";
		ActiveSound "EttinActive";
		HowlSound "PuppyBeat";
		Obituary "$OB_ETTIN";
		Tag "$FN_ETTIN";
	}
	States
	{
	Spawn:
		ETTN AA 10 A_Look;
		Loop;
	See:
		ETTN ABCD 5 A_Chase;
		Loop;
	Pain:
		ETTN H 7 A_Pain;
		Goto See;
	Melee:
		ETTN EF 6 A_FaceTarget;
		ETTN G 8 A_CustomMeleeAttack(random[EttinAttack](1,8)*2);
		Goto See;
	Death:
		ETTN IJ 4;
		ETTN K 4 A_Scream;
		ETTN L 4 A_NoBlocking;
		ETTN M 4 A_QueueCorpse;
		ETTN NOP 4;
		ETTN Q -1;
		Stop;
	XDeath:		
		ETTB A 4;
		ETTB B 4 A_NoBlocking;
		ETTB C 4 A_SpawnItemEx("EttinMace", 0,0,8.5, 
								random[DropMace](-128,127) * 0.03125,
								random[DropMace](-128,127) * 0.03125,
								10 + random[DropMace](0,255) * 0.015625, 0, SXF_ABSOLUTEVELOCITY);
		ETTB D 4 A_Scream;
		ETTB E 4 A_QueueCorpse;
		ETTB FGHIJK 4;
		ETTB L -1;
		Stop;
	Ice:
		ETTN R 5 A_FreezeDeath;
		ETTN R 1 A_FreezeDeathChunks;
		Wait;
	}
}

// Ettin mace ---------------------------------------------------------------

class EttinMace : Actor
{
	Default
	{
		Radius 5;
		Height 5;
		+DROPOFF
		+CORPSE
		+NOTELEPORT
		+FLOORCLIP
	}
	States
	{
	Spawn:
		ETTB MNOP 5;
		Loop;
	Crash:
		ETTB Q 5;
		ETTB R 5 A_QueueCorpse;
		ETTB S -1;
		Stop;
	}
}

// Ettin mash ---------------------------------------------------------------

class EttinMash : Ettin
{
	Default
	{
		+NOBLOOD
		+NOICEDEATH
		RenderStyle "Translucent";
		Alpha 0.4;
	}
	States
	{
	Death:
	XDeath:
	Ice:
		Stop;
	}
}




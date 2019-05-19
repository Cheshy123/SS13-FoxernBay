
//Timing subsystem
//Don't run if there is an identical unique timer active
#define TIMER_UNIQUE		0x1
//For unique timers: Replace the old timer rather then not start this one
#define TIMER_OVERRIDE		0x2
//Timing should be based on how timing progresses on clients, not the sever.
//	tracking this is more expensive,
//	should only be used in conjuction with things that have to progress client side, such as animate() or sound()
#define TIMER_CLIENT_TIME	0x4
//Timer can be stopped using deltimer()
#define TIMER_STOPPABLE		0x8
//To be used with TIMER_UNIQUE
//prevents distinguishing identical timers with the wait variable
#define TIMER_NO_HASH_WAIT  0x10

#define TIMER_NO_INVOKE_WARNING 600 //number of byond ticks that are allowed to pass before the timer subsystem thinks it hung on something

//For servers that can't do with any additional lag, set this to none in flightpacks.dm in subsystem/processing.
#define FLIGHTSUIT_PROCESSING_NONE 0
#define FLIGHTSUIT_PROCESSING_FULL 1

#define INITIALIZATION_INSSATOMS 0	//New should not call Initialize
#define INITIALIZATION_INNEW_MAPLOAD 1	//New should call Initialize(TRUE)
#define INITIALIZATION_INNEW_REGULAR 2	//New should call Initialize(FALSE)

#define INITIALIZE_HINT_NORMAL 0    //Nothing happens
#define INITIALIZE_HINT_LATELOAD 1  //Call LateInitialize
#define INITIALIZE_HINT_QDEL 2      //Call qdel on the atom

//type and all subtypes should always call Initialize in New()
#define INITIALIZE_IMMEDIATE(X) ##X/New(loc, ...){\
    ..();\
    if(!initialized) {\
        args[1] = TRUE;\
        SSatoms.InitAtom(src, args);\
    }\
}

// Subsystem init_order, from highest priority to lowest priority
// Subsystems shutdown in the reverse of the order they initialize in
// The numbers just define the ordering, they are meaningless otherwise.

#define SS_INIT_GARBAGE          16
#define SS_INIT_CHEMISTRY        15
#define SS_INIT_MATERIALS        14
#define SS_INIT_PLANTS           13
#define SS_INIT_ANTAGS           12
#define SS_INIT_CULTURE          11
#define SS_INIT_MISC             10
#define SS_INIT_SKYBOX           9
#define SS_INIT_MAPPING          8
#define SS_INIT_JOBS             7
#define SS_INIT_CHAR_SETUP       6
#define SS_INIT_CIRCUIT          5
#define SS_INIT_OPEN_SPACE       4
#define SS_INIT_ATOMS            3
#define SS_INIT_ICON_UPDATE      2
#define SS_INIT_MACHINES         1
#define SS_INIT_DEFAULT          0
#define SS_INIT_AIR             -1
#define SS_INIT_MISC_LATE       -2
#define SS_INIT_ALARM           -3
#define SS_INIT_SHUTTLE         -4
#define SS_INIT_LIGHTING        -5
#define SS_INIT_XENOARCH        -10
#define SS_INIT_BAY_LEGACY      -12
#define SS_INIT_TICKER          -20
#define SS_INIT_UNIT_TESTS      -100


// SS runlevels

#define RUNLEVEL_INIT 0
#define RUNLEVEL_LOBBY 1
#define RUNLEVEL_SETUP 2
#define RUNLEVEL_GAME 4
#define RUNLEVEL_POSTGAME 8

#define RUNLEVELS_DEFAULT (RUNLEVEL_SETUP | RUNLEVEL_GAME | RUNLEVEL_POSTGAME)

// Something to remember when setting priorities: SS_TICKER runs before Normal, which runs before SS_BACKGROUND.
// Each group has its own priority bracket.
// SS_BACKGROUND handles high server load differently than Normal and SS_TICKER do.
// Higher priority also means a larger share of a given tick before sleep checks.

#define SS_PRIORITY_DEFAULT 50          // Default priority for all processes levels

// SS_TICKER
#define SS_PRIORITY_ICON_UPDATE    20	// Queued icon updates. Mostly used by APCs and tables.

// Normal
#define SS_PRIORITY_TICKER         100  // Gameticker.
#define SS_PRIORITY_MOB            95	// Mob Life().
#define SS_PRIORITY_MACHINERY      95	// Machinery + powernet ticks.
#define SS_PRIORITY_AIR            80	// ZAS processing.
#define SS_PRIORITY_CHEMISTRY      60	// Multi-tick chemical reactions.
#define SS_PRIORITY_ALARM          20   // Alarm processing.
#define SS_PRIORITY_EVENT          20   // Event processing and queue handling.
#define SS_PRIORITY_SHUTTLE        20   // Shuttle movement.
#define SS_PRIORITY_CIRCUIT_COMP   20	// Processing circuit component do_work.
#define SS_PRIORITY_TEMPERATURE    20	// Cooling and heating of atoms.
#define SS_PRIORITY_RADIATION      20   // Radiation processing and cache updates.
#define SS_PRIORITY_OPEN_SPACE     20    // Open turf updates.
#define SS_PRIORITY_AIRFLOW        15	// Object movement from ZAS airflow.
#define SS_PRIORITY_VOTE           10   // Vote management.
#define SS_PRIORITY_INACTIVITY     10	// Idle kicking.
#define SS_PRIORITY_SUPPLY         10   // Supply point accumulation.
#define SS_PRIORITY_TRADE          10   // Adds/removes traders.

// SS_BACKGROUND
#define SS_PRIORITY_OBJECTS       100	// processing_objects processing.
#define SS_PRIORITY_PROCESSING    95	// Generic datum processor. Replaces objects processor.
#define SS_PRIORITY_PLANTS        90	// Plant processing, slow ticks.
#define SS_PRIORITY_VINES         50	// Spreading vine effects.
#define SS_PRIORITY_PSYCHICS      45	// Psychic complexus processing.
#define SS_PRIORITY_NANO          40    // Updates to nanoui uis.
#define SS_PRIORITY_TGUI          40    // Updates to tgui uis.
#define SS_PRIORITY_TURF          30    // Radioactive walls/blob.
#define SS_PRIORITY_EVAC          30    // Processes the evac controller.
#define SS_PRIORITY_CIRCUIT       30	// Processing Circuit's ticks and all that.
#define SS_PRIORITY_WIRELESS      30	// Wireless connection setup.
#define SS_PRIORITY_CHAR_SETUP    25    // Writes player preferences to savefiles.
#define SS_PRIORITY_GARBAGE       20	// Garbage collection.


// Subsystem fire priority, from lowest to highest priority
// If the subsystem isn't listed here it's either DEFAULT or PROCESS (if it's a processing subsystem child)


Can't Heal You README
for version 3.12

Healers!  Ever tried to heal or buff someone, only they're out of range 
or out of your line of sight?  And in the middle of a fight, you're
casting too fast and furious to take time to tell them?


What Can't Heal You Does
------------------------

Well, Can't Heal You will help you out by whispering the target of your
spell when that happens to tell them what you're trying to cast on 
them, and why it isn't working, so they can try to move where you 
*can* heal them.  Or at least you can tell them afterwards, "What?  
You didn't see that twenty messages telling you you were out of my
line of sight?"

Beyond that, Can't Heal You can whisper people when you try to buff them
but they have a higher level buff already, when you're sheeped, silenced,
or otherwise prevented from casting (in some cases, it may not know that
you've been prevented from casting until you try to cast a spell), and
when you're interrupted while casting in combat.

To keep from spamming random people you try to buff, it also checks to 
see if the spell's target is in your party, raid, or guild, and only
whispers them if they're in one of those.  

Can't Heal You will work in combination with Healbot, Grid+Clique, etc.
-- since it detects the game events involved with spellcasting, it
should work no matter how you cast the spell.  It also uses Blizzard's 
internal names for events and errors, so even if the interface hasn't
been localized in your language, Can't Heal You will still send messages
at the appropriate times.

It's not just for healers, too -- it works for any buff, so you
mages trying to hand out Arcane Intellect can automatically whisper
people too!

Can't Heal You has a configuration dialog that's merged into Blizzard's
configuration interface -- you can find it in the Addons tab, or you can
go directly go it by using the command "/chy".  There, you can choose
what things you want Can't Heal You to warn others about, change the 
messages that Can't Heal You gives, or even turn off Can't Heal You 
entirely.  Each of your characters has their own configuration.


Warnings and Gotchas
--------------------

Can't Heal You's detection of out of range casts has a problem.  If 
your target is already out of range when you start to cast the spell, 
and the game knows this (that is, when it's showing a red "out of range" 
dot or number on the spell), the game won't even try to cast the spell.  
Since  Can't Heal You works by detecting the message the game sends to the 
server when you cast a spell and getting the target information from it, 
the automatic detection won't work then.  To work around this problem,
you can use the "Manual Warning" method described further down.

A second problem is that players won't get whispered for spells that don't 
directly target them.  For example, Holy Nova won't whisper anyone, since 
it's an AoE, not targeted.  Greater Blessing of Wisdom won't whisper 
people who are the same class as the target, but aren't close enough,
since they're not the actual target.

The detection of interrupted spellcasts also isn't perfect.  Can't Heal
You tries to warn people when you can't heal them for a reason that's 
out of your control... so it tries to tell if your spellcast was 
interrupted because you moved, and not to send warnings in that case.
However, Blizzard doesn't provide a way for an addon to tell whether 
you're moving because you wanted to, or because something knocked you 
back.  Thus, if you're interrupted by a knockback ability, most likely
Can't Heal You won't say anything about that to your target.

Lastly, sometimes WoW sends a message as soon as something happens that
prevents you from casting, and sometimes it doesn't send one until you
try to cast.  Thus, it's possible that if you're silenced or the like, 
Can't Heal You may not say anything until and unless you try to cast a
spell.  On the flip side, the same thing can happen when you recover 
from something that prevents you from casting -- Can't Heal You might not
tell people you can cast again until you successfully cast a spell.


Commands
--------

Can't Heal You has the following command-line commands:

 /chy debug - Turns on debug mode.  This will show you a lot of stuff
              you probably won't care about.  Use the same command to
              turn it back off
              
 /chy reset - Resets all settings for this character to the defaults.
 
 /chy resetall - Resets the settings for the current character and
              the default settings used for new characters to the
              defaults.


Manual warning -- for advanced users
------------------------------------

As noted above, Can't Heal You doesn't see spellcasts if you're 
already out of range when you try to cast the spell.  However,
there is a way to work around this if you're comfortable with
macros, and are willing to use them for casting.  Can't Heal You
has a /chyw command you can use to check range, and automatically
whisper someone if they're out of range.  You'd use it in a 
macro like this:

#showtooltip
/chyw Greater Heal
/cast Greater Heal

/chyw can take all the options /cast can, so if you're doing
fancy things with targets, using modifier keys to cast different
spells, etc., you can just duplicate your /cast line, changing the
/cast part to /chyw.

Have fun!
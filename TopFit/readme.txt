TopFit
======

Author: Mirroar (Thyrfall @ EU-Die Todeskrallen)
Version: 3.3v6
WoW Version: 3.3.5 (TOC 30300)

WoWInterface: http://www.wowinterface.com/downloads/info16177-TopFit.html
Curse:        http://wow.curse.com/downloads/wow-addons/details/topfit.aspx
GitHub:       http://github.com/Mirroar/TopFit

1. Description
--------------
TopFit is a gear management addon designed to select the best gear for you when you just can't be bothered to compare items yourself.
To make intelligent gear choices for you, you will first have to create item scales, telling the Addon which stats are the most important to you. After that, just put all interesting items into you inventory and start the calculation. Voila, you have a fine new equipment set, which you can update with a single click from now on.
TopFit will check an item's stats, gems, enchantments, whether you can dualwield or Titan's Grip and more.
Any caps you're trying to reach can also be set (hit rating cap for damage dealers, defense rating cap for (non-bear-)tanks, etc).

2. Quickstart
-------------

How to level an alt without worrying about equipment:
1. Create a set with fitting values for your character or add one of the predefined sets.
2. In TopFit's Interface Options menu, choose that set under "Automatic Update Set".
3. Have fun playing! Your equipment will automatically be updated whenever you get a new equippable item.

How to create your own sets:
1. Decide on a good scale or get one from WoWHead.com, ElitistJerks.com or a similar site.
2. In WoW, open your Equipment window and click the glowing sword icon in the upper righthand corner.
3. In the calculations frame that you just opened, rename the default set to something fitting for your new set by clicking the big name, or just create a new set by clicking the blue plus sign next to the set dropdown.
4. Set weights for stats you're interested in. To do that, expand the frame by clicking the button labeled ">>", add any stat by clicking "Add Stat...", and click it in the list to set its value.
5. If you need to set a cap, click the check box next to the respective stat value. A new line will appear where you can set your cap value. By clicking the text next to the value, you can decide wether it should be a hard or soft cap.
6. Click "Start".
7. Marvel at your new set. You're done!

3. In-depth: Stat-weights and Caps
----------------------------------
Once upon a time, in a simplified world where you can only equip a single item...

Whenever you calculate a set in TopFit, it will first of all scan all the items in your inventory and thost that are equipped on your character. These items are then given a score depending on the stat weights you set.
Say [Item A] has 10 intellect, 15 hit rating and 5 crit on it, and you gave each of these a weight of 1, but nothing else. [Item A] will then have a score of 30 (10 * 1 + 15 * 1 + 5 * 1).
[Item B], which has 20 strength and 50 hit rating will then have a score of 50 (20 * 0 + 50 * 1). In this case, [Item B] is clearly the best choice (even though you might not really want the strength, it just has so much hit rating, which is too awesome).

In another scenario though, you might only want 10 hit rating. Any more than that is a waste for you, so you set a hard hit rating cap of 10. TopFit will then try to give you at least 10 hit rating, but will ignore any excess on items. The weight you set for hit rating will actually be ignored as long as the cap can be reached.
To be specific, [Item A], now with a score of 15 (10 * 1 + 15 * 0 + 5 * 1) will be considered better than [Item B], which now has a score of 0. Any other item with a score higher than 15 will be considered better than [Item A], as long as it has at least 10 hit rating. If it has less, it will not be considered for calculation.

The matter is entirely different if you set a cap to be a "soft cap", like you might do with defense rating as a tank, for example. This is because you have to hit this defense cap, but any excess defense still benefits you somewhat.
If you set a soft cap of 10 defense, for example, TopFit is still forced to equip at least 10 defense with your items, but will gladly take more if it can.
Comparing [Item C] (10 stamina, 10 defense rating) and [Item D] (8 stamina, 15 defense rating), with both stats valued at 1, will give you [Item D] as the winner, even though it has less stamina. Any item with less than 10 defense will still not fulfull our cap, and is therefore not chosen, no matter how much stamina it has.

These examples are of course extremely simplified, in WoW you can wear more than one item. When TopFit calculates a set with a cap, it has to reach that cap with the sum of all equipped items. Single items might not contribute to caps at all, or only little, but will be chosen based on score instead.


4. Feature Suggestions
----------------------
If you're missing a feature in TopFit, first check the Addon's website and see if it is already mentioned there, please. If not, feel free to drop me a comment or message with your suggestion.

5. What to do if you encounter a bug
------------------------------------
If anything does not work as intended, you'll again want to check TopFit's page and check the description and comments before posting about it. I'll try to get back to you as soon as possible, or maybe another helpful user will be able to provide you with the necessary hints.

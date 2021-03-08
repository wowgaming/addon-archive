# GearScores

<span class="tools-element"><a target="_blank" href="{{ site.github.repository_url }}/edit/master/{{{page.folder}}{{page.url | remove: '.html' | append: ''}}/README.md">Edit</a></span>

![](screen1.png)


## Downloads

[Addon Download Link](https://yehonal.github.io/DownGit/#/home?url=https://github.com/wowgaming/addon-archive/tree/master/GearScore)


### Dependencies (to download)

No dependencies.


## Description


The addon GearScores calculates a comparable score based on customisable stat weights, and displays it on item tooltips. Use it as a tool to choose the best items for your spec/gear.

Gear score does not come with any profiles, and thus you need to create them youself. You can use the interwebs to find the latest stats weights for your class/spec, or specific goal. The idea is that you can create new profiles with ease, and optimise your gear more easily.

### Procs:

Gear score only looks at raw item stats, and compleatly ignores procs.

### Gems:

If the item has a socket, it will calculate and show 3 different scores:

Base score: the raw stats score, ignoring the gem.
Base score + epic gem +200 of main stat (str, int, agi)
Base score + rare gem +150 of the highest secondary stat in the gearscore profile (crit, vers, haste, leach, mastery)
Help

Within the game run any of the following commands to get help using the application.

/gs help
/gs help list
/gs help create
/gs help delete
/gs help set
/gs help show

### Commands overview:

/gs list list all profiles.
/gs create create new profile.
/gs delete delete a profile.
/gs set set the active profile.
/gs show shows the profile and stats.
Creating a profile with /gs create
Creating a profile will automatically set it as the chosen profile.

Syntax:

/gs create <name><space><stats>
Example:

/gs create affliction i:1,m:1.04,h:0.86,c:0.75,v:0.60
Name:

allowed characters: a-z0-9_-/ (no spaces allowed!)

Stats:

Use the starting letter of each stat attribute, (if your class dosent use a stat, just skip it.) and combine it with a value seperated by a colon. Seperate each attribute-value pair with a comma. Avoid using spaces in the stats

Example:

i:1,m:1.04,h:0.86,c:0.75,v:0.60
Supported stats:

[i]nt 
[s]tr 
[a]gi 
[c]rit 
[v]ers 
[h]aste
[l]eech
[m]astery

Show the current profile with /gs show
Shows the current profile with name and stats in an easy readable format. If number is defined it will show the profile matching that number/index

/gs show <?num>
Select a profile to use with /gs set
Sets current profile

syntax:

/gs set <num> 
List profiles with /gs list
List all profiles by name and the number used to select them, the current profile will be highlighted.

/gs list 

Example:

/gs list
prints: 
- 1 null 
- 2 affliction 
- 3 demo
Delete a profile with /gs delete
Delete a profile

Syntax:

/gs delete <num>

Example:

delete the 3rd profile

/gs delete 3

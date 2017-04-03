#!/usr/bin/perl

print "Scanning plugins folder...\n";

open OUTPUT, "> Active.xml";
print OUTPUT qq(<Ui xmlns="http://www.blizzard.com/wow/ui/" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:schemaLocation="http://www.blizzard.com/wow/ui/ ..\\FrameXML\\UI.xsd">\n);

$active = $inactive = $count = 0;
my @embeddedModules;
for $fn (<[aA]uc-*>) {
	if (-d $fn) {
		if (-f "$fn/Embed.xml") {
			@embeddedModules[$active] = $fn;
			$active++;
			print "  + Activating: $fn\n";
		}
		else {
			$invalid++;
			print "  ! Module \"$fn\" is not embeddable\n";
		}
	}
}

print OUTPUT "\t<Script>\n\t\tAucAdvanced.EmbeddedModules = {\n";
while ($count < @embeddedModules) {
	print OUTPUT "\t\t\t\"$embeddedModules[$count]\",\n";
	$count++
}
print OUTPUT "\t\t}";
print OUTPUT "\n\t\t";
print OUTPUT 'AucAdvanced.RegisterRevision("$URL: http://svn.norganna.org/auctioneer/branches/5.8/Auc-Advanced/Modules/rebuild.pl $", "$Rev: 3029 $")';
print OUTPUT "\n\t</Script>\n\n";

$count = 0;
while ($count < @embeddedModules) {
	print OUTPUT "\t<Include file=\"$embeddedModules[$count]\\Embed.xml\"/>\n";
	$count++
}
print OUTPUT "</Ui>";

print "Activated: $active modules.\n";
if ($invalid > 0) {
	print "WARNING: There were $invalid non-embeddable modules detected.\n";
	print "Sometimes Auctioneer modules are not embeddable,\n";
	print "and need to be installed as normal addons.\n";
	print "Embeddable modules will have an Embed.xml file in the folder.\n";
	print "Press <RETURN> to exit...";
	<>;
}
else {
	sleep(2.5);
}


<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0"
                xmlns="http://www.w3.org/1999/xhtml">

<xsl:template match="DataStorePage">
	<!-- use external layout file -->
	<xsl:variable name="Layout" select="@Uses"/>
	<html>
		<head>
			<title>
				<xsl:value-of select="@Title" />
			</title>

			<script src="http://static.wowhead.com/widgets/power.js"></script>
		</head>

		<body>
			<xsl:apply-templates />
		</body>
	</html>
</xsl:template>

<xsl:template match="*">
	<xsl:value-of select="name()" /> : <xsl:value-of select="text()" /><br />
</xsl:template>

<!-- Shared -->
<xsl:template match="Skill">
	<xsl:value-of select="@name" /> : <xsl:value-of select="text()" /><br />
</xsl:template>

<xsl:template match="Item">
	<xsl:choose>
		<xsl:when test="@rarity &lt; 8">
			<a class="q{@rarity}" href="http://www.wowhead.com/?item={@id}"><xsl:value-of select="text()"/></a>
		</xsl:when>
		<xsl:otherwise>
			<a href="http://www.wowhead.com/?item={@id}"><xsl:value-of select="text()"/></a>
		</xsl:otherwise>
	</xsl:choose>
	<xsl:if test="@count &gt; 0">
		&#x20;x<xsl:value-of select="@count" />
	</xsl:if>
	<br />
</xsl:template>


<!-- DataStore Achievements -->
<xsl:template match="Achievement">
	<a href="http://www.wowhead.com/?achievement={@id}">Achievement <xsl:value-of select="@id"/></a>
	Status :
	<xsl:choose>
		<xsl:when test="text() = 'true'">
			Completed on <xsl:value-of select="@completionDate" />
		</xsl:when>
		<xsl:otherwise>
			<xsl:value-of select="text()"/>
		</xsl:otherwise>
	</xsl:choose>	
	<br />
</xsl:template>

<xsl:template match="Achievements">
	<table border="1" cellpadding="0" cellspacing="0">
		<tr>
			<td align="center">
				<b><xsl:value-of select="name()" /></b>
			</td>
		</tr>
		<tr>
			<td>
				<xsl:apply-templates select="Achievement" />
			</td>
		</tr>
	</table>
</xsl:template>

<!-- DataStore Auctions -->
<xsl:template match="Auction">
	<tr>
		<td>
			<a href="http://www.wowhead.com/?item={text()}">Item <xsl:value-of select="text()"/></a>
			Count : <xsl:value-of select="@count"/>,
			<xsl:if test="@highBidder">
				Highest Bidder : <xsl:value-of select="@highBidder"/>,
			</xsl:if>
			<xsl:if test="@ownerName">
				Owner : <xsl:value-of select="@ownerName"/>,
			</xsl:if>
			<xsl:if test="@startPrice">
				Starting Price : <xsl:value-of select="@startPrice"/>,
			</xsl:if>
			<xsl:if test="@bidPrice">
				Bid Price : <xsl:value-of select="@bidPrice"/>,
			</xsl:if>
			Buyout Price : <xsl:value-of select="@buyoutPrice"/>,
			Time Left : <xsl:value-of select="@timeLeft"/>
		</td>
	</tr>
</xsl:template>

<xsl:template match="Auctions|Bids">
	<table border="1" cellpadding="0" cellspacing="0">
		<tr>
			<td align="center">
				<b><xsl:value-of select="name()" /></b>
			</td>
		</tr>
		<xsl:apply-templates />
	</table>
</xsl:template>

<!-- DataStore Containers -->
<xsl:template match="Content">
	<xsl:apply-templates select="Item" />
</xsl:template>

<xsl:template match="Bag|Tab">
	<tr>
		<td>
			<b><xsl:value-of select="name()" /> <xsl:value-of select="@id" /></b><br />
			<xsl:apply-templates />
		</td>
	</tr>
</xsl:template>

<xsl:template match="Containers|Tabs">
	<table border="1" cellpadding="0" cellspacing="0">
		<tr>
			<td align="center">
				<b><xsl:value-of select="name()" /></b>
			</td>
		</tr>
		<xsl:apply-templates />
	</table>
</xsl:template>


<!-- DataStore Crafts -->
<xsl:template match="Crafts/Category/Spell">
	<a href="http://www.wowhead.com/?spell={text()}">Spell <xsl:value-of select="text()"/></a><br />
</xsl:template>

<xsl:template match="Crafts/Category">
	<b><xsl:value-of select="@name" /></b><br />
	<xsl:apply-templates select="Spell" />
</xsl:template>

<xsl:template match="Crafts">
	<b><xsl:value-of select="name()" /></b><br />
	<xsl:apply-templates select="Category" />
</xsl:template>

<xsl:template match="Profession">
	<tr>
		<td align="center">
			<b><xsl:value-of select="@name" /></b>
		</td>
	</tr>
	<tr>
		<td>
			<xsl:apply-templates />
		</td>
	</tr>
</xsl:template>

<xsl:template match="Professions">
	<table border="1" cellpadding="0" cellspacing="0">
		<tr>
			<td align="center">
				<b><xsl:value-of select="name()" /></b>
			</td>
		</tr>
		<xsl:apply-templates select="Profession" />
	</table>
</xsl:template>

<!-- DataStore Currencies -->
<xsl:template match="Currency">
	<tr>
		<td>
			<a href="http://www.wowhead.com/?item={@itemID}"><xsl:value-of select="text()"/></a>
		</td>
		<td>
			<xsl:value-of select="@count"/>
		</td>
	</tr>
</xsl:template>

<xsl:template match="Currencies/Category">
	<tr>
		<td>
			<b><xsl:value-of select="@name" /></b>
		</td>
	</tr>
	<xsl:apply-templates select="Currency" />
</xsl:template>

<xsl:template match="Currencies">
	<table border="1" cellpadding="0" cellspacing="0">
		<tr>
			<td align="center">
				<b><xsl:value-of select="name()" /></b>
			</td>
		</tr>
		<xsl:apply-templates select="Category" />
	</table>
</xsl:template>

<!-- DataStore Inventory -->
<xsl:template match="Inventory">
	<table border="1" cellpadding="0" cellspacing="0">
		<tr>
			<td align="center">
				<b><xsl:value-of select="name()" /></b>
			</td>
		</tr>
		<tr>
			<td>
				<xsl:apply-templates select="Item" />
			</td>
		</tr>
	</table>
</xsl:template>

<!-- DataStore Mails -->
<xsl:template match="Mail">
	<tr>
		<td>
			<xsl:apply-templates />
		</td>
	</tr>

</xsl:template>

<xsl:template match="Mails">
	<table border="1" cellpadding="0" cellspacing="0">
		<tr>
			<td align="center">
				<b><xsl:value-of select="name()" /></b>
			</td>
		</tr>
		<xsl:apply-templates select="Mail" />
	</table>
</xsl:template>

<!-- DataStore Pets -->
<xsl:template match="Mounts/Spell | Companions/Spell">
	<a href="http://www.wowhead.com/?spell={text()}"><xsl:value-of select="@name"/></a><br />
</xsl:template>

<xsl:template match="Mounts|Companions">
	<table border="1" cellpadding="0" cellspacing="0">
		<tr>
			<td align="center">
				<b><xsl:value-of select="name()" /></b>
			</td>
		</tr>
		<tr>
			<td>
				<xsl:apply-templates select="Spell" />
			</td>
		</tr>
	</table>
</xsl:template>

<!-- DataStore Quests -->
<!-- Note: for purely practical reasons, the history is not processed at this time (way too long pages, for too little use in this context) -->
<xsl:template match="Quest">
	<xsl:choose>
		<xsl:when test="@isHeader = 'true'">
			<xsl:value-of select="text()" />
		</xsl:when>
		<xsl:otherwise>
			<a href="http://www.wowhead.com/?quest={@id}"><xsl:value-of select="text()"/></a>
		</xsl:otherwise>
	</xsl:choose>	
	<br />
</xsl:template>

<xsl:template match="QuestLog">
	<table border="1" cellpadding="0" cellspacing="0">
		<tr>
			<td align="center">
				<b>Quest Log</b>
			</td>
		</tr>
		<tr>
			<td>
				<xsl:apply-templates select="Quest" />
			</td>
		</tr>
	</table>
</xsl:template>

<!-- DataStore Reputations -->
<xsl:template match="Faction">
	<xsl:value-of select="text()" /> : <xsl:value-of select="@rank" /> (<xsl:value-of select="@numPoints" />/<xsl:value-of select="@maxPoints" />)
	
	<br />
</xsl:template>

<xsl:template match="Factions">
	<table border="1" cellpadding="0" cellspacing="0">
		<tr>
			<td align="center">
				<b>Factions</b>
			</td>
		</tr>
		<tr>
			<td>
				<xsl:apply-templates select="Faction" />
			</td>
		</tr>
	</table>
</xsl:template>

<!-- DataStore Skills -->
<xsl:template match="Skills/Category">
	<td valign="top">
		<b><xsl:value-of select="@name" /></b>
		<br />
		<xsl:apply-templates select="Skill" />
	</td>
</xsl:template>

<xsl:template match="Skills">
	<table border="1" cellpadding="0" cellspacing="0">
		<tr>
			<td align="center" colspan="6">
				<b>Skills</b>
			</td>
		</tr>
		<tr>
			<xsl:apply-templates select="Category" />
		</tr>
	</table>
</xsl:template>

<!-- DataStore Spells -->
<xsl:template match="School/Spell">
	<a href="http://www.wowhead.com/?spell={text()}">Spell <xsl:value-of select="text()"/></a>&#x20;<xsl:value-of select="@rank"/>
	<br />
</xsl:template>

<xsl:template match="School">
	<td valign="top">
		<b><xsl:value-of select="@name" /></b>
		<br />
		<xsl:apply-templates select="Spell" />
	</td>
</xsl:template>

<xsl:template match="Spells">
	<table border="1" cellpadding="0" cellspacing="0">
		<tr>
			<td align="center" colspan="4">
				<b>Spellbook</b>
			</td>
		</tr>
		<tr>
			<xsl:apply-templates select="School" />
		</tr>
	</table>
</xsl:template>

<!-- DataStore Stats -->
<xsl:template match="Stats/Spell">
	<xsl:value-of select="name()" /> : <xsl:value-of select="text()" />
	<br />
</xsl:template>

<xsl:template match="Stats">
	<b><xsl:value-of select="name()" /> :</b><br />
	<xsl:apply-templates />
</xsl:template>

<!-- DataStore Talents -->
<xsl:template match="Glyph">
	<a href="http://www.wowhead.com/?spell={@spellID}">Glyph <xsl:value-of select="text()"/></a>&#x20;
	Spec: <xsl:value-of select="@spec"/>, Slot: <xsl:value-of select="@slot"/>, Type: <xsl:value-of select="@glyphType"/>
	<br />
</xsl:template>

<xsl:template match="Glyphs">
	<table border="1" cellpadding="0" cellspacing="0">
		<tr>
			<td align="center">
				<b><xsl:value-of select="name()" /></b>
			</td>
		</tr>
		<tr>
			<td>
				<xsl:apply-templates select="Glyph" />
			</td>
		</tr>
	</table>
</xsl:template>

<xsl:template match="Talent">
	[<xsl:value-of select="text()" />] : <xsl:value-of select="@pointsSpent"/>/<xsl:value-of select="@maximumRank"/><br />
</xsl:template>

<xsl:template match="TalentTree">
	<td valign="top">
		<b><xsl:value-of select="@name" /> (<xsl:value-of select="@spec" />)</b>
		<br />
		<xsl:apply-templates select="Talent" />
	</td>
</xsl:template>

<xsl:template match="TalentTrees">
	<table border="1" cellpadding="0" cellspacing="0">
		<tr>
			<td align="center" colspan="6">Talent Trees</td>
		</tr>
		<tr>
			<xsl:apply-templates select="TalentTree" />
		</tr>
	</table>
</xsl:template>

<!-- Global-->
<xsl:template match="Character | Guild">
	<div class="{name()}">
		<xsl:value-of select="@account" /> / <xsl:value-of select="@realm" /> / <xsl:value-of select="@name" />
		<br />
		<xsl:apply-templates />
	</div>
	<br />
</xsl:template>

<xsl:template match="Characters | Guilds">
	<b><xsl:value-of select="name()" /></b>
	<br />
	<xsl:apply-templates />
</xsl:template>

</xsl:stylesheet>
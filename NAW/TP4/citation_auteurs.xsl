<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="3.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<xsl:output method="xml" version="1.0" encoding="UTF-8" indent="yes"/>
	<xsl:template match="auteurs">
		<citations_auteurs>
			<xsl:apply-templates select="auteur"/>
		</citations_auteurs>
	</xsl:template>
	<xsl:template match="auteur">
		<xsl:variable name="n">
			<xsl:value-of select="@nom"/>
		</xsl:variable>
		<auteur>
			<xsl:attribute name="nom"><xsl:value-of select="$n"></xsl:value-of></xsl:attribute>
			<xsl:for-each select="document('citations.xml')//citation[auteur=$n]/texte">
				<texte>
					<xsl:value-of select="."></xsl:value-of>
				</texte>
			</xsl:for-each>
		</auteur>
	</xsl:template>
</xsl:stylesheet>

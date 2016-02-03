<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="3.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<xsl:output method="html" encoding="UTF-8" indent="yes"/>
	<xsl:template match="noeuds">
	<html>
		<head>
			<title></title>
		</head>
		<body>
			<xsl:apply-templates select="noeud"></xsl:apply-templates>
		</body>
	</html>
	</xsl:template>
	
	<xsl:template match="noeud">
		<p>
			<xsl:attribute name="id">param<xsl:value-of select="@numero"></xsl:value-of></xsl:attribute>
			
			<xsl:value-of select="./texte"></xsl:value-of>
		</p>
		<xsl:apply-templates select="aiguillage/voie"/>
	</xsl:template>

	<xsl:template match="voie">
			<a>
				<xsl:attribute name="href">#param<xsl:value-of select="./cible"></xsl:value-of></xsl:attribute>
				<xsl:value-of select="./condition"></xsl:value-of>
			</a>
	</xsl:template>
</xsl:stylesheet>

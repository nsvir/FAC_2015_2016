<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="3.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:fn="http://www.w3.org/2005/xpath-functions">
	<xsl:output method="html" encoding="UTF-8" indent="yes"/>
	<xsl:template match="questionnaires">
		<html>
			<head>
				<title/>
			</head>
			<body>
			<script src="questionnaire.js"></script>
				<xsl:apply-templates select="questionnaire"/>
				Total: <input type="text" size="2" name="total" value="0"/>
			</body>
		</html>
	</xsl:template>
	<xsl:template match="questionnaire">
		<p>
			<xsl:value-of select="./titre"/>
		</p>
		<xsl:apply-templates select="question"/>
	</xsl:template>
	
	<xsl:template match="question">
		<p>
			<xsl:value-of select="enonce"/>
		</p>
		<xsl:for-each select="./reponse">
			<input type="checkbox" onchange="checkTotal()" name="choice">
			<xsl:attribute name="score"><xsl:value-of select="@score"/></xsl:attribute>
			<xsl:value-of select="."/>
			</input>
			<br/>
		</xsl:for-each>
	</xsl:template>
</xsl:stylesheet>

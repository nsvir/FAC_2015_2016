<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="3.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:fn="http://www.w3.org/2005/xpath-functions">
	<xsl:output method="html" encoding="UTF-8" indent="yes"/>
	<xsl:template match="imdb250">
		<html>
			<head>
				<title/>
			</head>
			<body>
				<table>
					<tbody>
						<xsl:for-each select="./film">
							<xsl:sort select="replace(votants,' ','')" order="descending" data-type="number"/>
							<tr>
								<th>
									<xsl:value-of select="titre"/>
								</th>
								<th>
									<xsl:value-of select="annee"/>
								</th>
								<th>
									<xsl:value-of select="note"/>
								</th>
								<th>
									<xsl:value-of select="votants"/>
								</th>
							</tr>
						</xsl:for-each>
					</tbody>
				</table>
			</body>
		</html>
	</xsl:template>
</xsl:stylesheet>
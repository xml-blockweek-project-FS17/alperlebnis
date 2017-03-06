<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
    <xsl:output method="html" version="4.01" indent="yes"/>
    <xsl:output doctype-system="http://www.w3.org/TR/html4/strict.dtd"/>
    <xsl:output doctype-public="-//W3C//DTD HTML 4.01//EN"/>

	<xsl:template match="/">
		<div>
			<h2> Bitte melden Sie sich an um in den Admin Bereich zu gelangen </h2>
			User name: <input type="text" id="username" ></input>
			<br></br><br></br>
			Passwort: <input type="text" id="password"></input>
			<br></br><br></br>
			<button type="button" id="navLink1" href="#" onclick="login();">Log in</button>
		</div>
    </xsl:template>

</xsl:stylesheet>
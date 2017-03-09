<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:svg="http://www.w3.org/2000/svg"
                        xmlns:php="http://php.net/xsl"
                xmlns="http://www.w3.org/1999/xhtml"
                >
 
  <xsl:import href="navigation.xsl"/>
 
  <xsl:output method="xml" doctype-public="-//W3C//DTD XHTML 1.0 Strict//EN"
              doctype-system="http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd" indent="yes"/>

	<xsl:template match="/">
		
		<html lang="de">
            <xsl:call-template name="meta">
                <xsl:with-param name="pageName">Login</xsl:with-param>
            </xsl:call-template>
            <body>
                <xsl:call-template name="header">
                    <xsl:with-param name="pageName">Login</xsl:with-param>
                </xsl:call-template>
                <div>
					<h2> Bitte melden Sie sich an um in den Admin Bereich zu gelangen </h2>
					User name: <input type="text" id="username" ></input>
					<br></br><br></br>
					Passwort: <input type="text" id="password"></input>
					<br></br><br></br>
					<button type="button" id="navLink1" href="#" onclick="login();">Log in</button>
                                        <form action="FO/print-activities.php" method="get">
                                            <input type="submit" value="Generate Activities"/>
                                        </form>
				</div>
	            <xsl:call-template name="footer"/>
            </body>
        </html>
		
		
    </xsl:template>

</xsl:stylesheet>
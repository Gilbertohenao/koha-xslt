<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:marc="http://www.loc.gov/MARC21/slim"
  exclude-result-prefixes="marc">

  <xsl:output method="html" encoding="UTF-8" omit-xml-declaration="yes"/>

  <xsl:template match="/">
    <xsl:apply-templates select="//marc:record"/>
  </xsl:template>

  <xsl:template match="marc:record">
    <xsl:variable name="id" select="marc:controlfield[@tag='001']"/>

    <article class="authority-detail">
      <header>
        <h1>
          <xsl:apply-templates select="marc:datafield[@tag='100' or @tag='110' or @tag='111']"/>
        </h1>
        <div class="meta">
          <strong>AuthID:</strong> <xsl:value-of select="$id"/>
        </div>
      </header>

      <!-- Identificadores -->
      <section>
        <h2>Identificadores</h2>
        <ul>
          <xsl:for-each select="marc:datafield[@tag='024']">
            <li>
              <xsl:value-of select="concat(marc:subfield[@code='2'],': ', marc:subfield[@code='a'])"/>
            </li>
          </xsl:for-each>
        </ul>
      </section>

      <!-- Variantes 4XX -->
      <xsl:if test="marc:datafield[starts-with(@tag,'4')]">
        <section>
          <h2>Formas variantes</h2>
          <ul>
            <xsl:for-each select="marc:datafield[starts-with(@tag,'4')]">
              <li><xsl:apply-templates select="." mode="label"/></li>
            </xsl:for-each>
          </ul>
        </section>
      </xsl:if>

      <!-- Relaciones 5XX -->
      <xsl:if test="marc:datafield[starts-with(@tag,'5')]">
        <section>
          <h2>Relaciones</h2>
          <ul>
            <xsl:for-each select="marc:datafield[starts-with(@tag,'5')]">
              <li><xsl:apply-templates select="." mode="label"/></li>
            </xsl:for-each>
          </ul>
        </section>
      </xsl:if>

      <!-- Fuentes consultadas 670 -->
      <xsl:if test="marc:datafield[@tag='670']">
        <section>
          <h2>Fuentes consultadas</h2>
          <ul>
            <xsl:for-each select="marc:datafield[@tag='670']">
              <li><xsl:apply-templates select="." mode="label"/></li>
            </xsl:for-each>
          </ul>
        </section>
      </xsl:if>
    </article>
  </xsl:template>

  <xsl:template match="marc:datafield" mode="label">
    <xsl:for-each select="marc:subfield">
      <xsl:if test="position() &gt; 1"><xsl:text> </xsl:text></xsl:if>
      <xsl:value-of select="."/>
    </xsl:for-each>
  </xsl:template>

  <xsl:template match="marc:datafield[@tag='100' or @tag='110' or @tag='111']">
    <xsl:for-each select="marc:subfield[@code='a' or @code='b' or @code='c' or @code='d']">
      <xsl:if test="position() &gt; 1"><xsl:text> </xsl:text></xsl:if>
      <xsl:value-of select="."/>
    </xsl:for-each>
  </xsl:template>
</xsl:stylesheet>

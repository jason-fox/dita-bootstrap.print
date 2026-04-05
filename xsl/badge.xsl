<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:fo="http://www.w3.org/1999/XSL/Format"
                version="2.0">

  <!-- Badge Support -->
  <xsl:template match="*[contains(@class, ' bootstrap-d/badge ') or (contains(@class,' topic/ph ') and contains(@outputclass, 'badge'))]" priority="100">
    <fo:inline>
      <xsl:call-template name="commonattributes"/>
      
      <!-- Specialized Bootstrap Styling -->
      <xsl:variable name="theme" select="(@color, 'primary')[1]"/>
      
      <!-- 1. Background & Text Colors -->
      <xsl:call-template name="processBootstrapAttrSetReflection">
        <xsl:with-param name="attrSet" select="concat('__bg__', $theme)"/>
      </xsl:call-template>
      <xsl:call-template name="processBootstrapAttrSetReflection">
        <xsl:with-param name="attrSet" select="concat('__color__', if ($theme = 'warning' or $theme = 'light') then 'dark' else 'white')"/>
      </xsl:call-template>
      
      <!-- 2. Padding -->
      <xsl:choose>
        <xsl:when test="@padding">
          <xsl:call-template name="processBootstrapSpacing">
            <xsl:with-param name="attrValue" select="@padding"/>
            <xsl:with-param name="prefix" select="'p'"/>
          </xsl:call-template>
        </xsl:when>
        <xsl:otherwise>
          <xsl:attribute name="padding">1pt 3pt</xsl:attribute>
        </xsl:otherwise>
      </xsl:choose>

      <!-- 3. Rounding (Default to '1' (3pt) for a tighter, badge-like look) -->
      <xsl:call-template name="processBootstrapRounded">
        <xsl:with-param name="attrValue" select="(@rounded, '1')[1]"/>
      </xsl:call-template>

      <!-- Ensure font-weight is bold (typical for badges) but size inherits from parent -->
      <xsl:attribute name="font-weight">bold</xsl:attribute>
      <xsl:attribute name="vertical-align">baseline</xsl:attribute>

      <!-- 4. Spacing utility support (Attributes MUST be set before children) -->
      <xsl:call-template name="processBootstrapSpacing">
        <xsl:with-param name="attrValue" select="@margin"/>
        <xsl:with-param name="prefix" select="'m'"/>
      </xsl:call-template>
      <xsl:call-template name="processBootstrapOutputClass">
        <xsl:with-param name="attrValue" select="@outputclass"/>
      </xsl:call-template>

      <!-- 5. Content -->
      <xsl:apply-templates/>

    </fo:inline>
  </xsl:template>

</xsl:stylesheet>

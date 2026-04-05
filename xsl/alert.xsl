<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:fo="http://www.w3.org/1999/XSL/Format"
                xmlns:fox="http://xmlgraphics.apache.org/fop/extensions"
                version="2.0">

  <!-- Alert Support -->
  <xsl:template match="*[contains(@class, ' bootstrap-d/alert ')]" priority="5">
    <fo:block xsl:use-attribute-sets="section">
      <xsl:call-template name="commonattributes"/>
      
      <xsl:variable name="theme" select="(@color, 'secondary')[1]"/>
      
      <!-- 1. Background (Subtle variant includes high-contrast text color) -->
      <xsl:call-template name="processBootstrapAttrSetReflection">
        <xsl:with-param name="attrSet" select="concat('__bg__', $theme, '-subtle')"/>
      </xsl:call-template>

      <!-- 3. Border Color (Main theme color) -->
      <xsl:call-template name="processBootstrapBorderColor">
        <xsl:with-param name="attrValue" select="$theme"/>
      </xsl:call-template>
      
      <!-- 4. Default Visibility & Rounding -->
      <xsl:attribute name="border-style">solid</xsl:attribute>
      <xsl:attribute name="border-width">1pt</xsl:attribute>
      <xsl:call-template name="processBootstrapRounded">
        <xsl:with-param name="attrValue" select="(@rounded, 'yes')[1]"/>
      </xsl:call-template>

      <!-- 5. Default Padding -->
      <xsl:call-template name="processBootstrapSpacing">
        <xsl:with-param name="attrValue" select="(@padding, '3')[1]"/>
        <xsl:with-param name="prefix" select="'p'"/>
      </xsl:call-template>

      <!-- Overrides from specialization attributes -->
      <xsl:if test="@margin">
        <xsl:call-template name="processBootstrapSpacing">
          <xsl:with-param name="attrValue" select="@margin"/>
          <xsl:with-param name="prefix" select="'m'"/>
        </xsl:call-template>
      </xsl:if>
      
      <!-- Handle explicit overrides (if user wants a DIFFERENT border or width) -->
      <xsl:if test="@border">
        <xsl:call-template name="processBootstrapBorder">
          <xsl:with-param name="attrValue" select="@border"/>
        </xsl:call-template>
      </xsl:if>
      <xsl:if test="@width">
        <xsl:call-template name="processBootstrapWidth">
          <xsl:with-param name="attrValue" select="@width"/>
        </xsl:call-template>
      </xsl:if>
      
      <!-- Ensure the alert stays on one page as requested -->
      <xsl:attribute name="keep-together.within-page">always</xsl:attribute>
      
      <!-- Legacy outputclass support -->
      <xsl:call-template name="processBootstrapOutputClass">
        <xsl:with-param name="attrValue" select="@outputclass"/>
      </xsl:call-template>

      <!-- Default margin logic -->
      <xsl:if test="not(@margin)">
        <xsl:attribute name="margin-bottom">10pt</xsl:attribute>
      </xsl:if>

      <xsl:apply-templates/>
    </fo:block>
  </xsl:template>

</xsl:stylesheet>

<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:fo="http://www.w3.org/1999/XSL/Format"
  xmlns:fox="http://xmlgraphics.apache.org/fop/extensions"
  xmlns:opentopic-func="http://www.idiominc.com/opentopic/exsl/function"
  exclude-result-prefixes="opentopic-func fox"
  version="2.0"
>

  <!-- Button Toolbar Support (Single Row Block) -->
  <xsl:template match="*[contains(@class, ' bootstrap-d/button-toolbar ')]" priority="5">
    <fo:block margin-top="6pt" margin-bottom="6pt" wrap-option="no-wrap" keep-together.within-line="always">
      <xsl:call-template name="commonattributes"/>
      <xsl:apply-templates mode="toolbar-child"/>
    </fo:block>
  </xsl:template>

  <!-- Skip group containers in toolbars, just process buttons -->
  <xsl:template match="*[contains(@class, ' bootstrap-d/button-group ')]" mode="toolbar-child">
    <xsl:apply-templates mode="toolbar-child"/>
  </xsl:template>

  <!-- Process buttons directly in toolbar -->
  <xsl:template match="*[contains(@class, ' bootstrap-d/button ')]" mode="toolbar-child">
    <xsl:apply-templates select="."/>
  </xsl:template>

  <xsl:template match="text()" mode="toolbar-child"/>

  <!-- Button Group Support (Standard) -->
  <xsl:template match="*[contains(@class, ' bootstrap-d/button-group ')]" priority="5">
    <xsl:variable name="is-vertical" select="@vertical = 'yes'"/>
    <xsl:choose>
        <xsl:when test="$is-vertical">
          <!-- Width calculation based on string length -->
          <xsl:variable name="max-chars">
             <xsl:variable
            name="lengths"
            select="for $b in *[contains(@class, ' bootstrap-d/button ')] return string-length(normalize-space($b))"
          />
             <xsl:value-of select="if (empty($lengths)) then 0 else max($lengths)"/>
          </xsl:variable>
          
          <xsl:variable name="has-icon" select="boolean(descendant::*[contains(@class, ' bootstrap-d/icon ')])"/>
          <!-- 0.1em per char + 1em for icon + 0.5em for minimum margin -->
          <xsl:variable name="width-em" select="($max-chars * 0.1) + (if ($has-icon) then 1.5 else 0) + 0.5"/>

          <fo:block margin-top="6pt" margin-bottom="6pt">
             <xsl:call-template name="commonattributes"/>
             <fo:inline-container width="{$width-em}em" vertical-align="middle">
                <fo:table table-layout="fixed" width="{$width-em}em">
                   <fo:table-column column-width="{$width-em}em"/>
                   <fo:table-body>
                      <xsl:apply-templates mode="vertical-button-group"/>
                   </fo:table-body>
                </fo:table>
             </fo:inline-container>
          </fo:block>
        </xsl:when>
       <xsl:otherwise>
          <fo:inline>
             <xsl:call-template name="commonattributes"/>
             <xsl:apply-templates/>
          </fo:inline>
       </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

  <!-- Special processing for buttons in vertical groups -->
  <xsl:template match="*[contains(@class, ' bootstrap-d/button ')]" mode="vertical-button-group">
     <fo:table-row>
        <fo:table-cell>
           <fo:block>
              <xsl:apply-templates select="."/>
           </fo:block>
        </fo:table-cell>
     </fo:table-row>
  </xsl:template>

  <!-- Button Support -->
  <xsl:template match="*[contains(@class, ' bootstrap-d/button ')]" priority="5">
    <xsl:variable
      name="is-vertical"
      select="ancestor::*[contains(@class, ' bootstrap-d/button-group ')][1]/@vertical = 'yes'"
    />
    <xsl:variable name="element" select="if ($is-vertical) then 'fo:block' else 'fo:inline'"/>

    <fo:basic-link xsl:use-attribute-sets="xref">
      <!-- Link Destination -->
      <xsl:choose>
        <xsl:when test="(@scope = 'external') or not(empty(@format) or @format = 'dita')">
          <xsl:attribute name="external-destination">url('<xsl:value-of select="@href"/>')</xsl:attribute>
        </xsl:when>
        <xsl:when test="@href">
          <xsl:attribute name="internal-destination">
             <xsl:value-of select="opentopic-func:getDestinationId(@href)"/>
          </xsl:attribute>
        </xsl:when>
      </xsl:choose>

      <xsl:element name="{$element}">
        <xsl:call-template name="commonattributes"/>
        
        <!-- Specialized Bootstrap Styling -->
        <xsl:variable name="theme" select="(@color, 'primary')[1]"/>
        <xsl:variable name="size" select="(@size, 'default')[1]"/>
        
        <!-- 1. Background & Text Colors -->
        <xsl:choose>
          <xsl:when test="@outline = 'yes'">
            <xsl:call-template name="processBootstrapAttrSetReflection">
              <xsl:with-param name="attrSet" select="concat('__color__', $theme)"/>
            </xsl:call-template>
          </xsl:when>
          <xsl:otherwise>
            <xsl:call-template name="processBootstrapAttrSetReflection">
              <xsl:with-param name="attrSet" select="concat('__btn__', $theme)"/>
            </xsl:call-template>
          </xsl:otherwise>
        </xsl:choose>
        
        <!-- 2. Borders -->
        <xsl:attribute name="border-style">solid</xsl:attribute>
        <xsl:attribute name="border-width">
           <xsl:choose>
             <!-- Outline buttons require a border to be visible; enforce 1pt if theme globally suppresses borders -->
             <xsl:when
              test="@outline = 'yes' and normalize-space($bootstrap-border-width) = ('0', '0pt', '0px', 'none', '')"
            >1pt</xsl:when>
             <xsl:otherwise><xsl:value-of select="$bootstrap-border-width"/></xsl:otherwise>
           </xsl:choose>
        </xsl:attribute>
        <xsl:call-template name="processBootstrapBorderColor">
          <xsl:with-param name="attrValue" select="$theme"/>
        </xsl:call-template>
        <xsl:if test="@bordercolor">
          <xsl:call-template name="processBootstrapBorderColor">
            <xsl:with-param name="attrValue" select="@bordercolor"/>
          </xsl:call-template>
        </xsl:if>
        
        <!-- 3. Size-dependent Padding & Font Size -->
        <xsl:choose>
          <xsl:when test="$size = 'small'">
            <xsl:attribute name="font-size">9pt</xsl:attribute>
            <xsl:attribute name="padding">1.5pt 4pt</xsl:attribute>
          </xsl:when>
          <xsl:when test="$size = 'large'">
            <xsl:attribute name="font-size">14pt</xsl:attribute>
            <xsl:attribute name="padding">6pt 12pt</xsl:attribute>
          </xsl:when>
          <xsl:otherwise>
            <xsl:attribute name="font-size">11pt</xsl:attribute>
            <xsl:choose>
               <xsl:when test="contains(@outputclass, 'btn-floating')">
                  <xsl:attribute name="padding">6pt</xsl:attribute>
               </xsl:when>
               <xsl:otherwise>
                  <xsl:attribute name="padding">3pt 8pt</xsl:attribute>
               </xsl:otherwise>
            </xsl:choose>
          </xsl:otherwise>
        </xsl:choose>

        <!-- Override padding if specified -->
        <xsl:if test="@padding">
          <xsl:call-template name="processBootstrapSpacing">
            <xsl:with-param name="attrValue" select="@padding"/>
            <xsl:with-param name="prefix" select="'p'"/>
          </xsl:call-template>
        </xsl:if>
        
        <!-- 4. Rounding (Default to '2' (4pt) instead of 'yes' (6pt)) -->
        <xsl:call-template name="processBootstrapRounded">
          <xsl:with-param name="attrValue" select="(@rounded, if ($size = 'small') then '1' else '2')[1]"/>
        </xsl:call-template>
        
        <!-- Legacy / Spacing utility support (MOVED UP) -->
        <xsl:call-template name="processBootstrapSpacing">
          <xsl:with-param name="attrValue" select="@margin"/>
          <xsl:with-param name="prefix" select="'m'"/>
        </xsl:call-template>

        <!-- 6. Button Group Position Awareness -->
        <xsl:variable name="group" select="ancestor::*[contains(@class, ' bootstrap-d/button-group ')][1]"/>
        <xsl:if test="$group">
          <xsl:variable name="is-first" select="not(preceding-sibling::*[contains(@class, ' bootstrap-d/button ')])"/>
          <xsl:variable name="is-last" select="not(following-sibling::*[contains(@class, ' bootstrap-d/button ')])"/>
          <xsl:variable name="is-vertical" select="$group/@vertical = 'yes'"/>
          <xsl:choose>
            <!-- Single item: Keep all rounding, zero margins -->
            <xsl:when test="$is-first and $is-last">
              <xsl:attribute name="margin">0pt</xsl:attribute>
            </xsl:when>
            <!-- Vertical Orientation -->
            <xsl:when test="$is-vertical">
              <xsl:attribute name="width">100%</xsl:attribute>
              <xsl:attribute name="text-align">center</xsl:attribute>
              <xsl:choose>
                <xsl:when test="not($is-first) and not($is-last)">
                  <xsl:attribute name="fox:border-radius">0</xsl:attribute>
                  <xsl:attribute name="margin-top">-1pt</xsl:attribute>
                  <xsl:attribute name="margin-bottom">-1pt</xsl:attribute>
                </xsl:when>
                <xsl:when test="$is-first">
                  <xsl:attribute name="fox:border-after-start-radius">0</xsl:attribute>
                  <xsl:attribute name="fox:border-after-end-radius">0</xsl:attribute>
                  <xsl:attribute name="margin-top">0pt</xsl:attribute>
                  <xsl:attribute name="margin-bottom">-1pt</xsl:attribute>
                </xsl:when>
                <xsl:when test="$is-last">
                  <xsl:attribute name="fox:border-before-start-radius">0</xsl:attribute>
                  <xsl:attribute name="fox:border-before-end-radius">0</xsl:attribute>
                  <xsl:attribute name="margin-top">-1pt</xsl:attribute>
                  <xsl:attribute name="margin-bottom">0pt</xsl:attribute>
                </xsl:when>
              </xsl:choose>
            </xsl:when>
            <!-- Horizontal Orientation (Default) -->
            <xsl:otherwise>
              <xsl:choose>
                <xsl:when test="not($is-first) and not($is-last)">
                  <xsl:attribute name="fox:border-radius">0</xsl:attribute>
                  <xsl:attribute name="margin-left">-1pt</xsl:attribute>
                  <xsl:attribute name="margin-right">-1pt</xsl:attribute>
                </xsl:when>
                <xsl:when test="$is-first">
                  <xsl:attribute name="fox:border-before-end-radius">0</xsl:attribute>
                  <xsl:attribute name="fox:border-after-end-radius">0</xsl:attribute>
                  <xsl:attribute name="margin-left">0pt</xsl:attribute>
                  <xsl:attribute name="margin-right">-1pt</xsl:attribute>
                </xsl:when>
                <xsl:when test="$is-last">
                  <xsl:attribute name="fox:border-before-start-radius">0</xsl:attribute>
                  <xsl:attribute name="fox:border-after-start-radius">0</xsl:attribute>
                  <xsl:attribute name="margin-left">-1pt</xsl:attribute>
                  <xsl:attribute name="margin-right">0pt</xsl:attribute>
                </xsl:when>
              </xsl:choose>
            </xsl:otherwise>
          </xsl:choose>
        </xsl:if>

        <xsl:call-template name="processBootstrapOutputClass">
          <xsl:with-param name="attrValue" select="@outputclass"/>
        </xsl:call-template>

        <xsl:call-template name="bootstrap.decoration"/>

        <!-- 5. Content handling - ensure we only process the intended label -->
        <fo:inline>
          <xsl:if test="normalize-space() != '' and not(contains(@outputclass, 'btn-floating'))">
            <xsl:attribute name="baseline-shift">0.5pt</xsl:attribute>
          </xsl:if>
          <xsl:choose>
            <!-- If button has explicit child text or formatting elements, use those -->
            <xsl:when test="node()[not(self::processing-instruction('ditaot'))]">
              <xsl:apply-templates select="node()" mode="button-label"/>
            </xsl:when>
            <!-- Fallback: retrieve target title only (cleanly) -->
            <xsl:when test="@href">
               <xsl:variable name="dest" select="opentopic-func:getDestinationId(@href)"/>
               <xsl:variable name="target" select="key('key_anchor', $dest, $root)[1]"/>
               <xsl:choose>
                  <xsl:when test="$target/*[contains(@class, ' topic/title ')]">
                     <xsl:apply-templates select="$target/*[contains(@class, ' topic/title ')]" mode="insert-text"/>
                  </xsl:when>
                  <xsl:otherwise>
                     <xsl:value-of select="@href"/>
                  </xsl:otherwise>
               </xsl:choose>
            </xsl:when>
          </xsl:choose>
        </fo:inline>
      </xsl:element>
    </fo:basic-link>
  </xsl:template>

  <!-- Dedicated mode for button labels to ensure no metadata leak -->
  <xsl:template match="text()" mode="button-label">
    <xsl:value-of select="."/>
  </xsl:template>

  <xsl:template match="*" mode="button-label">
    <xsl:apply-templates select="."/>
  </xsl:template>

  <!-- Explicitly suppress metadata elements in button labels -->
  <xsl:template
    match="*[contains(@class, ' topic/desc ') or contains(@class, ' topic/shortdesc ')]"
    mode="button-label"
    priority="5"
  />

  <!-- Suppress any dita-ot internal processing instructions -->
  <xsl:template match="processing-instruction()" mode="button-label" priority="5"/>

</xsl:stylesheet>

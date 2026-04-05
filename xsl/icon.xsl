<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:fo="http://www.w3.org/1999/XSL/Format"
                version="2.0">

  <!-- Icon Support (Bootstrap Icons via SVG) -->
  <xsl:template match="*[contains(@class, ' bootstrap-d/icon ')]" priority="5">
    <xsl:param name="color"/>
    <xsl:if test="@outputclass">
      <xsl:variable name="icon-src">
        <xsl:variable name="raw-icon" select="(tokenize(@outputclass, ' ')[starts-with(., 'bi-')], tokenize(@outputclass, ' ')[. != 'bi'])[1]"/>
        <xsl:variable name="clean-icon" select="if (starts-with($raw-icon, 'bi-')) then substring-after($raw-icon, 'bi-') else $raw-icon"/>
        <xsl:value-of select="concat('https://icons.getbootstrap.com/assets/icons/', $clean-icon, '.svg')"/>
      </xsl:variable>

      <!-- Determine color from ancestors (e.g. if in a primary button, the icon should be white) -->
      <xsl:variable name="theme-container" select="ancestor-or-self::*[contains(@class, ' bootstrap-d/button ') or contains(@class, ' bootstrap-d/badge ') or contains(@class, ' bootstrap-d/alert ') or contains(@class, ' topic/note ') or @color][1]"/>
      <xsl:variable name="theme" select="($theme-container/@color, if ($theme-container) then 'primary' else '')[1]"/>
      
      <xsl:variable name="icon-color">
         <xsl:choose>
            <xsl:when test="$color != ''"><xsl:value-of select="$color"/></xsl:when>
            <xsl:when test="$theme-container[contains(@class, ' bootstrap-d/alert ') or contains(@class, ' topic/note ')]">
               <!-- For Alerts/Notes, inherit the subtle text color -->
               <xsl:variable name="note-type" select="if ($theme-container[contains(@class, ' topic/note ')]) then ($theme-container/@type, 'note')[1] else ''"/>
               <xsl:variable name="mapped-theme">
                 <xsl:choose>
                    <xsl:when test="$theme-container/@color"><xsl:value-of select="$theme-container/@color"/></xsl:when>
                    <xsl:when test="$note-type = 'note' or $note-type = 'notice' or $note-type = 'remember'">info</xsl:when>
                    <xsl:when test="$note-type = 'tip' or $note-type = 'fastpath'">success</xsl:when>
                    <xsl:when test="$note-type = 'important'">primary</xsl:when>
                    <xsl:when test="$note-type = 'warning' or $note-type = 'caution' or $note-type = 'restriction' or $note-type = 'trouble'">warning</xsl:when>
                    <xsl:when test="$note-type = 'danger'">danger</xsl:when>
                    <xsl:otherwise><xsl:value-of select="$theme"/></xsl:otherwise>
                 </xsl:choose>
               </xsl:variable>
               <xsl:variable name="attrSet" select="concat('__bg__', $mapped-theme, '-subtle')"/>
               <xsl:value-of select="document('../cfg/fo/attrs/bootstrap-attr.xsl')//xsl:attribute-set[@name = $attrSet]/xsl:attribute[@name = 'color']"/>
            </xsl:when>
            <xsl:when test="$theme = 'warning' or $theme = 'light' or $theme = 'white'">
               <xsl:text>black</xsl:text>
            </xsl:when>
            <xsl:when test="$theme != ''">
               <xsl:text>white</xsl:text>
            </xsl:when>
            <xsl:otherwise>
               <xsl:text>black</xsl:text>
            </xsl:otherwise>
         </xsl:choose>
      </xsl:variable>
      
      <!-- Use instream-foreign-object and forcefully inject the target color into the SVG -->
      <fo:instream-foreign-object content-height="1.1em" 
                                  content-width="auto">
        <xsl:attribute name="baseline-shift">
           <xsl:choose>
              <!-- If icon is solo in a button/badge, don't shift (to keep it centered) -->
              <xsl:when test="ancestor::*[contains(@class, ' bootstrap-d/button ') or contains(@class, ' bootstrap-d/badge ')][not(normalize-space() != '')]">0</xsl:when>
              <xsl:otherwise>-10%</xsl:otherwise>
           </xsl:choose>
        </xsl:attribute>
        <xsl:call-template name="processBootstrapSpacing">
          <xsl:with-param name="attrValue" select="@margin"/>
          <xsl:with-param name="prefix" select="'m'"/>
        </xsl:call-template>
        <xsl:call-template name="processBootstrapSpacing">
          <xsl:with-param name="attrValue">
             <xsl:variable name="has-preceding" select="preceding-sibling::node()[normalize-space() != '']"/>
             <xsl:variable name="has-following" select="following-sibling::node()[normalize-space() != '']"/>
             <xsl:choose>
                <xsl:when test="@padding"><xsl:value-of select="@padding"/></xsl:when>
                <xsl:when test="$has-preceding and $has-following">x2</xsl:when>
                <xsl:when test="$has-following">e2</xsl:when>
                <xsl:when test="$has-preceding">s2</xsl:when>
                <xsl:otherwise><!-- Solo icon: No padding --></xsl:otherwise>
             </xsl:choose>
          </xsl:with-param>
          <xsl:with-param name="prefix" select="'p'"/>
        </xsl:call-template>
        <xsl:apply-templates select="document($icon-src)/*" mode="color-icon">
           <xsl:with-param name="color" select="$icon-color"/>
        </xsl:apply-templates>
      </fo:instream-foreign-object>
    </xsl:if>
  </xsl:template>

  <!-- Dedicated mode for injecting target color into the SVG XML -->
  <xsl:template match="node() | @*" mode="color-icon">
    <xsl:param name="color"/>
    <xsl:copy>
      <xsl:apply-templates select="node() | @*" mode="color-icon">
        <xsl:with-param name="color" select="$color"/>
      </xsl:apply-templates>
    </xsl:copy>
  </xsl:template>

  <!-- Special handling for fill and color attributes to forcefully inject theme color -->
  <xsl:template match="@fill | @color" mode="color-icon">
    <xsl:param name="color"/>
    <xsl:attribute name="{name()}" select="$color"/>
  </xsl:template>

  <!-- Ensure SVG elements that depend on inheritance pick up the color explicitly -->
  <xsl:template match="*[local-name()='svg' or local-name()='path' or local-name()='circle' or local-name()='rect'][not(@fill)]" mode="color-icon">
    <xsl:param name="color"/>
    <xsl:copy>
      <xsl:attribute name="fill" select="$color"/>
      <xsl:apply-templates select="node() | @*" mode="color-icon">
        <xsl:with-param name="color" select="$color"/>
      </xsl:apply-templates>
    </xsl:copy>
  </xsl:template>

</xsl:stylesheet>

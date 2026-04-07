<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:fo="http://www.w3.org/1999/XSL/Format"
  xmlns:fox="http://xmlgraphics.apache.org/fop/extensions"
  xmlns:xs="http://www.w3.org/2001/XMLSchema"
  xmlns:opentopic-func="http://www.idiominc.com/opentopic/exsl/function"
  xmlns:dita-ot="http://dita-ot.sourceforge.net/ns/201007/dita-ot"
  exclude-result-prefixes="xs opentopic-func dita-ot"
  version="2.0"
>

  <xsl:param name="BOOTSTRAP_ICONS_INCLUDE" select="'yes'"/>
  
  <!-- Helper Template to retrieve settings from the $bootstrap-settings map with a fallback -->
  <xsl:template name="getBootstrapSetting">
    <xsl:param name="name"/>
    <xsl:param name="default"/>
    <xsl:variable name="val" select="$bootstrap-settings/entry[@name = $name]"/>
    <xsl:choose>
      <xsl:when test="$val != ''"><xsl:value-of select="$val"/></xsl:when>
      <xsl:otherwise><xsl:value-of select="$default"/></xsl:otherwise>
    </xsl:choose>
  </xsl:template>

  <!-- Map DITA Note Type to Bootstrap Theme -->
  <xsl:template name="getNoteTheme">
    <xsl:param name="type" select="'note'"/>
    <xsl:choose>
      <xsl:when test="$type = 'note' or $type = 'notice' or $type = 'remember'">info</xsl:when>
      <xsl:when test="$type = 'tip' or $type = 'fastpath'">success</xsl:when>
      <xsl:when test="$type = 'important'">primary</xsl:when>
      <xsl:when test="$type = 'warning' or $type = 'caution' or $type = 'restriction' or $type = 'trouble'">warning</xsl:when>
      <xsl:when test="$type = 'danger'">danger</xsl:when>
      <xsl:otherwise>secondary</xsl:otherwise>
    </xsl:choose>
  </xsl:template>

  <!-- Retrieve the computed value of a specific attribute from an attribute-set -->
  <xsl:template name="getBootstrapAttrValue">
    <xsl:param name="attrSet"/>
    <xsl:param name="attrName" select="'color'"/>
    <xsl:param name="path" select="'../../cfg/fo/attrs/bootstrap-attr.xsl'"/>
    <xsl:variable name="attr" select="document($path)//xsl:attribute-set[@name = $attrSet]/xsl:attribute[@name = $attrName]"/>
    <xsl:choose>
      <xsl:when test="$attr/xsl:value-of">
        <xsl:variable name="select" select="$attr/xsl:value-of/@select"/>
        <xsl:variable name="varName" select="if (starts-with($select, '$')) then substring-after($select, '$') else $select"/>
        <xsl:value-of select="$bootstrap-settings/entry[@name = $varName]"/>
      </xsl:when>
      <xsl:otherwise>
        <xsl:value-of select="$attr"/>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

  <!-- Reflection Template for Bootstrap Attribute Sets -->
  <xsl:template name="processBootstrapAttrSetReflection">
    <xsl:param name="attrSet"/>
    <xsl:param name="path" select="'../../cfg/fo/attrs/bootstrap-attr.xsl'"/>

    <xsl:for-each select="document($path)//xsl:attribute-set[@name = $attrSet]/xsl:attribute">
      <xsl:attribute name="{@name}">
        <xsl:for-each select="node()">
          <xsl:choose>
            <xsl:when test="self::xsl:value-of">
              <xsl:variable name="select" select="@select"/>
              <xsl:variable
                name="varName"
                select="if (starts-with($select, '$')) then substring-after($select, '$') else $select"
              />
              <xsl:value-of select="$bootstrap-settings/entry[@name = $varName]"/>
            </xsl:when>
            <xsl:otherwise>
              <xsl:value-of select="."/>
            </xsl:otherwise>
          </xsl:choose>
        </xsl:for-each>
      </xsl:attribute>
    </xsl:for-each>
  </xsl:template>

  <!-- Process @width attribute -->
  <xsl:template name="processBootstrapWidth">
    <xsl:param name="attrValue"/>
    <xsl:if test="$attrValue">
      <xsl:call-template name="processBootstrapAttrSetReflection">
        <xsl:with-param name="attrSet" select="concat('w-', $attrValue)"/>
      </xsl:call-template>
    </xsl:if>
  </xsl:template>

  <!-- Process @border attribute -->
  <xsl:template name="processBootstrapBorder">
    <xsl:param name="attrValue"/>
    <xsl:if test="$attrValue">
      <xsl:for-each select="tokenize(normalize-space($attrValue), ' ')">
        <xsl:variable name="token" select="."/>

        <!-- Apply base border style for numeric thickness outside the variable to avoid Saxon error -->
        <xsl:if test="string(number($token)) != 'NaN'">
          <xsl:call-template name="processBootstrapAttrSetReflection">
            <xsl:with-param name="attrSet" select="'border'"/>
          </xsl:call-template>
        </xsl:if>

        <xsl:variable name="attrSetName">
          <xsl:choose>
            <xsl:when test="$token = 'yes' or $token = 'true' or $token = 'border'">border</xsl:when>
            <xsl:when test="starts-with($token, 'border-')">
              <xsl:value-of select="$token"/>
            </xsl:when>
            <xsl:otherwise>
              <xsl:value-of select="concat('border-', $token)"/>
            </xsl:otherwise>
          </xsl:choose>
        </xsl:variable>
        
        <xsl:call-template name="processBootstrapAttrSetReflection">
          <xsl:with-param name="attrSet" select="$attrSetName"/>
        </xsl:call-template>
      </xsl:for-each>
    </xsl:if>
  </xsl:template>

  <!-- Process @frame attribute for Figures -->
  <xsl:template name="processBootstrapFrame">
    <xsl:param name="attrValue"/>
    <xsl:if test="$attrValue">
      <xsl:variable name="processedValue">
        <xsl:choose>
          <xsl:when test="$attrValue = 'all'">border</xsl:when>
          <xsl:when test="$attrValue = 'sides'">start end</xsl:when>
          <xsl:when test="$attrValue = 'top'">top</xsl:when>
          <xsl:when test="$attrValue = 'bottom'">bottom</xsl:when>
          <xsl:when test="$attrValue = 'topbot'">top bottom</xsl:when>
        </xsl:choose>
      </xsl:variable>
      <xsl:if test="normalize-space($processedValue) != ''">
        <xsl:call-template name="processBootstrapBorder">
          <xsl:with-param name="attrValue" select="$processedValue"/>
        </xsl:call-template>
        <!-- Effectively an additional padded border - using p-3 / 12pt -->
        <xsl:attribute name="padding"><xsl:value-of select="$bootstrap-spacing-3"/></xsl:attribute>
      </xsl:if>
    </xsl:if>
  </xsl:template>

  <!-- Process @bordercolor attribute -->
  <xsl:template name="processBootstrapBorderColor">
    <xsl:param name="attrValue"/>
    <xsl:if test="$attrValue">
      <xsl:attribute name="border-style">solid</xsl:attribute>
      <xsl:attribute name="border-width"><xsl:value-of select="$bootstrap-border-width"/></xsl:attribute>
      <xsl:call-template name="processBootstrapAttrSetReflection">
        <xsl:with-param name="attrSet" select="concat('border-', $attrValue)"/>
      </xsl:call-template>
    </xsl:if>
  </xsl:template>

  <!-- Process @border-width attribute -->
  <xsl:template name="processBootstrapBorderWidth">
    <xsl:param name="attrValue"/>
    <xsl:if test="$attrValue">
      <xsl:attribute name="border-width"><xsl:value-of select="$attrValue"/></xsl:attribute>
    </xsl:if>
  </xsl:template>

  <!-- Process @dir attribute for RTL/LTR direction -->
  <xsl:template name="processBootstrapDirection">
    <xsl:variable name="direction">
        <xsl:choose>
            <xsl:when test="@dir"><xsl:value-of select="@dir"/></xsl:when>
            <xsl:when test="ancestor::*[@dir]"><xsl:value-of select="ancestor::*[@dir][1]/@dir"/></xsl:when>
            <xsl:otherwise/>
        </xsl:choose>
    </xsl:variable>

    <xsl:choose>
      <xsl:when test="$direction = 'rtl'">
        <xsl:attribute name="writing-mode">rl-tb</xsl:attribute>
        <xsl:attribute name="direction">rtl</xsl:attribute>
        <xsl:attribute name="text-align">right</xsl:attribute>
        <xsl:attribute name="text-align-last">right</xsl:attribute>
      </xsl:when>
      <xsl:when test="$direction = 'ltr'">
        <xsl:attribute name="writing-mode">lr-tb</xsl:attribute>
        <xsl:attribute name="direction">ltr</xsl:attribute>
        <xsl:attribute name="text-align">left</xsl:attribute>
        <xsl:attribute name="text-align-last">left</xsl:attribute>
      </xsl:when>
    </xsl:choose>
  </xsl:template>

  <!-- Process @rounded attribute -->
  <xsl:template name="processBootstrapRounded">
    <xsl:param name="attrValue"/>
    <xsl:if test="$attrValue">
      <xsl:variable name="attrSetName">
        <xsl:choose>
          <xsl:when test="$attrValue = 'yes' or $attrValue = 'true'">rounded</xsl:when>
          <xsl:otherwise><xsl:value-of select="concat('rounded-', $attrValue)"/></xsl:otherwise>
        </xsl:choose>
      </xsl:variable>
      <xsl:call-template name="processBootstrapAttrSetReflection">
        <xsl:with-param name="attrSet" select="$attrSetName"/>
      </xsl:call-template>
    </xsl:if>
  </xsl:template>

  <!-- Process @margin and @padding attributes -->
  <xsl:template name="processBootstrapSpacing">
    <xsl:param name="attrValue"/>
    <xsl:param name="prefix"/> <!-- 'p' or 'm' -->
    <xsl:if test="$attrValue">
      <xsl:for-each select="tokenize(normalize-space($attrValue), ' ')">
        <xsl:variable name="token" select="."/>
        <xsl:variable name="attrSetName">
          <xsl:choose>
            <xsl:when test="$token = 'auto'">
              <xsl:value-of select="concat($prefix, '-auto')"/>
            </xsl:when>
            <xsl:when test="string-length($token) = 1">
              <xsl:value-of select="concat($prefix, '-', $token)"/>
            </xsl:when>
            <xsl:otherwise>
              <xsl:value-of select="concat($prefix, substring($token, 1, 1), '-', substring($token, 2))"/>
            </xsl:otherwise>
          </xsl:choose>
        </xsl:variable>
        <xsl:call-template name="processBootstrapAttrSetReflection">
          <xsl:with-param name="attrSet" select="$attrSetName"/>
        </xsl:call-template>
      </xsl:for-each>
    </xsl:if>
  </xsl:template>

  <!-- Process @outputclass attribute for Bootstrap classes -->
  <xsl:template name="processBootstrapOutputClass">
    <xsl:param name="attrValue"/>
    <xsl:if test="$attrValue">
      <xsl:variable name="tokens" select="tokenize(normalize-space($attrValue), ' ')"/>
      
      <!-- Pass 1: Background and other utilities -->
      <xsl:for-each select="$tokens">
        <xsl:variable name="token" select="."/>
        <xsl:choose>
          <xsl:when test="starts-with($token, 'bg-')">
            <xsl:call-template name="processBootstrapAttrSetReflection">
              <xsl:with-param name="attrSet" select="concat('__bg__', substring-after($token, 'bg-'))"/>
            </xsl:call-template>
          </xsl:when>
          <xsl:when
            test="$token = 'border' or $token = 'border-top' or $token = 'border-bottom' or $token = 'border-start' or $token = 'border-end' or 
                        starts-with($token, 'border-') or starts-with($token, 'rounded-') or $token = 'rounded' or
                        starts-with($token, 'w-') or starts-with($token, 'p-') or starts-with($token, 'm-') or
                        starts-with($token, 'px-') or starts-with($token, 'py-') or starts-with($token, 'pt-') or starts-with($token, 'pb-') or starts-with($token, 'ps-') or starts-with($token, 'pe-') or
                        starts-with($token, 'mx-') or starts-with($token, 'my-') or starts-with($token, 'mt-') or starts-with($token, 'mb-') or starts-with($token, 'ms-') or starts-with($token, 'me-') or
                        $token = 'h1' or $token = 'h2' or $token = 'h3' or $token = 'h4' or $token = 'h5' or $token = 'h6' or
                        starts-with($token, 'display-')"
          >
            <xsl:call-template name="processBootstrapAttrSetReflection">
              <xsl:with-param name="attrSet" select="$token"/>
            </xsl:call-template>
          </xsl:when>
          <!-- Text Align utilities (New) -->
          <xsl:when test="$token = 'text-start'"><xsl:attribute name="text-align">left</xsl:attribute></xsl:when>
          <xsl:when test="$token = 'text-center'"><xsl:attribute name="text-align">center</xsl:attribute></xsl:when>
          <xsl:when test="$token = 'text-end'"><xsl:attribute name="text-align">right</xsl:attribute></xsl:when>
        </xsl:choose>
      </xsl:for-each>

      <!-- Pass 2: Text color -->
      <xsl:for-each select="$tokens">
        <xsl:variable name="token" select="."/>
        <xsl:if
          test="starts-with($token, 'text-') and not($token = 'text-start' or $token = 'text-center' or $token = 'text-end')"
        >
          <xsl:call-template name="processBootstrapAttrSetReflection">
            <xsl:with-param name="attrSet" select="concat('__color__', substring-after($token, 'text-'))"/>
          </xsl:call-template>
        </xsl:if>
      </xsl:for-each>
    </xsl:if>
  </xsl:template>

  <!-- Baseline Section and Div Support -->
  <xsl:template
    match="*[contains(@class, ' topic/section ') or 
                         contains(@class, ' topic/div ') or 
                         contains(@class, ' topic/bodydiv ')]"
  >
    <fo:block>
      <xsl:call-template name="commonattributes"/>
      <xsl:if test="@color">
        <xsl:call-template name="processBootstrapAttrSetReflection">
          <xsl:with-param name="attrSet" select="concat('__bg__', @color)"/>
        </xsl:call-template>
        <xsl:if test="not(@padding)">
          <xsl:attribute name="padding">5pt</xsl:attribute>
        </xsl:if>
      </xsl:if>
      <xsl:call-template name="processBootstrapSpacing">
        <xsl:with-param name="attrValue" select="@padding"/>
        <xsl:with-param name="prefix" select="'p'"/>
      </xsl:call-template>
      <xsl:call-template name="processBootstrapSpacing">
        <xsl:with-param name="attrValue" select="@margin"/>
        <xsl:with-param name="prefix" select="'m'"/>
      </xsl:call-template>
      <xsl:call-template name="processBootstrapBorder">
        <xsl:with-param name="attrValue" select="@border"/>
      </xsl:call-template>
      <xsl:call-template name="processBootstrapWidth">
        <xsl:with-param name="attrValue" select="@width"/>
      </xsl:call-template>
      <xsl:call-template name="processBootstrapBorderColor">
        <xsl:with-param name="attrValue" select="@bordercolor"/>
      </xsl:call-template>
      <xsl:call-template name="processBootstrapRounded">
        <xsl:with-param name="attrValue" select="@rounded"/>
      </xsl:call-template>
      <xsl:call-template name="processBootstrapOutputClass">
        <xsl:with-param name="attrValue" select="@outputclass"/>
      </xsl:call-template>
      <xsl:call-template name="processBootstrapDirection"/>
      <xsl:apply-templates/>
    </fo:block>
  </xsl:template>

  <!-- Inline Ph Support -->
  <xsl:template match="*[contains(@class, ' topic/ph ')]">
    <fo:inline>
      <xsl:call-template name="commonattributes"/>
      <xsl:call-template name="processBootstrapSpacing">
        <xsl:with-param name="attrValue" select="@padding"/>
        <xsl:with-param name="prefix" select="'p'"/>
      </xsl:call-template>
      <xsl:call-template name="processBootstrapSpacing">
        <xsl:with-param name="attrValue" select="@margin"/>
        <xsl:with-param name="prefix" select="'m'"/>
      </xsl:call-template>
      <xsl:call-template name="processBootstrapBorder">
        <xsl:with-param name="attrValue" select="@border"/>
      </xsl:call-template>
      <xsl:call-template name="processBootstrapBorderColor">
        <xsl:with-param name="attrValue" select="@bordercolor"/>
      </xsl:call-template>
      <xsl:call-template name="processBootstrapRounded">
        <xsl:with-param name="attrValue" select="@rounded"/>
      </xsl:call-template>
      <xsl:call-template name="processBootstrapOutputClass">
        <xsl:with-param name="attrValue" select="@outputclass"/>
      </xsl:call-template>
      <xsl:call-template name="processBootstrapDirection"/>
      <xsl:apply-templates/>
    </fo:inline>
  </xsl:template>

  <!-- Paragraph Support -->
  <xsl:template match="*[contains(@class, ' topic/p ')]">
    <fo:block xsl:use-attribute-sets="p">
      <xsl:call-template name="commonattributes"/>
      <xsl:call-template name="processBootstrapSpacing">
        <xsl:with-param name="attrValue" select="@padding"/>
        <xsl:with-param name="prefix" select="'p'"/>
      </xsl:call-template>
      <xsl:call-template name="processBootstrapSpacing">
        <xsl:with-param name="attrValue" select="@margin"/>
        <xsl:with-param name="prefix" select="'m'"/>
      </xsl:call-template>
      <xsl:call-template name="processBootstrapBorder">
        <xsl:with-param name="attrValue" select="@border"/>
      </xsl:call-template>
      <xsl:call-template name="processBootstrapWidth">
        <xsl:with-param name="attrValue" select="@width"/>
      </xsl:call-template>
      <xsl:call-template name="processBootstrapBorderColor">
        <xsl:with-param name="attrValue" select="@bordercolor"/>
      </xsl:call-template>
      <xsl:call-template name="processBootstrapRounded">
        <xsl:with-param name="attrValue" select="@rounded"/>
      </xsl:call-template>
      <xsl:call-template name="processBootstrapOutputClass">
        <xsl:with-param name="attrValue" select="@outputclass"/>
      </xsl:call-template>
      <xsl:call-template name="processBootstrapDirection"/>
      <xsl:apply-templates/>
    </fo:block>
  </xsl:template>

  <!-- Blockquote (lq) Support -->
  <xsl:template match="*[contains(@class, ' topic/lq ')]">
    <fo:block margin-bottom="12pt">
      <xsl:call-template name="commonattributes"/>
      <xsl:if test="@color">
        <xsl:call-template name="processBootstrapAttrSetReflection">
          <xsl:with-param name="attrSet" select="concat('__bg__', @color)"/>
        </xsl:call-template>
        <xsl:if test="not(@padding)">
          <xsl:attribute name="padding">5pt</xsl:attribute>
        </xsl:if>
      </xsl:if>
      <xsl:call-template name="processBootstrapSpacing">
        <xsl:with-param name="attrValue" select="@padding"/>
        <xsl:with-param name="prefix" select="'p'"/>
      </xsl:call-template>
      <xsl:call-template name="processBootstrapSpacing">
        <xsl:with-param name="attrValue" select="@margin"/>
        <xsl:with-param name="prefix" select="'m'"/>
      </xsl:call-template>
      <xsl:call-template name="processBootstrapBorder">
        <xsl:with-param name="attrValue" select="@border"/>
      </xsl:call-template>
      <xsl:call-template name="processBootstrapWidth">
        <xsl:with-param name="attrValue" select="@width"/>
      </xsl:call-template>
      <xsl:call-template name="processBootstrapBorderColor">
        <xsl:with-param name="attrValue" select="@bordercolor"/>
      </xsl:call-template>
      <xsl:call-template name="processBootstrapRounded">
        <xsl:with-param name="attrValue" select="@rounded"/>
      </xsl:call-template>
      <xsl:call-template name="processBootstrapOutputClass">
        <xsl:with-param name="attrValue" select="@outputclass"/>
      </xsl:call-template>
      <xsl:call-template name="processBootstrapDirection"/>
      <xsl:if test="not(@outputclass)">
        <xsl:attribute name="font-size">15pt</xsl:attribute>
      </xsl:if>
      <xsl:apply-templates/>
    </fo:block>
  </xsl:template>

  <!-- Text/Paragraphs within Blockquote (lq) -->
  <xsl:template match="*[contains(@class, ' topic/lq ')]/*[contains(@class, ' topic/p ')]" priority="5">
    <fo:block xsl:use-attribute-sets="p">
      <xsl:call-template name="commonattributes"/>
      
      <!-- Default large font for lq/p unless an override is present -->
      <xsl:if test="not(@outputclass) and not(parent::*/@outputclass)">
        <xsl:attribute name="font-size">15pt</xsl:attribute>
      </xsl:if>

      <xsl:call-template name="processBootstrapSpacing">
        <xsl:with-param name="attrValue" select="@padding"/>
        <xsl:with-param name="prefix" select="'p'"/>
      </xsl:call-template>
      <xsl:call-template name="processBootstrapSpacing">
        <xsl:with-param name="attrValue" select="@margin"/>
        <xsl:with-param name="prefix" select="'m'"/>
      </xsl:call-template>
      <xsl:call-template name="processBootstrapBorder">
        <xsl:with-param name="attrValue" select="@border"/>
      </xsl:call-template>
      <xsl:call-template name="processBootstrapWidth">
        <xsl:with-param name="attrValue" select="@width"/>
      </xsl:call-template>
      <xsl:call-template name="processBootstrapBorderColor">
        <xsl:with-param name="attrValue" select="@bordercolor"/>
      </xsl:call-template>
      <xsl:call-template name="processBootstrapRounded">
        <xsl:with-param name="attrValue" select="@rounded"/>
      </xsl:call-template>
      <xsl:call-template name="processBootstrapOutputClass">
        <xsl:with-param name="attrValue" select="@outputclass"/>
      </xsl:call-template>
      <xsl:call-template name="processBootstrapDirection"/>
      <xsl:attribute name="line-height">1.5</xsl:attribute>
      <xsl:apply-templates/>
    </fo:block>
  </xsl:template>

  <!-- Unstyled List Support (ul and ol) -->
  <xsl:template
    match="*[contains(@class, ' topic/ul ') or contains(@class, ' topic/ol ')][tokenize(@outputclass, ' ') = 'list-unstyled']"
  >
    <fo:block margin-bottom="12pt">
      <xsl:call-template name="commonattributes"/>
      <xsl:call-template name="processBootstrapDirection"/>
      <xsl:apply-templates select="*[contains(@class, ' topic/li ')]" mode="list-unstyled"/>
    </fo:block>
  </xsl:template>

  <xsl:template match="*[contains(@class, ' topic/li ')]" mode="list-unstyled">
    <fo:block margin-left="0pt" margin-bottom="3pt">
      <xsl:call-template name="commonattributes"/>
      <xsl:apply-templates/>
    </fo:block>
  </xsl:template>

  <!-- Inline List Support (ul and ol) -->
  <xsl:template
    match="*[contains(@class, ' topic/ul ') or contains(@class, ' topic/ol ')][tokenize(@outputclass, ' ') = 'list-inline']"
  >
    <fo:block margin-bottom="12pt">
      <xsl:call-template name="commonattributes"/>
      <xsl:call-template name="processBootstrapDirection"/>
      <xsl:apply-templates select="*[contains(@class, ' topic/li ')]" mode="list-inline"/>
    </fo:block>
  </xsl:template>

  <xsl:template match="*[contains(@class, ' topic/li ')]" mode="list-inline">
    <fo:inline padding-right="8pt">
      <xsl:call-template name="commonattributes"/>
      <xsl:apply-templates/>
    </fo:inline>
  </xsl:template>

  <!-- Suppress any elements used for dark/light mode switching in print -->
  <xsl:template
    match="*[tokenize(normalize-space(@outputclass), ' ') = 'd-light' or tokenize(normalize-space(@outputclass), ' ') = 'd-dark']"
    priority="5"
  />

  <!-- Only render the first image within a picture element -->
  <xsl:template match="*[contains(@class, ' bootstrap-d/picture ')]" priority="6">
    <fo:block>
      <xsl:call-template name="commonattributes"/>
      <xsl:apply-templates select="*[contains(@class, ' topic/image ')][1]"/>
    </fo:block>
  </xsl:template>

  <!-- Thumbnail Support -->
  <xsl:template match="*[contains(@class, ' bootstrap-d/thumbnail ')]" priority="6">
    <xsl:variable name="resolved-href">
      <xsl:choose>
        <xsl:when test="@scope = 'external' or opentopic-func:isAbsolute(@href)">
          <xsl:value-of select="@href"/>
        </xsl:when>
        <xsl:when test="exists(key('jobFile', @href, $job))">
          <xsl:value-of select="key('jobFile', @href, $job)/@src"/>
        </xsl:when>
        <xsl:otherwise>
          <xsl:value-of select="concat($input.dir.url, @href)"/>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:variable>

    <xsl:variable name="theme" select="@color"/>
    <xsl:choose>
      <xsl:when test="@placement = 'break'">
        <fo:block margin-top="{$bootstrap-spacing-3}" margin-bottom="{$bootstrap-spacing-3}" text-align="center">
          <fo:external-graphic
            src="url('{$resolved-href}')"
            content-width="scale-to-fit"
            scaling="uniform"
            padding="{$bootstrap-spacing-1}"
            fox:border-radius="{$bootstrap-rounded-2}"
            vertical-align="middle"
          >
            <xsl:attribute name="border">
              <xsl:value-of select="concat($bootstrap-border-width, ' solid')"/>
            </xsl:attribute>
            <xsl:choose>
              <xsl:when test="$theme">
                <xsl:call-template name="processBootstrapBorderColor">
                  <xsl:with-param name="attrValue" select="$theme"/>
                </xsl:call-template>
                <xsl:call-template name="processBootstrapAttrSetReflection">
                  <xsl:with-param name="attrSet" select="concat('__bg__', $theme, '-subtle')"/>
                </xsl:call-template>
              </xsl:when>
              <xsl:otherwise>
                <xsl:attribute name="border-color"><xsl:value-of select="$bootstrap-border-color"/></xsl:attribute>
                <xsl:attribute name="background-color">#ffffff</xsl:attribute>
              </xsl:otherwise>
            </xsl:choose>
            <xsl:call-template name="commonattributes"/>
            <xsl:if test="@height"><xsl:attribute name="height" select="@height"/></xsl:if>
            <xsl:if test="@width"><xsl:attribute name="width" select="@width"/></xsl:if>
          </fo:external-graphic>
        </fo:block>
      </xsl:when>
      <xsl:otherwise>
        <fo:external-graphic
          src="url('{$resolved-href}')"
          content-width="scale-to-fit"
          scaling="uniform"
          padding="{$bootstrap-spacing-1}"
          fox:border-radius="{$bootstrap-rounded-2}"
          vertical-align="middle"
        >
          <xsl:attribute name="border">
            <xsl:value-of select="concat($bootstrap-border-width, ' solid')"/>
          </xsl:attribute>
          <xsl:choose>
            <xsl:when test="$theme">
              <xsl:call-template name="processBootstrapBorderColor">
                <xsl:with-param name="attrValue" select="$theme"/>
              </xsl:call-template>
              <xsl:call-template name="processBootstrapAttrSetReflection">
                <xsl:with-param name="attrSet" select="concat('__bg__', $theme, '-subtle')"/>
              </xsl:call-template>
            </xsl:when>
            <xsl:otherwise>
              <xsl:attribute name="border-color"><xsl:value-of select="$bootstrap-border-color"/></xsl:attribute>
              <xsl:attribute name="background-color">#ffffff</xsl:attribute>
            </xsl:otherwise>
          </xsl:choose>
          <xsl:call-template name="commonattributes"/>
          <xsl:if test="@height"><xsl:attribute name="height" select="@height"/></xsl:if>
          <xsl:if test="@width"><xsl:attribute name="width" select="@width"/></xsl:if>
        </fo:external-graphic>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>


</xsl:stylesheet>

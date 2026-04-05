<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:fo="http://www.w3.org/1999/XSL/Format"
                xmlns:fox="http://xmlgraphics.apache.org/fop/extensions"
                xmlns:xs="http://www.w3.org/2001/XMLSchema"
                xmlns:opentopic-func="http://www.idiominc.com/opentopic/exsl/function"
                xmlns:dita-ot="http://dita-ot.sourceforge.net/ns/201007/dita-ot"
                exclude-result-prefixes="xs opentopic-func dita-ot"
                version="2.0">

  <!-- Matches carousel specialized elements or bodydiv/ol with carousel outputclass -->
  <xsl:template match="*[contains(@class, ' bootstrap-d/carousel ') or (contains(@class, ' topic/ol ') and tokenize(@outputclass, ' ') = 'carousel')]" priority="5">
    <fo:block>
      <xsl:call-template name="commonattributes"/>
      <xsl:call-template name="processBootstrapDirection"/>
      <xsl:call-template name="processBootstrapSpacing">
        <xsl:with-param name="attrValue" select="@margin"/>
        <xsl:with-param name="prefix" select="'m'"/>
      </xsl:call-template>
      <xsl:call-template name="processBootstrapWidth">
        <xsl:with-param name="attrValue" select="@width"/>
      </xsl:call-template>

      <!-- Identify all item-level content to be flattened into the 3-column grid -->
      <xsl:variable name="items" select="(*[contains(@class, ' bootstrap-d/carousel-item ')] | *[contains(@class, ' topic/li ')]) / (
          *[contains(@class, ' topic/image ')] | 
          *[contains(@class, ' topic/fig ')] | 
          *[contains(@class, ' bootstrap-d/grid-row ') and not(preceding-sibling::*[contains(@class, ' topic/image ')])]/*[contains(@class, ' bootstrap-d/grid-col ')][* or normalize-space()] | 
          *[not(contains(@class, ' topic/image ') or contains(@class, ' topic/fig ') or contains(@class, ' bootstrap-d/grid-row '))]
        )"/>

      <xsl:if test="count($items) &lt; 10">
        <xsl:attribute name="keep-with-next">always</xsl:attribute>
        <xsl:attribute name="keep-together.within-page">always</xsl:attribute>
      </xsl:if>

      <!-- Dynamic representation for print: A 3-column table -->
      <fo:table table-layout="fixed" width="100%" border-collapse="separate" border-spacing="5pt">
        <fo:table-column column-width="proportional-column-width(1)"/>
        <fo:table-column column-width="proportional-column-width(1)"/>
        <fo:table-column column-width="proportional-column-width(1)"/>
        
        <fo:table-body>
          <!-- The $items variable is now calculated at the start of the template -->

          
          <xsl:for-each select="$items[position() mod 3 = 1]">
            <xsl:variable name="group-start-idx" select="position()"/>
            <xsl:variable name="current-group" select="$items[position() &gt;= ($group-start-idx - 1) * 3 + 1 and position() &lt;= $group-start-idx * 3]"/>
            
            <fo:table-row>
              <xsl:for-each select="$current-group">
                <fo:table-cell padding="5pt" border="1pt solid">
                  <!-- Border color logic: carousel/@color or default grey -->
                  <xsl:variable name="theme" select="ancestor::*[contains(@class, ' bootstrap-d/carousel ')][1]/@color"/>
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
                      <xsl:attribute name="border-color">#dee2e6</xsl:attribute>
                    </xsl:otherwise>
                  </xsl:choose>
                  <xsl:attribute name="fox:border-radius">4pt</xsl:attribute>

                  <fo:block start-indent="0pt">
                    <xsl:choose>
                       <xsl:when test="contains(@class, ' bootstrap-d/grid-col ')">
                          <xsl:apply-templates select="node()"/>
                       </xsl:when>
                       <xsl:otherwise>
                          <xsl:apply-templates select="."/>
                       </xsl:otherwise>
                    </xsl:choose>
                    
                    <!-- 
                       Special Case: Image with a following Grid Row providing captions.
                       We pull the corresponding grid-col content into the same cell below the image.
                    -->
                    <xsl:if test="contains(@class, ' topic/image ')">
                      <xsl:variable name="img-idx" select="count(preceding-sibling::*[contains(@class, ' topic/image ')]) + 1"/>
                      <!-- Look for grid-row in the same parent -->
                      <xsl:variable name="matching-col" select="parent::*/*[contains(@class, ' bootstrap-d/grid-row ')][1]/*[contains(@class, ' bootstrap-d/grid-col ')][$img-idx]"/>
                      <xsl:if test="$matching-col">
                        <fo:block font-size="9pt" color="#6c757d" text-align="center" font-style="italic" margin-top="4pt">
                          <xsl:apply-templates select="$matching-col/node()"/>
                        </fo:block>
                      </xsl:if>
                    </xsl:if>
                  </fo:block>
                </fo:table-cell>
              </xsl:for-each>
              
              <!-- Fill remaining columns with empty cells (no border for these?) -->
              <xsl:if test="count($current-group) &lt; 3">
                <xsl:for-each select="1 to (3 - count($current-group))">
                  <fo:table-cell><fo:block/></fo:table-cell>
                </xsl:for-each>
              </xsl:if>
            </fo:table-row>
          </xsl:for-each>
        </fo:table-body>
      </fo:table>
    </fo:block>
  </xsl:template>

  <!-- Unwrap cards when inside a carousel to avoid double-nesting/borders -->
  <xsl:template match="*[contains(@class, ' bootstrap-d/carousel ')]//*[contains(@class, ' bootstrap-d/card ')]" priority="10">
     <xsl:apply-templates/>
  </xsl:template>

  <xsl:template match="*[contains(@class, ' topic/image ')][ancestor::*[contains(@class, ' bootstrap-d/carousel ') or tokenize(@outputclass, ' ') = 'carousel']]" priority="20">
    <fo:block text-align="center">
      <xsl:variable name="resolved-href">
        <xsl:choose>
          <xsl:when test="@scope = 'external' or opentopic-func:isAbsolute(@href)">
            <xsl:value-of select="@href"/>
          </xsl:when>
          <!-- Using standard job mapping for local images -->
          <xsl:when test="exists(key('jobFile', @href, $job))">
            <xsl:value-of select="key('jobFile', @href, $job)/@src"/>
          </xsl:when>
          <xsl:otherwise>
            <xsl:value-of select="concat($input.dir.url, @href)"/>
          </xsl:otherwise>
        </xsl:choose>
      </xsl:variable>

      <fo:external-graphic src="url('{$resolved-href}')" content-width="scale-to-fit" width="100%" height="auto" scaling="uniform">
        <xsl:call-template name="commonattributes"/>
      </fo:external-graphic>
    </fo:block>
  </xsl:template>

</xsl:stylesheet>

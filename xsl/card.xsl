<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:fo="http://www.w3.org/1999/XSL/Format"
                xmlns:fox="http://xmlgraphics.apache.org/fop/extensions"
                xmlns:xs="http://www.w3.org/2001/XMLSchema"
                xmlns:opentopic-func="http://www.idiominc.com/opentopic/exsl/function"
                xmlns:dita-ot="http://dita-ot.sourceforge.net/ns/201007/dita-ot"
                exclude-result-prefixes="xs opentopic-func dita-ot"
                version="2.0">

  <!-- Match both specialized card elements and sections/divs with @outputclass='card' -->
  <!-- Aggressive priority="100" to override any other plugin or base templates. -->
  <xsl:template match="*[contains(@class, ' bootstrap-d/card ') or (tokenize(@outputclass, ' ') = 'card' and (contains(@class, ' topic/section ') or contains(@class, ' topic/div ') or contains(@class, ' topic/bodydiv ')))]" priority="5">
    
    <fo:block>
      <xsl:call-template name="processBootstrapDirection"/>
      <xsl:variable name="direction">
        <xsl:choose>
          <xsl:when test="@dir"><xsl:value-of select="@dir"/></xsl:when>
          <xsl:when test="ancestor::*[@dir]"><xsl:value-of select="ancestor::*[@dir][1]/@dir"/></xsl:when>
          <xsl:otherwise/>
        </xsl:choose>
      </xsl:variable>

      <xsl:variable name="card-pct">
        <xsl:choose>
          <xsl:when test="@width = '25'">25</xsl:when>
          <xsl:when test="@width = '50'">50</xsl:when>
          <xsl:when test="@width = '75'">75</xsl:when>
          <xsl:when test="@width = '100'">100</xsl:when>
          <xsl:otherwise>70</xsl:otherwise>
        </xsl:choose>
      </xsl:variable>
      <xsl:variable name="gap-pct" select="100 - number($card-pct)"/>

      <!-- Positioning Table Wrapper: Using Natural FO Flow -->
      <!-- The table writing-mode matches the component's direction, forcing Column 1 to the correct side. -->
      <fo:table table-layout="fixed" width="100%" space-before="10pt" space-after="10pt">
        <xsl:call-template name="processBootstrapDirection"/>
        
        <xsl:choose>
          <!-- Fixed width Card (e.g. 70%) with a Gap (e.g. 30%) -->
          <xsl:when test="$card-pct &lt; 100">
             <fo:table-column column-width="proportional-column-width({$card-pct})"/>
             <fo:table-column column-width="proportional-column-width({$gap-pct})"/>
          </xsl:when>
          <!-- Full width Card -->
          <xsl:otherwise>
             <fo:table-column column-width="proportional-column-width(1)"/>
          </xsl:otherwise>
        </xsl:choose>

        <fo:table-body>
          <fo:table-row>
             <!-- Column 1: Always contains the Card content -->
             <!-- In RTL, Column 1 is on the Right. In LTR, Column 1 is on the Left. -->
             <fo:table-cell>
                <xsl:call-template name="renderCardInternal"/>
             </fo:table-cell>
             
             <!-- Column 2: Always contains the empty Gap (if any) -->
             <xsl:if test="$card-pct &lt; 100">
               <fo:table-cell>
                  <fo:block/>
               </fo:table-cell>
             </xsl:if>
          </fo:table-row>
        </fo:table-body>
      </fo:table>
    </fo:block>
  </xsl:template>

  <xsl:template name="renderCardInternal">
      <fo:table xsl:use-attribute-sets="section">
        <xsl:call-template name="commonattributes"/>
        
        <!-- Start-aligned within its cell -->
        <xsl:attribute name="start-indent">0pt</xsl:attribute>
        <xsl:attribute name="end-indent">0pt</xsl:attribute>
        
        <!-- Frame Border: Uses @color theme if present, falls back to light gray -->
        <xsl:attribute name="border">1pt solid</xsl:attribute>
        <xsl:variable name="theme" select="@color"/>
        <xsl:choose>
          <xsl:when test="$theme">
            <xsl:call-template name="processBootstrapBorderColor">
              <xsl:with-param name="attrValue" select="$theme"/>
            </xsl:call-template>
          </xsl:when>
          <xsl:otherwise>
            <xsl:attribute name="border-color">#dee2e6</xsl:attribute>
          </xsl:otherwise>
        </xsl:choose>
        <!-- Ensure the entire card stays on one page -->
        <xsl:attribute name="keep-together.within-page">always</xsl:attribute>

        <fo:table-column column-width="proportional-column-width(1)"/>
        <fo:table-body>
          
          <!-- Element Selection -->
          <xsl:variable name="all-images" select="*[contains(@class, ' topic/image ')]"/>
          <xsl:variable name="top-images" select="$all-images[contains(@outputclass, 'card-img-top')] | ($all-images[1][not(contains(@outputclass, 'card-img-bottom'))])"/>
          <xsl:variable name="header" select="*[contains(@class, ' bootstrap-d/card-header ') or contains(@outputclass, 'card-header')]"/>
          <xsl:variable name="footer" select="*[contains(@class, ' bootstrap-d/card-footer ') or contains(@outputclass, 'card-footer')]"/>
          <xsl:variable name="title" select="*[contains(@class, ' topic/title ')]"/>

          <!-- 1. Card Header Row -->
          <xsl:if test="$header">
            <fo:table-row>
              <fo:table-cell padding="8pt 15pt" background-color="#f8f9fa" border-bottom="1pt solid #dee2e6">
                 <xsl:call-template name="processBootstrapDirection"/>
                 <fo:block>
                    <xsl:call-template name="processBootstrapDirection"/>
                    <xsl:apply-templates select="$header"/>
                 </fo:block>
              </fo:table-cell>
            </fo:table-row>
          </xsl:if>

          <!-- 2. Image Row (Image moved down by 4pt) -->
          <xsl:if test="$top-images">
            <fo:table-row line-height="0">
              <fo:table-cell padding="4pt 0 0 0">
                 <fo:block>
                    <xsl:apply-templates select="$top-images"/>
                 </fo:block>
              </fo:table-cell>
            </fo:table-row>
          </xsl:if>

          <!-- 3. Title Row -->
          <xsl:if test="$title">
            <fo:table-row>
              <fo:table-cell padding="10pt 15pt 0 15pt">
                 <xsl:call-template name="processBootstrapDirection"/>
                 <xsl:if test="$theme">
                    <xsl:call-template name="processBootstrapAttrSetReflection">
                       <xsl:with-param name="attrSet" select="concat('__bg__', $theme, '-subtle')"/>
                    </xsl:call-template>
                 </xsl:if>
                 <fo:block>
                    <xsl:call-template name="processBootstrapDirection"/>
                        <xsl:apply-templates select="$title"/>
                 </fo:block>
              </fo:table-cell>
            </fo:table-row>
          </xsl:if>

          <fo:table-row>
            <fo:table-cell padding="10pt 15pt">
               <xsl:call-template name="processBootstrapDirection"/>
               <xsl:if test="$theme">
                  <xsl:call-template name="processBootstrapAttrSetReflection">
                     <xsl:with-param name="attrSet" select="concat('__bg__', $theme, '-subtle')"/>
                  </xsl:call-template>
               </xsl:if>
               <fo:block>
                  <xsl:call-template name="processBootstrapDirection"/>
                  <xsl:apply-templates select="node() except (
                     $title |
                     $top-images |
                     $header |
                     $footer |
                     processing-instruction('ditaot')
                  )"/>
               </fo:block>
            </fo:table-cell>
          </fo:table-row>

          <!-- 5. Card Footer Row -->
          <xsl:if test="$footer">
            <fo:table-row>
              <fo:table-cell padding="8pt 15pt" background-color="#f8f9fa" border-top="1pt solid #dee2e6">
                 <xsl:call-template name="processBootstrapDirection"/>
                 <fo:block>
                    <xsl:call-template name="processBootstrapDirection"/>
                    <xsl:apply-templates select="$footer"/>
                 </fo:block>
              </fo:table-cell>
            </fo:table-row>
          </xsl:if>

        </fo:table-body>
      </fo:table>
  </xsl:template>

  <!-- Card Title specialized rendering (Removes extra section margins) -->
  <xsl:template match="*[contains(@class, ' bootstrap-d/card ') or (tokenize(@outputclass, ' ') = 'card' and (contains(@class, ' topic/section ') or contains(@class, ' topic/div ') or contains(@class, ' topic/bodydiv ')))]/*[contains(@class, ' topic/title ')]" priority="5">
    <fo:block font-size="14pt" font-weight="bold" margin-bottom="8pt">
       <xsl:call-template name="processBootstrapDirection"/>
                <xsl:apply-templates/>
             </fo:block>
  </xsl:template>

  <!-- Card Images (Ensure 100% width scaling within the row) -->
  <xsl:template match="*[contains(@class, ' bootstrap-d/card ') or (tokenize(@outputclass, ' ') = 'card' and (contains(@class, ' topic/section ') or contains(@class, ' topic/div ') or contains(@class, ' topic/bodydiv ')))]//*[contains(@class, ' topic/image ')]" priority="5">
    <fo:block text-align="center">
      <xsl:call-template name="processBootstrapDirection"/>
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

  <!-- Card Header/Footer internal blocks -->
  <xsl:template match="*[contains(@class, ' bootstrap-d/card-header ') or contains(@outputclass, 'card-header')]" priority="5">
     <fo:block font-weight="bold">
        <xsl:call-template name="processBootstrapDirection"/>
        <xsl:apply-templates/>
     </fo:block>
  </xsl:template>

</xsl:stylesheet>

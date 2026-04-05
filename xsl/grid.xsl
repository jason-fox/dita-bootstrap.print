<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:fo="http://www.w3.org/1999/XSL/Format"
                xmlns:fox="http://xmlgraphics.apache.org/fop/extensions"
                version="2.0">

  <!-- Grid Row Handling -->
  <!-- A grid-row is a table of one row with 12 columns. -->
  <xsl:template match="*[contains(@class, ' bootstrap-d/grid-row ')]" priority="5">
    <fo:table table-layout="fixed" width="100%" space-before="10pt" space-after="10pt">
      <xsl:call-template name="commonattributes"/>
      <xsl:call-template name="processBootstrapDirection"/>
      
      <!-- Table Stacking Trick: Inherit indentation from parent -->
      <xsl:attribute name="start-indent">inherited-property-value(start-indent)</xsl:attribute>
      
      <!-- Define exactly 12 columns as per Bootstrap grid system -->
      <fo:table-column column-width="proportional-column-width(1)"/>
      <fo:table-column column-width="proportional-column-width(1)"/>
      <fo:table-column column-width="proportional-column-width(1)"/>
      <fo:table-column column-width="proportional-column-width(1)"/>
      <fo:table-column column-width="proportional-column-width(1)"/>
      <fo:table-column column-width="proportional-column-width(1)"/>
      <fo:table-column column-width="proportional-column-width(1)"/>
      <fo:table-column column-width="proportional-column-width(1)"/>
      <fo:table-column column-width="proportional-column-width(1)"/>
      <fo:table-column column-width="proportional-column-width(1)"/>
      <fo:table-column column-width="proportional-column-width(1)"/>
      <fo:table-column column-width="proportional-column-width(1)"/>
      
      <fo:table-body>
        <fo:table-row>
          <xsl:call-template name="processBootstrapDirection"/>
          <xsl:apply-templates/>
        </fo:table-row>
      </fo:table-body>
    </fo:table>
  </xsl:template>

  <!-- Grid Column Handling -->
  <xsl:template match="*[contains(@class, ' bootstrap-d/grid-col ')]" priority="5">
    <fo:table-cell>
      <xsl:call-template name="commonattributes"/>
      <xsl:call-template name="processBootstrapDirection"/>
      
      <!-- Spanning logic: Use @colspan if defined, else assign equally among siblings -->
      <xsl:variable name="col-count" select="count(../*[contains(@class, ' bootstrap-d/grid-col ')])"/>
      <xsl:attribute name="number-columns-spanned">
        <xsl:choose>
          <xsl:when test="@colspan">
            <xsl:value-of select="@colspan"/>
          </xsl:when>
          <xsl:otherwise>
            <xsl:value-of select="12 idiv $col-count"/>
          </xsl:otherwise>
        </xsl:choose>
      </xsl:attribute>

      <!-- Standard Bootstrap-like gutter padding -->
      <xsl:attribute name="padding-left">12pt</xsl:attribute>
      <xsl:attribute name="padding-right">12pt</xsl:attribute>

      <fo:block start-indent="0pt">
        <xsl:call-template name="processBootstrapDirection"/>
        <xsl:apply-templates/>
      </fo:block>
    </fo:table-cell>
  </xsl:template>

  <!-- Suppress non-grid content inside grid-row table cells if needed, 
       but currently grid-row content allows %bodydiv; and %div; directly.
       If they are children, they will behave like full-span or fall-through?
       Actually, grid-row template uses a single fo:table-row and 
       apply-templates. If a child is not a grid-col, it will break FO table rules!
  -->
  <xsl:template match="*[contains(@class, ' bootstrap-d/grid-row ')]/*[not(contains(@class, ' bootstrap-d/grid-col '))]" priority="5">
     <!-- Should we wrap non-grid-col components in a full-width cell? -->
     <fo:table-cell number-columns-spanned="12" padding-left="12pt" padding-right="12pt">
        <fo:block start-indent="0pt">
           <xsl:apply-templates select="."/>
        </fo:block>
     </fo:table-cell>
  </xsl:template>

</xsl:stylesheet>

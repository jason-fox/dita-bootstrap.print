<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:fo="http://www.w3.org/1999/XSL/Format"
                xmlns:xs="http://www.w3.org/2001/XMLSchema"
                xmlns:dita-ot="http://dita-ot.sourceforge.net/ns/201007/dita-ot"
                exclude-result-prefixes="xs dita-ot"
                version="2.0">

  <!-- 
    Table Support for Bootstrap Print
    
    Theming Hierarchy: Entry > Row > thead > Table
    
    When <table color="primary"> is set:
    - thead row takes primary color (like badge)
    - tbody rows take primary-subtle color (like alert)
    - borders (if present) also take primary color
    
    When <thead color="xxx"> is set:
    - thead row takes the specified color, overriding table color.
    
    When <table striped="yes"> is set:
    - Only even rows in the body take the background color.
    
    When <table striped-columns="yes"> is set:
    - Only even columns in the body take the background color.
    
    When <table divider="yes"> is set:
    - A thicker border (2pt) is applied between table groups (thead, tbody, tfoot).
  -->

  <!-- 1. Table Header Row Styling -->
  <xsl:template match="*[contains(@class, ' topic/thead ')]/*[contains(@class, ' topic/row ')]" priority="5">
    <fo:table-row xsl:use-attribute-sets="thead.row">
      <xsl:call-template name="commonattributes"/>
      
      <!-- Preference: row/@color > thead/@color > table/@color -->
      <xsl:variable name="theme" select="(@color, 
                                          parent::*[contains(@class, ' topic/thead ')]/@color, 
                                          ancestor::*[contains(@class, ' topic/table ')][1]/@color)[1]"/>
      
      <xsl:if test="$theme">
        <!-- Header takes the main theme color (solid background) -->
        <xsl:call-template name="processBootstrapAttrSetReflection">
          <xsl:with-param name="attrSet" select="concat('__bg__', $theme)"/>
        </xsl:call-template>
        <!-- Ensure high-contrast text color for header -->
        <xsl:call-template name="processBootstrapAttrSetReflection">
          <xsl:with-param name="attrSet" select="concat('__color__', if ($theme = 'warning' or $theme = 'light') then 'dark' else 'white')"/>
        </xsl:call-template>
      </xsl:if>
      
      <xsl:apply-templates/>
    </fo:table-row>
  </xsl:template>

  <!-- 2. Table Body Row Styling -->
  <xsl:template match="*[contains(@class, ' topic/tbody ')]/*[contains(@class, ' topic/row ')]" priority="5">
    <fo:table-row xsl:use-attribute-sets="tbody.row">
      <xsl:call-template name="commonattributes"/>

      <xsl:variable name="rowTheme" select="@color"/>
      <xsl:variable name="table" select="ancestor::*[contains(@class, ' topic/table ')][1]"/>
      <xsl:variable name="tableTheme" select="$table/@color"/>
      <xsl:variable name="striped" select="$table/@striped = 'yes'"/>
      
      <xsl:variable name="rowIndex" select="count(preceding-sibling::*[contains(@class, ' topic/row ')]) + 1"/>
      <xsl:variable name="isColoredRow" select="not($striped) or ($rowIndex mod 2 = 0)"/>
      
      <xsl:choose>
        <!-- Row-specific color always wins -->
        <xsl:when test="$rowTheme">
          <xsl:call-template name="processBootstrapAttrSetReflection">
            <xsl:with-param name="attrSet" select="concat('__bg__', $rowTheme, '-subtle')"/>
          </xsl:call-template>
        </xsl:when>
        <!-- Table-level color or row-striping -->
        <xsl:when test="$isColoredRow">
          <xsl:choose>
            <xsl:when test="$tableTheme">
              <xsl:call-template name="processBootstrapAttrSetReflection">
                <xsl:with-param name="attrSet" select="concat('__bg__', $tableTheme, '-subtle')"/>
              </xsl:call-template>
            </xsl:when>
            <xsl:when test="$striped">
              <xsl:call-template name="processBootstrapAttrSetReflection">
                <xsl:with-param name="attrSet" select="'table-striped'"/>
              </xsl:call-template>
            </xsl:when>
          </xsl:choose>
        </xsl:when>
      </xsl:choose>

      <xsl:apply-templates/>
    </fo:table-row>
  </xsl:template>
  
  <!-- 3. Entry styling to handle border colors, cell backgrounds, striping and dividends -->
  <xsl:template match="*[contains(@class, ' topic/entry ')]" priority="5">
    <xsl:variable name="isHeader" select="parent::*[contains(@class, ' topic/row ')]/parent::*[contains(@class, ' topic/thead ')]"/>
    <xsl:variable name="isFooter" select="parent::*[contains(@class, ' topic/row ')]/parent::*[contains(@class, ' topic/tfoot ')]"/>
    <xsl:variable name="table" select="ancestor::*[contains(@class, ' topic/table ')][1]"/>
    <xsl:variable name="tableTheme" select="$table/@color"/>
    <xsl:variable name="stripedCols" select="$table/@striped-columns = 'yes'"/>
    
    <xsl:variable name="colIndex" select="if (@dita-ot:x) then xs:integer(@dita-ot:x) else 0"/>
    <xsl:variable name="isColoredCol" select="$stripedCols and ($colIndex mod 2 = 0) and not($isHeader) and not($isFooter)"/>
    
    <xsl:variable name="isGroupDivider" select="$table/@divider = 'yes' and not(parent::*/preceding-sibling::*[contains(@class, ' topic/row ')]) and (parent::*/parent::*[contains(@class, ' topic/tbody ')] or parent::*/parent::*[contains(@class, ' topic/tfoot ')])"/>

    <fo:table-cell>
      <xsl:call-template name="commonattributes"/>
      
      <!-- Apply Standard PDF2 Attribute Sets -->
      <xsl:choose>
        <xsl:when test="$isHeader">
          <xsl:call-template name="get-attributes">
            <xsl:with-param name="element" as="element()">
              <placeholder xsl:use-attribute-sets="thead.row.entry"/>
            </xsl:with-param>
          </xsl:call-template>
        </xsl:when>
        <xsl:otherwise>
          <xsl:choose>
            <xsl:when test="$table/@rowheader = 'firstcol' and @dita-ot:x = '1'">
              <xsl:call-template name="get-attributes">
                <xsl:with-param name="element" as="element()">
                  <placeholder xsl:use-attribute-sets="tbody.row.entry__firstcol"/>
                </xsl:with-param>
              </xsl:call-template>
            </xsl:when>
            <xsl:otherwise>
              <xsl:call-template name="get-attributes">
                <xsl:with-param name="element" as="element()">
                  <placeholder xsl:use-attribute-sets="tbody.row.entry"/>
                </xsl:with-param>
              </xsl:call-template>
            </xsl:otherwise>
          </xsl:choose>
        </xsl:otherwise>
      </xsl:choose>
      
      <xsl:call-template name="applySpansAttrs"/>
      <xsl:call-template name="applyAlignAttrs"/>
      <xsl:call-template name="generateTableEntryBorder"/>
      
      <!-- 4. Theme Border Color (Typically follows the table theme) -->
      <xsl:if test="$tableTheme">
        <xsl:call-template name="processBootstrapAttrSetReflection">
          <xsl:with-param name="attrSet" select="concat('border-', $tableTheme)"/>
        </xsl:call-template>
      </xsl:if>
      
      <!-- 5. Group Divider (Thicker border between table groups) -->
      <xsl:if test="$isGroupDivider">
        <xsl:attribute name="border-top-width">2pt</xsl:attribute>
      </xsl:if>
      
      <!-- 5. Cell-level color or column striping -->
      <xsl:choose>
        <!-- Entry-specific color wins -->
        <xsl:when test="@color">
           <xsl:call-template name="processBootstrapAttrSetReflection">
             <xsl:with-param name="attrSet" select="concat('__bg__', @color, if ($isHeader) then '' else '-subtle')"/>
           </xsl:call-template>
           <xsl:if test="$isHeader">
               <xsl:call-template name="processBootstrapAttrSetReflection">
                 <xsl:with-param name="attrSet" select="concat('__color__', if (@color = 'warning' or @color = 'light') then 'dark' else 'white')"/>
               </xsl:call-template>
           </xsl:if>
        </xsl:when>
        <!-- Column Striping (applied if cell has no theme color) -->
        <xsl:when test="$isColoredCol">
           <xsl:choose>
            <xsl:when test="$tableTheme">
              <xsl:call-template name="processBootstrapAttrSetReflection">
                <xsl:with-param name="attrSet" select="concat('__bg__', $tableTheme, '-subtle')"/>
              </xsl:call-template>
            </xsl:when>
            <xsl:otherwise>
              <xsl:call-template name="processBootstrapAttrSetReflection">
                <xsl:with-param name="attrSet" select="'table-striped'"/>
              </xsl:call-template>
            </xsl:otherwise>
          </xsl:choose>
        </xsl:when>
      </xsl:choose>
      
      <!-- 6. Content -->
      <xsl:choose>
        <xsl:when test="@rotate eq '1'">
          <fo:block-container reference-orientation="90">
            <fo:block>
              <xsl:call-template name="get-attributes">
                <xsl:with-param name="element" as="element()">
                  <xsl:choose>
                    <xsl:when test="$isHeader"><placeholder xsl:use-attribute-sets="thead.row.entry__content"/></xsl:when>
                    <xsl:otherwise><placeholder xsl:use-attribute-sets="tbody.row.entry__content"/></xsl:otherwise>
                  </xsl:choose>
                </xsl:with-param>
              </xsl:call-template>
              <xsl:call-template name="processEntryContent"/>
            </fo:block>
          </fo:block-container>
        </xsl:when>
        <xsl:otherwise>
          <fo:block>
            <xsl:call-template name="get-attributes">
              <xsl:with-param name="element" as="element()">
                <xsl:choose>
                  <xsl:when test="$isHeader"><placeholder xsl:use-attribute-sets="thead.row.entry__content"/></xsl:when>
                  <xsl:otherwise><placeholder xsl:use-attribute-sets="tbody.row.entry__content"/></xsl:otherwise>
                </xsl:choose>
              </xsl:with-param>
            </xsl:call-template>
            <xsl:call-template name="processEntryContent"/>
          </fo:block>
        </xsl:otherwise>
      </xsl:choose>
    </fo:table-cell>
  </xsl:template>

</xsl:stylesheet>

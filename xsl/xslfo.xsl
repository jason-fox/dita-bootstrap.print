<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:xs="http://www.w3.org/2001/XMLSchema"
                xmlns:fo="http://www.w3.org/1999/XSL/Format"
                xmlns:fox="http://xmlgraphics.apache.org/fop/extensions"
                exclude-result-prefixes="xs fox"
                version="2.0">

  <!-- Core Attribute Sets and Utility Functions -->
  <xsl:import href="../cfg/fo/attrs/bootstrap-attr.xsl"/>
  
  <!-- Shared Utilities (Refactored logic) -->
  <xsl:include href="utility-classes.xsl"/>

  <!-- Component Specific Modules -->
  <xsl:include href="accordion.xsl"/>
  <xsl:include href="alert.xsl"/>
  <xsl:include href="button.xsl"/>
  <xsl:include href="badge.xsl"/>
  <xsl:include href="card.xsl"/>
  <xsl:include href="carousel.xsl"/>
  <xsl:include href="figure.xsl"/>
  <xsl:include href="grid.xsl"/>
  <xsl:include href="icon.xsl"/>
  <xsl:include href="list-group.xsl"/>
  <xsl:include href="note.xsl"/>
  <xsl:include href="tables.xsl"/>

</xsl:stylesheet>

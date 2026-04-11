<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:fo="http://www.w3.org/1999/XSL/Format"
  xmlns:fox="http://xmlgraphics.apache.org/fop/extensions"
  version="2.0"
>

  <xsl:import href="default-values.xsl"/>
  <xsl:import href="settings-map.xsl"/>

  <!-- Standard Bootstrap Text Colors -->
  <xsl:attribute-set name="__color__primary">
    <xsl:attribute name="color"><xsl:value-of select="$bootstrap-primary"/></xsl:attribute>
  </xsl:attribute-set>
  <xsl:attribute-set name="__color__secondary">
    <xsl:attribute name="color"><xsl:value-of select="$bootstrap-secondary"/></xsl:attribute>
  </xsl:attribute-set>
  <xsl:attribute-set name="__color__success">
    <xsl:attribute name="color"><xsl:value-of select="$bootstrap-success"/></xsl:attribute>
  </xsl:attribute-set>
  <xsl:attribute-set name="__color__danger">
    <xsl:attribute name="color"><xsl:value-of select="$bootstrap-danger"/></xsl:attribute>
  </xsl:attribute-set>
  <xsl:attribute-set name="__color__warning">
    <xsl:attribute name="color"><xsl:value-of select="$bootstrap-warning"/></xsl:attribute>
  </xsl:attribute-set>
  <xsl:attribute-set name="__color__info">
    <xsl:attribute name="color"><xsl:value-of select="$bootstrap-info"/></xsl:attribute>
  </xsl:attribute-set>
  <xsl:attribute-set name="__color__light">
    <xsl:attribute name="color"><xsl:value-of select="$bootstrap-light"/></xsl:attribute>
  </xsl:attribute-set>
  <xsl:attribute-set name="__color__dark">
    <xsl:attribute name="color"><xsl:value-of select="$bootstrap-dark"/></xsl:attribute>
  </xsl:attribute-set>
  <xsl:attribute-set name="common.link">
    <xsl:attribute name="color">
      <xsl:choose>
        <xsl:when test="@color and local-name() = 'xref'">
          <xsl:variable name="explicitVar" select="concat('bootstrap-', @color)"/>
          <xsl:choose>
            <xsl:when test="$bootstrap-settings/entry[@name = $explicitVar]">
              <xsl:value-of select="$bootstrap-settings/entry[@name = $explicitVar]"/>
            </xsl:when>
            <xsl:otherwise><xsl:value-of select="@color"/></xsl:otherwise>
          </xsl:choose>
        </xsl:when>
        <xsl:otherwise>
          <xsl:variable name="theme">
        <xsl:choose>
          <xsl:when test="ancestor::*[contains(@class, ' topic/note ')]/@color"><xsl:value-of select="ancestor::*[contains(@class, ' topic/note ')]/@color"/></xsl:when>
          <xsl:when test="ancestor::*[contains(@class, ' topic/note ')]">
            <xsl:variable name="type" select="(ancestor::*[contains(@class, ' topic/note ')]/@type, 'note')[1]"/>
            <xsl:choose>
              <xsl:when test="$type = 'note' or $type = 'notice' or $type = 'remember'">info</xsl:when>
              <xsl:when test="$type = 'tip' or $type = 'fastpath'">success</xsl:when>
              <xsl:when test="$type = 'important'">primary</xsl:when>
              <xsl:when test="$type = 'warning' or $type = 'caution' or $type = 'restriction' or $type = 'trouble'">warning</xsl:when>
              <xsl:when test="$type = 'danger'">danger</xsl:when>
              <xsl:otherwise>secondary</xsl:otherwise>
            </xsl:choose>
          </xsl:when>
          <xsl:when test="ancestor::*[contains(@class, ' bootstrap-d/alert ')]"><xsl:value-of select="(ancestor::*[contains(@class, ' bootstrap-d/alert ')]/@color, 'secondary')[1]"/></xsl:when>
          <xsl:when test="ancestor::*[contains(@class, ' bootstrap-d/card ') or tokenize(@outputclass, ' ') = 'card']"><xsl:value-of select="ancestor::*[contains(@class, ' bootstrap-d/card ') or tokenize(@outputclass, ' ') = 'card']/@color"/></xsl:when>
          <xsl:when test="ancestor::*[contains(@class, ' topic/section ') or contains(@class, ' topic/div ') or contains(@class, ' topic/bodydiv ')]"><xsl:value-of select="ancestor::*[contains(@class, ' topic/section ') or contains(@class, ' topic/div ') or contains(@class, ' topic/bodydiv ')][1]/@color"/></xsl:when>
        </xsl:choose>
      </xsl:variable>
      <xsl:choose>
        <xsl:when test="$theme != ''">
          <xsl:variable name="subtleVar" select="concat('bootstrap-', $theme, '-subtle-text')"/>
          <xsl:value-of select="$bootstrap-settings/entry[@name = $subtleVar]"/>
        </xsl:when>
        <xsl:otherwise>
          <xsl:value-of select="$bootstrap-link"/>
        </xsl:otherwise>
      </xsl:choose>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:attribute>
    <xsl:attribute name="text-decoration">
      <xsl:choose>
        <xsl:when test="@color and local-name() = 'xref'">underline</xsl:when>
        <xsl:otherwise>
          <xsl:variable name="theme">
            <xsl:choose>
              <xsl:when test="ancestor::*[contains(@class, ' topic/note ')]/@color"><xsl:value-of select="ancestor::*[contains(@class, ' topic/note ')]/@color"/></xsl:when>
              <xsl:when test="ancestor::*[contains(@class, ' topic/note ')]">
                <xsl:variable name="type" select="(ancestor::*[contains(@class, ' topic/note ')]/@type, 'note')[1]"/>
                <xsl:choose>
                  <xsl:when test="$type = 'note' or $type = 'notice' or $type = 'remember'">info</xsl:when>
                  <xsl:when test="$type = 'tip' or $type = 'fastpath'">success</xsl:when>
                  <xsl:when test="$type = 'important'">primary</xsl:when>
                  <xsl:when test="$type = 'warning' or $type = 'caution' or $type = 'restriction' or $type = 'trouble'">warning</xsl:when>
                  <xsl:when test="$type = 'danger'">danger</xsl:when>
                  <xsl:otherwise>secondary</xsl:otherwise>
                </xsl:choose>
              </xsl:when>
              <xsl:when test="ancestor::*[contains(@class, ' bootstrap-d/alert ')]"><xsl:value-of select="(ancestor::*[contains(@class, ' bootstrap-d/alert ')]/@color, 'secondary')[1]"/></xsl:when>
              <xsl:when test="ancestor::*[contains(@class, ' bootstrap-d/card ') or tokenize(@outputclass, ' ') = 'card']"><xsl:value-of select="ancestor::*[contains(@class, ' bootstrap-d/card ') or tokenize(@outputclass, ' ') = 'card']/@color"/></xsl:when>
              <xsl:when test="ancestor::*[contains(@class, ' topic/section ') or contains(@class, ' topic/div ') or contains(@class, ' topic/bodydiv ')]"><xsl:value-of select="ancestor::*[contains(@class, ' topic/section ') or contains(@class, ' topic/div ') or contains(@class, ' topic/bodydiv ')][1]/@color"/></xsl:when>
            </xsl:choose>
          </xsl:variable>
          <xsl:choose>
            <xsl:when test="$theme != ''">underline</xsl:when>
            <xsl:otherwise>none</xsl:otherwise>
          </xsl:choose>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:attribute>
  </xsl:attribute-set>

  <!-- Standard Bootstrap Background Colors -->
  <xsl:attribute-set name="__bg__primary">
    <xsl:attribute name="background-color"><xsl:value-of select="$bootstrap-primary"/></xsl:attribute>
    <xsl:attribute name="color"><xsl:value-of select="$bootstrap-btn-primary-color"/></xsl:attribute>
  </xsl:attribute-set>
  <xsl:attribute-set name="__bg__secondary">
    <xsl:attribute name="background-color"><xsl:value-of select="$bootstrap-secondary"/></xsl:attribute>
    <xsl:attribute name="color"><xsl:value-of select="$bootstrap-btn-secondary-color"/></xsl:attribute>
  </xsl:attribute-set>
  <xsl:attribute-set name="__bg__success">
    <xsl:attribute name="background-color"><xsl:value-of select="$bootstrap-success"/></xsl:attribute>
    <xsl:attribute name="color"><xsl:value-of select="$bootstrap-btn-success-color"/></xsl:attribute>
  </xsl:attribute-set>
  <xsl:attribute-set name="__bg__danger">
    <xsl:attribute name="background-color"><xsl:value-of select="$bootstrap-danger"/></xsl:attribute>
    <xsl:attribute name="color"><xsl:value-of select="$bootstrap-btn-danger-color"/></xsl:attribute>
  </xsl:attribute-set>
  <xsl:attribute-set name="__bg__warning">
    <xsl:attribute name="background-color"><xsl:value-of select="$bootstrap-warning"/></xsl:attribute>
    <xsl:attribute name="color"><xsl:value-of select="$bootstrap-btn-warning-color"/></xsl:attribute>
  </xsl:attribute-set>
  <xsl:attribute-set name="__bg__info">
    <xsl:attribute name="background-color"><xsl:value-of select="$bootstrap-info"/></xsl:attribute>
    <xsl:attribute name="color"><xsl:value-of select="$bootstrap-btn-info-color"/></xsl:attribute>
  </xsl:attribute-set>
  <xsl:attribute-set name="__bg__light">
    <xsl:attribute name="background-color"><xsl:value-of select="$bootstrap-light"/></xsl:attribute>
    <xsl:attribute name="color"><xsl:value-of select="$bootstrap-btn-light-color"/></xsl:attribute>
  </xsl:attribute-set>
  <xsl:attribute-set name="__bg__dark">
    <xsl:attribute name="background-color"><xsl:value-of select="$bootstrap-dark"/></xsl:attribute>
    <xsl:attribute name="color"><xsl:value-of select="$bootstrap-btn-dark-color"/></xsl:attribute>
  </xsl:attribute-set>
  <!-- Subtle Background Colors (for Alerts, Callouts, etc.) -->
  <xsl:attribute-set name="__bg__primary-subtle">
    <xsl:attribute name="background-color"><xsl:value-of select="$bootstrap-primary-subtle"/></xsl:attribute>
    <xsl:attribute name="color"><xsl:value-of select="$bootstrap-primary-subtle-text"/></xsl:attribute>
  </xsl:attribute-set>
  <xsl:attribute-set name="__bg__secondary-subtle">
    <xsl:attribute name="background-color"><xsl:value-of select="$bootstrap-secondary-subtle"/></xsl:attribute>
    <xsl:attribute name="color"><xsl:value-of select="$bootstrap-secondary-subtle-text"/></xsl:attribute>
  </xsl:attribute-set>
  <xsl:attribute-set name="__bg__success-subtle">
    <xsl:attribute name="background-color"><xsl:value-of select="$bootstrap-success-subtle"/></xsl:attribute>
    <xsl:attribute name="color"><xsl:value-of select="$bootstrap-success-subtle-text"/></xsl:attribute>
  </xsl:attribute-set>
  <xsl:attribute-set name="__bg__danger-subtle">
    <xsl:attribute name="background-color"><xsl:value-of select="$bootstrap-danger-subtle"/></xsl:attribute>
    <xsl:attribute name="color"><xsl:value-of select="$bootstrap-danger-subtle-text"/></xsl:attribute>
  </xsl:attribute-set>
  <xsl:attribute-set name="__bg__warning-subtle">
    <xsl:attribute name="background-color"><xsl:value-of select="$bootstrap-warning-subtle"/></xsl:attribute>
    <xsl:attribute name="color"><xsl:value-of select="$bootstrap-warning-subtle-text"/></xsl:attribute>
  </xsl:attribute-set>
  <xsl:attribute-set name="__bg__info-subtle">
    <xsl:attribute name="background-color"><xsl:value-of select="$bootstrap-info-subtle"/></xsl:attribute>
    <xsl:attribute name="color"><xsl:value-of select="$bootstrap-info-subtle-text"/></xsl:attribute>
  </xsl:attribute-set>
  <xsl:attribute-set name="__bg__light-subtle">
    <xsl:attribute name="background-color"><xsl:value-of select="$bootstrap-light-subtle"/></xsl:attribute>
    <xsl:attribute name="color"><xsl:value-of select="$bootstrap-light-subtle-text"/></xsl:attribute>
  </xsl:attribute-set>
  <xsl:attribute-set name="__bg__dark-subtle">
    <xsl:attribute name="background-color"><xsl:value-of select="$bootstrap-dark-subtle"/></xsl:attribute>
    <xsl:attribute name="color"><xsl:value-of select="$bootstrap-dark-subtle-text"/></xsl:attribute>
  </xsl:attribute-set>

  <!-- Component-Specific Backgrounds: Tables -->
  <xsl:attribute-set name="__table__primary">
    <xsl:attribute name="background-color"><xsl:value-of select="$bootstrap-table-primary-bg"/></xsl:attribute>
    <xsl:attribute name="color"><xsl:value-of select="$bootstrap-table-primary-color"/></xsl:attribute>
  </xsl:attribute-set>
  <xsl:attribute-set name="__table__secondary">
    <xsl:attribute name="background-color"><xsl:value-of select="$bootstrap-table-secondary-bg"/></xsl:attribute>
    <xsl:attribute name="color"><xsl:value-of select="$bootstrap-table-secondary-color"/></xsl:attribute>
  </xsl:attribute-set>
  <xsl:attribute-set name="__table__success">
    <xsl:attribute name="background-color"><xsl:value-of select="$bootstrap-table-success-bg"/></xsl:attribute>
    <xsl:attribute name="color"><xsl:value-of select="$bootstrap-table-success-color"/></xsl:attribute>
  </xsl:attribute-set>
  <xsl:attribute-set name="__table__info">
    <xsl:attribute name="background-color"><xsl:value-of select="$bootstrap-table-info-bg"/></xsl:attribute>
    <xsl:attribute name="color"><xsl:value-of select="$bootstrap-table-info-color"/></xsl:attribute>
  </xsl:attribute-set>
  <xsl:attribute-set name="__table__warning">
    <xsl:attribute name="background-color"><xsl:value-of select="$bootstrap-table-warning-bg"/></xsl:attribute>
    <xsl:attribute name="color"><xsl:value-of select="$bootstrap-table-warning-color"/></xsl:attribute>
  </xsl:attribute-set>
  <xsl:attribute-set name="__table__danger">
    <xsl:attribute name="background-color"><xsl:value-of select="$bootstrap-table-danger-bg"/></xsl:attribute>
    <xsl:attribute name="color"><xsl:value-of select="$bootstrap-table-danger-color"/></xsl:attribute>
  </xsl:attribute-set>
  <xsl:attribute-set name="__table__light">
    <xsl:attribute name="background-color"><xsl:value-of select="$bootstrap-table-light-bg"/></xsl:attribute>
    <xsl:attribute name="color"><xsl:value-of select="$bootstrap-table-light-color"/></xsl:attribute>
  </xsl:attribute-set>
  <xsl:attribute-set name="__table__dark">
    <xsl:attribute name="background-color"><xsl:value-of select="$bootstrap-table-dark-bg"/></xsl:attribute>
    <xsl:attribute name="color"><xsl:value-of select="$bootstrap-table-dark-color"/></xsl:attribute>
  </xsl:attribute-set>

  <!-- Component-Specific Backgrounds: Buttons -->
  <xsl:attribute-set name="__btn__primary">
    <xsl:attribute name="background-color"><xsl:value-of select="$bootstrap-btn-primary-bg"/></xsl:attribute>
    <xsl:attribute name="color"><xsl:value-of select="$bootstrap-btn-primary-color"/></xsl:attribute>
    <xsl:attribute name="border-color"><xsl:value-of select="$bootstrap-btn-primary-bg"/></xsl:attribute>
  </xsl:attribute-set>
  <xsl:attribute-set name="__btn__secondary">
    <xsl:attribute name="background-color"><xsl:value-of select="$bootstrap-btn-secondary-bg"/></xsl:attribute>
    <xsl:attribute name="color"><xsl:value-of select="$bootstrap-btn-secondary-color"/></xsl:attribute>
    <xsl:attribute name="border-color"><xsl:value-of select="$bootstrap-btn-secondary-bg"/></xsl:attribute>
  </xsl:attribute-set>
  <xsl:attribute-set name="__btn__success">
    <xsl:attribute name="background-color"><xsl:value-of select="$bootstrap-btn-success-bg"/></xsl:attribute>
    <xsl:attribute name="color"><xsl:value-of select="$bootstrap-btn-success-color"/></xsl:attribute>
    <xsl:attribute name="border-color"><xsl:value-of select="$bootstrap-btn-success-bg"/></xsl:attribute>
  </xsl:attribute-set>
  <xsl:attribute-set name="__btn__info">
    <xsl:attribute name="background-color"><xsl:value-of select="$bootstrap-btn-info-bg"/></xsl:attribute>
    <xsl:attribute name="color"><xsl:value-of select="$bootstrap-btn-info-color"/></xsl:attribute>
    <xsl:attribute name="border-color"><xsl:value-of select="$bootstrap-btn-info-bg"/></xsl:attribute>
  </xsl:attribute-set>
  <xsl:attribute-set name="__btn__warning">
    <xsl:attribute name="background-color"><xsl:value-of select="$bootstrap-btn-warning-bg"/></xsl:attribute>
    <xsl:attribute name="color"><xsl:value-of select="$bootstrap-btn-warning-color"/></xsl:attribute>
    <xsl:attribute name="border-color"><xsl:value-of select="$bootstrap-btn-warning-bg"/></xsl:attribute>
  </xsl:attribute-set>
  <xsl:attribute-set name="__btn__danger">
    <xsl:attribute name="background-color"><xsl:value-of select="$bootstrap-btn-danger-bg"/></xsl:attribute>
    <xsl:attribute name="color"><xsl:value-of select="$bootstrap-btn-danger-color"/></xsl:attribute>
    <xsl:attribute name="border-color"><xsl:value-of select="$bootstrap-btn-danger-bg"/></xsl:attribute>
  </xsl:attribute-set>
  <xsl:attribute-set name="__btn__light">
    <xsl:attribute name="background-color"><xsl:value-of select="$bootstrap-btn-light-bg"/></xsl:attribute>
    <xsl:attribute name="color"><xsl:value-of select="$bootstrap-btn-light-color"/></xsl:attribute>
    <xsl:attribute name="border-color"><xsl:value-of select="$bootstrap-btn-light-bg"/></xsl:attribute>
  </xsl:attribute-set>
  <xsl:attribute-set name="__btn__dark">
    <xsl:attribute name="background-color"><xsl:value-of select="$bootstrap-btn-dark-bg"/></xsl:attribute>
    <xsl:attribute name="color"><xsl:value-of select="$bootstrap-btn-dark-color"/></xsl:attribute>
    <xsl:attribute name="border-color"><xsl:value-of select="$bootstrap-btn-dark-bg"/></xsl:attribute>
  </xsl:attribute-set>

  <!-- Component-Specific Backgrounds: Badges -->
  <xsl:attribute-set name="__badge__primary">
    <xsl:attribute name="background-color"><xsl:value-of select="$bootstrap-badge-primary-bg"/></xsl:attribute>
    <xsl:attribute name="color"><xsl:value-of select="$bootstrap-badge-primary-color"/></xsl:attribute>
  </xsl:attribute-set>
  <xsl:attribute-set name="__badge__secondary">
    <xsl:attribute name="background-color"><xsl:value-of select="$bootstrap-badge-secondary-bg"/></xsl:attribute>
    <xsl:attribute name="color"><xsl:value-of select="$bootstrap-badge-secondary-color"/></xsl:attribute>
  </xsl:attribute-set>
  <xsl:attribute-set name="__badge__success">
    <xsl:attribute name="background-color"><xsl:value-of select="$bootstrap-badge-success-bg"/></xsl:attribute>
    <xsl:attribute name="color"><xsl:value-of select="$bootstrap-badge-success-color"/></xsl:attribute>
  </xsl:attribute-set>
  <xsl:attribute-set name="__badge__info">
    <xsl:attribute name="background-color"><xsl:value-of select="$bootstrap-badge-info-bg"/></xsl:attribute>
    <xsl:attribute name="color"><xsl:value-of select="$bootstrap-badge-info-color"/></xsl:attribute>
  </xsl:attribute-set>
  <xsl:attribute-set name="__badge__warning">
    <xsl:attribute name="background-color"><xsl:value-of select="$bootstrap-badge-warning-bg"/></xsl:attribute>
    <xsl:attribute name="color"><xsl:value-of select="$bootstrap-badge-warning-color"/></xsl:attribute>
  </xsl:attribute-set>
  <xsl:attribute-set name="__badge__danger">
    <xsl:attribute name="background-color"><xsl:value-of select="$bootstrap-badge-danger-bg"/></xsl:attribute>
    <xsl:attribute name="color"><xsl:value-of select="$bootstrap-badge-danger-color"/></xsl:attribute>
  </xsl:attribute-set>
  <xsl:attribute-set name="__badge__light">
    <xsl:attribute name="background-color"><xsl:value-of select="$bootstrap-badge-light-bg"/></xsl:attribute>
    <xsl:attribute name="color"><xsl:value-of select="$bootstrap-badge-light-color"/></xsl:attribute>
  </xsl:attribute-set>
  <xsl:attribute-set name="__badge__dark">
    <xsl:attribute name="background-color"><xsl:value-of select="$bootstrap-badge-dark-bg"/></xsl:attribute>
    <xsl:attribute name="color"><xsl:value-of select="$bootstrap-badge-dark-color"/></xsl:attribute>
  </xsl:attribute-set>

  <!-- Standard Bootstrap Spacing (Padding) -->
  <xsl:attribute-set name="p-0"><xsl:attribute name="padding"><xsl:value-of
        select="$bootstrap-spacing-0"
      /></xsl:attribute></xsl:attribute-set>
  <xsl:attribute-set name="p-1"><xsl:attribute name="padding"><xsl:value-of
        select="$bootstrap-spacing-1"
      /></xsl:attribute></xsl:attribute-set>
  <xsl:attribute-set name="p-2"><xsl:attribute name="padding"><xsl:value-of
        select="$bootstrap-spacing-2"
      /></xsl:attribute></xsl:attribute-set>
  <xsl:attribute-set name="p-3"><xsl:attribute name="padding"><xsl:value-of
        select="$bootstrap-spacing-3"
      /></xsl:attribute></xsl:attribute-set>
  <xsl:attribute-set name="p-4"><xsl:attribute name="padding"><xsl:value-of
        select="$bootstrap-spacing-4"
      /></xsl:attribute></xsl:attribute-set>
  <xsl:attribute-set name="p-5"><xsl:attribute name="padding"><xsl:value-of
        select="$bootstrap-spacing-5"
      /></xsl:attribute></xsl:attribute-set>

  <xsl:attribute-set name="pt-0"><xsl:attribute name="padding-top"><xsl:value-of
        select="$bootstrap-spacing-0"
      /></xsl:attribute></xsl:attribute-set>
  <xsl:attribute-set name="pt-1"><xsl:attribute name="padding-top"><xsl:value-of
        select="$bootstrap-spacing-1"
      /></xsl:attribute></xsl:attribute-set>
  <xsl:attribute-set name="pt-2"><xsl:attribute name="padding-top"><xsl:value-of
        select="$bootstrap-spacing-2"
      /></xsl:attribute></xsl:attribute-set>
  <xsl:attribute-set name="pt-3"><xsl:attribute name="padding-top"><xsl:value-of
        select="$bootstrap-spacing-3"
      /></xsl:attribute></xsl:attribute-set>
  <xsl:attribute-set name="pt-4"><xsl:attribute name="padding-top"><xsl:value-of
        select="$bootstrap-spacing-4"
      /></xsl:attribute></xsl:attribute-set>
  <xsl:attribute-set name="pt-5"><xsl:attribute name="padding-top"><xsl:value-of
        select="$bootstrap-spacing-5"
      /></xsl:attribute></xsl:attribute-set>

  <xsl:attribute-set name="pb-0"><xsl:attribute name="padding-bottom"><xsl:value-of
        select="$bootstrap-spacing-0"
      /></xsl:attribute></xsl:attribute-set>
  <xsl:attribute-set name="pb-1"><xsl:attribute name="padding-bottom"><xsl:value-of
        select="$bootstrap-spacing-1"
      /></xsl:attribute></xsl:attribute-set>
  <xsl:attribute-set name="pb-2"><xsl:attribute name="padding-bottom"><xsl:value-of
        select="$bootstrap-spacing-2"
      /></xsl:attribute></xsl:attribute-set>
  <xsl:attribute-set name="pb-3"><xsl:attribute name="padding-bottom"><xsl:value-of
        select="$bootstrap-spacing-3"
      /></xsl:attribute></xsl:attribute-set>
  <xsl:attribute-set name="pb-4"><xsl:attribute name="padding-bottom"><xsl:value-of
        select="$bootstrap-spacing-4"
      /></xsl:attribute></xsl:attribute-set>
  <xsl:attribute-set name="pb-5"><xsl:attribute name="padding-bottom"><xsl:value-of
        select="$bootstrap-spacing-5"
      /></xsl:attribute></xsl:attribute-set>

  <xsl:attribute-set name="ps-0"><xsl:attribute name="padding-left"><xsl:value-of
        select="$bootstrap-spacing-0"
      /></xsl:attribute></xsl:attribute-set>
  <xsl:attribute-set name="ps-1"><xsl:attribute name="padding-left"><xsl:value-of
        select="$bootstrap-spacing-1"
      /></xsl:attribute></xsl:attribute-set>
  <xsl:attribute-set name="ps-2"><xsl:attribute name="padding-left"><xsl:value-of
        select="$bootstrap-spacing-2"
      /></xsl:attribute></xsl:attribute-set>
  <xsl:attribute-set name="ps-3"><xsl:attribute name="padding-left"><xsl:value-of
        select="$bootstrap-spacing-3"
      /></xsl:attribute></xsl:attribute-set>
  <xsl:attribute-set name="ps-4"><xsl:attribute name="padding-left"><xsl:value-of
        select="$bootstrap-spacing-4"
      /></xsl:attribute></xsl:attribute-set>
  <xsl:attribute-set name="ps-5"><xsl:attribute name="padding-left"><xsl:value-of
        select="$bootstrap-spacing-5"
      /></xsl:attribute></xsl:attribute-set>

  <xsl:attribute-set name="pe-0"><xsl:attribute name="padding-right"><xsl:value-of
        select="$bootstrap-spacing-0"
      /></xsl:attribute></xsl:attribute-set>
  <xsl:attribute-set name="pe-1"><xsl:attribute name="padding-right"><xsl:value-of
        select="$bootstrap-spacing-1"
      /></xsl:attribute></xsl:attribute-set>
  <xsl:attribute-set name="pe-2"><xsl:attribute name="padding-right"><xsl:value-of
        select="$bootstrap-spacing-2"
      /></xsl:attribute></xsl:attribute-set>
  <xsl:attribute-set name="pe-3"><xsl:attribute name="padding-right"><xsl:value-of
        select="$bootstrap-spacing-3"
      /></xsl:attribute></xsl:attribute-set>
  <xsl:attribute-set name="pe-4"><xsl:attribute name="padding-right"><xsl:value-of
        select="$bootstrap-spacing-4"
      /></xsl:attribute></xsl:attribute-set>
  <xsl:attribute-set name="pe-5"><xsl:attribute name="padding-right"><xsl:value-of
        select="$bootstrap-spacing-5"
      /></xsl:attribute></xsl:attribute-set>

  <xsl:attribute-set name="px-0"><xsl:attribute name="padding-left"><xsl:value-of
        select="$bootstrap-spacing-0"
      /></xsl:attribute><xsl:attribute name="padding-right"><xsl:value-of
        select="$bootstrap-spacing-0"
      /></xsl:attribute></xsl:attribute-set>
  <xsl:attribute-set name="px-1"><xsl:attribute name="padding-left"><xsl:value-of
        select="$bootstrap-spacing-1"
      /></xsl:attribute><xsl:attribute name="padding-right"><xsl:value-of
        select="$bootstrap-spacing-1"
      /></xsl:attribute></xsl:attribute-set>
  <xsl:attribute-set name="px-2"><xsl:attribute name="padding-left"><xsl:value-of
        select="$bootstrap-spacing-2"
      /></xsl:attribute><xsl:attribute name="padding-right"><xsl:value-of
        select="$bootstrap-spacing-2"
      /></xsl:attribute></xsl:attribute-set>
  <xsl:attribute-set name="px-3"><xsl:attribute name="padding-left"><xsl:value-of
        select="$bootstrap-spacing-3"
      /></xsl:attribute><xsl:attribute name="padding-right"><xsl:value-of
        select="$bootstrap-spacing-3"
      /></xsl:attribute></xsl:attribute-set>
  <xsl:attribute-set name="px-4"><xsl:attribute name="padding-left"><xsl:value-of
        select="$bootstrap-spacing-4"
      /></xsl:attribute><xsl:attribute name="padding-right"><xsl:value-of
        select="$bootstrap-spacing-4"
      /></xsl:attribute></xsl:attribute-set>
  <xsl:attribute-set name="px-5"><xsl:attribute name="padding-left"><xsl:value-of
        select="$bootstrap-spacing-5"
      /></xsl:attribute><xsl:attribute name="padding-right"><xsl:value-of
        select="$bootstrap-spacing-5"
      /></xsl:attribute></xsl:attribute-set>

  <xsl:attribute-set name="py-0"><xsl:attribute name="padding-top"><xsl:value-of
        select="$bootstrap-spacing-0"
      /></xsl:attribute><xsl:attribute name="padding-bottom"><xsl:value-of
        select="$bootstrap-spacing-0"
      /></xsl:attribute></xsl:attribute-set>
  <xsl:attribute-set name="py-1"><xsl:attribute name="padding-top"><xsl:value-of
        select="$bootstrap-spacing-1"
      /></xsl:attribute><xsl:attribute name="padding-bottom"><xsl:value-of
        select="$bootstrap-spacing-1"
      /></xsl:attribute></xsl:attribute-set>
  <xsl:attribute-set name="py-2"><xsl:attribute name="padding-top"><xsl:value-of
        select="$bootstrap-spacing-2"
      /></xsl:attribute><xsl:attribute name="padding-bottom"><xsl:value-of
        select="$bootstrap-spacing-2"
      /></xsl:attribute></xsl:attribute-set>
  <xsl:attribute-set name="py-3"><xsl:attribute name="padding-top"><xsl:value-of
        select="$bootstrap-spacing-3"
      /></xsl:attribute><xsl:attribute name="padding-bottom"><xsl:value-of
        select="$bootstrap-spacing-3"
      /></xsl:attribute></xsl:attribute-set>
  <xsl:attribute-set name="py-4"><xsl:attribute name="padding-top"><xsl:value-of
        select="$bootstrap-spacing-4"
      /></xsl:attribute><xsl:attribute name="padding-bottom"><xsl:value-of
        select="$bootstrap-spacing-4"
      /></xsl:attribute></xsl:attribute-set>
  <xsl:attribute-set name="py-5"><xsl:attribute name="padding-top"><xsl:value-of
        select="$bootstrap-spacing-5"
      /></xsl:attribute><xsl:attribute name="padding-bottom"><xsl:value-of
        select="$bootstrap-spacing-5"
      /></xsl:attribute></xsl:attribute-set>

  <!-- Standard Bootstrap Spacing (Margin) -->
  <xsl:attribute-set name="m-0"><xsl:attribute name="margin"><xsl:value-of
        select="$bootstrap-spacing-0"
      /></xsl:attribute></xsl:attribute-set>
  <xsl:attribute-set name="m-1"><xsl:attribute name="margin"><xsl:value-of
        select="$bootstrap-spacing-1"
      /></xsl:attribute></xsl:attribute-set>
  <xsl:attribute-set name="m-2"><xsl:attribute name="margin"><xsl:value-of
        select="$bootstrap-spacing-2"
      /></xsl:attribute></xsl:attribute-set>
  <xsl:attribute-set name="m-3"><xsl:attribute name="margin"><xsl:value-of
        select="$bootstrap-spacing-3"
      /></xsl:attribute></xsl:attribute-set>
  <xsl:attribute-set name="m-4"><xsl:attribute name="margin"><xsl:value-of
        select="$bootstrap-spacing-4"
      /></xsl:attribute></xsl:attribute-set>
  <xsl:attribute-set name="m-5"><xsl:attribute name="margin"><xsl:value-of
        select="$bootstrap-spacing-5"
      /></xsl:attribute></xsl:attribute-set>

  <xsl:attribute-set name="mt-0"><xsl:attribute name="margin-top"><xsl:value-of
        select="$bootstrap-spacing-0"
      /></xsl:attribute></xsl:attribute-set>
  <xsl:attribute-set name="mt-1"><xsl:attribute name="margin-top"><xsl:value-of
        select="$bootstrap-spacing-1"
      /></xsl:attribute></xsl:attribute-set>
  <xsl:attribute-set name="mt-2"><xsl:attribute name="margin-top"><xsl:value-of
        select="$bootstrap-spacing-2"
      /></xsl:attribute></xsl:attribute-set>
  <xsl:attribute-set name="mt-3"><xsl:attribute name="margin-top"><xsl:value-of
        select="$bootstrap-spacing-3"
      /></xsl:attribute></xsl:attribute-set>
  <xsl:attribute-set name="mt-4"><xsl:attribute name="margin-top"><xsl:value-of
        select="$bootstrap-spacing-4"
      /></xsl:attribute></xsl:attribute-set>
  <xsl:attribute-set name="mt-5"><xsl:attribute name="margin-top"><xsl:value-of
        select="$bootstrap-spacing-5"
      /></xsl:attribute></xsl:attribute-set>

  <xsl:attribute-set name="mb-0"><xsl:attribute name="margin-bottom"><xsl:value-of
        select="$bootstrap-spacing-0"
      /></xsl:attribute></xsl:attribute-set>
  <xsl:attribute-set name="mb-1"><xsl:attribute name="margin-bottom"><xsl:value-of
        select="$bootstrap-spacing-1"
      /></xsl:attribute></xsl:attribute-set>
  <xsl:attribute-set name="mb-2"><xsl:attribute name="margin-bottom"><xsl:value-of
        select="$bootstrap-spacing-2"
      /></xsl:attribute></xsl:attribute-set>
  <xsl:attribute-set name="mb-3"><xsl:attribute name="margin-bottom"><xsl:value-of
        select="$bootstrap-spacing-3"
      /></xsl:attribute></xsl:attribute-set>
  <xsl:attribute-set name="mb-4"><xsl:attribute name="margin-bottom"><xsl:value-of
        select="$bootstrap-spacing-4"
      /></xsl:attribute></xsl:attribute-set>
  <xsl:attribute-set name="mb-5"><xsl:attribute name="margin-bottom"><xsl:value-of
        select="$bootstrap-spacing-5"
      /></xsl:attribute></xsl:attribute-set>

  <xsl:attribute-set name="ms-0"><xsl:attribute name="margin-left"><xsl:value-of
        select="$bootstrap-spacing-0"
      /></xsl:attribute></xsl:attribute-set>
  <xsl:attribute-set name="ms-1"><xsl:attribute name="margin-left"><xsl:value-of
        select="$bootstrap-spacing-1"
      /></xsl:attribute></xsl:attribute-set>
  <xsl:attribute-set name="ms-2"><xsl:attribute name="margin-left"><xsl:value-of
        select="$bootstrap-spacing-2"
      /></xsl:attribute></xsl:attribute-set>
  <xsl:attribute-set name="ms-3"><xsl:attribute name="margin-left"><xsl:value-of
        select="$bootstrap-spacing-3"
      /></xsl:attribute></xsl:attribute-set>
  <xsl:attribute-set name="ms-4"><xsl:attribute name="margin-left"><xsl:value-of
        select="$bootstrap-spacing-4"
      /></xsl:attribute></xsl:attribute-set>
  <xsl:attribute-set name="ms-5"><xsl:attribute name="margin-left"><xsl:value-of
        select="$bootstrap-spacing-5"
      /></xsl:attribute></xsl:attribute-set>

  <xsl:attribute-set name="me-0"><xsl:attribute name="margin-right"><xsl:value-of
        select="$bootstrap-spacing-0"
      /></xsl:attribute></xsl:attribute-set>
  <xsl:attribute-set name="me-1"><xsl:attribute name="margin-right"><xsl:value-of
        select="$bootstrap-spacing-1"
      /></xsl:attribute></xsl:attribute-set>
  <xsl:attribute-set name="me-2"><xsl:attribute name="margin-right"><xsl:value-of
        select="$bootstrap-spacing-2"
      /></xsl:attribute></xsl:attribute-set>
  <xsl:attribute-set name="me-3"><xsl:attribute name="margin-right"><xsl:value-of
        select="$bootstrap-spacing-3"
      /></xsl:attribute></xsl:attribute-set>
  <xsl:attribute-set name="me-4"><xsl:attribute name="margin-right"><xsl:value-of
        select="$bootstrap-spacing-4"
      /></xsl:attribute></xsl:attribute-set>
  <xsl:attribute-set name="me-5"><xsl:attribute name="margin-right"><xsl:value-of
        select="$bootstrap-spacing-5"
      /></xsl:attribute></xsl:attribute-set>

  <xsl:attribute-set name="mx-0"><xsl:attribute name="margin-left"><xsl:value-of
        select="$bootstrap-spacing-0"
      /></xsl:attribute><xsl:attribute name="margin-right"><xsl:value-of
        select="$bootstrap-spacing-0"
      /></xsl:attribute></xsl:attribute-set>
  <xsl:attribute-set name="mx-1"><xsl:attribute name="margin-left"><xsl:value-of
        select="$bootstrap-spacing-1"
      /></xsl:attribute><xsl:attribute name="margin-right"><xsl:value-of
        select="$bootstrap-spacing-1"
      /></xsl:attribute></xsl:attribute-set>
  <xsl:attribute-set name="mx-2"><xsl:attribute name="margin-left"><xsl:value-of
        select="$bootstrap-spacing-2"
      /></xsl:attribute><xsl:attribute name="margin-right"><xsl:value-of
        select="$bootstrap-spacing-2"
      /></xsl:attribute></xsl:attribute-set>
  <xsl:attribute-set name="mx-3"><xsl:attribute name="margin-left"><xsl:value-of
        select="$bootstrap-spacing-3"
      /></xsl:attribute><xsl:attribute name="margin-right"><xsl:value-of
        select="$bootstrap-spacing-3"
      /></xsl:attribute></xsl:attribute-set>
  <xsl:attribute-set name="mx-4"><xsl:attribute name="margin-left"><xsl:value-of
        select="$bootstrap-spacing-4"
      /></xsl:attribute><xsl:attribute name="margin-right"><xsl:value-of
        select="$bootstrap-spacing-4"
      /></xsl:attribute></xsl:attribute-set>
  <xsl:attribute-set name="mx-5"><xsl:attribute name="margin-left"><xsl:value-of
        select="$bootstrap-spacing-5"
      /></xsl:attribute><xsl:attribute name="margin-right"><xsl:value-of
        select="$bootstrap-spacing-5"
      /></xsl:attribute></xsl:attribute-set>

  <xsl:attribute-set name="my-0"><xsl:attribute name="margin-top"><xsl:value-of
        select="$bootstrap-spacing-0"
      /></xsl:attribute><xsl:attribute name="margin-bottom"><xsl:value-of
        select="$bootstrap-spacing-0"
      /></xsl:attribute></xsl:attribute-set>
  <xsl:attribute-set name="my-1"><xsl:attribute name="margin-top"><xsl:value-of
        select="$bootstrap-spacing-1"
      /></xsl:attribute><xsl:attribute name="margin-bottom"><xsl:value-of
        select="$bootstrap-spacing-1"
      /></xsl:attribute></xsl:attribute-set>
  <xsl:attribute-set name="my-2"><xsl:attribute name="margin-top"><xsl:value-of
        select="$bootstrap-spacing-2"
      /></xsl:attribute><xsl:attribute name="margin-bottom"><xsl:value-of
        select="$bootstrap-spacing-2"
      /></xsl:attribute></xsl:attribute-set>
  <xsl:attribute-set name="my-3"><xsl:attribute name="margin-top"><xsl:value-of
        select="$bootstrap-spacing-3"
      /></xsl:attribute><xsl:attribute name="margin-bottom"><xsl:value-of
        select="$bootstrap-spacing-3"
      /></xsl:attribute></xsl:attribute-set>
  <xsl:attribute-set name="my-4"><xsl:attribute name="margin-top"><xsl:value-of
        select="$bootstrap-spacing-4"
      /></xsl:attribute><xsl:attribute name="margin-bottom"><xsl:value-of
        select="$bootstrap-spacing-4"
      /></xsl:attribute></xsl:attribute-set>
  <xsl:attribute-set name="my-5"><xsl:attribute name="margin-top"><xsl:value-of
        select="$bootstrap-spacing-5"
      /></xsl:attribute><xsl:attribute name="margin-bottom"><xsl:value-of
        select="$bootstrap-spacing-5"
      /></xsl:attribute></xsl:attribute-set>

  <xsl:attribute-set name="m-auto"><xsl:attribute name="margin">auto</xsl:attribute></xsl:attribute-set>
  <xsl:attribute-set name="mx-auto"><xsl:attribute name="margin-left">auto</xsl:attribute><xsl:attribute
      name="margin-right"
    >auto</xsl:attribute></xsl:attribute-set>
  <xsl:attribute-set name="my-auto"><xsl:attribute name="margin-top">auto</xsl:attribute><xsl:attribute
      name="margin-bottom"
    >auto</xsl:attribute></xsl:attribute-set>
  <xsl:attribute-set name="mt-auto"><xsl:attribute name="margin-top">auto</xsl:attribute></xsl:attribute-set>
  <xsl:attribute-set name="mb-auto"><xsl:attribute name="margin-bottom">auto</xsl:attribute></xsl:attribute-set>
  <xsl:attribute-set name="ms-auto"><xsl:attribute name="margin-left">auto</xsl:attribute></xsl:attribute-set>
  <xsl:attribute-set name="me-auto"><xsl:attribute name="margin-right">auto</xsl:attribute></xsl:attribute-set>

  <!-- Standard Bootstrap Widths -->
  <xsl:attribute-set name="w-25"><xsl:attribute name="inline-progression-dimension">25%</xsl:attribute><xsl:attribute
      name="width"
    >25%</xsl:attribute></xsl:attribute-set>
  <xsl:attribute-set name="w-50"><xsl:attribute name="inline-progression-dimension">50%</xsl:attribute><xsl:attribute
      name="width"
    >50%</xsl:attribute></xsl:attribute-set>
  <xsl:attribute-set name="w-75"><xsl:attribute name="inline-progression-dimension">75%</xsl:attribute><xsl:attribute
      name="width"
    >75%</xsl:attribute></xsl:attribute-set>
  <xsl:attribute-set name="w-100"><xsl:attribute name="inline-progression-dimension">100%</xsl:attribute><xsl:attribute
      name="width"
    >100%</xsl:attribute></xsl:attribute-set>
  <xsl:attribute-set name="w-auto"><xsl:attribute name="inline-progression-dimension">auto</xsl:attribute><xsl:attribute
      name="width"
    >auto</xsl:attribute></xsl:attribute-set>

  <!-- Standard Bootstrap Borders -->
  <xsl:attribute-set name="border">
    <xsl:attribute name="border">
      <xsl:value-of select="$bootstrap-border-width"/> solid <xsl:value-of select="$bootstrap-border-color"/>
    </xsl:attribute>
  </xsl:attribute-set>
  <xsl:attribute-set name="border-top">
    <xsl:attribute name="border-top">
      <xsl:value-of select="$bootstrap-border-width"/> solid <xsl:value-of select="$bootstrap-border-color"/>
    </xsl:attribute>
  </xsl:attribute-set>
  <xsl:attribute-set name="border-bottom">
    <xsl:attribute name="border-bottom">
      <xsl:value-of select="$bootstrap-border-width"/> solid <xsl:value-of select="$bootstrap-border-color"/>
    </xsl:attribute>
  </xsl:attribute-set>
  <xsl:attribute-set name="border-start">
    <xsl:attribute name="border-left">
      <xsl:value-of select="$bootstrap-border-width"/> solid <xsl:value-of select="$bootstrap-border-color"/>
    </xsl:attribute>
  </xsl:attribute-set>
  <xsl:attribute-set name="border-end">
    <xsl:attribute name="border-right">
      <xsl:value-of select="$bootstrap-border-width"/> solid <xsl:value-of select="$bootstrap-border-color"/>
    </xsl:attribute>
  </xsl:attribute-set>

  <!-- Border Colors -->
  <xsl:attribute-set name="border-primary"><xsl:attribute name="border-color"><xsl:value-of
        select="$bootstrap-primary"
      /></xsl:attribute></xsl:attribute-set>
  <xsl:attribute-set name="border-secondary"><xsl:attribute name="border-color"><xsl:value-of
        select="$bootstrap-secondary"
      /></xsl:attribute></xsl:attribute-set>
  <xsl:attribute-set name="border-success"><xsl:attribute name="border-color"><xsl:value-of
        select="$bootstrap-success"
      /></xsl:attribute></xsl:attribute-set>
  <xsl:attribute-set name="border-danger"><xsl:attribute name="border-color"><xsl:value-of
        select="$bootstrap-danger"
      /></xsl:attribute></xsl:attribute-set>
  <xsl:attribute-set name="border-warning"><xsl:attribute name="border-color"><xsl:value-of
        select="$bootstrap-warning"
      /></xsl:attribute></xsl:attribute-set>
  <xsl:attribute-set name="border-info"><xsl:attribute name="border-color"><xsl:value-of
        select="$bootstrap-info"
      /></xsl:attribute></xsl:attribute-set>
  <xsl:attribute-set name="border-light"><xsl:attribute name="border-color"><xsl:value-of
        select="$bootstrap-light"
      /></xsl:attribute></xsl:attribute-set>
  <xsl:attribute-set name="border-dark"><xsl:attribute name="border-color"><xsl:value-of
        select="$bootstrap-dark"
      /></xsl:attribute></xsl:attribute-set>
  <!-- Border Thickness -->
  <xsl:attribute-set name="border-1"><xsl:attribute name="border-width">1pt</xsl:attribute></xsl:attribute-set>
  <xsl:attribute-set name="border-2"><xsl:attribute name="border-width">2pt</xsl:attribute></xsl:attribute-set>
  <xsl:attribute-set name="border-3"><xsl:attribute name="border-width">3pt</xsl:attribute></xsl:attribute-set>
  <xsl:attribute-set name="border-4"><xsl:attribute name="border-width">4pt</xsl:attribute></xsl:attribute-set>
  <xsl:attribute-set name="border-5"><xsl:attribute name="border-width">5pt</xsl:attribute></xsl:attribute-set>

  <xsl:attribute-set name="border-primary-subtle"><xsl:attribute name="border-color"><xsl:value-of
        select="$bootstrap-primary-subtle"
      /></xsl:attribute></xsl:attribute-set>
  <xsl:attribute-set name="border-secondary-subtle"><xsl:attribute name="border-color"><xsl:value-of
        select="$bootstrap-secondary-subtle"
      /></xsl:attribute></xsl:attribute-set>
  <xsl:attribute-set name="border-success-subtle"><xsl:attribute name="border-color"><xsl:value-of
        select="$bootstrap-success-subtle"
      /></xsl:attribute></xsl:attribute-set>
  <xsl:attribute-set name="border-danger-subtle"><xsl:attribute name="border-color"><xsl:value-of
        select="$bootstrap-danger-subtle"
      /></xsl:attribute></xsl:attribute-set>
  <xsl:attribute-set name="border-warning-subtle"><xsl:attribute name="border-color"><xsl:value-of
        select="$bootstrap-warning-subtle"
      /></xsl:attribute></xsl:attribute-set>
  <xsl:attribute-set name="border-info-subtle"><xsl:attribute name="border-color"><xsl:value-of
        select="$bootstrap-info-subtle"
      /></xsl:attribute></xsl:attribute-set>
  <xsl:attribute-set name="border-light-subtle"><xsl:attribute name="border-color"><xsl:value-of
        select="$bootstrap-light-subtle"
      /></xsl:attribute></xsl:attribute-set>
  <xsl:attribute-set name="border-dark-subtle"><xsl:attribute name="border-color"><xsl:value-of
        select="$bootstrap-dark-subtle"
      /></xsl:attribute></xsl:attribute-set>

  <!-- Rounded Corners (Approximate Bootstrap values) -->
  <!-- Rounded Corners (Apache FOP extensions) -->
  <xsl:attribute-set name="rounded">
    <xsl:attribute name="fox:border-radius">
      <xsl:value-of select="$bootstrap-rounded"/>
    </xsl:attribute>
  </xsl:attribute-set>
  <xsl:attribute-set name="rounded-0"><xsl:attribute name="fox:border-radius"><xsl:value-of
        select="$bootstrap-rounded-0"
      /></xsl:attribute></xsl:attribute-set>
  <xsl:attribute-set name="rounded-1"><xsl:attribute name="fox:border-radius"><xsl:value-of
        select="$bootstrap-rounded-1"
      /></xsl:attribute></xsl:attribute-set>
  <xsl:attribute-set name="rounded-2"><xsl:attribute name="fox:border-radius"><xsl:value-of
        select="$bootstrap-rounded-2"
      /></xsl:attribute></xsl:attribute-set>
  <xsl:attribute-set name="rounded-3"><xsl:attribute name="fox:border-radius"><xsl:value-of
        select="$bootstrap-rounded-3"
      /></xsl:attribute></xsl:attribute-set>
  <xsl:attribute-set name="rounded-4"><xsl:attribute name="fox:border-radius"><xsl:value-of
        select="$bootstrap-rounded-4"
      /></xsl:attribute></xsl:attribute-set>
  <xsl:attribute-set name="rounded-5"><xsl:attribute name="fox:border-radius"><xsl:value-of
        select="$bootstrap-rounded-5"
      /></xsl:attribute></xsl:attribute-set>
  <xsl:attribute-set name="rounded-circle"><xsl:attribute name="fox:border-radius"><xsl:value-of
        select="$bootstrap-rounded-circle"
      /></xsl:attribute></xsl:attribute-set>
  <xsl:attribute-set name="rounded-pill"><xsl:attribute name="fox:border-radius"><xsl:value-of
        select="$bootstrap-rounded-pill"
      /></xsl:attribute></xsl:attribute-set>

  <!-- Heading utilities (h1-h6 aliases) -->
  <xsl:attribute-set name="h1"><xsl:attribute name="font-size"><xsl:value-of
        select="$bootstrap-h1-font-size"
      /></xsl:attribute><xsl:attribute name="font-weight">bold</xsl:attribute><xsl:attribute
      name="margin-top"
    ><xsl:value-of select="$bootstrap-h1-margin-top"/></xsl:attribute><xsl:attribute name="margin-bottom"><xsl:value-of
        select="$bootstrap-h1-margin-bottom"
      /></xsl:attribute></xsl:attribute-set>
  <xsl:attribute-set name="h2"><xsl:attribute name="font-size"><xsl:value-of
        select="$bootstrap-h2-font-size"
      /></xsl:attribute><xsl:attribute name="font-weight">bold</xsl:attribute><xsl:attribute
      name="margin-top"
    ><xsl:value-of select="$bootstrap-h2-margin-top"/></xsl:attribute><xsl:attribute name="margin-bottom"><xsl:value-of
        select="$bootstrap-h2-margin-bottom"
      /></xsl:attribute></xsl:attribute-set>
  <xsl:attribute-set name="h3"><xsl:attribute name="font-size"><xsl:value-of
        select="$bootstrap-h3-font-size"
      /></xsl:attribute><xsl:attribute name="font-weight">bold</xsl:attribute><xsl:attribute
      name="margin-top"
    ><xsl:value-of select="$bootstrap-h3-margin-top"/></xsl:attribute><xsl:attribute name="margin-bottom"><xsl:value-of
        select="$bootstrap-h3-margin-bottom"
      /></xsl:attribute></xsl:attribute-set>
  <xsl:attribute-set name="h4"><xsl:attribute name="font-size"><xsl:value-of
        select="$bootstrap-h4-font-size"
      /></xsl:attribute><xsl:attribute name="font-weight">bold</xsl:attribute><xsl:attribute
      name="margin-top"
    ><xsl:value-of select="$bootstrap-h4-margin-top"/></xsl:attribute><xsl:attribute name="margin-bottom"><xsl:value-of
        select="$bootstrap-h4-margin-bottom"
      /></xsl:attribute></xsl:attribute-set>
  <xsl:attribute-set name="h5"><xsl:attribute name="font-size"><xsl:value-of
        select="$bootstrap-h5-font-size"
      /></xsl:attribute><xsl:attribute name="font-weight">bold</xsl:attribute><xsl:attribute
      name="margin-top"
    ><xsl:value-of select="$bootstrap-h5-margin-top"/></xsl:attribute><xsl:attribute name="margin-bottom"><xsl:value-of
        select="$bootstrap-h5-margin-bottom"
      /></xsl:attribute></xsl:attribute-set>
  <xsl:attribute-set name="h6"><xsl:attribute name="font-size"><xsl:value-of
        select="$bootstrap-h6-font-size"
      /></xsl:attribute><xsl:attribute name="font-weight">bold</xsl:attribute><xsl:attribute
      name="margin-top"
    ><xsl:value-of select="$bootstrap-h6-margin-top"/></xsl:attribute><xsl:attribute name="margin-bottom"><xsl:value-of
        select="$bootstrap-h6-margin-bottom"
      /></xsl:attribute></xsl:attribute-set>

  <!-- Topic Headings Overrides -->
  <xsl:attribute-set name="topic.title" use-attribute-sets="h1">
    <xsl:attribute name="border-after-width">1pt</xsl:attribute>
    <xsl:attribute name="border-after-style">solid</xsl:attribute>
    <xsl:attribute name="border-after-color"><xsl:value-of select="$bootstrap-border-color"/></xsl:attribute>
    <xsl:attribute name="keep-with-next.within-column">always</xsl:attribute>
  </xsl:attribute-set>

  <xsl:attribute-set name="topic.topic.title" use-attribute-sets="h2">
    <xsl:attribute name="keep-with-next.within-column">always</xsl:attribute>
  </xsl:attribute-set>

  <xsl:attribute-set name="topic.topic.topic.title" use-attribute-sets="h3">
    <xsl:attribute name="keep-with-next.within-column">always</xsl:attribute>
  </xsl:attribute-set>

  <xsl:attribute-set name="topic.topic.topic.topic.title" use-attribute-sets="h4">
    <xsl:attribute name="keep-with-next.within-column">always</xsl:attribute>
  </xsl:attribute-set>

  <xsl:attribute-set name="topic.topic.topic.topic.topic.title" use-attribute-sets="h5">
    <xsl:attribute name="keep-with-next.within-column">always</xsl:attribute>
  </xsl:attribute-set>

  <xsl:attribute-set name="topic.topic.topic.topic.topic.topic.title" use-attribute-sets="h6">
    <xsl:attribute name="keep-with-next.within-column">always</xsl:attribute>
  </xsl:attribute-set>


  <!-- Display utilities (display-1 to display-6) -->
  <xsl:attribute-set name="display-1"><xsl:attribute name="font-size"><xsl:value-of
        select="$bootstrap-display-1-font-size"
      /></xsl:attribute><xsl:attribute name="font-weight"><xsl:value-of
        select="$bootstrap-display-font-weight"
      /></xsl:attribute><xsl:attribute name="line-height"><xsl:value-of
        select="$bootstrap-display-line-height"
      /></xsl:attribute></xsl:attribute-set>
  <xsl:attribute-set name="display-2"><xsl:attribute name="font-size"><xsl:value-of
        select="$bootstrap-display-2-font-size"
      /></xsl:attribute><xsl:attribute name="font-weight"><xsl:value-of
        select="$bootstrap-display-font-weight"
      /></xsl:attribute><xsl:attribute name="line-height"><xsl:value-of
        select="$bootstrap-display-line-height"
      /></xsl:attribute></xsl:attribute-set>
  <xsl:attribute-set name="display-3"><xsl:attribute name="font-size"><xsl:value-of
        select="$bootstrap-display-3-font-size"
      /></xsl:attribute><xsl:attribute name="font-weight"><xsl:value-of
        select="$bootstrap-display-font-weight"
      /></xsl:attribute><xsl:attribute name="line-height"><xsl:value-of
        select="$bootstrap-display-line-height"
      /></xsl:attribute></xsl:attribute-set>
  <xsl:attribute-set name="display-4"><xsl:attribute name="font-size"><xsl:value-of
        select="$bootstrap-display-4-font-size"
      /></xsl:attribute><xsl:attribute name="font-weight"><xsl:value-of
        select="$bootstrap-display-font-weight"
      /></xsl:attribute><xsl:attribute name="line-height"><xsl:value-of
        select="$bootstrap-display-line-height"
      /></xsl:attribute></xsl:attribute-set>
  <xsl:attribute-set name="display-5"><xsl:attribute name="font-size"><xsl:value-of
        select="$bootstrap-display-5-font-size"
      /></xsl:attribute><xsl:attribute name="font-weight"><xsl:value-of
        select="$bootstrap-display-font-weight"
      /></xsl:attribute><xsl:attribute name="line-height"><xsl:value-of
        select="$bootstrap-display-line-height"
      /></xsl:attribute></xsl:attribute-set>
  <xsl:attribute-set name="display-6"><xsl:attribute name="font-size"><xsl:value-of
        select="$bootstrap-display-6-font-size"
      /></xsl:attribute><xsl:attribute name="font-weight"><xsl:value-of
        select="$bootstrap-display-font-weight"
      /></xsl:attribute><xsl:attribute name="line-height"><xsl:value-of
        select="$bootstrap-display-line-height"
      /></xsl:attribute></xsl:attribute-set>

  <!-- Table Striping -->
  <xsl:attribute-set name="table-striped">
      <xsl:attribute name="background-color"><xsl:value-of select="$bootstrap-table-striped-color"/></xsl:attribute>
  </xsl:attribute-set>
  
  <xsl:attribute-set name="lead">
      <xsl:attribute name="font-size"><xsl:value-of select="$bootstrap-lead-font-size"/></xsl:attribute>
      <xsl:attribute name="font-weight"><xsl:value-of select="$bootstrap-lead-font-weight"/></xsl:attribute>
  </xsl:attribute-set>

</xsl:stylesheet>

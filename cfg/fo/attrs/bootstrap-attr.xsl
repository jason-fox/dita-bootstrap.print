<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:fo="http://www.w3.org/1999/XSL/Format"
                xmlns:fox="http://xmlgraphics.apache.org/fop/extensions"
                version="2.0">

  <!-- Standard Bootstrap Text Colors -->
  <xsl:attribute-set name="__color__primary">
    <xsl:attribute name="color">#0d6efd</xsl:attribute>
  </xsl:attribute-set>
  <xsl:attribute-set name="__color__secondary">
    <xsl:attribute name="color">#6c757d</xsl:attribute>
  </xsl:attribute-set>
  <xsl:attribute-set name="__color__success">
    <xsl:attribute name="color">#198754</xsl:attribute>
  </xsl:attribute-set>
  <xsl:attribute-set name="__color__danger">
    <xsl:attribute name="color">#dc3545</xsl:attribute>
  </xsl:attribute-set>
  <xsl:attribute-set name="__color__warning">
    <xsl:attribute name="color">#ffc107</xsl:attribute>
  </xsl:attribute-set>
  <xsl:attribute-set name="__color__info">
    <xsl:attribute name="color">#0dcaf0</xsl:attribute>
  </xsl:attribute-set>
  <xsl:attribute-set name="__color__light">
    <xsl:attribute name="color">#f8f9fa</xsl:attribute>
  </xsl:attribute-set>
  <xsl:attribute-set name="__color__dark">
    <xsl:attribute name="color">#212529</xsl:attribute>
  </xsl:attribute-set>
  <xsl:attribute-set name="__color__black">
    <xsl:attribute name="color">#000000</xsl:attribute>
  </xsl:attribute-set>
  <xsl:attribute-set name="__color__white">
    <xsl:attribute name="color">#ffffff</xsl:attribute>
  </xsl:attribute-set>

  <!-- Standard Bootstrap Background Colors -->
  <xsl:attribute-set name="__bg__primary">
    <xsl:attribute name="background-color">#0d6efd</xsl:attribute>
    <xsl:attribute name="color">#ffffff</xsl:attribute>
  </xsl:attribute-set>
  <xsl:attribute-set name="__bg__secondary">
    <xsl:attribute name="background-color">#6c757d</xsl:attribute>
    <xsl:attribute name="color">#ffffff</xsl:attribute>
  </xsl:attribute-set>
  <xsl:attribute-set name="__bg__success">
    <xsl:attribute name="background-color">#198754</xsl:attribute>
    <xsl:attribute name="color">#ffffff</xsl:attribute>
  </xsl:attribute-set>
  <xsl:attribute-set name="__bg__danger">
    <xsl:attribute name="background-color">#dc3545</xsl:attribute>
    <xsl:attribute name="color">#ffffff</xsl:attribute>
  </xsl:attribute-set>
  <xsl:attribute-set name="__bg__warning">
    <xsl:attribute name="background-color">#ffc107</xsl:attribute>
    <xsl:attribute name="color">#000000</xsl:attribute>
  </xsl:attribute-set>
  <xsl:attribute-set name="__bg__info">
    <xsl:attribute name="background-color">#0dcaf0</xsl:attribute>
    <xsl:attribute name="color">#000000</xsl:attribute>
  </xsl:attribute-set>
  <xsl:attribute-set name="__bg__light">
    <xsl:attribute name="background-color">#f8f9fa</xsl:attribute>
    <xsl:attribute name="color">#000000</xsl:attribute>
  </xsl:attribute-set>
  <xsl:attribute-set name="__bg__dark">
    <xsl:attribute name="background-color">#212529</xsl:attribute>
    <xsl:attribute name="color">#ffffff</xsl:attribute>
  </xsl:attribute-set>
  <xsl:attribute-set name="__bg__black">
    <xsl:attribute name="background-color">#000000</xsl:attribute>
    <xsl:attribute name="color">#ffffff</xsl:attribute>
  </xsl:attribute-set>
  <xsl:attribute-set name="__bg__white">
    <xsl:attribute name="background-color">#ffffff</xsl:attribute>
    <xsl:attribute name="color">#000000</xsl:attribute>
  </xsl:attribute-set>

  <!-- Subtle Background Colors (for Alerts, Callouts, etc.) -->
  <xsl:attribute-set name="__bg__primary-subtle">
    <xsl:attribute name="background-color">#e0f2ff</xsl:attribute>
    <xsl:attribute name="color">#084298</xsl:attribute>
  </xsl:attribute-set>
  <xsl:attribute-set name="__bg__secondary-subtle">
    <xsl:attribute name="background-color">#e2e3e5</xsl:attribute>
    <xsl:attribute name="color">#41464b</xsl:attribute>
  </xsl:attribute-set>
  <xsl:attribute-set name="__bg__success-subtle">
    <xsl:attribute name="background-color">#d1e7dd</xsl:attribute>
    <xsl:attribute name="color">#0f5132</xsl:attribute>
  </xsl:attribute-set>
  <xsl:attribute-set name="__bg__danger-subtle">
    <xsl:attribute name="background-color">#f8d7da</xsl:attribute>
    <xsl:attribute name="color">#842029</xsl:attribute>
  </xsl:attribute-set>
  <xsl:attribute-set name="__bg__warning-subtle">
    <xsl:attribute name="background-color">#fff3cd</xsl:attribute>
    <xsl:attribute name="color">#332701</xsl:attribute>
  </xsl:attribute-set>
  <xsl:attribute-set name="__bg__info-subtle">
    <xsl:attribute name="background-color">#cff4fc</xsl:attribute>
    <xsl:attribute name="color">#032830</xsl:attribute>
  </xsl:attribute-set>
  <xsl:attribute-set name="__bg__light-subtle">
    <xsl:attribute name="background-color">#fefefe</xsl:attribute>
    <xsl:attribute name="color">#141619</xsl:attribute>
  </xsl:attribute-set>
  <xsl:attribute-set name="__bg__dark-subtle">
    <xsl:attribute name="background-color">#ced4da</xsl:attribute>
    <xsl:attribute name="color">#141619</xsl:attribute>
  </xsl:attribute-set>

  <!-- Standard Bootstrap Spacing (Padding) -->
  <xsl:attribute-set name="p-0"><xsl:attribute name="padding">0</xsl:attribute></xsl:attribute-set>
  <xsl:attribute-set name="p-1"><xsl:attribute name="padding">3pt</xsl:attribute></xsl:attribute-set>
  <xsl:attribute-set name="p-2"><xsl:attribute name="padding">6pt</xsl:attribute></xsl:attribute-set>
  <xsl:attribute-set name="p-3"><xsl:attribute name="padding">12pt</xsl:attribute></xsl:attribute-set>
  <xsl:attribute-set name="p-4"><xsl:attribute name="padding">18pt</xsl:attribute></xsl:attribute-set>
  <xsl:attribute-set name="p-5"><xsl:attribute name="padding">36pt</xsl:attribute></xsl:attribute-set>

  <xsl:attribute-set name="pt-0"><xsl:attribute name="padding-top">0</xsl:attribute></xsl:attribute-set>
  <xsl:attribute-set name="pt-1"><xsl:attribute name="padding-top">3pt</xsl:attribute></xsl:attribute-set>
  <xsl:attribute-set name="pt-2"><xsl:attribute name="padding-top">6pt</xsl:attribute></xsl:attribute-set>
  <xsl:attribute-set name="pt-3"><xsl:attribute name="padding-top">12pt</xsl:attribute></xsl:attribute-set>
  <xsl:attribute-set name="pt-4"><xsl:attribute name="padding-top">18pt</xsl:attribute></xsl:attribute-set>
  <xsl:attribute-set name="pt-5"><xsl:attribute name="padding-top">36pt</xsl:attribute></xsl:attribute-set>

  <xsl:attribute-set name="pb-0"><xsl:attribute name="padding-bottom">0</xsl:attribute></xsl:attribute-set>
  <xsl:attribute-set name="pb-1"><xsl:attribute name="padding-bottom">3pt</xsl:attribute></xsl:attribute-set>
  <xsl:attribute-set name="pb-2"><xsl:attribute name="padding-bottom">6pt</xsl:attribute></xsl:attribute-set>
  <xsl:attribute-set name="pb-3"><xsl:attribute name="padding-bottom">12pt</xsl:attribute></xsl:attribute-set>
  <xsl:attribute-set name="pb-4"><xsl:attribute name="padding-bottom">18pt</xsl:attribute></xsl:attribute-set>
  <xsl:attribute-set name="pb-5"><xsl:attribute name="padding-bottom">36pt</xsl:attribute></xsl:attribute-set>

  <xsl:attribute-set name="ps-0"><xsl:attribute name="padding-left">0</xsl:attribute></xsl:attribute-set>
  <xsl:attribute-set name="ps-1"><xsl:attribute name="padding-left">3pt</xsl:attribute></xsl:attribute-set>
  <xsl:attribute-set name="ps-2"><xsl:attribute name="padding-left">6pt</xsl:attribute></xsl:attribute-set>
  <xsl:attribute-set name="ps-3"><xsl:attribute name="padding-left">12pt</xsl:attribute></xsl:attribute-set>
  <xsl:attribute-set name="ps-4"><xsl:attribute name="padding-left">18pt</xsl:attribute></xsl:attribute-set>
  <xsl:attribute-set name="ps-5"><xsl:attribute name="padding-left">36pt</xsl:attribute></xsl:attribute-set>

  <xsl:attribute-set name="pe-0"><xsl:attribute name="padding-right">0</xsl:attribute></xsl:attribute-set>
  <xsl:attribute-set name="pe-1"><xsl:attribute name="padding-right">3pt</xsl:attribute></xsl:attribute-set>
  <xsl:attribute-set name="pe-2"><xsl:attribute name="padding-right">6pt</xsl:attribute></xsl:attribute-set>
  <xsl:attribute-set name="pe-3"><xsl:attribute name="padding-right">12pt</xsl:attribute></xsl:attribute-set>
  <xsl:attribute-set name="pe-4"><xsl:attribute name="padding-right">18pt</xsl:attribute></xsl:attribute-set>
  <xsl:attribute-set name="pe-5"><xsl:attribute name="padding-right">36pt</xsl:attribute></xsl:attribute-set>

  <xsl:attribute-set name="px-0"><xsl:attribute name="padding-left">0</xsl:attribute><xsl:attribute name="padding-right">0</xsl:attribute></xsl:attribute-set>
  <xsl:attribute-set name="px-1"><xsl:attribute name="padding-left">3pt</xsl:attribute><xsl:attribute name="padding-right">3pt</xsl:attribute></xsl:attribute-set>
  <xsl:attribute-set name="px-2"><xsl:attribute name="padding-left">6pt</xsl:attribute><xsl:attribute name="padding-right">6pt</xsl:attribute></xsl:attribute-set>
  <xsl:attribute-set name="px-3"><xsl:attribute name="padding-left">12pt</xsl:attribute><xsl:attribute name="padding-right">12pt</xsl:attribute></xsl:attribute-set>
  <xsl:attribute-set name="px-4"><xsl:attribute name="padding-left">18pt</xsl:attribute><xsl:attribute name="padding-right">18pt</xsl:attribute></xsl:attribute-set>
  <xsl:attribute-set name="px-5"><xsl:attribute name="padding-left">36pt</xsl:attribute><xsl:attribute name="padding-right">36pt</xsl:attribute></xsl:attribute-set>

  <xsl:attribute-set name="py-0"><xsl:attribute name="padding-top">0</xsl:attribute><xsl:attribute name="padding-bottom">0</xsl:attribute></xsl:attribute-set>
  <xsl:attribute-set name="py-1"><xsl:attribute name="padding-top">3pt</xsl:attribute><xsl:attribute name="padding-bottom">3pt</xsl:attribute></xsl:attribute-set>
  <xsl:attribute-set name="py-2"><xsl:attribute name="padding-top">6pt</xsl:attribute><xsl:attribute name="padding-bottom">6pt</xsl:attribute></xsl:attribute-set>
  <xsl:attribute-set name="py-3"><xsl:attribute name="padding-top">12pt</xsl:attribute><xsl:attribute name="padding-bottom">12pt</xsl:attribute></xsl:attribute-set>
  <xsl:attribute-set name="py-4"><xsl:attribute name="padding-top">18pt</xsl:attribute><xsl:attribute name="padding-bottom">18pt</xsl:attribute></xsl:attribute-set>
  <xsl:attribute-set name="py-5"><xsl:attribute name="padding-top">36pt</xsl:attribute><xsl:attribute name="padding-bottom">36pt</xsl:attribute></xsl:attribute-set>

  <!-- Standard Bootstrap Spacing (Margin) -->
  <xsl:attribute-set name="m-0"><xsl:attribute name="margin">0</xsl:attribute></xsl:attribute-set>
  <xsl:attribute-set name="m-1"><xsl:attribute name="margin">3pt</xsl:attribute></xsl:attribute-set>
  <xsl:attribute-set name="m-2"><xsl:attribute name="margin">6pt</xsl:attribute></xsl:attribute-set>
  <xsl:attribute-set name="m-3"><xsl:attribute name="margin">12pt</xsl:attribute></xsl:attribute-set>
  <xsl:attribute-set name="m-4"><xsl:attribute name="margin">18pt</xsl:attribute></xsl:attribute-set>
  <xsl:attribute-set name="m-5"><xsl:attribute name="margin">36pt</xsl:attribute></xsl:attribute-set>

  <xsl:attribute-set name="mt-0"><xsl:attribute name="margin-top">0</xsl:attribute></xsl:attribute-set>
  <xsl:attribute-set name="mt-1"><xsl:attribute name="margin-top">3pt</xsl:attribute></xsl:attribute-set>
  <xsl:attribute-set name="mt-2"><xsl:attribute name="margin-top">6pt</xsl:attribute></xsl:attribute-set>
  <xsl:attribute-set name="mt-3"><xsl:attribute name="margin-top">12pt</xsl:attribute></xsl:attribute-set>
  <xsl:attribute-set name="mt-4"><xsl:attribute name="margin-top">18pt</xsl:attribute></xsl:attribute-set>
  <xsl:attribute-set name="mt-5"><xsl:attribute name="margin-top">36pt</xsl:attribute></xsl:attribute-set>

  <xsl:attribute-set name="mb-0"><xsl:attribute name="margin-bottom">0</xsl:attribute></xsl:attribute-set>
  <xsl:attribute-set name="mb-1"><xsl:attribute name="margin-bottom">3pt</xsl:attribute></xsl:attribute-set>
  <xsl:attribute-set name="mb-2"><xsl:attribute name="margin-bottom">6pt</xsl:attribute></xsl:attribute-set>
  <xsl:attribute-set name="mb-3"><xsl:attribute name="margin-bottom">12pt</xsl:attribute></xsl:attribute-set>
  <xsl:attribute-set name="mb-4"><xsl:attribute name="margin-bottom">18pt</xsl:attribute></xsl:attribute-set>
  <xsl:attribute-set name="mb-5"><xsl:attribute name="margin-bottom">36pt</xsl:attribute></xsl:attribute-set>

  <xsl:attribute-set name="ms-0"><xsl:attribute name="margin-left">0</xsl:attribute></xsl:attribute-set>
  <xsl:attribute-set name="ms-1"><xsl:attribute name="margin-left">3pt</xsl:attribute></xsl:attribute-set>
  <xsl:attribute-set name="ms-2"><xsl:attribute name="margin-left">6pt</xsl:attribute></xsl:attribute-set>
  <xsl:attribute-set name="ms-3"><xsl:attribute name="margin-left">12pt</xsl:attribute></xsl:attribute-set>
  <xsl:attribute-set name="ms-4"><xsl:attribute name="margin-left">18pt</xsl:attribute></xsl:attribute-set>
  <xsl:attribute-set name="ms-5"><xsl:attribute name="margin-left">36pt</xsl:attribute></xsl:attribute-set>

  <xsl:attribute-set name="me-0"><xsl:attribute name="margin-right">0</xsl:attribute></xsl:attribute-set>
  <xsl:attribute-set name="me-1"><xsl:attribute name="margin-right">3pt</xsl:attribute></xsl:attribute-set>
  <xsl:attribute-set name="me-2"><xsl:attribute name="margin-right">6pt</xsl:attribute></xsl:attribute-set>
  <xsl:attribute-set name="me-3"><xsl:attribute name="margin-right">12pt</xsl:attribute></xsl:attribute-set>
  <xsl:attribute-set name="me-4"><xsl:attribute name="margin-right">18pt</xsl:attribute></xsl:attribute-set>
  <xsl:attribute-set name="me-5"><xsl:attribute name="margin-right">36pt</xsl:attribute></xsl:attribute-set>

  <xsl:attribute-set name="mx-0"><xsl:attribute name="margin-left">0</xsl:attribute><xsl:attribute name="margin-right">0</xsl:attribute></xsl:attribute-set>
  <xsl:attribute-set name="mx-1"><xsl:attribute name="margin-left">3pt</xsl:attribute><xsl:attribute name="margin-right">3pt</xsl:attribute></xsl:attribute-set>
  <xsl:attribute-set name="mx-2"><xsl:attribute name="margin-left">6pt</xsl:attribute><xsl:attribute name="margin-right">6pt</xsl:attribute></xsl:attribute-set>
  <xsl:attribute-set name="mx-3"><xsl:attribute name="margin-left">12pt</xsl:attribute><xsl:attribute name="margin-right">12pt</xsl:attribute></xsl:attribute-set>
  <xsl:attribute-set name="mx-4"><xsl:attribute name="margin-left">18pt</xsl:attribute><xsl:attribute name="margin-right">18pt</xsl:attribute></xsl:attribute-set>
  <xsl:attribute-set name="mx-5"><xsl:attribute name="margin-left">36pt</xsl:attribute><xsl:attribute name="margin-right">36pt</xsl:attribute></xsl:attribute-set>

  <xsl:attribute-set name="my-0"><xsl:attribute name="margin-top">0</xsl:attribute><xsl:attribute name="margin-bottom">0</xsl:attribute></xsl:attribute-set>
  <xsl:attribute-set name="my-1"><xsl:attribute name="margin-top">3pt</xsl:attribute><xsl:attribute name="margin-bottom">3pt</xsl:attribute></xsl:attribute-set>
  <xsl:attribute-set name="my-2"><xsl:attribute name="margin-top">6pt</xsl:attribute><xsl:attribute name="margin-bottom">6pt</xsl:attribute></xsl:attribute-set>
  <xsl:attribute-set name="my-3"><xsl:attribute name="margin-top">12pt</xsl:attribute><xsl:attribute name="margin-bottom">12pt</xsl:attribute></xsl:attribute-set>
  <xsl:attribute-set name="my-4"><xsl:attribute name="margin-top">18pt</xsl:attribute><xsl:attribute name="margin-bottom">18pt</xsl:attribute></xsl:attribute-set>
  <xsl:attribute-set name="my-5"><xsl:attribute name="margin-top">36pt</xsl:attribute><xsl:attribute name="margin-bottom">36pt</xsl:attribute></xsl:attribute-set>

  <xsl:attribute-set name="m-auto"><xsl:attribute name="margin">auto</xsl:attribute></xsl:attribute-set>
  <xsl:attribute-set name="mx-auto"><xsl:attribute name="margin-left">auto</xsl:attribute><xsl:attribute name="margin-right">auto</xsl:attribute></xsl:attribute-set>
  <xsl:attribute-set name="my-auto"><xsl:attribute name="margin-top">auto</xsl:attribute><xsl:attribute name="margin-bottom">auto</xsl:attribute></xsl:attribute-set>
  <xsl:attribute-set name="mt-auto"><xsl:attribute name="margin-top">auto</xsl:attribute></xsl:attribute-set>
  <xsl:attribute-set name="mb-auto"><xsl:attribute name="margin-bottom">auto</xsl:attribute></xsl:attribute-set>
  <xsl:attribute-set name="ms-auto"><xsl:attribute name="margin-left">auto</xsl:attribute></xsl:attribute-set>
  <xsl:attribute-set name="me-auto"><xsl:attribute name="margin-right">auto</xsl:attribute></xsl:attribute-set>

  <!-- Standard Bootstrap Widths -->
  <xsl:attribute-set name="w-25"><xsl:attribute name="inline-progression-dimension">25%</xsl:attribute><xsl:attribute name="width">25%</xsl:attribute></xsl:attribute-set>
  <xsl:attribute-set name="w-50"><xsl:attribute name="inline-progression-dimension">50%</xsl:attribute><xsl:attribute name="width">50%</xsl:attribute></xsl:attribute-set>
  <xsl:attribute-set name="w-75"><xsl:attribute name="inline-progression-dimension">75%</xsl:attribute><xsl:attribute name="width">75%</xsl:attribute></xsl:attribute-set>
  <xsl:attribute-set name="w-100"><xsl:attribute name="inline-progression-dimension">100%</xsl:attribute><xsl:attribute name="width">100%</xsl:attribute></xsl:attribute-set>
  <xsl:attribute-set name="w-auto"><xsl:attribute name="inline-progression-dimension">auto</xsl:attribute><xsl:attribute name="width">auto</xsl:attribute></xsl:attribute-set>

  <!-- Standard Bootstrap Borders -->
  <xsl:attribute-set name="border">
    <xsl:attribute name="border">1pt solid #dee2e6</xsl:attribute>
  </xsl:attribute-set>
  <xsl:attribute-set name="border-top">
    <xsl:attribute name="border-top">1pt solid #dee2e6</xsl:attribute>
  </xsl:attribute-set>
  <xsl:attribute-set name="border-bottom">
    <xsl:attribute name="border-bottom">1pt solid #dee2e6</xsl:attribute>
  </xsl:attribute-set>
  <xsl:attribute-set name="border-start">
    <xsl:attribute name="border-left">1pt solid #dee2e6</xsl:attribute>
  </xsl:attribute-set>
  <xsl:attribute-set name="border-end">
    <xsl:attribute name="border-right">1pt solid #dee2e6</xsl:attribute>
  </xsl:attribute-set>

  <!-- Border Colors -->
  <xsl:attribute-set name="border-primary"><xsl:attribute name="border-color">#0d6efd</xsl:attribute></xsl:attribute-set>
  <xsl:attribute-set name="border-secondary"><xsl:attribute name="border-color">#6c757d</xsl:attribute></xsl:attribute-set>
  <xsl:attribute-set name="border-success"><xsl:attribute name="border-color">#198754</xsl:attribute></xsl:attribute-set>
  <xsl:attribute-set name="border-danger"><xsl:attribute name="border-color">#dc3545</xsl:attribute></xsl:attribute-set>
  <xsl:attribute-set name="border-warning"><xsl:attribute name="border-color">#ffc107</xsl:attribute></xsl:attribute-set>
  <xsl:attribute-set name="border-info"><xsl:attribute name="border-color">#0dcaf0</xsl:attribute></xsl:attribute-set>
  <xsl:attribute-set name="border-light"><xsl:attribute name="border-color">#f8f9fa</xsl:attribute></xsl:attribute-set>
  <xsl:attribute-set name="border-dark"><xsl:attribute name="border-color">#212529</xsl:attribute></xsl:attribute-set>
  <xsl:attribute-set name="border-black"><xsl:attribute name="border-color">#000000</xsl:attribute></xsl:attribute-set>
  <xsl:attribute-set name="border-white"><xsl:attribute name="border-color">#ffffff</xsl:attribute></xsl:attribute-set>

  <!-- Border Thickness -->
  <xsl:attribute-set name="border-1"><xsl:attribute name="border-width">1pt</xsl:attribute></xsl:attribute-set>
  <xsl:attribute-set name="border-2"><xsl:attribute name="border-width">2pt</xsl:attribute></xsl:attribute-set>
  <xsl:attribute-set name="border-3"><xsl:attribute name="border-width">3pt</xsl:attribute></xsl:attribute-set>
  <xsl:attribute-set name="border-4"><xsl:attribute name="border-width">4pt</xsl:attribute></xsl:attribute-set>
  <xsl:attribute-set name="border-5"><xsl:attribute name="border-width">5pt</xsl:attribute></xsl:attribute-set>

  <xsl:attribute-set name="border-primary-subtle"><xsl:attribute name="border-color">#e0f2ff</xsl:attribute></xsl:attribute-set>
  <xsl:attribute-set name="border-secondary-subtle"><xsl:attribute name="border-color">#e2e3e5</xsl:attribute></xsl:attribute-set>
  <xsl:attribute-set name="border-success-subtle"><xsl:attribute name="border-color">#d1e7dd</xsl:attribute></xsl:attribute-set>
  <xsl:attribute-set name="border-danger-subtle"><xsl:attribute name="border-color">#f8d7da</xsl:attribute></xsl:attribute-set>
  <xsl:attribute-set name="border-warning-subtle"><xsl:attribute name="border-color">#fff3cd</xsl:attribute></xsl:attribute-set>
  <xsl:attribute-set name="border-info-subtle"><xsl:attribute name="border-color">#cff4fc</xsl:attribute></xsl:attribute-set>
  <xsl:attribute-set name="border-light-subtle"><xsl:attribute name="border-color">#fefefe</xsl:attribute></xsl:attribute-set>
  <xsl:attribute-set name="border-dark-subtle"><xsl:attribute name="border-color">#ced4da</xsl:attribute></xsl:attribute-set>

  <!-- Rounded Corners (Approximate Bootstrap values) -->
  <!-- Rounded Corners (Apache FOP extensions) -->
  <xsl:attribute-set name="rounded"><xsl:attribute name="fox:border-radius">6pt</xsl:attribute></xsl:attribute-set>
  <xsl:attribute-set name="rounded-0"><xsl:attribute name="fox:border-radius">0</xsl:attribute></xsl:attribute-set>
  <xsl:attribute-set name="rounded-1"><xsl:attribute name="fox:border-radius">3pt</xsl:attribute></xsl:attribute-set>
  <xsl:attribute-set name="rounded-2"><xsl:attribute name="fox:border-radius">4pt</xsl:attribute></xsl:attribute-set>
  <xsl:attribute-set name="rounded-3"><xsl:attribute name="fox:border-radius">5pt</xsl:attribute></xsl:attribute-set>
  <xsl:attribute-set name="rounded-4"><xsl:attribute name="fox:border-radius">8pt</xsl:attribute></xsl:attribute-set>
  <xsl:attribute-set name="rounded-5"><xsl:attribute name="fox:border-radius">16pt</xsl:attribute></xsl:attribute-set>
  <xsl:attribute-set name="rounded-circle"><xsl:attribute name="fox:border-radius">50%</xsl:attribute></xsl:attribute-set>
  <xsl:attribute-set name="rounded-pill"><xsl:attribute name="fox:border-radius">100pt</xsl:attribute></xsl:attribute-set>

  <!-- Heading utilities (h1-h6 aliases) -->
  <xsl:attribute-set name="h1"><xsl:attribute name="font-size">28pt</xsl:attribute><xsl:attribute name="font-weight">bold</xsl:attribute><xsl:attribute name="margin-top">12pt</xsl:attribute><xsl:attribute name="margin-bottom">6pt</xsl:attribute></xsl:attribute-set>
  <xsl:attribute-set name="h2"><xsl:attribute name="font-size">24pt</xsl:attribute><xsl:attribute name="font-weight">bold</xsl:attribute><xsl:attribute name="margin-top">10pt</xsl:attribute><xsl:attribute name="margin-bottom">5pt</xsl:attribute></xsl:attribute-set>
  <xsl:attribute-set name="h3"><xsl:attribute name="font-size">18pt</xsl:attribute><xsl:attribute name="font-weight">bold</xsl:attribute><xsl:attribute name="margin-top">10pt</xsl:attribute><xsl:attribute name="margin-bottom">5pt</xsl:attribute></xsl:attribute-set>
  <xsl:attribute-set name="h4"><xsl:attribute name="font-size">14pt</xsl:attribute><xsl:attribute name="font-weight">bold</xsl:attribute><xsl:attribute name="margin-top">8pt</xsl:attribute><xsl:attribute name="margin-bottom">4pt</xsl:attribute></xsl:attribute-set>
  <xsl:attribute-set name="h5"><xsl:attribute name="font-size">12pt</xsl:attribute><xsl:attribute name="font-weight">bold</xsl:attribute><xsl:attribute name="margin-top">8pt</xsl:attribute><xsl:attribute name="margin-bottom">4pt</xsl:attribute></xsl:attribute-set>
  <xsl:attribute-set name="h6"><xsl:attribute name="font-size">10pt</xsl:attribute><xsl:attribute name="font-weight">bold</xsl:attribute><xsl:attribute name="margin-top">6pt</xsl:attribute><xsl:attribute name="margin-bottom">3pt</xsl:attribute></xsl:attribute-set>

  <!-- Display utilities (display-1 to display-6) -->
  <xsl:attribute-set name="display-1"><xsl:attribute name="font-size">60pt</xsl:attribute><xsl:attribute name="font-weight">300</xsl:attribute><xsl:attribute name="line-height">1.2</xsl:attribute></xsl:attribute-set>
  <xsl:attribute-set name="display-2"><xsl:attribute name="font-size">52pt</xsl:attribute><xsl:attribute name="font-weight">300</xsl:attribute><xsl:attribute name="line-height">1.2</xsl:attribute></xsl:attribute-set>
  <xsl:attribute-set name="display-3"><xsl:attribute name="font-size">44pt</xsl:attribute><xsl:attribute name="font-weight">300</xsl:attribute><xsl:attribute name="line-height">1.2</xsl:attribute></xsl:attribute-set>
  <xsl:attribute-set name="display-4"><xsl:attribute name="font-size">36pt</xsl:attribute><xsl:attribute name="font-weight">300</xsl:attribute><xsl:attribute name="line-height">1.2</xsl:attribute></xsl:attribute-set>
  <xsl:attribute-set name="display-5"><xsl:attribute name="font-size">28pt</xsl:attribute><xsl:attribute name="font-weight">300</xsl:attribute><xsl:attribute name="line-height">1.2</xsl:attribute></xsl:attribute-set>
  <xsl:attribute-set name="display-6"><xsl:attribute name="font-size">24pt</xsl:attribute><xsl:attribute name="font-weight">300</xsl:attribute><xsl:attribute name="line-height">1.2</xsl:attribute></xsl:attribute-set>

  <!-- No border -->
  <xsl:attribute-set name="border-0"><xsl:attribute name="border">none</xsl:attribute></xsl:attribute-set>

</xsl:stylesheet>

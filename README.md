# DITA Bootstrap Print

A plug-in for [DITA Open Toolkit][1] that adds PDF print output to the [DITA Bootstrap plug-in][2].


- [Installing](#installing)
- [Using](#using)
- [Featured Bootstrap components](#featured-bootstrap-components)
- [Customizing](#customizing)
- [License](#license)

## Installing

Use the `dita` command to add this plug-in and its requirements to your DITA Open Toolkit installation:

```console
dita install net.infotexture.dita-bootstrap
dita install https://github.com/infotexture/dita-bootstrap.print/archive/master.zip
```

## Using

Specify the `pdf` format when building output with the `dita` command. If the plug-in is installed, the Bootstrap-based XSL-FO overrides will be applied automatically.

```console
dita --input=path/to/your.ditamap \
     --format=pdf
```

## Featured Bootstrap components

The plug-in includes XSL-FO handling for the following DITA Bootstrap components. You can use these either through the **DITA Bootstrap Specialization** elements to achieve a consistent look in print:

- [Accordions](https://infotexture.github.io/dita-bootstrap/accordion.html) (`<accordion>`)
- [Alerts](https://infotexture.github.io/dita-bootstrap/alerts.html) (`<alert>`)
- [Badges](https://infotexture.github.io/dita-bootstrap/badge.html) (`<badge>`)
- [Buttons](https://infotexture.github.io/dita-bootstrap/buttons.html) (`<button>`)
- [Cards](https://infotexture.github.io/dita-bootstrap/card.html) (`<card>`)
- [Carousels](https://infotexture.github.io/dita-bootstrap/carousel.html) (`<carousel>` as a contact sheet)
- [Figures](https://infotexture.github.io/dita-bootstrap/figures.html) (`<fig>`)
- [Grid layout](https://infotexture.github.io/dita-bootstrap/grid.html) (`<grid-row>`, `<grid-col>`)
- [Icons](https://infotexture.github.io/dita-bootstrap/icons.html) (`<icon>`)
- [List groups](https://infotexture.github.io/dita-bootstrap/list-group.html) (`<list-group>`)
- [Notes](https://infotexture.github.io/dita-bootstrap/alerts.html) (`<note>` - as `<alert>`)
- [Tables](https://infotexture.github.io/dita-bootstrap/tables.html) (`<table>`)
- [Thumbnails](https://infotexture.github.io/dita-bootstrap/images.html) (`<thumbnail>`)

## Using Bootstrap Specializations

The preferred way to use this plug-in is via the [DITA Bootstrap domain specializations][2]. These provide native DITA elements with specialized attributes for Bootstrap styling:

```xml
<card color="primary" border="1" rounded="yes">
  <title>Card Title</title>
  <p>Card content goes here.</p>
</card>
```

The print plug-in interprets these specialized elements and attributes to generate equivalent XSL-FO styling in the PDF output.

### Colors and Borders

Most DITA Bootstrap Specializations, as well as many base DITA elements, support the `color` and `border` attributes to control their appearance:

-   **Color Themes**: Use standard Bootstrap themes such as `primary`, `secondary`, `success`, `danger`, `warning`, `info`, `light`, and `dark`.
    ```xml
    <section color="primary">
      <title>Primary Section</title>
      <p>This section has a primary background color.</p>
    </section>

    <alert color="warning">
      <p>This is a warning alert.</p>
    </alert>
    <badge color="success">New</badge>
    ```
-   **Border Thickness**: Use numeric values from `1` to `5` to control border width.
    ```xml
    <ph border="1">Bordered phrase</ph>

    <card border="3" color="info">
      <title>Thick Border Card</title>
      <p>Content...</p>
    </card>
    ```

### Thumbnails

The `<thumbnail>` element (a specialization of `<image>`) can be used to add a themed frame around images:

```xml
<thumbnail href="image.png" color="primary" placement="break"/>
```

-   **@color**: Sets the border and background theme (e.g., `primary` uses a solid primary border and a subtle primary background).
-   **@placement**: Use `break` for a centered block-level image or `inline` for flowing text integration.

## Customizing

### Common Bootstrap utility classes

Many of the common Bootstrap utility classes for borders, background, text, and spacing can be used via the `outputclass` attribute in DITA topics. The print plug-in interprets these classes and applies corresponding XSL-FO styling.

For more information on the available classes, see the [main DITA Bootstrap documentation][2].



## License

[Apache 2.0](LICENSE) © 2026 Jason Fox

[1]: http://www.dita-ot.org
[2]: https://github.com/infotexture/dita-bootstrap

# {gex} <a href='https://github.com/matt-dray/gex'><img src='man/figures/logo.png' align='right' width='200'/></a>

<!-- badges: start -->
[![Project Status: Inactive – The project has reached a stable, usable state but is no longer being actively developed; support/maintenance will be provided as time allows.](https://www.repostatus.org/badges/latest/inactive.svg)](https://www.repostatus.org/#inactive)
[![R-CMD-check](https://github.com/matt-dray/gex/actions/workflows/R-CMD-check.yaml/badge.svg)](https://github.com/matt-dray/gex/actions/workflows/R-CMD-check.yaml)
[![Blog posts](https://img.shields.io/badge/rostrum.blog-posts-008900?labelColor=000000&logo=data%3Aimage%2Fgif%3Bbase64%2CR0lGODlhEAAQAPEAAAAAABWCBAAAAAAAACH5BAlkAAIAIf8LTkVUU0NBUEUyLjADAQAAACwAAAAAEAAQAAAC55QkISIiEoQQQgghRBBCiCAIgiAIgiAIQiAIgSAIgiAIQiAIgRAEQiAQBAQCgUAQEAQEgYAgIAgIBAKBQBAQCAKBQEAgCAgEAoFAIAgEBAKBIBAQCAQCgUAgEAgCgUBAICAgICAgIBAgEBAgEBAgEBAgECAgICAgECAQIBAQIBAgECAgICAgICAgECAQECAQICAgICAgICAgEBAgEBAgEBAgICAgICAgECAQIBAQIBAgECAgICAgIBAgECAQECAQIBAgICAgIBAgIBAgEBAgECAgECAgICAgICAgECAgECAgQIAAAQIKAAAh%2BQQJZAACACwAAAAAEAAQAAAC55QkIiESIoQQQgghhAhCBCEIgiAIgiAIQiAIgSAIgiAIQiAIgRAEQiAQBAQCgUAQEAQEgYAgIAgIBAKBQBAQCAKBQEAgCAgEAoFAIAgEBAKBIBAQCAQCgUAgEAgCgUBAICAgICAgIBAgEBAgEBAgEBAgECAgICAgECAQIBAQIBAgECAgICAgICAgECAQECAQICAgICAgICAgEBAgEBAgEBAgICAgICAgECAQIBAQIBAgECAgICAgIBAgECAQECAQIBAgICAgIBAgIBAgEBAgECAgECAgICAgICAgECAgECAgQIAAAQIKAAA7)](https://www.rostrum.blog/index.html#category=gex)
<!-- badges: end -->

## What

An R package to help create simple hexagon-shaped sticker logos with the dimensions of [the Stickers Standard](https://sticker.how/#type-hexagon).

{gex}:

* is dependency-lightweight
* lets you add as many text and image elements as you like
* uses the grid graphics system, so is 'extensible'

The package does what I need it to do but is not fully tested across all systems.
[Please contribute](https://github.com/matt-dray/gex/issues) if you have bug reports or ideas.

## Install

You can install {gex} [from GitHub](https://github.com/matt-dray/gex) like:

``` r
install.packages("remotes")  # if not yet installed
remotes::install_github("matt-dray/gex")
```

The package uses the inbuilt {grid} graphics system and the sister package [{gridGeometry}](https://cran.r-project.org/package=gridGeometry).
The package may include more 'gridverse' packages in future.

## Example

Build a sticker additively with a series of function calls:

1. `open_device()` to set up a PNG graphics device with the dimensions of [the Stickers Standard](https://sticker.how/#type-hexagon).
1. `add_hex()` to add the underlying hexagon 'canvas'.
1. `add_image()` to place an image (run multiple times for more images).
1. `add_text()` to place and style text (run multiple times for more text).
1. `add_border()` to put a border around the edge of the hex (add this after images and text to draw over the top of them).
1. `close_device()` to close the PNG graphics device and save to file.

You can set various text and image properties like position, size, colour and angle.
Text and images will be clipped if they exceed the boundary of the hexagon.

It's up to the user to read their own images (via {[png](https://cran.r-project.org/package=png)} or {[jpeg](https://cran.r-project.org/package=jpeg)}) and install the fonts they want to use.

Below is an extremely basic example.
Note how you call each function independently, much like writing base plots.

```r
# Somewhere to save it
temp_path <- "~/Desktop/hexbase.png"

# Bring your own image
image_path <- system.file("img", "Rlogo.png", package = "png")
image_png <- png::readPNG(image_path)

# Build and write the hex
gex::open_device(
  file_path = temp_path,
  resolution = 300  # ppi, you can increase this
)
gex::add_hex(col = "bisque")  # named or hexadecimal
gex::add_image(
  img = image_png,
  y = 0.6,  # 0 to 1 on x and y axes
  angle = 20,
  width = 0.5
)
gex::add_text(
  string = "example",
  x = 0.495,
  y = 0.35,
  col = "#000000",
  family = "Comic Sans MS",   # bring your own font
  face = "bold"
)
gex::add_text(
  string = "example",
  x = 0.505,
  y = 0.34,
  col = "red",
  family = "Comic Sans MS",
  face = "bold"
)
gex::add_text(  # add multiple text and images
  string = "visit rostrum.blog ftw",
  x = 0.73, 
  y = 0.18,
  angle = 30,  # rotate to match lower-right edge
  size = 5,  # point size
  col = "blue", 
  family = "Papyrus"
)
gex::add_border(col = "hotpink3")
gex::close_device()  # writes to file
```

That creates this absolutely stunning demo sticker, written to the specified `file_path`:

<img src='man/figures/example.png' width='200' alt="A bisque-coloured hexagon with a hotpink border. The R logo is above centre and tilted at a jaunty angle. The text 'example' writtenin Comic Sans and is copied and shifted to give the effect of a shadow, red on black. On the lower-right edge in blue papyrus font is the text 'visit rostrum.blog ftw'.">

Note that you can't rely on plot-window previews when you're developing your sticker (they lie).
You must inspect the generated PNG file instead.
You could do this with a `system()` call from R:

``` r
# Open the PNG hex image for inspection
system(paste("open", temp_path))
```

Try `start` rather than `open` on Windows.

## Related

For more established hex-making tools with R, try:

* [{hexSticker}](https://github.com/GuangchuangYu/hexSticker) by Guangchuang Yu
* [{bunny}](https://github.com/dmi3kno/bunny) by Dmytro Perepolkin
* the [hexmake](https://connect.thinkr.fr/hexmake/) Shiny app by Colin Fay

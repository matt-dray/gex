% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/hexagon.R
\name{open_device}
\alias{open_device}
\title{Open a PNG Device with Sticker-Standard Dimensions}
\usage{
open_device(file_path, resolution = 300)
}
\arguments{
\item{file_path}{Character. File path to a .png where the output file will be
saved. The containing directory must already exist.}

\item{resolution}{Numeric. Resolution of the graphics device in pixels per
inch (ppi). Higher values have better resolution but create larger file
sizes.}
}
\value{
Nothing. A graphics device is opened.
}
\description{
Begin a PNG plot device with dimensions matching
\href{https://sticker.how/#type-hexagon}{the Stickers Standard}: 4.39 cm wide by
5.08 cm high (2 by 1.73 inches).
}
\details{
\subsection{Order}{

When building a hex, this function should be called first, followed by
\link{add_hex}. You can then use  \link{add_text}, \link{add_image} and \link{add_border} (if
desired) and finally \link{close_device}.
}
}
\examples{
temp_path <- tempfile(fileext = ".png")
open_device(temp_path)
add_hex()
img_path <- system.file("img", "Rlogo.png", package = "png")
img_png <- png::readPNG(img_path)
add_image(img_png)
add_text()
add_border()
close_device()
}
\seealso{
Other hex device handlers: 
\code{\link{close_device}()}
}
\concept{hex device handlers}

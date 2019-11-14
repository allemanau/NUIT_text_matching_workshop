# NUIT Text Matching Workshop
This repository contains all materials for the NUIT Text Matching Workshop on November 20, 2019.
# Software and Packages
You'll need a version of R, preferably 3.6.1 (Action of the Toes), and RStudio. Installation instructions are [here](https://workshops.rcs.northwestern.edu/install/r/). Once you have a complete R installation, start RStudio and install the following packages from the console using the following commands:

```r
install.packages("tidyverse")
install.packages("stringdist")
install.packages("fuzzyjoin")
```

If you are asked to install any of these from binaries (`There are binary versions available but the source versions are later. Do you want to install from sources the package which needs compilation?`), just say no (type `n` and hit enter/return). The libraries should all install successfully, which you can test by loading them:

```r
library(tidyverse)
library(stringdist)
library(fuzzyjoin)
```

If you have any trouble with these installations, please feel free to come to [Data Drop-in Hours](https://www.it.northwestern.edu/research/consultation/data-services.html) from 2-4PM on Tuesday, November 19, or come early to the workshop on Wednesday so the issue can be resolved.

# Workshop Materials

With R and RStudio installed on your laptop, download all of the materials to your laptop. Click on the green Clone or Download button above, then download the repository as a ZIP file.

<p align="center">
  <img src="https://github.com/allemanau/NUIT_text_matching_workshop/tree/master/images/github_clone_or_download.png?raw=true"/>
</p>

Find the downloaded .zip file on your computer, likely in your Downloads folder. Unzip it - usually by double-clicking. This will create a directory called BLAH. Move this somewhere on your computer where you'll be able to find it, like your Documents folder.

Double-click on `text_matching_workshop.Rproj` to open the project. Or from RStudio, `File > Open Project...`, then navigate to the location of the file.

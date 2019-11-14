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

If you have any trouble with these installations, please feel free to come to Data Drop-in Hours from 2-4PM on Tuesday, or come early to the workshop on Wednesday so the issue can be resolved.

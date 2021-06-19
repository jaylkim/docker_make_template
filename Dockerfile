# This Dockerfile builds an image based on the rocker/verse
# that includes the tidyverse packages and others related to Rmd.
# Put this Dockerfile in your project folder and build a project image.
# Then, run a container in which you will conduct data analysis as usual.
# Change the version tag as needed.

FROM rocker/verse:4.1.0

MAINTAINER JK

COPY Makefile /home/rstudio/Makefile
COPY Dockerfile /home/rstudio/Dockerfile

RUN install2.r tidymodels renv reticulate
RUN ln -s /usr/local/lib/R/site-library/littler/examples/update.r \
    /usr/local/bin/update.r
RUN update.r

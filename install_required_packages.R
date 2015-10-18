list.of.packages <- c("ggplot2", "plyr", "dplyr",
                      "reshape", "reshape2", "tidyr",
                      "stringr","devtools",
                      "ggmap","lubridate","scales",
                      "gridExtra")
new.packages <- list.of.packages[!(list.of.packages %in%
                                     installed.packages()[,"Package"])]
if(length(new.packages)) install.packages(new.packages)
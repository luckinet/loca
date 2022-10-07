# script description ----
#
# This script test all output objects that should be available at the end
# of this module.
message("\n---- test-output ----")

# a. pairwise correlations between landuse suitabilities (to explain patterns of allocation)
# b. detect parallel allocation focussing on smaller partner
# c. correlation between these two metrics
# -> enables us to look for more in-situ data to improve the model



# load packages ----
#


# script arguments ----
#


# load metadata ----
#


# load (and visualise) data ----
#
pb <- txtProgressBar(min = 0, max = 9, style = 3, char=">",
                     width=getOption("width")-14)


setTxtProgressBar(pb, 1)

setTxtProgressBar(pb, 2)



# write output ----
#
close(pb)
beep(sound = 10)
message("---- done ----")

# script description ----
#
# This script test all output objects that should be available at the end
# of this module.
message("\n---- test-output ----")


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

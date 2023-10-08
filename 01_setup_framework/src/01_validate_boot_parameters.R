message("\n---- validate boot parameters ----")


# model parameters
#
message(" --> model specs")
assertCharacter(x = model_name, len = 1)
assertCharacter(x = model_version, len = 1, pattern = "([0-9]+)\\.([0-9]+)\\.([0-9]+)(?:-([0-9A-Za-z-]+(?:\\.[0-9A-Za-z-]+)*))?(?:\\+[0-9A-Za-z-]+)?")
assertIntegerish(x = model_years, min.len = 2, all.missing = FALSE)
assertNumeric(x = model_extent, len = 4, lower = -180, upper = 180, any.missing = FALSE)

message(" --> packages available")
message(" --> paths valid")
message(" --> directories present")
message(" --> base files present")

message(" --> variables defined")
assertLogical(x = build_crops, len = 1, any.missing = FALSE)
assertLogical(x = build_livestock, len = 1, any.missing = FALSE)
assertLogical(x = build_landuse, len = 1, any.missing = FALSE)


# beep(sound = 10)
message("     ... done")

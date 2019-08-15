objects_list = c(ls())
# objects_list
selector = ( objects_list == "responses_reserved_copy" )
# selector
objects_list = objects_list[!selector]
# objects_list
rm(list = objects_list)
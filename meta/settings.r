registar_settings = list(
    should_I_send_checkout_error_outside_registar = FALSE,
    externalCheckoutErrorHandler_name = "findSomeVariableNameInRegistry",
    externalCheckoutErrorHandler_location = ""
)


unpack = function (list_of_settings) {
    list2env(list_of_settings, envir = parent.frame())
}
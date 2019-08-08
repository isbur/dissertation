##############
# Переменные #
##############

# По номеру вопроса
correspondence_raw_vector = c("национальность", 2,
                              "срок проживания в РФ", 3,
                              "планы на будущее", 5,
                              "знание языка", 6,
                              "способ решения проблем", 14,
                              "создание семьи", 18,
                              "получение гражданства", 19,
                              "религия", 101,
                              "диаспоральность", 102,
                              "общение и досуг", 103)

correspondence_matrix = matrix(correspondence_raw_vector, ncol=2, byrow = TRUE)

correspondence_named_vector = correspondence_matrix[,2]
names(correspondence_named_vector) = correspondence_matrix[,1]

correspondence = correspondence_named_vector


# Национальность
nationalities_correspondence_vector = c("узбек", 0,
                                        "армянин", 1,
                                        "казах",2)
nationalities_correspondence_matrix = matrix(nationalities_correspondence_vector, ncol=2, byrow = TRUE)


# Религия
religions_correspondence_vector = c("ислам", 0,
                                    "христианство", 1,
                                    "не религиозен", 2)
religions_correspondence_matrix = matrix(religions_correspondence_vector, ncol=2, byrow = TRUE)


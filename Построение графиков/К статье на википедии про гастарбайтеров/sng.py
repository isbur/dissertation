import matplotlib.pyplot as plt
from openpyxl import load_workbook


fig, ax = plt.subplots(figsize=(6, 8), subplot_kw=dict(aspect="equal", anchor = "N"))
hist_data = [25602,
             46898,
             21282,
             71680,
             41165,
             31369,
             63467,
             8734,
             64073,
             150182,
             64581]
hist_labels = ["Азербайджан",
               "Армения",
               "Беларусь",
               "Казахстан",
               "Киргизия",
               "Республика Молдова",
               "Таджикистан",
               "Туркмения",
               "Узбекистан",
               "Украина",
               "Другие страны"]
wedges, texts, autotexts = ax.pie( hist_data, autopct = lambda pct: "{:.1f}%".format(pct), pctdistance = 1.2)
ax.legend(wedges, hist_labels,
          loc="upper center",
          bbox_to_anchor=(0.5, 0))
plt.savefig( "migr.png", bbox_inches = 'tight' )
plt.close()



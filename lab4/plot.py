import csv
from matplotlib import pyplot as plt

if __name__ == "__main__":
    with open("result.csv", "r") as f:
        reader = csv.reader(f, delimiter=";", )
        data = [tuple(int(x) for x in record) for record in reader][1:]

    data.sort()
    x = [record[0] for record in data]
    y = [record[1] for record in data]

    plt.plot(x, y)
    plt.title("Nadwyżki w przedsięwzięciu")
    plt.xlabel("Maksymalny budżet na nadgodziny [PLN]")
    plt.ylabel("Czas trwania przedsięwzięcia [dni]")

    plt.show()

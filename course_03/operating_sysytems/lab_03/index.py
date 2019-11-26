import matplotlib.pyplot as plt
import numpy as np
import system_emulation.system as sys


system = sys.System(intensity=0.75, end_time=400)
system.run(True)
history, _ = system.statistics()

x1 = []
for bid in history:
    delay = bid.processing_start - bid.advent
    x1.append(delay)

plt.figure()
plt.subplot(3, 1, 1)
plt.xlabel("Время ожидания")
plt.ylabel("Количество заявок")

plt.hist(x1)
plt.grid()


x2 = np.arange(0, 2, 0.1)
y2 = []
for i in x2:
    system = sys.System(i, 4, int(1000*(i + 0.1)))
    system.run()
    history_of_bids, _ = system.statistics()

    average_delay = 0
    if len(history_of_bids) > 0:
        delay_sum = 0
        for bid in history_of_bids:
            delay_sum += bid.processing_start - bid.advent

        average_delay = delay_sum / len(history_of_bids)
    y2.append(average_delay)

plt.subplot(3, 1, 2)
plt.xlabel("Интенсивность")
plt.ylabel("Время ожидания")
plt.plot(x2, y2)
plt.grid()


x3 = np.arange(0.02, 1, 0.01)
y3 = []

for i in x3:
    system = sys.System(i, end_time=5000, max_complexity=5)
    system.run()
    _, standing_time = system.statistics()

    y3.append(standing_time)

plt.subplot(3, 1, 3)
plt.xlabel("Интенсивность")
plt.ylabel("Время простоя")
plt.plot(x3, y3)
plt.grid()

plt.tight_layout()
plt.show()

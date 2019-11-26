from scipy.stats import poisson
from scipy import mean


class StandardOutput:
    _counter = 0
    _history = []

    def smooth(self):
        if len(self._history) > 0:
            self._history.sort(key=lambda bid:
                               bid.processing_start - bid.advent)

            mu = mean([bid.processing_start - bid.advent
                       for bid in self._history])

            p = poisson.rvs(mu, size=len(self._history))
            p.sort()

            for i in range(len(self._history)):
                self._history[i]._start = self._history[i].advent + p[i]

            self._history.sort(key=lambda bid: bid._end)

    def echo(self, task):
        self._counter += 1
        # print('Task #', self._counter,
        #       ' advent:', task.advent, '|',
        #       'complexity:', task.complexity, '|',
        #       'processing start:', task.processing_start, '|',
        #       'end:', task.processing_end)
        self._history.append(task)

    def history(self):
        return self._history

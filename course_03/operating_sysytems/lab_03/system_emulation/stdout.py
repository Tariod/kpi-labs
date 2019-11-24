class StandardOutput:
    _counter = 0
    _history = []

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

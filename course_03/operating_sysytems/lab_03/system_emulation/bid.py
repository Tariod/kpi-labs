class Bid():
    _processing = 0
    _start = None
    _end = None

    def __init__(self, advent, complexity):
        self.advent = advent
        self.complexity = complexity

    @property
    def processing_start(self):
        return self._start

    @property
    def processing_end(self):
        return self._end

    def start(self, time):
        self._start = time

    def process(self):
        if self._start is not None:
            self._processing += 1
            return self._processing == self.complexity

    def finalize(self, time):
        if self._processing == self.complexity:
            self._end = time

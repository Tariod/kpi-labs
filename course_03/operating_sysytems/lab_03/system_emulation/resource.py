class Resource:
    _standing_time = 0
    _task = None

    def is_free(self):
        return self._task is None

    def assign(self, bid, time):
        if self.is_free():
            self._task = bid
            self._task.start(time)

    def process(self, time):
        if self.is_free():
            self._standing_time += 1
        else:
            if self._task.process():
                res, self._task = self._task, None
                res.finalize(time + 1)
                return res

    def monitoring(self):
        return self._standing_time

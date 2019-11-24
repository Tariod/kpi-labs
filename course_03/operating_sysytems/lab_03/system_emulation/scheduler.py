class Scheduler:
    def __init__(self, resource, algoritm):
        self._algoritm = algoritm
        self._resource = resource
        self._queue = []

    def tick(self, time, *bids):
        self._queue.extend(bids)
        if self._resource.is_free():
            i = self._algoritm(self._queue)
            if i is not None:
                task = self._queue.pop(i)
                self._resource.assign(task, time)

        return self._resource.process(time)

    def is_free(self):
        return len(self._queue) == 0 and self._resource.is_free()

    def monitoring(self):
        return self._resource.monitoring()

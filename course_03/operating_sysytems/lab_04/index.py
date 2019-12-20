from datetime import datetime
import numpy as np
import plotly.figure_factory as ff
import random


class Resource:
    def __init__(self, title):
        self.title = title
        self.task = None

    def is_free(self):
        return self.task is None

    def set_task(self, task, time):
        self.task = task
        self.task.set_resource(self.title, time)

    def process(self):
        task = self.task
        if task:
            weights[task.title] -= 1
            if weights[task.title] == 0:
                self.task = None
                return task


class Task:
    def __init__(self, title, weight):
        self.title = title
        self.weight = weight

    def set_resource(self, resource, start):
        self.start = start
        self.resource = resource


adjacency_matrix = [
    [0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
    [0, 0, 0, 0, 4, 4, 0, 0, 0, 0, 0, 0, 0, 0, 0],
    [0, 0, 0, 0, 0, 1, 2, 0, 0, 0, 0, 0, 0, 0, 0],
    [0, 0, 0, 0, 0, 0, 5, 0, 0, 0, 0, 7, 0, 0, 0],
    [0, 0, 0, 0, 0, 0, 0, 2, 1, 0, 0, 0, 0, 0, 0],
    [0, 0, 0, 0, 0, 0, 0, 0, 4, 6, 0, 0, 0, 0, 0],
    [0, 0, 0, 0, 0, 0, 0, 0, 0, 2, 3, 0, 0, 0, 0],
    [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 4, 0, 0],
    [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2, 3, 0],
    [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 4, 1],
    [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 5],
    [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 4],
    [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
    [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
    [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]
]

weights = [2, 3, 1, 4, 5, 2, 3, 4, 5, 1, 3, 6, 2, 3, 5]

# adjacency_matrix = [
#     [0, 0, 3, 4, 0],
#     [0, 0, 0, 2, 3],
#     [0, 0, 0, 0, 0],
#     [0, 0, 0, 0, 0],
#     [0, 0, 0, 0, 0]
# ]
# weights = [2, 3, 1, 4, 5]

resources = 4

cm = [Resource(title) for title in range(resources)]


def get_free_resources():
    return list(filter(lambda resource: resource.is_free(), cm))


def get_ready():
    processing = []
    for resource in cm:
        if not resource.is_free():
            processing.append(resource.task.title)

    ready = []
    for task, weight in enumerate(weights):
        parents = [row[task] for row in adjacency_matrix]
        if weight > 0 and not any(
            [task == i for i in processing]
        ) and all([parent == 0 for parent in parents]):
            ready.append(task)
    return ready


def get_ready_for_resource(resource):
    ready = []
    for task, weight in enumerate(weights):
        if weight > 0:
            col = [row[task] for row in adjacency_matrix]
            parents = []
            for i in range(len(col)):
                if col[i] != 0:
                    if weights[i] != 0:
                        parents = []
                        break
                    for pending_task in pending:
                        if pending_task.title == i:
                            parents.append(pending_task)
            if len(parents) > 0 and all([
                parent.resource == resource.title for parent in parents
            ]):
                ready.append(task)
    return ready


def process():
    processed = []
    for resource in cm:
        task = resource.process()
        if task:
            processed.append(task)
    return processed


def wait(pending):
    for task in pending:
        for i in range(len(weights)):
            if adjacency_matrix[task.title][i] != 0:
                adjacency_matrix[task.title][i] -= 1


def get_finalized(pending):
    finalized = []
    for task in pending:
        if all([forwarding == 0 for forwarding
                in adjacency_matrix[task.title]]):
            finalized.append(task)

    for task in finalized:
        pending.remove(task)

    return finalized


pending = []
finalized = []
time = 0
while len(finalized) != len(weights):
    free_resources = get_free_resources()
    if len(free_resources) > 0:
        ready = get_ready()
        for resource in free_resources:
            if len(ready) > 0:
                index = ready.pop(0)
                task = Task(index, weights[index])
                resource.set_task(task, time)
            else:
                ready_for_resource = get_ready_for_resource(resource)
                if len(ready_for_resource) > 0:
                    index = ready_for_resource.pop(0)
                    for row in range(len(weights)):
                        adjacency_matrix[row][index] = 0
                    task = Task(index, weights[index])
                    resource.set_task(task, time)
    finalized = finalized + get_finalized(pending)
    wait(pending)
    pending = pending + process()
    time += 1


def to_date(x):
    return datetime.fromtimestamp(x * 24 * 3600).strftime("%Y-%m-%d")


df = [dict(
    Task=task.resource,
    Start=to_date(task.start),
    Finish=to_date(task.start + task.weight),
    Title=task.title
) for task in finalized]
df.sort(key=lambda task: task['Task'])

num_tick_labels = [i for i in range(1000)]
date_ticks = [to_date(x) for x in num_tick_labels]


def random_color():
    levels = np.arange(0, 1, 0.1)
    return tuple(random.choice(levels) for _ in range(3))


colors = {i: random_color() for i in range(len(finalized))}

fig = ff.create_gantt(
    df,
    colors=colors,
    index_col='Title',
    group_tasks=True,
    showgrid_x=True)
fig.update_xaxes(tickvals=date_ticks, ticktext=num_tick_labels)
fig.show()

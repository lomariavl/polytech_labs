import random
from OpenGL.GL import *


class Collider:
    def __init__(self, plane_center, plane_size):
        self.plane_center = plane_center
        self.plane_size = plane_size

    def draw_collider(self):
        glBegin(GL_QUADS)
        glColor3f(1.0, 1.0, 1.0)
        glVertex3f(self.plane_center[0] - self.plane_size / 2, self.plane_center[1],
                   self.plane_center[2] - self.plane_size / 2)  # Нижний левый угол
        glVertex3f(self.plane_center[0] + self.plane_size / 2, self.plane_center[1],
                   self.plane_center[2] - self.plane_size / 2)  # Нижний правый угол
        glVertex3f(self.plane_center[0] + self.plane_size / 2, self.plane_center[1],
                   self.plane_center[2] + self.plane_size / 2)  # Верхний правый угол
        glVertex3f(self.plane_center[0] - self.plane_size / 2, self.plane_center[1],
                   self.plane_center[2] + self.plane_size / 2)  # Верхний левый угол
        glEnd()


class Teapot:

    def __init__(self, coordinates, size):
        self.coordinates = coordinates
        self.size = size
        self.ttl = 150
        self.vector = [(random.random() - 0.5) * 0.1, 0.1, (random.random() - 0.5) * 0.1]

    def is_crossing_collider(self, collider: Collider) -> bool:
        if (self.coordinates[0] < collider.plane_center[0] - collider.plane_size / 2 or
                self.coordinates[0] > collider.plane_center[0] + collider.plane_size / 2):
            return False
        if (self.coordinates[2] < collider.plane_center[2] - collider.plane_size / 2 or
                self.coordinates[2] > collider.plane_center[2] + collider.plane_size / 2):
            return False
        if self.coordinates[1] < collider.plane_center[1]:
            return False

        return True

    def update(self, collider: Collider):
        if self.is_crossing_collider(collider):
            dot_product = sum(v * n for v, n in zip(self.vector, [0, 1, 0]))
            reflected_vector = [v - 2 * dot_product * n for v, n in zip(self.vector, [0, 1, 0])]
            self.vector = reflected_vector

        self.ttl -= 1
        self.size *= 1.029
        for v in range(3):
            self.vector[v] *= 1.025

        self.coordinates[0] += self.vector[0]
        self.coordinates[1] += self.vector[1]
        self.coordinates[2] += self.vector[2]

    def is_alive(self):
        return self.ttl > 0


class Emitter:
    def __init__(self, plane_center, plane_size):
        self.plane_center = plane_center
        self.plane_size = plane_size

    def generate_emitter(self):
        glBegin(GL_QUADS)
        glColor3f(1.0, 1.0, 1.0)
        glVertex3f(self.plane_center[0] - self.plane_size / 2, self.plane_center[1],
                   self.plane_center[2] - self.plane_size / 2)  # Нижний левый угол
        glVertex3f(self.plane_center[0] + self.plane_size / 2, self.plane_center[1],
                   self.plane_center[2] - self.plane_size / 2)  # Нижний правый угол
        glVertex3f(self.plane_center[0] + self.plane_size / 2, self.plane_center[1],
                   self.plane_center[2] + self.plane_size / 2)  # Верхний правый угол
        glVertex3f(self.plane_center[0] - self.plane_size / 2, self.plane_center[1],
                   self.plane_center[2] + self.plane_size / 2)  # Верхний левый угол
        glEnd()

    def emit(self):
        x = (self.plane_center[0] - self.plane_size / 2) + random.random() * self.plane_size
        z = (self.plane_center[2] - self.plane_size / 2) + random.random() * self.plane_size
        new_teapot = Teapot([x, self.plane_center[1], z], 0.1)
        return new_teapot

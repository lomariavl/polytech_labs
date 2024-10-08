import math

from OpenGL.GL import *
from OpenGL.GLUT import *
from OpenGL.GLU import *

cylinder_y = 0.0
object_x = 0.0
object_y = 0.0
object_z = 0.0
moving_down = True


def draw_object():
    glTranslatef(object_x, object_y, object_z)
    draw_cylinder(1.0, 2.0, 20)


def draw_cylinder(radius, height, slices):
    glColor3f(0, 0, 1.0)
    global cylinder_y

    glBegin(GL_LINES)
    for i in range(slices):
        angle = 2 * math.pi * i / slices
        x1 = radius * math.cos(angle)
        y1 = radius * math.sin(angle) + cylinder_y
        x2 = radius * math.cos(angle + 2 * math.pi / slices)
        y2 = radius * math.sin(angle + 2 * math.pi / slices) + cylinder_y

        glVertex3f(x1, y1, -height / 2)
        glVertex3f(x2, y2, -height / 2)

        glVertex3f(x1, y1, height / 2)
        glVertex3f(x2, y2, height / 2)

        glVertex3f(x1, y1, -height / 2)
        glVertex3f(x1, y1, height / 2)

    glEnd()


def draw_tetrahedron():
    glColor3f(0, 1.0, 0)
    glPushMatrix()
    glutWireTetrahedron()
    glPopMatrix()


def display():
    glClear(GL_COLOR_BUFFER_BIT | GL_DEPTH_BUFFER_BIT)
    glLoadIdentity()
    gluLookAt(5, 5, 0, 0, 0, 0, 0, 1, 0)

    draw_tetrahedron()
    draw_object()
    glutSwapBuffers()


def reshape(width, height):
    glViewport(0, 0, width, height)
    glMatrixMode(GL_PROJECTION)
    glLoadIdentity()
    gluPerspective(45, width / height, 0.1, 100.0)
    glMatrixMode(GL_MODELVIEW)
    glLoadIdentity()


def move_object():
    global object_y, moving_down

    if moving_down:
        object_y -= 0.1
        if object_y <= -5.0:
            moving_down = False
    else:
        object_y += 0.1
        if object_y >= 5.0:
            moving_down = True

    glutPostRedisplay()


def main():
    glutInit()
    glutInitDisplayMode(GLUT_DOUBLE | GLUT_RGB | GLUT_DEPTH)
    glutInitWindowSize(800, 600)
    glutCreateWindow(b"Tetrahedron and cylinder")
    glEnable(GL_DEPTH_TEST)
    glClearColor(0.0, 0.0, 0.0, 1.0)
    glutDisplayFunc(display)
    glutReshapeFunc(reshape)
    glutIdleFunc(move_object)
    glutMainLoop()


if __name__ == "__main__":
    main()

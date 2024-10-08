from OpenGL.GL import *
from OpenGL.GLUT import *
from OpenGL.GLU import *

import math


def draw_sphere(radius, slices, stacks):
    for i in range(stacks):
        lat0 = 3.141592653589793 * (-0.5 + i / stacks)
        z0 = math.sin(lat0)
        zr0 = math.cos(lat0)

        lat1 = 3.141592653589793 * (-0.5 + (i + 1) / stacks)
        z1 = math.sin(lat1)
        zr1 = math.cos(lat1)

        glBegin(GL_LINE_LOOP)
        for j in range(slices):
            lng = 2 * 3.141592653589793 * j / slices
            x = math.cos(lng)
            y = math.sin(lng)
            glVertex3f(x * zr0 * radius, y * zr0 * radius, z0 * radius)
        glEnd()

        glBegin(GL_LINES)
        for j in range(slices):
            lng = 2 * 3.141592653589793 * j / slices
            x0 = math.cos(lng)
            y0 = math.sin(lng)
            glVertex3f(x0 * zr0 * radius, y0 * zr0 * radius, z0 * radius)
            glVertex3f(x0 * zr1 * radius, y0 * zr1 * radius, z1 * radius)
        glEnd()


def draw_teapot():
    global scale
    glPushMatrix()
    glColor3f(1.0, 0.0, 0.0)
    glScalef(scale, scale, scale)
    glutSolidTeapot(1.0)
    glPopMatrix()


def display():
    glClear(GL_COLOR_BUFFER_BIT | GL_DEPTH_BUFFER_BIT)
    glLoadIdentity()
    gluLookAt(0, 0, 5, 0, 0, 0, 0, 1, 0)

    glColor3f(1.0, 1.0, 1.0)
    glTranslatef(0.0, 0.0, 0.0)
    draw_sphere(1.75, 20, 20)

    glTranslatef(0.0, 0.0, 0.0)
    draw_teapot()

    glutSwapBuffers()


def keyboard(key, x, y):
    global scale
    if key == b'=':
        scale *= 1.1
    elif key == b'-':
        scale /= 1.1

    glutPostRedisplay()


def reshape(width, height):
    glViewport(0, 0, width, height)
    glMatrixMode(GL_PROJECTION)
    glLoadIdentity()
    gluPerspective(45, width / height, 0.1, 100.0)
    glMatrixMode(GL_MODELVIEW)
    glLoadIdentity()


def main():
    global scale
    scale = 1.0
    glutInit()
    glutInitDisplayMode(GLUT_DOUBLE | GLUT_RGB | GLUT_DEPTH)
    glutInitWindowSize(800, 600)
    glutCreateWindow(b"Wireframe Sphere with wireframe Teapot")
    glEnable(GL_DEPTH_TEST)
    glClearColor(0.0, 0.0, 0.0, 1.0)
    glutDisplayFunc(display)
    glutReshapeFunc(reshape)
    glutKeyboardFunc(keyboard)
    glutMainLoop()


if __name__ == "__main__":
    main()

from OpenGL.GL import *
from OpenGL.GLU import *
from OpenGL.GLUT import *
from dependencies import Emitter, Teapot, Collider

frame_interval = 10
center_emitter = (0, 0, 0)  # Центр плоскости
plane_size = 6.0  # Размер плоскости
emitter_size = 4
center_collider = (0, 5, 0)

frame_count = 0


teapots: list[Teapot] = []

emitter = [
    Emitter(center_emitter, emitter_size)
]

collider = Collider(center_collider, plane_size)


def draw_teapot(teapot: Teapot):
    coordinate = teapot.coordinates
    size = teapot.size

    glPushMatrix()
    glColor3f(1.0, 0.0, 0.0)

    glTranslatef(coordinate[0], coordinate[1], coordinate[2])  # Перемещение в указанные координаты
    glutSolidTeapot(size)
    glPopMatrix()


def display():
    global frame_count
    glClear(GL_COLOR_BUFFER_BIT | GL_DEPTH_BUFFER_BIT)
    glLoadIdentity()

    # 'eyeX', 'eyeY', 'eyeZ',
    # 'centerX', 'centerY', 'centerZ',
    # 'upX', 'upY', 'upZ'
    gluLookAt(-30, 16, -30,
              0, 3, 0,
              0, 1, 0)
    # gluLookAt(6, -10, 6,
    #           0, 6, 0,
    #           0, 1, 0)

    for e in emitter:
        e.generate_emitter()
        if frame_count == 0:
            teapots.append(e.emit())

    for t in teapots:
        if t.is_alive():
            t.update(collider)
        else:
            teapots.remove(t)

    for teapot in teapots:
        draw_teapot(teapot)

    collider.draw_collider()

    frame_count = (frame_count + 1) % 10

    glutSwapBuffers()


def update_scene(_):
    glutPostRedisplay()
    glutTimerFunc(frame_interval, update_scene, 0)


def main():
    glutInit()
    glutInitDisplayMode(GLUT_DOUBLE | GLUT_RGB | GLUT_DEPTH)
    glutInitWindowSize(800, 600)
    glutCreateWindow('Coursework, 28')

    glEnable(GL_DEPTH_TEST)

    glClearColor(0.0, 0.0, 0.0, 1.0)
    glutDisplayFunc(display)
    glMatrixMode(GL_PROJECTION)
    gluPerspective(45, 1, 0.1, 50)
    glMatrixMode(GL_MODELVIEW)
    glutTimerFunc(frame_interval, update_scene, 0)

    glutMainLoop()


if __name__ == "__main__":
    main()

from OpenGL.GL import *
from OpenGL.GLUT import *
from OpenGL.GLU import *
from pygame import image

texture_id = ''
light_intensity = 0.2  # Изначальная интенсивность света
light_color = [1.0, 1.0, 1.0, 1.0]  # Изначальный цвет света
position_light = [1.0, 1.0, 1.0, 1.0]


def init_light():
    glEnable(GL_LIGHTING)  # Включаем расчет освещения
    glEnable(GL_LIGHT0)  # Включаем источник света №0

    update_light()


def change_position_light(x):
    global position_light
    position_light[0] += x
    print(position_light)
    update_light()


def update_light():
    global position_light
    glLightfv(GL_LIGHT0, GL_POSITION, position_light)  # Положение источника света
    glLightfv(GL_LIGHT0, GL_DIFFUSE, light_color)  # Цвет источника света


def change_light_intensity(delta):
    global light_intensity
    light_intensity += delta
    if light_intensity < 0.0:
        light_intensity = 0.0
    glLightf(GL_LIGHT0, GL_DIFFUSE, light_intensity)
    glLightfv(GL_LIGHT0, GL_AMBIENT, [light_intensity] * 4)


def change_light_color(color):
    global light_color
    light_color = color
    update_light()


def keyboard(key, x, y):
    global light_intensity
    if key == b'+':
        change_light_intensity(0.05)
    elif key == b'-':
        change_light_intensity(-0.05)
    elif key == b'r':
        change_light_color([1.0, 0.0, 0.0, 1.0])  # Красный цвет света
    elif key == b'g':
        change_light_color([0.0, 1.0, 0.0, 1.0])  # Зеленый цвет света
    elif key == b'b':
        change_light_color([0.0, 0.0, 1.0, 1.0])  # Синий цвет света
    elif key == b'x':
        change_position_light(-1)
    elif key == b'X':
        change_position_light(1)

    glutPostRedisplay()


def load_texture(image_name):
    textureSurface = image.load(image_name)
    textureData = image.tostring(textureSurface, "RGBA", True)

    width = textureSurface.get_width()
    height = textureSurface.get_height()

    texture_id = glGenTextures(1)
    glBindTexture(GL_TEXTURE_2D, texture_id)
    glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MIN_FILTER, GL_LINEAR)
    glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MAG_FILTER, GL_LINEAR)
    glTexImage2D(GL_TEXTURE_2D, 0, GL_RGBA, width, height, 0, GL_RGBA, GL_UNSIGNED_BYTE, textureData)

    return texture_id


# def load_texture(image_name):
#     textureSurface = image.load(image_name)
#     textureData = image.tostring(textureSurface, "RGBA", True)
#
#     width = textureSurface.get_width()
#     height = textureSurface.get_height()
#
#     texture_id = glGenTextures(1)
#     glBindTexture(GL_TEXTURE_2D, texture_id)
#     glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MIN_FILTER, GL_LINEAR)
#     glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MAG_FILTER, GL_LINEAR)
#     glTexImage2D(GL_TEXTURE_2D, 0, GL_RGBA, width, height, 0, GL_RGBA, GL_UNSIGNED_BYTE, textureData)
#
#     return texture_id


def draw_cylinder():
    global texture_id
    quadric = gluNewQuadric()
    glEnable(GL_TEXTURE_2D)
    glBindTexture(GL_TEXTURE_2D, texture_id)
    gluQuadricTexture(quadric, GL_TRUE)
    glPushMatrix()
    glColor4f(1, 1, 1, 1)
    glTranslatef(2, 1, -1)
    glRotatef(90, 1, 0, 0)
    glMaterialfv(GL_FRONT, GL_AMBIENT_AND_DIFFUSE, [0, 0, 1, 1])
    glMaterialfv(GL_FRONT, GL_SPECULAR, [0, 0, 0, 1])
    glMaterialf(GL_FRONT, GL_SHININESS, 0)
    gluCylinder(quadric, 0.6, 0.6, 1, 30, 20)
    glPopMatrix()
    glDisable(GL_TEXTURE_2D)


def draw_sphere(radius, slices, stacks):
    glColor4f(1, 1, 0, 0.6)
    glTranslatef(-0.5, 1, -0.5)
    glScalef(0.5, 0.5, -0.5)
    quadric = gluNewQuadric()
    # gluQuadricDrawStyle(quadric,)  # Устанавливаем стиль рисования - solid
    gluSphere(quadric, radius, slices, stacks)


def draw_teapot():
    glPushMatrix()
    glColor4f(1.0, 0.0, 1.0, 1)

    # Устанавливаем параметры материала
    glMaterialfv(GL_FRONT, GL_AMBIENT, [0.0215, 0.1745, 0.0215, 1.0])
    glMaterialfv(GL_FRONT, GL_DIFFUSE, [0.07568, 0.61424, 0.07568, 1.0])
    glMaterialfv(GL_FRONT, GL_SPECULAR, [0.633, 0.727811, 0.633, 1.0])
    glMaterialf(GL_FRONT, GL_SHININESS, 15.8)

    glutSolidTeapot(1.0)
    glPopMatrix()


def display():
    glClear(GL_COLOR_BUFFER_BIT | GL_DEPTH_BUFFER_BIT)
    glLoadIdentity()
    init_light()
    gluLookAt(5, 5, 5, 0, 0, 0, 0, 1, 0)  # Камера смотрит на (0, 0, 0)

    draw_teapot()
    draw_cylinder()
    draw_sphere(1.75, 20, 20)
    glutSwapBuffers()


def reshape(width, height):
    glViewport(0, 0, width, height)
    glMatrixMode(GL_PROJECTION)
    glLoadIdentity()
    gluPerspective(45, width / height, 0.1, 100.0)
    glMatrixMode(GL_MODELVIEW)
    glLoadIdentity()


def main():
    glutInit()
    glutInitDisplayMode(GLUT_DOUBLE | GLUT_RGBA | GLUT_DEPTH)
    glutInitWindowSize(800, 600)
    glutCreateWindow(b"Shiny Teapot")
    glEnable(GL_DEPTH_TEST)
    glEnable(GL_BLEND)
    glBlendFunc(GL_SRC_ALPHA, GL_ONE_MINUS_SRC_ALPHA)
    glClearColor(0.0, 0.0, 0.0, 1.0)

    glEnable(GL_COLOR_MATERIAL)
    glEnable(GL_NORMALIZE)

    glutDisplayFunc(display)
    glutKeyboardFunc(keyboard)
    glutReshapeFunc(reshape)

    global texture_id

    texture_id = load_texture("../pngwing.com.png")
    glutMainLoop()


if __name__ == "__main__":
    main()

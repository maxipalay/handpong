# handpong

![HandPong Logo] (hangpong-logo.jpeg)

### ¿Qué es HandPong?

Es nuestra visión moderna del reconocido juego "pong". No hacen falta mandos para jugar, solo basta con mover las manos!

Dos modos de juego: 
  - un jugador, estilo frontón
  - dos jugadores, uno contra uno

### Tecnologías utilizadas

Unity: es el motor de la interfaz gráfica del juego.

Matlab: es la herramienta con la cual se desarrolló la interfaz de control a través de técnicas de IA.

### ¿Cómo funciona?

Implementamos una red neuronal YOLOv2 que usa las características extraídas por una MobileNetv2 pre-entrenada en el dataset ImageNet. Esta red MobilenetV2+YOLOv2 es lo que proporciona la capacidad de detectar manos en tiempo real!

Entrenamos la red para nuestra aplicación utilizando dos datasets de terceros (ver referencias al final), Nombre1 y Nombre2
y creamos uno nuevo donde etiquetamos unas ~1200 fotos para entrenar la red neuronal con escenarios mas similares a los del videojuego.

Creamos en Unity una interfaz basada en el antiguo Pong, y le dimos nuestro propio toque moderno.

Conectamos el videojuego de Unity con Matlab a traves de comunicación TCP. Matlab detecta continuamente las imagenes captadas por la webcam y a través de un puerto pasa la información al motor Unity para que mueva las palas.

## HandPong realizado por

JORGE CRISTÓBAL ASCASO, 
MAXIMILIANO NICOLÁS PALAY SILVA, 
FELIPE ANGEL PASCUAL TORTOLA, 
PAULA TOMÁS COLLADO 
en el marco de la asignatura Sistemas Complejos Bioinspirados de la Univesidad Politecnica de Valencia, dictada por Andreu M. Climent, PhD.

2020
## Referencias/Créditos

Este proyecto fue hecho en el marco de la asignatura Sistemas Complejos Bioinspirados en la Universidad Politécnica de Valencia, dictada por Andreu M. Climent, PhD.

REFERENCIA DATASET1

REFERENCIA DATASET2

REFERENCIA A NUESTRO DATASET

Otras referencias, como documentación de Matlab utilizada pueden encontrarse en los archivos de código como comentarios.

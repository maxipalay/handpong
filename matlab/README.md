# Descripción de los archivos con los fuentes de Matlab

### Nota
Para poder usar este codigo con los datasets, debe descargarlos y colocarlos de la siguiente manera. No se exponen los datos en este repositorio, solo las referencias.

1) Descargar los datos de las tres referencias.
2) Crear tres directorios dentro del directorio "matlab": "dataset_hands", "dataset_egohands", "dataset_max"

En el directorio "dataset_hands" debe copiar el contenido de la descarga del Dataset Hands, debe colocar el contenido de tal manera que el directorio quede con la siguiente estructura:
- dataset_hands/README.txt
- dataset_hands/validation_dataset
- dataset_hands/training_dataset
- ...

En el directorio "dataset_egohands" debe copiar el contenido de la descarga del dataset Egoands, debe colocar el contenido de tal manera que el directorio quede con la siguiente estructura:
- dataset_egohands/README.txt
- dataset_egohands/metadata.mat
- dataset_egohands/DEMO_1.m
- ...

En el directorio dataset_max debe copiar el contenido de la descarga del dataset elaborado por nosotros, debe colocar el contenido de tal manera que el directorio quede con la siguiente estructura:
- dataset_max/data_maxihands.mat
- dataset_max/getframesandboxes.m
- dataset_max/pictures
- ...

## codigo fuente
- data_processing_hands.m - Procesa las imagenes y etiquetas del dataset Hands para que sea mas sencillo trabajar con los datos, genera el archivo data_hands.mat
- data_processing_egohands.m - Procesa las imagenes y etiquetas del dataset Egohands para que sea mas sencillo trabajar con los datos, genera el archivo data_egohands.mat
- data_processing_merge.m - Abre los archivos data_*.mat, los fusiona, mezcla el orden de los datos de forma aleatoria, separa los datos en tres sets (entrenamiento, validacion y evaluacion) y genera los archivos full_dataset_*.mat

- YOLOv2_network_creation.m - Crea un red neuronal YOLOv2 utilizando un extractor de features MobilenetV2
- YOLOv2_network_training.m - Entrena la red neuronal YOLOv2
- YOLOv2_network_evaluation.m - Evalua la red neuronal YOLOv2 entrenada
- YOLOv2_network_inference_optimized.m - A traves de la webcam permite visualizar las detecciones de la camara, de hasta dos manos, y una por cada mitad de la imagen (izquierda/derecha)

- handpong.m - Es básicamente YOLOv2_network_inference_optimized, pero con comunicación TCP agregada. Es este archivo el que ejecutamos en Matlab al ejecutar el videojuego.

## archivos
- data_maxihands.mat - contiene las referencias a las imágenes etiquetadas del set de elaboracion propia.
- data_hands.mat - contiene las referencias a las imágenes etiquetadas del set Hands.
- data_egohands.mat - contiene las referencias a las imágenes etiquetadas del set Egohands.

- full_dataset_training.mat - Contiene las referencias a una porcion de los datos ordenados aleatoriamente, que son utilizados - para entrenar la red.
- full_dataset_validation.mat - Contiene las referencias a una porcion de los datos ordenados aleatoriamente, que son utilizados para validar el comportamiento de la red en el entrenamiento.
- full_dataset_evaluation.mat - Contiene las referencias a una porcion de los datos ordenados aleatoriamente, que son utilizados para evaluar el rendimiento de la red.





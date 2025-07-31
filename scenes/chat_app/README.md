# sistema dialogo

## formato JSON
- dialogo es por medio de un json
    - su formato es 
        - personajes string
            -el que habla
        - lineas, contiene un array, con las lineas de dialogo
        - lineas_2 (opcional),array, permite tener dos rutas de dialogo esta seria la segunda ruta
        - command(opcional) array, aqui contiene commandos como "cambiar de imagen", "reproducir sonito" etc... aun falta formalizar los comandos, solo es la base
        - siguiente, diccionario, que contiene todo lo anterior, se utiliza para avanzar la conversacion de forma logica y poder tener todo en un json por conversacion
    - ver conversacion de referencia con excepcion de (opcional) todo tiene que segir este formato

## chat_app.gd
    - se encarga de leer el json de dialogo he "imprimir" las lineas de dialogo como si fuera un app de chat
    - imprimir botones de opciones
    - tomar deciciones de que rama de dialogo se va a imprimir
    - y varias cosas mas
    - aun esta en fase de desarrollo


personaje : player
lineas: blabla

personaje: furry
lineas: bla
command: empieza a loore

personaje: opciones
lineas opcion 1
lineas_2 opcion2

personajes player
lineas branch 1
lineas_2 branch 2
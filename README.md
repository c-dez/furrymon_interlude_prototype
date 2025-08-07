# carpeta photos se debe de agregar a res://nsfw
# dialogo se avanza con tecla "space" o "enter"
# Descripcion:
- Sistema de dialogo tipo chat
- muestra dialogo segun quien es el que habla
- muestra imagen
- hay botones para dos opciones que el jugador puede elegir
- el sistema de dialogos toma deciciones por medio de commands (strings)
    - se creo un sistema de commandos por medio de un string, este string se declara en el dialogo.json dentro de key "commands":y se divide y cada parte de el es evaluada en un match para realizar acciones
    - que pasa al elegir un boton de opcion
    - cambiar de imagen

# por hacer:
- estandarizar sintaxis de commnads
    - cambiar imagenes, reproducir sonidos etc
- implementar sistema de save/load game
- solo un sistema( chat_app) ha sido creado hasta ahora en el futuro necesito un manager para los distintos sistemas
- indicacion visual de que el dialogo ha terminado

# me gustaria:
- estilizar dialogo, resaltar, cambiar color de palabras

# IMPORTANTE:
- las imagenes se almacenan en carpeta nsfw y esta esta en gitignore
# TP3-Mundial-Ortiz-Serrano
trabajo practico de metodologia de desarrollo de videojuegos, temática mundial.
un juego de sigilo en el que el objetivo es secarle la nuca al chiqui (quien va a tener una barra de sudor) cuando se da vuelta y no estes en su rango de vision. Ahi te vas a poder acercar y tocar una tecla para secarle la nuca y bajarle la vida, si se da vuelta y te ve, te va a atacar con un pañuelo mojado y sacarte vida. Vas a tener que ocultarte y buscar el momento mas oportuno para secarle la nuca. El juego comtará con dos personajes jugables: Leandro Paredes y Angel Di María, Paredes hace más daño y Di María tiene más vida. El objetivo es secarle la nuca al chiqui hasta dejarsela seca

# controles
1. Movilidad: WASD
2. Ataque: space
3. Secar pañuelo: r
4. Agarra los pañuelos del piso, al pasar el juego apareceran mejores pañuelos
5. anda por detras de el chiqui, si entras en su campo de vision te va a atacar


# Aclaracion 
copilot aparece como colaborador por los merges entre los pull request de las ramas features y bugs con la rama main, para resolver conflictos entre archivos imports y imagenes. 

# Guía de Flujo de Trabajo en Git

Para mantener el proyecto ordenado y evitar conflictos, vamos a usar un flujo de trabajo basado en **Feature Branches** (Ramas por Tarea). 

Cada mecánica, mapa o menú nuevo se hace en su propia rama y, una vez terminado y revisado, se integra al juego principal.

---

## Desarrollo



### 1. Actualizar repo
Antes de abrir Godot chequea estar en la ultima version del repo
```bash
git checkout main
git pull origin main
```

### 2. Crear rama de trabajo
Creá una rama nueva exclusiva para la tarea que vas a hacer y pasate a ella. Usá un nombre descriptivo con el prefijo `feature/` (para mecánicas nuevas) o `fix/` (para arreglar bugs).

```bash
git checkout -b feature/nombre-de-tu-tarea
```

### 3. Subir la rama a GitHub
Cuando consideres que la tarea está terminada y lista para sumarse al juego, subí tu rama al repositorio remoto.

```bash
git push origin feature/nombre-de-tu-tarea
```

### 4. Crear el Pull Request (PR) y Revisión
1. Entrá a la página del repositorio en GitHub. Te va a aparecer un botón verde sugiriendo crear un **"Compare & pull request"** con tu rama recién subida.
2. Creá el PR dejando un pequeño comentario de qué archivos tocaste o qué hace el código nuevo.
3. El otro desarrollador entra, revisa los cambios para confirmar que todo esté en orden y no rompa nada, y le da al botón **Merge Pull Request**.


### 5. Limpieza y vuelta a empezar
Una vez que el PR está aprobado y fusionado, la rama que creaste ya cumplió su función y no se usa más. Podés borrarla en GitHub para mantener todo limpio. Para agarrar la siguiente tarea, volvés al Paso 1.

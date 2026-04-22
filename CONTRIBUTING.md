# Guía de Contribución

¡Gracias por contribuir a este proyecto! Por favor lee este documento antes de empezar a trabajar.

---

## Tabla de contenidos

- [Flujo de trabajo con Git](#flujo-de-trabajo-con-git)
- [Convención de commits](#convención-de-commits)
- [Convención de ramas](#convención-de-ramas)
- [Pull Requests](#pull-requests)
- [Estilo de código SQL](#estilo-de-código-sql)
- [Operaciones comunes con Git](#operaciones-comunes-con-git)
- [Reportar problemas](#reportar-problemas)

---

## Flujo de trabajo con Git

1. Clona el repositorio y asegúrate de estar actualizado:
   ```bash
   git clone https://github.com/AngieG-dev/sql-sistema-ventas.git
   git checkout main
   git pull origin main
   ```

2. Crea una rama nueva para tu tarea (ver [Convención de ramas](#convención-de-ramas)):
   ```bash
   git checkout -b feature/NombreApellido
   ```

3. Trabaja en tu rama, haciendo commits pequeños y frecuentes.

4. Antes de abrir un PR, sincroniza con `main`:
   ```bash
   git checkout feature/NombreApellido
   git fetch origin
   git rebase origin/main
   ```

5. Abre un Pull Request hacia `main` y solicita revisión al dueño del repositorio.

> ⚠️ **Nunca hagas push directo a `main`.** Todo cambio debe pasar por PR.

---

## Convención de commits

Usamos [Conventional Commits](https://www.conventionalcommits.org/es/). El formato es:

```
<tipo>(<ámbito>): <descripción breve en imperativo>
```

### Tipos permitidos

| Tipo       | Cuándo usarlo                                          |
|------------|--------------------------------------------------------|
| `feat`     | Nueva consulta o funcionalidad SQL                     |
| `fix`      | Corrección de una consulta con error                   |
| `docs`     | Cambios solo en documentación o README                 |
| `style`    | Formato, indentación o comentarios (sin cambio lógico) |
| `refactor` | Reestructuración de consultas sin cambiar resultados   |
| `chore`    | Tareas de mantenimiento, configuración del repo        |

### Ejemplos

```
feat(report.sql): agregar consultas de nivel 3 con agregaciones
fix(report.sql): corregir JOIN en consulta de detalle de ventas
docs(README.md): agregar diagrama ER en Mermaid
style(report.sql): agregar comentarios separadores entre niveles
```

---

## Convención de ramas

```
feature/<NombreApellido>
```

### Ejemplos

```
feature/DiegoCastillo
feature/JulioOyarzun
feature/AngelaGalleguillos
```

---

## Pull Requests

Antes de abrir un PR asegúrate de:

- [ ] Tu rama está actualizada con `main`
- [ ] Las consultas SQL se ejecutan sin errores en PostgreSQL
- [ ] El archivo `report.sql` tiene todas las consultas comentadas y ordenadas
- [ ] Seguiste las convenciones de commits y ramas
- [ ] El PR tiene un título descriptivo siguiendo la convención de commits
- [ ] Agregaste una descripción breve de qué cambia y por qué

Un PR debe ser revisado y aprobado por el dueño del repositorio antes de hacer merge.

Para crear un PR, luego de hacer push a tu rama, ingresa al [repositorio en GitHub](https://github.com/AngieG-dev/sql-sistema-ventas) y haz clic en el botón verde que aparece para crear la PR.

### Plantilla de descripción de la PR

En la descripción de la Pull Request copia y pega este texto, agrega la descripción breve y marca con una `x` lo que aplique.

```markdown
## Descripción
Breve explicación del cambio: qué consultas se agregan o corrigen y por qué.

## Tipo de cambio
- [ ] Fix (corrección de consulta con error)
- [ ] Feature (nueva consulta o bloque de consultas)
- [ ] Docs (documentación o README)
- [ ] Refactor / Style / Chore

## Checklist
- [ ] Probado localmente en PostgreSQL
- [ ] Consultas ordenadas y comentadas en report.sql
- [ ] Sin romper consultas ya existentes
- [ ] Actualicé el README si fue necesario
```

Las opciones que no marques deben quedar con el espacio vacío `[ ]`. Las que sí marques deben reemplazar el espacio con una `x` → `[x]`.

> No deben quedar espacios entre los corchetes y la x.

---

## Estilo de código SQL

- Escribe las palabras clave SQL en mayúsculas: `SELECT`, `FROM`, `WHERE`, `JOIN`, etc.
- Cada consulta debe ir precedida de un comentario que indique su número y propósito:
  ```sql
  -- 1. Mostrar todos los clientes registrados
  SELECT * FROM clientes;
  ```
- Usa líneas en blanco para separar consultas entre sí.
- Evita líneas en blanco en exceso dentro de una misma consulta.
- Indenta las cláusulas secundarias para mayor legibilidad:
  ```sql
  SELECT c.nombre, v.id_venta, v.fecha
  FROM clientes c
  JOIN ventas v ON c.id_cliente = v.id_cliente
  WHERE v.fecha = '2026-04-02';
  ```

---

## Operaciones comunes con Git

### Traer los últimos cambios de `main` a tu rama

Mientras trabajas, `main` puede avanzar. Para mantener tu rama actualizada:

```bash
git checkout feature/NombreApellido
git fetch origin
git rebase origin/main
```

Si hay conflictos, Git te indicará qué archivos resolver. Una vez resueltos:

```bash
git add <archivos-resueltos>
git rebase --continue
```

> 💡 Preferir `rebase` sobre `merge` para mantener el historial limpio y lineal.

---

### Deshacer el último commit (sin perder los cambios)

Si hiciste un commit antes de tiempo:

```bash
git reset --soft HEAD~1
```

Tus cambios quedan en staging, listos para volver a commitear.

---

### Guardar cambios temporalmente sin commitear

Si necesitas cambiar de rama pero no quieres perder tu trabajo en progreso:

```bash
git stash
# cambia de rama, haz lo que necesites...
git stash pop   # recupera tus cambios
```

---

### Ver el estado de tu rama vs. `main`

```bash
git log origin/main..HEAD --oneline   # commits que tienes tú y main no
git diff origin/main                  # diferencia en el código
```

---

## Reportar problemas

Si encuentras un error en alguna consulta o tienes una sugerencia:

1. Revisa si ya existe un issue abierto sobre el tema.
2. Si no existe, abre uno con:
   - **Descripción clara** del problema o sugerencia
   - **Número de consulta** afectada (ej: "Consulta 17")
   - **Resultado obtenido vs. resultado esperado**
   - Captura de pantalla del error si aplica

---

## ¿Dudas?

Consulta al equipo en el canal de Discord del grupo. ¡Todas las dudas son bienvenidas!

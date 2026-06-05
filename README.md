# Sentinella (landing page)

Sitio estÃ¡tico de presentaciÃ³n comercial de Sentinella: mensaje de producto, beneficios, precios y contacto, con soporte bilingÃ¼e inglÃ©s y espaÃ±ol en el cliente.

## Contenido del repositorio

| Archivo o carpeta | DescripciÃ³n |
|-------------------|-------------|
| `index.html` | Estructura semÃ¡ntica, secciones y metadatos SEO. |
| `styles.css` | Estilos y diseÃ±o responsive. |
| `script.js` | NavegaciÃ³n, conmutador de idioma (EN/ES) y textos dinÃ¡micos. |
| `assets/hero-dashboard.jpeg` | Imagen del hero (monitor con panel de operaciones). |

No se requiere build ni gestor de paquetes: basta con servir los archivos como sitio estÃ¡tico.

## Vista local

OpciÃ³n 1: abrir `index.html` directamente en el navegador (teniendo en cuenta posibles restricciones CORS o rutas segÃºn el navegador).

OpciÃ³n 2: servidor HTTP simple en la carpeta del proyecto, por ejemplo con Python:

```bash
python -m http.server 8080
```

Luego visitar `http://localhost:8080`.

## ImÃ¡genes

Las rutas en `index.html` apuntan a `assets/`. Al sustituir el hero, mantener el nombre de archivo referenciado o actualizar la ruta en el HTML y los textos `alt` acorde al contenido.

## Despliegue

Subir `index.html`, `styles.css`, `script.js` y la carpeta `assets/` a cualquier hosting de archivos estÃ¡ticos (CDN, almacenamiento con sitio web estÃ¡tico, etc.) y configurar el dominio y certificados TLS segÃºn la polÃ­tica de la organizaciÃ³n.

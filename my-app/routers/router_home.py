from app import app
from flask import render_template, request, flash, redirect, url_for, session, jsonify
from mysql.connector.errors import Error

# Importando conexión a BD
from controllers.funciones_home import *

PATH_URL = "public/peliculas"

# Registrar una nueva película
@app.route('/registrar-pelicula', methods=['GET'])
def viewFormPelicula():
    if 'conectado' in session:
        return render_template(f'{PATH_URL}/form_pelicula.html')
    else:
        flash('Primero debes iniciar sesión.', 'error')
        return redirect(url_for('inicio'))

@app.route('/form-registrar-pelicula', methods=['POST'])
def formPelicula():
    if 'conectado' in session:
        if 'poster_pelicula' in request.files:
            poster_pelicula = request.files['poster_pelicula']
            try:
                # Procesar formulario
                resultado = procesar_form_pelicula(request.form, poster_pelicula)
                if resultado:
                    flash('Película registrada con éxito.', 'success')
                    return redirect(url_for('lista_peliculas'))
                else:
                    flash('La película NO fue registrada. Verifica los datos ingresados.', 'error')
            except Exception as e:
                # Captura y muestra el error en consola
                print(f"Error al registrar la película: {e}")
                flash('Ocurrió un error al registrar la película.', 'error')

            # Renderiza nuevamente el formulario si falla
            return render_template(f'{PATH_URL}/form_pelicula.html')
        else:
            flash('Debes subir un póster para la película.', 'error')
            return render_template(f'{PATH_URL}/form_pelicula.html')
    else:
        flash('Primero debes iniciar sesión.', 'error')
        return redirect(url_for('inicio'))


# Listar todas las películas
@app.route('/lista-de-peliculas', methods=['GET'])
def lista_peliculas():
    if 'conectado' in session:
        return render_template(f'{PATH_URL}/lista_peliculas.html', peliculas=sql_lista_peliculasBD())
    else:
        flash('Primero debes iniciar sesión.', 'error')
        return redirect(url_for('inicio'))

# Detalles de una película
@app.route("/detalles-pelicula/", methods=['GET'])
@app.route("/detalles-pelicula/<int:idPelicula>", methods=['GET'])
def detallePelicula(idPelicula=None):
    if 'conectado' in session:
        if idPelicula is None:
            return redirect(url_for('inicio'))
        else:
            detalle_pelicula = sql_detalles_peliculasBD(idPelicula) or []
            return render_template(f'{PATH_URL}/detalles_pelicula.html', detalle_pelicula=detalle_pelicula)
    else:
        flash('Primero debes iniciar sesión.', 'error')
        return redirect(url_for('inicio'))

# Buscar películas
@app.route("/buscando-pelicula", methods=['POST'])
def viewBuscarPeliculaBD():
    resultadoBusqueda = buscarPeliculaBD(request.json['busqueda'])
    if resultadoBusqueda:
        return render_template(f'{PATH_URL}/resultado_busqueda_pelicula.html', dataBusqueda=resultadoBusqueda)
    else:
        return jsonify({'fin': 0})

# Editar una película
@app.route("/editar-pelicula/<int:id>", methods=['GET'])
def viewEditarPelicula(id):
    if 'conectado' in session:
        respuestaPelicula = buscarPeliculaUnica(id)
        if respuestaPelicula:
            return render_template(f'{PATH_URL}/form_pelicula_update.html', respuestaPelicula=respuestaPelicula)
        else:
            flash('La película no existe.', 'error')
            return redirect(url_for('inicio'))
    else:
        flash('Primero debes iniciar sesión.', 'error')
        return redirect(url_for('inicio'))

# Actualizar información de película
@app.route('/actualizar-pelicula', methods=['POST'])
def actualizarPelicula():
    resultData = procesar_actualizacion_form_pelicula(request)
    if resultData:
        return redirect(url_for('lista_peliculas'))
    
@app.route("/lista-de-usuarios", methods=['GET'])
def usuarios():
    if 'conectado' in session:
        resp_usuariosBD = lista_usuariosBD()
        return render_template('public/usuarios/lista_usuarios.html', resp_usuariosBD=resp_usuariosBD)
    else:
        return redirect(url_for('inicioCpanel'))


@app.route('/borrar-usuario/<string:id>', methods=['GET'])
def borrarUsuario(id):
    resp = eliminarUsuario(id)
    if resp:
        flash('El Usuario fue eliminado correctamente', 'success')
        return redirect(url_for('usuarios'))

# Borrar una película
@app.route('/borrar-pelicula/<string:id_pelicula>/<string:poster_pelicula>', methods=['GET'])
def borrarPelicula(id_pelicula, poster_pelicula):
    resp = eliminarPelicula(id_pelicula, poster_pelicula)
    if resp:
        flash('La película fue eliminada correctamente', 'success')
        return redirect(url_for('lista_peliculas'))

# Descargar un informe de películas
@app.route("/descargar-informe-peliculas/", methods=['GET'])
def reporteBD():
    if 'conectado' in session:
        return generarReporteExcelPeliculas()
    else:
        flash('Primero debes iniciar sesión.', 'error')
        return redirect(url_for('inicio'))


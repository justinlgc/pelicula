const loaderOut = document.querySelector("#loader-out");
function fadeOut(element) {
  let opacity = 1;
  const timer = setInterval(function () {
    if (opacity <= 0.1) {
      clearInterval(timer);
      element.style.display = "none";
    }
    element.style.opacity = opacity;
    opacity -= opacity * 0.1;
  }, 50);
}
fadeOut(loaderOut);

function eliminarPelicula(id_pelicula, poster_pelicula) {
  if (confirm("¿Estás seguro que deseas eliminar la película?")) {
    let url = `/borrar-pelicula/${id_pelicula}/${poster_pelicula}`;
    if (url) {
      window.location.href = url;
    }
  }
}

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01//EN" "http://www.w3.org/TR/html4/strict.dtd">
<html lang="en">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
        <title>Bezier en Poligonos</title>
        <link rel="stylesheet" href="estilos.css" type="text/css" media="screen">
        <script src="http://code.jquery.com/jquery-1.9.1.min.js"></script>
        <script src="raphael.js" type="text/javascript" charset="utf-8"></script>
        <script src="raphael.free_transform.js" type="text/javascript" charset="utf-8"></script>
        <script src="raphael.polygons.js" type="text/javascript" charset="utf-8"></script>
        <script src="prueba_poligono.js" type="text/javascript" charset="utf-8"></script>
        
        <script type="text/javascript" charset="utf-8">
            $(function () {
                inicializar();
            });
        </script>
    </head>
    <body>
        <div id="holder"></div>
        <button id="agregar">Agregar Poligono</button><br>
        <button id="borrar">Borrar Poligono</button><br>
        <button id="liberar">Quitar selección</button><br>
        Seleccionar poligono: <select id="listaPoligonos"><option id="none" value="-1">Ninguno</select><br>
        <div id="propiedadesPoligono">
            <button id="reiniciar">Reiniciar cambios poligono</button><br>
            Forma Poligono: <select id="formaPoligono">
                <option value="rectangulo">Rectangulo</option>
                <option value="cuadrado">Cuadrado</option>
                <option value="triangulo">Triangulo</option>
                <option value="trianguloIzquierda">Triangulo izquierda</option>
                <option value="trianguloDefecha">Triangulo derecha</option>
                <option value="trapecio">Trapecio</option>
                <option value="trapecioIzquierda">TrapecioIzquierda</option>
                <option value="trapecioDerecha">Trapecio Derecha</option>
                <option value="semicirculo">Semicirculo</option>
                <option value="casco1">Casco 1</option>
                <option value="casco2">Casco 2</option>
                <option value="casco3">Casco 3</option>
                <option value="circulo">Circulo</option>
            </select><br>
            Forma Bezier: <select id="formaBezier">
                <option value="recta">Recta</option>
                <option value="curva">Curva libre</option>
            </select><br>
            Numero de filas: <input id="numeroFilas" /><br>
            Cuadros por filas: <div id="cuadrosPorFilas"></div>
        </div>
    </body>
</html>

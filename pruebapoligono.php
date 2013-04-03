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
        
        <script type="text/javascript" charset="utf-8">
            var r;
            var poligonoActual = undefined;
            var listaPoligonos = [];
            var ft;
            
            $(function () {
                r = Raphael("holder");
                r.rect(0, 0, 800, 600, 5).attr({stroke: "#666"});
                $("#agregar").click(function(){
                    cargarPoligono();
                });
                $("#listaPoligonos").change(function(){
                    if (poligonoActual != undefined){
                        poligonoActual.noEdit();
                    }
                    $("#listaPoligonos option:selected").each(function(){
                        poligonoActual = listaPoligonos[$(this).val()];
                        poligonoActual.edit();
                    });
                });
            });

            function cargarPoligono(){
                if (poligonoActual != undefined){
                    poligonoActual.noEdit();
                }
            
                poligonoActual = new Polygon(r);
                poligonoActual.add(
                      [[100,0],[200,200],[0,100]],//poligono
                      [20, 20, 20, 100, 200, 100, 200, 200]//bezier
                      );
                
                nombre = prompt("Nombre de la Poligono");
                l = listaPoligonos.length;
                $("#listaPoligonos").append("<option id='Poligono_"+l+"' value='"+l+"'>"+nombre+"</option>");
                listaPoligonos.push(poligonoActual);
                $("#Poligono_"+l).attr("selected", "selected");
            }
        </script>
    </head>
    <body>
        <div id="holder"></div>
        <button id="agregar">Agregar Poligono</button>
        <select id="listaPoligonos"></select>
        
    </body>
</html>

r = null
poligonoActual = undefined
listaPoligonos = []
ft = null


inicializar = () ->
    r = Raphael("holder")
    r.rect(0, 0, 800, 600, 5).attr({stroke: "#666"})
    
    $("#agregar").click(cargarPoligono)
    $("#borrar").click(borrarPoligono)
    $("#liberar").click(quitarSeleccion)
    $("#listaPoligonos").change(cambiaListaPoligonos)
    $("#reiniciar").click(()->
        poligonoActual.reset()
    )


cargarPoligono= () ->
    if poligonoActual != undefined
        poligonoActual.noEdit()

    poligonoActual = new Polygon(r)
    poligonoActual.add(
          [[300,100],[500,100],[500, 150],[300, 150]],    #poligono
          [300, 125, 330, 125, 470, 125, 500, 125] #bezier
          )
    
    poligonoActual.propiedades =  {
            formaPoligono : "rectangulo",
            formaBezier : "recta",
            numeroFilas : 2,
            cuadrosPorFilas : [10, 12]
            }
    
    nombre = prompt("Nombre de la Poligono")
    if nombre.len()>0
        l = listaPoligonos.length
        $("#listaPoligonos").append("<option id='Poligono_"+l+"' value='"+l+"'>"+nombre+"</option>")
        listaPoligonos.push(poligonoActual)
        $("#Poligono_"+l).attr("selected", "selected")
        propiedadesPoligono()
    return


propiedadesPoligono= () ->
    $("#propiedadesPoligono").show()
    propiedades = poligonoActual.propiedades
    $("#formaPoligono").val(propiedades.formaPoligono)
    $("#formaBezier").val(propiedades.formaBezier)
    $("#numeroFilas").val(propiedades.numeroFilas)
    
    $("#cuadrosPorFilas").empty()
    for cuadroFila in propiedades.cuadrosPorFilas 
        $("#cuadrosPorFilas").append("Fila "+(_i+1)+": <input id='cuadrosPorFilas_"+_i+"' value='"+cuadroFila+"' /><br>")
    return

cambiaListaPoligonos= () ->
    if poligonoActual != undefined
        poligonoActual.noEdit()

    $("#listaPoligonos option:selected").each -> 
        if $(this).val()!="-1"
            poligonoActual = listaPoligonos[$(this).val()]
            poligonoActual.edit()
            $("#propiedadesPoligono").show()
        else
            $("#propiedadesPoligono").hide()
    return
    
    
borrarPoligono = () ->
    if poligonoActual != undefined
        for p in listaPoligonos
            if poligonoActual == p
                listaPoligonos[_i] = undefined
                poligonoActual.del()
                #delete poligonoActual
                poligonoActual = undefined
                $("#listaPoligonos option:selected").remove()
                $("#propiedadesPoligono").hide()
                break
    return


quitarSeleccion = () ->
    if poligonoActual != undefined
        poligonoActual.noEdit()
    poligonoActual = undefined
    $('option:selected').removeAttr('selected')
    $("#none").attr("selected", true)
    $("#propiedadesPoligono").hide()
    return









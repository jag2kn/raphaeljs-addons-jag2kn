class Polygon
    constructor: (@r) ->
        dashed = {fill: "#F99", stroke: "#666", "stroke-dasharray": "- "}
        controls = null
        path = null
        linecurve = null
        propiedades = null

    movePoint: (dx, dy) ->
        this.update(dx - (this.dx || 0), dy - (this.dy || 0))
        this.dx = dx
        this.dy = dy
        return

    up: () ->
        this.dx = this.dy = 0
        this.animate({"fill-opacity": 1}, 500)
        return

    start: () ->
        this.odx = 0
        this.ody = 0
        this.animate({"fill-opacity": 0.2}, 500)
        return 



    curve: (color) ->
        x = @bezier[0]
        y = @bezier[1]
        ax = @bezier[2]
        ay = @bezier[3]
        cx = @bezier[4]
        cy = @bezier[5]
        zx = @bezier[6]
        zy = @bezier[7]
        path = [["M", x, y], ["C", ax, ay, cx, cy, zx, zy]]
        @linecurve = @r.path(path).attr({stroke: color || @raphael.getColor(), "stroke-width": 4, "stroke-linecap": "round"})
        @edit()
        return    
    
    edit: () ->
        x = @bezier[0]
        y = @bezier[1]
        ax = @bezier[2]
        ay = @bezier[3]
        cx = @bezier[4]
        cy = @bezier[5]
        zx = @bezier[6]
        zy = @bezier[7]
        
        path = [["M", x, y], ["C", ax, ay, cx, cy, zx, zy]]
        path2 = [["M", x, y], ["L", ax, ay], ["M", cx, cy], ["L", zx, zy]]
        discattr = {fill: "#F99", stroke: "none"}
        controls = @r.set(
             @r.path(path2).attr({stroke: "#ccc", "stroke-dasharray": ". "}),
             @r.circle(x, y, 5).attr(discattr),
             @r.circle(ax, ay, 5).attr(discattr),
             @r.circle(cx, cy, 5).attr(discattr),
             @r.circle(zx, zy, 5).attr(discattr)
        )
        @controls = controls
        linecurve = @linecurve

        controls[1].update = (x, y) ->
            X = this.attr("cx") + x
            Y = this.attr("cy") + y
            this.attr({cx: X, cy: Y})
            path[0][1] = X
            path[0][2] = Y
            path2[0][1] = X
            path2[0][2] = Y
            controls[2].update(x, y)
            return
            
        controls[2].update = (x, y) ->
            X = this.attr("cx") + x
            Y = this.attr("cy") + y
            this.attr({cx: X, cy: Y})
            path[1][1] = X
            path[1][2] = Y
            path2[1][1] = X
            path2[1][2] = Y
            linecurve.attr({path: path})
            controls[0].attr({path: path2})
            return
            
        controls[3].update = (x, y) ->
            X = this.attr("cx") + x
            Y = this.attr("cy") + y
            this.attr({cx: X, cy: Y})
            path[1][3] = X
            path[1][4] = Y
            path2[2][1] = X
            path2[2][2] = Y
            linecurve.attr({path: path})
            controls[0].attr({path: path2})
            return
            
        controls[4].update = (x, y) ->
            X = this.attr("cx") + x
            Y = this.attr("cy") + y
            this.attr({cx: X, cy: Y})
            path[1][5] = X
            path[1][6] = Y
            path2[3][1] = X
            path2[3][2] = Y
            controls[3].update(x, y)
            return

        controls.drag(@movePoint, @start, @up)
        @ft = @r.freeTransform(@path, {}, @updateTransform)
        @updateTransform(null, ["drag end"])
        return

    ###
    paper.customAttributes.pathXY = function( x,y ) {
        return { path: Raphael.transformPath(this.attr('path'), ['T', x - getPathX(this), y - getPathY(this) ]) };
    };
    ###
    updateTransform:(ft, event) ->
        #console.log(event)
        if poligonoActual == null
            return
            
        if event[0] == "drag end" || event[0] == "rotate end" || event[0] == "scale end"
            poligonoActual.linecurve.transform(poligonoActual.path.transform())
            for control in poligonoActual.controls    
                control.transform(poligonoActual.path.transform())
        return
            
    noEdit:() ->
        @ft.unplug()
        @bezier[0] = @controls[1].attr("cx")
        @bezier[1] = @controls[1].attr("cy")
        @bezier[2] = @controls[2].attr("cx")
        @bezier[3] = @controls[2].attr("cy")
        @bezier[4] = @controls[3].attr("cx")
        @bezier[5] = @controls[3].attr("cy")
        @bezier[6] = @controls[4].attr("cx")
        @bezier[7] = @controls[4].attr("cy")
        @controls.remove()
        return

    add: (points, bezier) ->
        @points = points
        @bezier = bezier
        @bezierOrg = []
        for b in @bezier
            @bezierOrg[_i] = b
            
        l="M"
        lines = ""
        for point in points
            lines += l+point[0]+","+point[1]+" "
            l="L"
        pathString = lines+"z"
        @path = @r.path(pathString)
        @path.attr(@dashed)
        
        @curve("hsb(.1, .75, .75)")
               
        return @path
    
            
    reset:() ->
        @path.transform("");
        @linecurve.transform("");
        for control in @controls    
            control.transform("")

        @noEdit()

        for b in @bezierOrg
            @bezier[_j] = b
        
        x = @bezierOrg[0]
        y = @bezierOrg[1]
        ax = @bezierOrg[2]
        ay = @bezierOrg[3]
        cx = @bezierOrg[4]
        cy = @bezierOrg[5]
        zx = @bezierOrg[6]
        zy = @bezierOrg[7]
        
        path = [["M", x, y], ["C", ax, ay, cx, cy, zx, zy]]
        @linecurve.attr({path: path})
        @edit()
        return
    del:() ->
        @ft.unplug()
        @controls.remove()
        @linecurve.remove()
        @path.remove()
        return













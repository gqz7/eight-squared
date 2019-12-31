window.onload = () => {

    const canvas = document.getElementById('canvas'),
    ctx = canvas.getContext('2d'),
    width = canvas.width = innerWidth,
    height = canvas.height = innerHeight;

    let time = 100,
        angle = Math.PI / 2;

        let i = 0;

    ctx.strokeStyle = "white";
    ctx.translate(width/2, height);

    function createLine(x1,y1,x2,y2) {
        ctx.beginPath()
        ctx.moveTo(x1, y1)
        ctx.lineTo(x2, y2)
        ctx.stroke()
    }

    function clear() {
        ctx.save();
        ctx.setTransform(1, 0, 0, 1, 0, 0);
        ctx.clearRect(0, 0, canvas.width, canvas.height);
        ctx.restore();
    }
   
    function create_tree(angle, length, interations) {
        
        createLine(0,0,0,-length);

        ctx.translate(0, -length);
        length *= .67;
    
        if(length > 3) { 
        ctx.save()
        ctx.rotate(angle)
        create_tree(angle, length); 

        ctx.restore()
        ///////////////
        
        //////////////
        ctx.save()
    
        ctx.rotate(-angle)
        create_tree(-angle, length);
        ctx.restore()

        }
    }

    //animate the tree
    render()
        function render() {
            clear()
            
            time++;
            angle -= .003;

            ctx.strokeStyle = 'hsl(' + (time * 1) + ', 100%, 65%)';

            // console.log(time)

            ctx.save()
            create_tree(angle, 50 + time/2, 3);
            ctx.restore()
            
            setTimeout( window.requestAnimationFrame, 0, (render));
            
        }

}
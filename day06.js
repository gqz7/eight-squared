
window.onload = function () {

   var canvas = document.getElementById("canvas"),
        context = canvas.getContext("2d"),
        width = canvas.width = this.innerWidth, //this refers to window
        height = canvas.height = this.innerHeight,
        time = 0,
        multFactor = 17;

        context.strokeStyle = 'white';

        context.translate(width/2, height/2);
        context.rotate((-160 * Math.PI) / 180);


        function createFibSpi(sizeLength) {
            

            let prevSL = sizeLength/100,
                curSL = sizeLength/3;
            
                context.beginPath();

                context.rotate(.001);

                curSL = curSL + prevSL;

                context.moveTo(curSL+10, curSL-4);

                context.lineTo(curSL, curSL);


                context.stroke()

                
                
            context.strokeStyle = 'hsl(' + (sizeLength / 3) + ', 100%, 65%)';
        }
    

        render()

        function render() {
            time += .2
    
            createFibSpi(time)

            for (let i = 1; i < multFactor; i++) {
               createFibSpi(time * Math.pow(i, 1.01))
                
            }
            

            if (time > 160) {

                context.save();
                context.setTransform(1, 0, 0, 1, 0, 0);
                context.clearRect(0, 0, canvas.width, canvas.height);
                context.restore();

                multFactor++;

                time = 0;
                
            }


            setTimeout( window.requestAnimationFrame, 0, (render));

        }

        


        

}

window.onload = function () {

   var canvas = document.getElementById("canvas"),
        context = canvas.getContext("2d"),
        width = canvas.width = this.innerWidth, //this refers to window
        height = canvas.height = this.innerHeight,
        time = 0;

        context.strokeStyle = 'white';

        context.translate(width/2, height/2);
        context.rotate((-15 * Math.PI) / 180);


        function createFibSpi(sizeLength) {

            let prevSL = sizeLength/100,
                curSL = sizeLength;
            
            for (let i = 0; i < 10; i++) {
                context.beginPath();

                

                context.rotate(.001);

                curSL = curSL - prevSL;

                context.moveTo(curSL+4, curSL-4);

                context.lineTo(curSL, curSL);

                prevSL = curSL;

                context.stroke()
                
            }
        }
    

        render()

        function render() {
            time += .2

            createFibSpi(time)


            setTimeout( window.requestAnimationFrame, 0, (render));

        }

        


        

}
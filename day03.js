
window.onload = function () {

   var canvas = document.getElementById("canvas"),
        context = canvas.getContext("2d"),
        width = canvas.width = this.innerWidth, //this refers to window
        height = canvas.height = this.innerHeight,
        size = 0;

        context.strokeStyle = 'white';

        context.translate(width/2, height/2);
        context.rotate((-15 * Math.PI) / 180);


        function createSpiral(maxSize, totalLines, increment) {
             context.save();
            
            let prevX = maxSize,

                prevY = maxSize,

                currentX, currentY,
                nextX, nextY;

            for (let i = 0; i < totalLines - increment; i++) {
                context.beginPath();

                context.strokeStyle = 'hsl(' + (i * 3) + ', 100%, 65%)';

                currentX = prevX - increment; 
                currentY = prevY - increment; 

                context.moveTo(currentX,currentY);


                //fibonaci ratio of rotation
                // context.rotate((-currentX / prevX)/increment);
                context.rotate(.1);

                //fibonaci squecence of line length
                nextX = currentX - ((currentX / prevX) / .7);
                nextY = currentY - ((currentY / prevY) * .6);

                context.lineTo(nextX ,nextY );
                context.stroke();

                prevX = currentX;
                prevY = currentY;

            }

            context.restore();
            
        }

        let definitionOfRatio = 2;

        // createSpiral(333,100, 10)
        render()

        function render() {
            size += 4;
            
            context.save();
            context.setTransform(1, 0, 0, 1, 0, 0);
            context.clearRect(0, 0, canvas.width, canvas.height);
            context.restore();

            definitionOfRatio += 0;

            totalLines = size / definitionOfRatio - 10;

            // createSpiral(100, .01);

            createSpiral(size, totalLines, definitionOfRatio);

            context.rotate(.02);

            setTimeout( window.requestAnimationFrame, 30, (render));

        }

    
        

}

window.onload = function () {

   var canvas = document.getElementById("canvas"),
        context = canvas.getContext("2d"),
        width = canvas.width = this.innerWidth, //this refers to window
        height = canvas.height = this.innerHeight,
        time = 0;

        context.strokeStyle = 'black';

        context.translate(width/2, height/2);
        context.rotate((-15 * Math.PI) / 180);


        function createTri(sizeLength) {
            
            for (let i = 0; i < 3; i++) {
                context.beginPath();

                context.moveTo(sizeLength, sizeLength);

                context.rotate((120 * Math.PI)/180);

                context.lineTo(sizeLength, sizeLength);

                context.stroke()
                
            }
        }
        

        function createCircle(radius) {

            for (let i = 0; i < 36; i++) {
                context.beginPath();

                context.moveTo(radius, radius);

                context.rotate((10 * Math.PI)/180);

                context.lineTo(radius, radius);

                context.stroke()
                
            }
            
        }

        var size = 30;

        render()

        function render() {

            for (let i = 0; i < 2; i++) {

            size += 2;
            
                if (i % 2 == 0) {

                    createTri(size);
                    
                } else {

                    createCircle(size);

                }
            }

            // context.rotate(.2);

            setTimeout( window.requestAnimationFrame, 30, (render));

        }

        


        

}
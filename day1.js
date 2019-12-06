
window.onload = function () {

   var canvas = document.getElementById("canvas"),
        context = canvas.getContext("2d"),
        width = canvas.width = this.innerWidth, //this refers to window
        height = canvas.height = this.innerHeight,
        time = 0;

        context.strokeStyle = 'black';

        // context.beginPath();

        // context.moveTo(width, height);
        // context.lineTo(100,0);

        // context.stroke();

        context.translate(width/2, height/2);


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

        var size = 10;

        

        for (let i = 0; i < 100; i++) {

            size += 10;
            
            if (i % 2 == 0) {

                createTri(size);
                
            } else {

                createCircle(size);

            }
            
        }


        

}
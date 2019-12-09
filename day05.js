
window.onload = function () {

   var canvas = document.getElementById("canvas"),
        context = canvas.getContext("2d"),
        width = canvas.width = this.innerWidth, //this refers to window
        height = canvas.height = this.innerHeight,
        branchLength = 0;

        context.strokeStyle = 'white';


        //setting up the canvas so the image looks good
        context.translate(width/2, 100);
        context.rotate(Math.PI);

        //the 'tree' will start at the center of the canvas
        let originX = 0,
            originY = 0;

        //function that creates a tree branch (one vertical, two horiz) and calls the leaf creating function for the horizontal branches
        function create_branch(branchLength) {


            context.translate(0,-branchLength);

            for (let i = 0; i < 3; i++) {

                context.save();

                context.rotate(((90 * i - 90) * (Math.PI/180)));

                context.beginPath();
                
                context.moveTo(originX, originY + branchLength);

                context.lineTo(originX, originY);

                context.stroke();

                if (i != 1) {
                    create_leaf(originX, originY, branchLength);
                }

                context.restore();
                
            }

        }


        //function that creates the 'leaves' for each horizontal branch

        function create_leaf(x,y, leafSize) {

            context.rotate(90 * (Math.PI / 180));

             for (let i = 0; i < 20; i++) {

                 //color of each 'leaf line' is a random shade of green
                context.strokeStyle = 'hsl(' +  (60 * Math.random() + 90) + ', 100%, 80%)';

                    context.save();
                    
                    context.beginPath();

                    context.moveTo(x + leafSize, y);

                    context.lineTo((Math.sin(i) * leafSize) + leafSize * 2, Math.cos(i) * (leafSize/ 3));

                    context.stroke();

                    context.restore();
            
            }
            
        }

        //inital declaration of size detirmins the starting size of the branch
        let size = 10
       
        continuousTreeRender()

        function continuousTreeRender() {
            size += size * .07;
            
            create_branch(size);
            
            context.save()
            context.translate(500, size);

            create_branch(size);
            context.translate(-1000, size);
            create_branch(size);
            
            context.restore();

            // context.rotate(.02);

            setTimeout( window.requestAnimationFrame, 70, (continuousTreeRender));

        }


}

window.onload = function () {

   var canvas = document.getElementById("canvas"),
        context = canvas.getContext("2d"),
        width = canvas.width = this.innerWidth, //this refers to window
        height = canvas.height = this.innerHeight,
        size = 0;

        context.strokeStyle = 'white';

        context.translate(width/2, height/2);
        // context.rotate((-15 * Math.PI) / 180);


        function createTree(brances, stems, rungs, branchLength) {

            //starting branch

            context.beginPath();
            context.moveTo(0,-100);
            context.lineTo(0, branchLength * 3);

            let prevBranchX = 0;
            let prevBranchY = 0;

            context.stroke();

            

            while (rungs > 0) {

                brancesStartX = prevBranchX;
                brancesStartY = prevBranchY - (rungs * branchLength);

                for (let i = 1; i <= brances; i++) {

                    
                    
                    context.beginPath();

                    for (let j = 0; j < stems; j++) {

                        context.moveTo(brancesStartX, brancesStartY - branchLength);
                        context.save();
                        context.rotate(Math.PI / (j) - Math.PI);

                        context.lineTo(brancesStartX * i, 0 + branchLength );
                        context.stroke();
                        context.restore();

                        context.moveTo(brancesStartX, brancesStartY - branchLength);
                        context.save();
                        context.rotate(-(Math.PI / (j) - Math.PI));

                        context.lineTo(brancesStartX, 0 + branchLength );
                        context.stroke();
                        context.restore();

                        
                    }
                    
                }

                rungs--

            }


            
        }

        createTree(6, 3, 100);

        render()

        function render() {
            size += 1;
            
            createTree(3, (size /10), 4, size);

            // context.rotate(.02);

            setTimeout( window.requestAnimationFrame, 30, (render));

        }

    
        

}
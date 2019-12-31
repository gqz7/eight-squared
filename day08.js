window.onload = () => {

    const canvas = document.getElementById('canvas'),
    ctx = canvas.getContext('2d'),
    width = canvas.width = 1700,
    height = canvas.height = 900;

    ctx.strokeStyle = "white"

    //setup/define the root of the tree
    


    //animate the tree
    render()
        function render() {
            time += .2;

            if (time > 240) {

                // context.save();
                // context.setTransform(1, 0, 0, 1, 0, 0);
                // context.clearRect(0, 0, canvas.width, canvas.height);
                // context.restore();
                // time = 0;
                
            } else {
                 setTimeout( window.requestAnimationFrame, 0, (render));
            }
        }

}
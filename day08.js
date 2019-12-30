window.onload = () => {

    const canvas = document.getElementById('canvas'),
    ctx = canvas.getContext('2d'),
    width = canvas.width = 1700,
    height = canvas.height = 900;

    ctx.strokeStyle = "white";

    ctx.beginPath();
    ctx.moveTo(100,100);
    ctx.lineTo(200,300);
    ctx.stroke();

    

}
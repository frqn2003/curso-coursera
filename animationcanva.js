let canva = document.getElementById("canvas");
let ctx = canva.getContext("2d");

const velocidad = 10;
let posicionX = 50;
let posicionY = 50;
let radio = 40;

let velocidadMovimiento = velocidad;

function moverBola(){
    if (posicionX + radio > canva.width) {
        velocidadMovimiento = -velocidad;
    }
    else if(posicionX - radio < 0){
        velocidadMovimiento = velocidad;
    }
    posicionX += velocidadMovimiento;
}

function dibujarBola(){
    ctx.clearRect(0,0,canva.width, canva.height);

    ctx.fillStyle = "red";
    ctx.beginPath();
    ctx.arc(posicionX, posicionY, radio, 0, 2 * Math.PI);
    ctx.fill();
}

function animar(){
    moverBola();
    dibujarBola();
    requestAnimationFrame(animar);
}

animar();
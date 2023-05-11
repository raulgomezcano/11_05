package com.softtek.modelo;
public class Campos {
    private int x;
    public Campos(int valorInicial) {
        this.x = valorInicial; // constructor que inicializa el valor de x
    }

    public int Muestra() {
        return this.x; // devuelve el valor actual de x
    }

    public void Incrementa() {
        this.x++; // incrementa el valor de x en 1 unidad
    }
}

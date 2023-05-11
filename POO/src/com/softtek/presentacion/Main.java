package com.softtek.presentacion;

import com.softtek.modelo.Campos;

public class Main {
    public static void main(String[] args) {
        Campos campo = new Campos(5);
        System.out.println("Valor inicial de x: " + campo.Muestra());

        campo.Incrementa(); // incrementa el valor de x
        System.out.println("Valor incrementado de x: " + campo.Muestra());

    }
}
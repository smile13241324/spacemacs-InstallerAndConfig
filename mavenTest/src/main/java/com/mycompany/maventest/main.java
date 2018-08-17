/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.mycompany.maventest;

import com.mycompany.maventest.zeug.ClassB;

/**
 *
 * @author smile13241324
 */
public class main {

  public static void main(String[] args) {

    ClassB b = new ClassB();
    b.storeStuff2("BLABLA");
    b.storeStuff2("BLABLA");
    System.out.println("-----------------");
    System.out.println(b.getStuff());
    System.out.println("-----------------");
  }
}

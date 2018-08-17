package com.mycompany.gradleTest;

import com.mycompany.gradleTest.zeug.ClassB;

/**
 *
 * @author smile13241324
 */
public class main {

  public static void main(String[] args) {

    ClassB b = new ClassB();
    b.storeStuff2("BLABLA");
    System.out.println("-----------------");
    System.out.println(b.getStuff());
    System.out.println("-----------------");
  }
}

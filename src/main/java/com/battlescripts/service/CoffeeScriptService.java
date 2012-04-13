package com.battlescripts.service;

import java.io.IOException;
import java.io.InputStreamReader;
import java.io.Reader;

import javax.inject.Named;

import org.mozilla.javascript.Context;
import org.mozilla.javascript.JavaScriptException;
import org.mozilla.javascript.Scriptable;

@Named("coffeeScriptService")
public class CoffeeScriptService {

  public String compileCoffeeScript(String source) throws Exception {

    Reader lib = new InputStreamReader(this.getClass().getClassLoader().getResourceAsStream("coffee-script.js"));
    
    Context context = Context.enter();
    context.setOptimizationLevel(-1);
    try {
      Scriptable globalScope = context.initStandardObjects();
      context.evaluateReader(globalScope, lib, "coffee-script.js", 0, null);
      String version = (String) context.evaluateString(globalScope, "CoffeeScript.VERSION;", "source", 0, null);
      System.out.println(version);
      
      Scriptable compileScope = context.newObject(globalScope);
      compileScope.setParentScope(globalScope);
      compileScope.put("coffeeScript", compileScope, source);
      
      String javascript =  (String) context.evaluateString(
          compileScope,
          String.format("CoffeeScript.compile(coffeeScript, %s);", "{bare: true}"),
          "source", 0, null);
      
      return javascript;
    } 
    catch (IOException e) {
      throw e;
    }
    catch (JavaScriptException e) {
      throw e;
    }
    finally {
        Context.exit();
    }
    
  }

}

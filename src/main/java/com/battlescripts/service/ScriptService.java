package com.battlescripts.service;

import javax.inject.Inject;
import javax.inject.Named;

import com.battlescripts.dao.mapper.BattleScriptsMapper;
import com.battlescripts.domain.Script;

@Named("scriptService")
public class ScriptService {

  @Inject
  protected CoffeeScriptService coffeeScriptService;

  @Inject
  protected BattleScriptsMapper battleScriptsMapper;
  
  public void saveScript(Script script) throws Exception {
    coffeeScriptService.compileCoffeeScript(script.getContent());
    if(script.getId() == null){
      System.out.println("INSERTING");
      battleScriptsMapper.insertScript(script);
    } else {
      System.out.println("UPDATING");
      battleScriptsMapper.updateScript(script);
    }
  }
  
}

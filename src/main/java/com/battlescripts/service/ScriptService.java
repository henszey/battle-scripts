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
    if(script.getId() != null){
      battleScriptsMapper.insertScript(script);
    } else {
      battleScriptsMapper.updateScript(script);
    }
  }
  
}

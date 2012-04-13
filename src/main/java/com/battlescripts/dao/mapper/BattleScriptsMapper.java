package com.battlescripts.dao.mapper;

import java.util.List;

import com.battlescripts.domain.Script;

public interface BattleScriptsMapper {

  public void insertScript(Script script);
  
  public void updateScript(Script script);
  
  public Script selectScript(Integer id);
  
  public List<Script> selectAllScripts();
  
}

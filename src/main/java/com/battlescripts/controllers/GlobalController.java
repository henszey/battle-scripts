package com.battlescripts.controllers;

import javax.inject.Inject;

import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.battlescripts.dao.mapper.BattleScriptsMapper;


@Controller
public class GlobalController {

  @Inject
  protected BattleScriptsMapper battleScriptsMapper;
  
  @RequestMapping({"/","/index"})
  public String index(ModelMap model) {
    model.put("ships", battleScriptsMapper.selectAllScripts());
    return "index";
  }
  
  @RequestMapping({"/about"})
  public String about() {
    return "about";
  }

  @RequestMapping(value = "/login", method = RequestMethod.GET)
  public String login() {
    return "login";
  }
  
  @RequestMapping("/matchup")
  public String matchup() {
    return "matchup";
  }
  
  
  
}

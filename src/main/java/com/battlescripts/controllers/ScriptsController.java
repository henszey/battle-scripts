package com.battlescripts.controllers;

import javax.inject.Inject;

import org.springframework.security.access.annotation.Secured;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.battlescripts.dao.mapper.BattleScriptsMapper;
import com.battlescripts.domain.Script;
import com.battlescripts.service.CoffeeScriptService;
import com.battlescripts.service.ScriptService;


@Controller
public class ScriptsController {

  
  @Inject
  protected ScriptService scriptService;
  
  @Inject
  protected BattleScriptsMapper battleScriptsMapper;
  
  @Inject
  protected CoffeeScriptService coffeeScriptService;
  

  @RequestMapping(value = "/ships", method = RequestMethod.POST)
  @Secured("ROLE_USER")
  @ResponseBody
  public String saveShip(@RequestBody Script script) throws Exception {

    //TODO: set uid, don't take what the client sends...
    scriptService.saveScript(script);
    
    SecurityContextHolder.getContext().getAuthentication();
    SecurityContextHolder.getContext().getAuthentication().getPrincipal();
    
    return "success";
  }
  
  @RequestMapping(value = "/ships/{id}.coffee", method = RequestMethod.GET)
  @ResponseBody
  public String shipScript(@PathVariable Integer id) throws Exception {
    //HttpServletResponse response 
    //response.setContentType("text/coffeescript");
    Script script = battleScriptsMapper.selectScript(id);
    
    return script.getContent();
  }
  
  @RequestMapping(value = "/ships/{id}.js", method = RequestMethod.GET)
  @ResponseBody
  public String shipJavascript(@PathVariable Integer id) throws Exception {
    //HttpServletResponse response 
    //response.setContentType("application/javascript");
    Script script = battleScriptsMapper.selectScript(id);
    
    String javascript = coffeeScriptService.compileCoffeeScript(script.getContent());
    
    return javascript;
  }
  
}

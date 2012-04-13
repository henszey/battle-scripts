package com.battlescripts.controllers;

import javax.inject.Inject;
import javax.servlet.http.HttpServletResponse;

import org.springframework.security.access.annotation.Secured;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
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
  public String saveShip(@ModelAttribute Script script) throws Exception {

    System.out.println(script);
    System.out.println(script.getId());
    System.out.println(script.getUid());
    System.out.println(script.getContent());

    System.out.println(SecurityContextHolder.getContext().getAuthentication());
    System.out.println(SecurityContextHolder.getContext().getAuthentication().getPrincipal());
    
    //TODO: set uid, don't take what the client sends...
    scriptService.saveScript(script);
    
    SecurityContextHolder.getContext().getAuthentication();
    SecurityContextHolder.getContext().getAuthentication().getPrincipal();
    
    return "about";
  }
  
  @RequestMapping(value = "/ships/{id}.coffee", method = RequestMethod.GET)
  @ResponseBody
  public String shipScript(HttpServletResponse response, @PathVariable Integer id) throws Exception {
    Script script = battleScriptsMapper.selectScript(id);
    
    response.setContentType("text/coffeescript");
    return script.getContent();
  }
  
  @RequestMapping(value = "/ships/{id}.js", method = RequestMethod.GET)
  @ResponseBody
  public String shipJavascript(HttpServletResponse response, @PathVariable Integer id) throws Exception {
    
    Script script = battleScriptsMapper.selectScript(id);
    
    String javascript = coffeeScriptService.compileCoffeeScript(script.getContent());
    
    response.setContentType("application/javascript");
    return javascript;
  }
  
  @RequestMapping(value = "/ships/{id}", method = RequestMethod.GET)
  @ResponseBody
  public Script ship(@PathVariable Integer id) throws Exception {

    Script script = battleScriptsMapper.selectScript(id);
    
    return script;
  }
  
  @RequestMapping(value = "/ships/{id}.html", method = RequestMethod.GET)
  public String shipPage(@PathVariable Integer id, ModelMap model) throws Exception {
    Script script = battleScriptsMapper.selectScript(id);
    String javascript = coffeeScriptService.compileCoffeeScript(script.getContent());
    model.put("script", javascript);
    return "rawscript";
  }
  

}

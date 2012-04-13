package com.battlescripts.controllers;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;


@Controller
public class GlobalController {

  @RequestMapping({"/","/index"})
  public String index() {
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

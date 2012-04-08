package com.battlescripts.controllers;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;


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
  
}

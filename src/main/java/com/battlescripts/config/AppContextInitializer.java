package com.battlescripts.config;

import org.springframework.context.ApplicationContextInitializer;
import org.springframework.web.context.support.AnnotationConfigWebApplicationContext;

public class AppContextInitializer implements
    ApplicationContextInitializer<AnnotationConfigWebApplicationContext> {

  public void initialize(AnnotationConfigWebApplicationContext applicationContext) {
    applicationContext.addBeanFactoryPostProcessor(AppConfig.mySqlScanner(applicationContext));
    applicationContext.addBeanFactoryPostProcessor(AppConfig.placeholderConfigurer(applicationContext.getEnvironment()));
    applicationContext.register(AppConfig.class);
  }

}

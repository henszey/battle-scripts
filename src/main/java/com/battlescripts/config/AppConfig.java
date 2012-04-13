package com.battlescripts.config;

import javax.inject.Inject;

import org.apache.commons.dbcp.BasicDataSource;
import org.apache.ibatis.session.SqlSessionFactory;
import org.mybatis.spring.SqlSessionFactoryBean;
import org.mybatis.spring.SqlSessionTemplate;
import org.mybatis.spring.mapper.MapperScannerConfigurer;
import org.springframework.context.ConfigurableApplicationContext;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.ComponentScan;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.annotation.ImportResource;
import org.springframework.context.support.PropertySourcesPlaceholderConfigurer;
import org.springframework.core.env.Environment;
import org.springframework.core.io.ClassPathResource;
import org.springframework.stereotype.Controller;


@Configuration
//@EnableCaching(mode = AdviceMode.ASPECTJ)
@ComponentScan(basePackages = "com.battlescripts", excludeFilters = {@ComponentScan.Filter(Controller.class), @ComponentScan.Filter(Configuration.class)})
@ImportResource({"classpath:/static-resources.xml", "classpath:/security.xml"})
public class AppConfig {

  @Inject
  private Environment env;

  public static PropertySourcesPlaceholderConfigurer placeholderConfigurer(Environment env) {
    PropertySourcesPlaceholderConfigurer configurer = new PropertySourcesPlaceholderConfigurer();
    configurer.setEnvironment(env);
    return configurer;
  }
  
  public static MapperScannerConfigurer mySqlScanner(ConfigurableApplicationContext context) {
    MapperScannerConfigurer configurer = new MapperScannerConfigurer();
    configurer.setSqlSessionFactoryBeanName("mySqlSessionFactory");
    configurer.setSqlSessionTemplateBeanName("mySqlSessionTemplate");
    configurer.setBasePackage("com.battlescripts.dao.mapper");
    configurer.setApplicationContext(context);
    return configurer;
  }

  @Bean(destroyMethod = "close")
  public BasicDataSource mysqlDataSource() {
    BasicDataSource ds = new BasicDataSource();

    ds.setDriverClassName("com.mysql.jdbc.Driver");
    ds.setUrl("jdbc:mysql://localhost/battlescripts_dev");
    ds.setUsername("battlescripts");
    ds.setInitialSize(2);
    ds.setMaxActive(10);
    ds.setMinIdle(10);
    ds.setMaxWait(10000);
    ds.setTestOnBorrow(true);
    ds.setValidationQuery("select 1");
    
    return ds;
  }

  @Bean
  public SqlSessionFactory mySqlSessionFactory() throws Exception {
    SqlSessionFactoryBean sqlSessionFactoryBean = new SqlSessionFactoryBean();
    sqlSessionFactoryBean.setConfigLocation(new ClassPathResource("/com/battlescripts/dao/mapper/sql-map-mysql-config.xml"));
    sqlSessionFactoryBean.setDataSource(mysqlDataSource());
    sqlSessionFactoryBean.afterPropertiesSet();
    return sqlSessionFactoryBean.getObject();
  }

  @Bean
  public SqlSessionTemplate mySqlSessionTemplate() throws Exception {
    return new SqlSessionTemplate(mySqlSessionFactory());
  }
  
  
  /*
  @Bean
  public CacheManager cacheManager() throws Exception {
    EhCacheManagerFactoryBean ehcache = new EhCacheManagerFactoryBean();
    ehcache.setConfigLocation(new ClassPathResource("/ehcache.xml"));
    ehcache.afterPropertiesSet();
    EhCacheCacheManager cacheManager = new EhCacheCacheManager();
    cacheManager.setCacheManager(ehcache.getObject());
    return cacheManager;
  }
  */
  
}

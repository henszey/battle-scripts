package com.battlescripts.service;

import javax.inject.Named;

import com.google.caja.lexer.FetchedData;
import com.google.caja.lexer.InputSource;
import com.google.caja.reporting.MessageQueue;
import com.google.caja.reporting.SimpleMessageQueue;
import com.google.caja.service.CajolingService;
import com.google.caja.service.ContentHandlerArgs;

@Named("javascriptCajoler")
public class JavascriptCajoler {

  public String cajole(String string) throws Exception {
    CajolingService cajolingService = new CajolingService();

    FetchedData fetchedData = FetchedData.fromBytes(string.getBytes("ISO-8859-1"), "text/html", "ISO-8859-1", InputSource.UNKNOWN);
    MessageQueue mq = new SimpleMessageQueue();
    ContentHandlerArgs contentHandlerArgs = new ContentHandlerArgs(){
      public String get(String arg0) {
        return null;
      }
    };
    FetchedData result = cajolingService.handle(fetchedData, contentHandlerArgs, mq);
    
    return new String(result.getByteContent());
  }
  

}

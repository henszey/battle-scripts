<html>
  <head></head>
  <body>
    <div id="output"></div>
    <script type="text/javascript">
      function timerFired(event) {
        document.getElementById('output').innerHTML +=
            'Got timer event at time ' + event.time + '<br/>';
      }
      timerService.registerListener(timerFired);
   </script>
  </body>
</html>